
/****************************************************

				[ SQL HUGO ]

****************************************************/
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
-------------------------------------

--[PROC] For returning User Personal Orders in UserPage
go
create or alter proc usp_returnUserPersonalOrders(@ID int, @estado int) AS
select ENC_REF, DataCompra, MoradaEntrega, Sum(Qtd) as 'Qty', sum(Total) as 'Total', Descricao
from EncomendaHistorico inner join estado on EncomendaHistorico.ID_Estado = Estado.ID
						inner join Compra on Compra.ID_Encomenda = EncomendaHistorico.ENC_REF
where EncomendaHistorico.ID_Cliente = @ID AND EncomendaHistorico.ID_Estado = IIF(@estado = 4, 4, ID_estado)
group by  ENC_REF, DataCompra, MoradaEntrega, Descricao
order by EncomendaHistorico.ENC_REF DESC

------------------------------------

--[TEMP QUERY] For adjusting inserts of products from warehouse into preexisting pickups
go
insert into StockPickup
select Produto.Codreferencia,3,0,0,1
from Produto
------------------------------------

--[TRIGGER] For removing inactive or discontinued Items from any and all carts
go
Create or alter trigger t_removeInactivesFromCarts on Produto after update

as
begin try
begin tran
    
    if exists(Select '*' from inserted inner join deleted on inserted.Codreferencia = deleted.Codreferencia where inserted.activo = 0)
     begin
        delete from carrinho where carrinho.Prod_ref = (Select inserted.Codreferencia from inserted)
     end

commit
end try
    begin catch
        print error_message();
        rollback;
    end catch





