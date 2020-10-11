
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
 where Receita.NrSaude = (select cliente.nrSaude from Cliente where Cliente.nrSaude = @healthNumber) and Receita.REC_REF = @prescription_ref

update Receita set Receita.InCart = 1 where Receita.REC_REF = @prescription_ref
    
commit
end try
begin catch
    set @errorMessage = ERROR_MESSAGE();
    rollback
end catch
GO
-------------------------------------
--[PROC] Removes All prescription items from Cart
go
Create or alter proc usp_removeAllPrescriptionItemsfromCart(
                                       @healthNumber int,
                                       @clientID int
                                       
)

as
begin try
begin tran
       
     if exists (select '*' from Receita where Receita.InCart = 1 and NrSaude = @healthNumber)
     begin
     update Receita set InCart = 0 where NrSaude = @healthNumber
     delete Carrinho from Carrinho inner join Produto on Produto.Codreferencia = Carrinho.Prod_ref where (Carrinho.ID_Cliente = @clientID) and (Produto.precisaReceita = 1)
     end

commit
end try
    begin catch
        rollback;
    end catch


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

    select * from EncomendaHistorico
    select * from cliente
----------------------------- 
--[PROC] REGULAR ORDER AUTHENTICATION ON PICKUP
go
Create or alter proc usp_regularOrderAuth_ATM(
                                             @order_ref int,
                                             @pickup_id int,
                                             @email varchar(100),
                                             @pw varchar(100),
                                             @ERROR_MESSAGE varchar(200) OUTPUT

)

as
begin try
begin tran
    
    if not exists(select '*' from cliente where cliente.email = @email and cliente.password = @pw)     
       THROW 60001, 'Wrong Email or Password' ,10;   
       
    if exists (select '*' from cliente inner join EncomendaHistorico on cliente.ID = EncomendaHistorico.ID_Cliente 
                   where cliente.email = @email and EncomendaHistorico.ENC_REF = @order_ref and EncomendaHistorico.ID_Estado = 10)
        THROW 60003, 'This Order has expired.', 10;

    if not exists (select '*' from cliente inner join EncomendaHistorico on cliente.ID = EncomendaHistorico.ID_Cliente 
                   where cliente.email = @email and cliente.password = @pw and EncomendaHistorico.ENC_REF = @order_ref and EncomendaHistorico.ID_Estado = 5 and EncomendaHistorico.ID_Pickup = @pickup_id)
       THROW 60002, 'No orders pending retrieval were found for this ATM.', 10;
    
  
    if exists (select '*' from EncomendaHistorico inner join Cliente on Cliente.ID = EncomendaHistorico.ID_Cliente
               where cliente.email = @email
               AND (EncomendaHistorico.ID_Estado = 5)
               AND (datediff(day,EncomendaHistorico.UltimaActualizacao,GETDATE())) >= 4 
               AND (EncomendaHistorico.ENC_REF = @order_ref))
       
       begin 
       update EncomendaHistorico set ID_Estado = 10, UltimaActualizacao = GETDATE() where EncomendaHistorico.ID_Cliente = (Select cliente.id from cliente where email = @email) and EncomendaHistorico.ENC_REF = @order_ref	
       set @ERROR_MESSAGE = 'This Order has expired.';
       end
        
    else
        begin
        update EncomendaHistorico set ID_Estado = 6, UltimaActualizacao = GETDATE() where EncomendaHistorico.ID_Cliente = (Select cliente.id from cliente where email = @email) and EncomendaHistorico.ENC_REF = @order_ref	
        end

commit
end try
    begin catch
       set @ERROR_MESSAGE = ERROR_MESSAGE();
        rollback;
    end catch
-----------------------------------------------------------------------------
--[PROC] QR order authentication at pickup
go
Create or alter proc usp_qrOrderAuth_ATM(
                                             @order_ref int,
                                             @clientID int,
                                             @pickupID int,
                                             @ERROR_MESSAGE varchar(200) OUTPUT

)

