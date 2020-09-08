
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
