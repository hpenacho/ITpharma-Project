
/****************************************************

				[ SQL HUGO ]

****************************************************/

--[PROC] return user Info to checkout
GO
create or alter proc usp_ClientInfoToCheckout (@ID_cliente int) 

AS
begin try
begin tran

    select cliente.nome as 'Name', cliente.email, cliente.morada as 'Address', Cliente.codPostal as 'ZipCode'
     from Cliente
     where Cliente.ID = @ID_cliente

commit
end try
begin catch
    print ERROR_MESSAGE();
    rollback
end catch
GO

---------------------------------

--[PROC] VALIDATES PRESCRIPTION (if valid and unlifted, places it in users cart and proceeds to checkout Page for purchase)
GO
create or alter proc usp_validatePrescription (
                                               @healthNumber varchar(20),
                                               @prescription_ref int,
                                               @errorMessage varchar(200) output
                                               ) 

AS
begin try

	    IF NOT EXISTS(SELECT '*' FROM Receita WHERE Receita.NrSaude = @healthNumber and Receita.REC_REF = @prescription_ref)
		throw 88001, 'Unable to find valid prescriptions for the supplied information.' , 10

        IF EXISTS(SELECT '*' FROM Receita where receita.levantada = 1 and receita.NrSaude = @healthNumber and receita.REC_REF = @prescription_ref  )
		throw 88002, 'Prescription has been used up already.', 10

        DECLARE @expireMessage NVARCHAR(100)
        SET @expireMessage = CONCAT (N'This prescription expired ', (select DATEDIFF(day, Receita.DataExpiracao , getdate()) from Receita where Receita.REC_REF = @prescription_ref),' days ago (',(select DataExpiracao from Receita where REC_REF = @prescription_ref),')')
            
	    IF EXISTS(SELECT '*' FROM Receita WHERE Receita.DataExpiracao < getdate() and Receita.REC_REF = @prescription_ref)
		throw 88003, @expireMessage, 10

        IF EXISTS(SELECT '*' FROM Receita where Receita.InCart = 1 and Receita.REC_REF = @prescription_ref)
        throw 88004, 'One or more Items from this prescription already in Cart.', 10
      
begin tran

 insert into Carrinho 
 select (select Cliente.ID from Cliente where Cliente.nrSaude = @healthNumber), ItemReceita.Prod_ref, null
 from ItemReceita inner join Receita on ItemReceita.ID_Receita = Receita.REC_REF
 where Receita.NrSaude in (
        select cliente.nrSaude from Cliente where Cliente.nrSaude = @healthNumber
)

update Receita set Receita.InCart = 1 where Receita.REC_REF = @prescription_ref
    
commit
end try
begin catch
    set @errorMessage = ERROR_MESSAGE();
    rollback
end catch
GO