as
begin try
begin tran
    
      
    if not exists (select '*' from EncomendaHistorico
                   where EncomendaHistorico.ENC_REF = @order_ref and EncomendaHistorico.ID_Cliente = @clientID and EncomendaHistorico.ID_Pickup = @pickupID and EncomendaHistorico.ID_Estado = 5)
       THROW 60002, 'No orders pending retrieval were found for this Pickup-ATM, please ensure you are using the correct QR code associated with your order.', 10;

    else
        begin
        update EncomendaHistorico set ID_Estado = 6, UltimaActualizacao = GETDATE() where EncomendaHistorico.ENC_REF = @order_ref	
        end

commit
end try
    begin catch
       set @ERROR_MESSAGE = ERROR_MESSAGE();
        rollback;
    end catch
    ---------------------

   --[PROC] -- gets the pickups associated tunnel ID for anonymous clients
    go
Create or alter proc usp_getATMtunnelID(
                                       @atmDesignation varchar(150)                                            

)

as
begin try
begin tran
    
    select Cliente.ID as 'atmTunnelID' from cliente where Cliente.nome = @atmDesignation

commit
end try
    begin catch
        rollback;
    end catch
    --------------
  --[query estatistica selectcommand]
  Select EncomendaHistorico.ID_Pickup, Cliente.nome as 'Pickup', count(EncomendaHistorico.Enc_ref) as 'Orders'
                                 From Cliente inner join EncomendaHistorico on Cliente.id = EncomendaHistorico.id_cliente
                                    where Cliente.nome like 'ATM -%'
                                    group by Cliente.id, Cliente.nome, datanascimento, ID_Pickup                                  
                 
           union all

   Select EncomendaHistorico.ID_Pickup,Pickup.Descricao as 'Pickup', count(EncomendaHistorico.Enc_ref) as 'OnlineOrders'
                                From Cliente inner join EncomendaHistorico on Cliente.id = EncomendaHistorico.id_cliente
                                inner join Pickup on EncomendaHistorico.ID_Pickup = Pickup.ID
                                where MoradaEntrega like 'ATM -%'
                                group by EncomendaHistorico.ID_Pickup, Pickup.Descricao
                                order by EncomendaHistorico.ID_Pickup

----------------------------
--[PROC] Reset ATM - Cart for new Users

GO 
CREATE OR ALTER PROC usp_resetATMcart(@atmTunnelID int) AS
BEGIN TRY
BEGIN TRAN

	delete from carrinho where carrinho.ID_Cliente = @atmTunnelID;

COMMIT
END TRY
BEGIN CATCH
	ROLLBACK;
END CATCH

-----------------------------
--[PROC] add to ATM cart
                
                 GO
	create or alter proc usp_increaseATMcartQty(@clientTunnelID int, @prodref varchar(20), @pickupID int) AS
	BEGIN TRY
	BEGIN TRAN
                                
        if((select count(carrinho.Prod_ref) from carrinho where Prod_ref = @prodref and carrinho.ID_Cliente = @clientTunnelID) < (select StockPickup.qtd from StockPickup inner join Pickup on Pickup.ID = StockPickup.ID_Stock_Pickup where Pickup.ID = @pickupID and StockPickup.Prod_ref = @prodref))                      
        begin
		insert into carrinho values(@clientTunnelID, @prodref, null)
        end

	commit
	end try
	begin catch
		rollback
	end catch

	------------ [ PROC ] Remove item from cart
	GO
	create or alter proc usp_decreaseATMcartQty(@clientTunnelID int, @prodref varchar(20)) AS
    BEGIN TRY
	BEGIN TRAN

		delete top(1) from Carrinho where (Carrinho.ID_Cliente = @clientTunnelID) AND Carrinho.Prod_ref = @prodref

	commit
	end try
	begin catch
		rollback
	end catch