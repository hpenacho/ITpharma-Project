
/****************************************************

				[ SQL BACK OFFICE ]

****************************************************/


create table Admins(

	ID int identity primary key,
	username varchar(50) unique not null,
	password varchar(100) not null
)

create table Cliente( 

	ID int identity primary key,
	nome varchar(50) not null,
	email varchar(100) unique not null,
	password varchar(100) not null,
	morada varchar(300) null,
	activo bit default 0,
	firstActivation bit default 1,
	nif varchar(20) null unique,
	nrSaude varchar(20) null unique,
	sexo char(1) check (sexo in ('M','F')),
	dataNascimento date null
) 

create table Categoria(
	
	ID int identity primary key,
	descricao varchar(100) unique not null
)

create table Marca (

	ID int identity primary key,
	descricao varchar(100) unique not null
)

create table Produto(
	
	Codreferencia varchar(20) primary key,
	nome varchar(150) not null unique,
	preco decimal(7,2) null,
	resumo varchar(50) null,
	descricao varchar(MAX) null,
	imagem varbinary(MAX) null,
	pdfFolheto varbinary(MAX) null,
	ID_Categoria int references Categoria(ID) null,
	ID_Marca int references Marca(ID) null,
	precisaReceita bit default 0,
	ref_generico varchar(20) references Produto(Codreferencia) null,
	Activo bit default 1,
	Descontinuado bit default 0
)

create table Carrinho(

	ID_Cliente int references Cliente(ID) ON DELETE CASCADE,
	Prod_ref varchar(20) references Produto(Codreferencia) ON DELETE CASCADE,
	Cookie varchar(50) null
)


create table Compra(
	
	ID_Encomenda int references EncomendaHistorico(ENC_REF) ON DELETE CASCADE,
	Prod_ref varchar(20) references Produto(Codreferencia) ON DELETE CASCADE,
	Qtd int not null,
	Total decimal(10,2) not null
)

create table Estado(
	
	ID int identity primary key,
	Tipo bit,
	Descricao varchar(50) not null unique
)

create table ExamesAnalises(
	
	ID int identity primary key,
	ID_Cliente int references Cliente(ID),
	PDF_Binario varbinary(MAX),
	DataPedido date default getdate(),
	ID_Estado int references Estado(ID)
)

create table ExamesParceria(

	ID int identity primary key,
	parceria varchar(50) not null
)



create table StockArmazem(

	Prod_Ref varchar(20) references Produto(Codreferencia) ON DELETE CASCADE,
	Qtd int check(Qtd >= 0),
	QtdMin int check (QtdMin >= 0),
	QtdMax int,
	check(QtdMax > QtdMin),
	primary key(Prod_Ref)
)

create table Pickup(

	ID int identity primary key,
	Descricao varchar(150) not null,
	Lat float,  --coords y
	Long float,  --coords x
)


create table StockPickup(
	
	ID int identity primary key,
	Qtd int check (Qtd >= 0),
	Prod_ref varchar(20) references Produto(Codreferencia) ON DELETE CASCADE,
	QtdMin int check (QtdMin >= 0),
	QtdMax int,
	check(QtdMax > QtdMin),
	ID_Stock_Pickup int references Pickup(ID) ON DELETE CASCADE
)


create table EncomendaHistorico(
	
	ENC_REF int primary key identity,
	ID_Cliente int references Cliente(ID) ON DELETE CASCADE,
	ID_Estado int references Estado(ID),
	DataCompra date default getdate() not null,
	UltimaActualizacao datetime null,
	MoradaEntrega varchar(300) null,
	ID_Pickup int references Pickup(ID),
)

create table ItemReceita(
	
	Qtd int check(Qtd >= 0),
	Prod_ref varchar(20) references Produto(Codreferencia) ON DELETE CASCADE,
	ID_Receita int references Receita(REC_REF), -- na eventualidade de dar bidé, meter on delete cascade
	primary key(Prod_ref, ID_Receita)
)

create table Receita( -- à partida não se apaga receita 
	
	REC_REF int identity primary key,
	Cod_Medico varchar(50) not null,
	DataExpiracao date default Dateadd(day, 15, getdate()),
	Levantada bit,
	NrSaude varchar(20) null, -- NÃO ESTÁ LIGADA EM SQL MAS SERVE DE AUTENTICAÇÃO NO C#
)

create table Pub_Sazonal(
	
	ID int identity primary key,
	Descricao varchar(50) not null,
	DataStart date null,
	DataExpiracao date null
)

create table Pub_Cliente(
	ID int identity primary key,
	Descricao varchar(50) not null,
	DataStart date null,
	DataExpiracao date null
)

create table Publicidade(

	ID int identity primary key,
	Imagem varbinary(MAX) not null,
	Tipo bit, -- 0 info do cliente, 1 sazonal
	ID_Pub_Sazonal int references Pub_Sazonal(ID),
	ID_Pub_Cliente int references Pub_Cliente(ID)
)

-- INSERTS, UPDATES, DELETES

/* COMENTÁRIOS 

BUGS - É POSSÍVEL O PRODUTO SER O SEU PRÓPRIO GENÉRICO
	   É POSSÍVEL REACTIVAR UM PRODUTO COM MARCA E CATEGORIA NULA	
	   [ATENÇÃO: CRIAR REFERENCIA ÚNICA INACTIVA PARA UM GENERICO SEM PAI]

DECISÕES -

	    NÃO SE APAGA PRODUTOS, fica INACTIVO

*/


-- QUERIES

-- SELECCIONAR TODOS OS GENERICOS

SELECT * from produto where ref_generico IS NOT NULL

-- SELECCIONAR UM GENERICO 

SELECT * FROM PRODUTO WHERE ref_generico = 'XY1'


-- TRIGGERS

-- APAGAR A MARCA	
GO
create or alter trigger trg_apagarMarca on Marca instead of delete as 
BEGIN TRY
BEGIN TRAN

		UPDATE PRODUTO SET PRODUTO.ID_Marca = NULL, PRODUTO.Activo = 0 WHERE PRODUTO.ID_Marca in (select deleted.ID from deleted)
		delete from Marca where Marca.id in (select deleted.ID from deleted)

COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH

-- APAGAR A CATEGORIA	
GO
create or alter trigger trg_apagarCategoria on Categoria instead of delete as 
BEGIN TRY
BEGIN TRAN

		UPDATE PRODUTO SET PRODUTO.ID_Categoria = NULL, PRODUTO.Activo = 0 WHERE PRODUTO.ID_Categoria in (select deleted.ID from deleted)
		delete from Categoria where Categoria.id in (select deleted.ID from deleted)

COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH

--	APAGAR PRODUTO TENDO EM CONTA O GENÉRICO [ATENÇÃO: CRIAR REFERENCIA ÚNICA INACTIVA PARA UM GENERICO SEM PAI]

GO
create or alter trigger trg_DelProdRefGen on produto instead of delete AS
BEGIN TRY
BEGIN TRAN
		
		
		update produto set produto.ref_generico = null where Produto.ref_generico in (select deleted.codreferencia from deleted)
		delete from Produto where Produto.Codreferencia in (select deleted.codreferencia from deleted)

COMMIT
END TRY
BEGIN CATCH
	print ERROR_MESSAGE();
	ROLLBACK
END CATCH


-- QUERIES

-- ESTADO do stock

select Produto.Codreferencia, Produto.nome, StockArmazem.Qtd, StockArmazem.QtdMin, StockArmazem.QtdMax, case when Qtd <= QtdMin then 'Pedir Stock'
																											 when Qtd > QtdMax then 'Excesso Stock'
																											 ELSE 'Nominal'
																											 END AS 'Estado'
from produto inner join StockArmazem on StockArmazem.Prod_Ref = produto.Codreferencia

-- Stock Pickup com Stock Loja

select Pickup.Descricao AS 'Nome da Loja', 
	   Produto.nome AS 'Produto', 
	   StockArmazem.Qtd As 'Stock Armazém', 
	   StockPickup.Qtd As 'Stock Pickup', StockPickup.QtdMin As 'Stock Min', 
	   StockPickup.QtdMax  As 'Stock Max', 
	   case 
	   when StockPickup.Qtd <= StockPickup.QtdMin then 'Pedir Stock'
	   when StockPickup.Qtd > StockPickup.QtdMax then 'Excesso Stock'
	   ELSE 'Nominal'
       END AS 'Estado do Armazém'

from Pickup inner join StockPickup on Pickup.ID = StockPickup.ID_Stock_Pickup
			inner join Produto on Produto.Codreferencia = StockPickup.Prod_ref
			inner join StockArmazem on StockArmazem.Prod_Ref = Produto.Codreferencia


-- Inserir uma Encomenda após compra 
go
create or alter proc usp_encomenda(@IDcliente int, 
								   @MoradaEntrega varchar(300),
								   @Pickup int,
								   @zip_code varchar(20),
								   @receiver varchar(50),
								   @orderNumber int OUTPUT,
								   @ERROR_MESSAGE varchar(200) OUTPUT								   								   
								   )
								   as
begin try
begin tran 

			DECLARE @C_prodRef as varchar(20)
			DECLARE @C_prodQty as int

			DECLARE carrinho_Cursor CURSOR FOR  
			SELECT Carrinho.Prod_ref, count(Carrinho.Prod_ref) 
			FROM Carrinho 			
			WHERE Carrinho.ID_Cliente = @IDcliente
			GROUP BY Carrinho.Prod_ref
			OPEN carrinho_Cursor;  
			FETCH NEXT FROM carrinho_Cursor INTO @C_prodRef, @C_prodQty;  
			WHILE @@FETCH_STATUS = 0  
			   BEGIN  
				  if @Pickup is null -- then its a home delivery, affects warehouse stock
					begin
						if( (Select StockArmazem.Qtd from StockArmazem where StockArmazem.Prod_Ref = @C_prodRef) < @C_prodQty )
							begin
								insert into EncomendaHistorico values(@IDcliente, 0, getdate(), getdate(), @MoradaEntrega, @Pickup, @zip_code, @receiver)
								set @ERROR_MESSAGE = 'NOT enough stock in warehouse, order was inserted as "Awaiting Restock"'
								break;
							end
					end  
					
				   else -- then its a pickup order, affects pickup Stock
					begin
						if( (Select StockPickup.Qtd from StockPickup where StockPickup.Prod_Ref = @C_prodRef and StockPickup.ID_Stock_Pickup = @Pickup) < @C_prodQty )
							begin
								insert into EncomendaHistorico values(@IDcliente, 0, getdate(), getdate(), @MoradaEntrega, @Pickup, @zip_code, @receiver)
								set @ERROR_MESSAGE =  concat('NOT enough stock in pickup of id ', @Pickup,' , order was inserted as "Awaiting Restock"')
								break;
							end
					end

				  FETCH NEXT FROM carrinho_Cursor INTO @C_prodRef, @C_prodQty;  
			   END; 

			   if (@@FETCH_status = -1) -- if it reached the end of cart, it means that no product was out of stock for the chosen delivery method (home delivery or pickup)
			   begin
					set @ERROR_MESSAGE =  'There is enough stock for this specific order'
					insert into EncomendaHistorico values(@IDcliente, 0, getdate(), getdate(), @MoradaEntrega, @Pickup, @zip_code, @receiver)
				end

				CLOSE carrinho_Cursor;  
				DEALLOCATE carrinho_Cursor; 
				

		Declare @thisEnc int
		set @thisEnc = (select Max(EncomendaHistorico.ENC_REF) from EncomendaHistorico)
		
		insert into compra
		select @thisEnc as 'orderNumber', Prod_ref AS 'Produto', count(Prod_ref) AS 'QTD' , sum(produto.preco) AS 'Total' , produto.preco as 'Item price at time'
		from Carrinho inner join Produto on Carrinho.Prod_ref = Produto.Codreferencia
		where Carrinho.ID_Cliente = @IDcliente
		group by Prod_ref, produto.preco

		if (@ERROR_MESSAGE = 'There is enough stock for this specific order')
			begin
				update EncomendaHistorico set EncomendaHistorico.ID_Estado = 1 where EncomendaHistorico.ENC_REF = @thisEnc
			end

		DELETE FROM carrinho WHERE carrinho.ID_Cliente = @IDcliente;

		if exists(select Produto.precisaReceita from Produto
				 inner join Compra on Produto.Codreferencia = Compra.Prod_ref
				 inner join EncomendaHistorico on Compra.ID_Encomenda = EncomendaHistorico.ENC_REF
				 where EncomendaHistorico.ENC_REF = @thisEnc
				 group by Produto.precisaReceita)
		
		update Receita
		set Receita.Levantada = 1, Receita.InCart = 0
		where Receita.InCart = 1 AND Receita.Levantada = 0 AND Receita.NrSaude = (select Cliente.nrSaude from Cliente where Cliente.ID = @IDcliente)

		SET @orderNumber = @thisEnc
commit
end try
begin catch
	set @ERROR_MESSAGE =  ERROR_Message()	
	rollback;
end catch
GO


-- QUERY PARA UTILIZADOR VER A SUA ENCOMENDA NA ÁREA PESSOAL

select EncomendaHistorico.ENC_REF, Estado.Descricao AS 'Estado', EncomendaHistorico.UltimaActualizacao, EncomendaHistorico.DataCompra, sum(Compra.Qtd) ,sum(Compra.Total)
from  EncomendaHistorico inner join Compra on EncomendaHistorico.ENC_REF = Compra.ID_Encomenda 
						 inner join Estado on EncomendaHistorico.ID_Estado = Estado.ID
						 inner join Cliente on EncomendaHistorico.ID_Cliente = Cliente.ID
where Cliente.ID = @IDCLIENTE 
group by EncomendaHistorico.ENC_REF, Estado.Descricao, EncomendaHistorico.UltimaActualizacao, EncomendaHistorico.DataCompra, EncomendaHistorico.MoradaEntrega


-- STORED PROCEDURE loginBackOffice
-- esta usp simplesmente verifica se os dados introduzidos no login sao simultaneamente validos
-- caso nao sejam, será devolvida msg de erro, cuja falta de presença implica login com sucesso. 
GO
CREATE OR ALTER PROCEDURE [dbo].[usp_loginAdmins]

	@adminName varchar(50),
	@pw varchar(100),
	@OUTPUT varchar(300)

AS
BEGIN TRY
BEGIN TRAN
	
    if not exists (select '*' from administradores where userName=@adminName and password = @pw)					
			THROW 60001, 'Wrong user name or password', 10
					
commit
END TRY
BEGIN CATCH
	set @OUTPUT = ERROR_MESSAGE();
	ROLLBACK;
END CATCH

--FIM USP loginBackOffice


create table Categoria(
	
	ID int identity primary key,
	descricao varchar(100) unique not null
)

create table Marca (

	ID int identity primary key,
	descricao varchar(100) unique not null
)


-- [PROCEDURE] INSERT BRANDS BACKOFFICE
GO
create or alter proc usp_insertCategory (@descricao varchar(100), @errorMessage varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

	IF EXISTS (SELECT '*' from Categoria where descricao = @descricao)
		THROW 60001,'The Category specified already exists' , 10;

	insert into Categoria values(@descricao)
	set @errorMessage = 'The Category was created successfully';

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	ROLLBACK;
END CATCH

-- [PROCEDURE] INSERT BRANDS BACKOFFICE

GO
create or alter proc usp_insertBrand(@descricao varchar(100), @errorMessage varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

	IF EXISTS (SELECT '*' from Marca where descricao = @descricao)
		THROW 60001,'The Brand specified already exists' ,10

	insert into Marca values(@descricao)
	set @errorMessage = 'The Brand was created successfully';

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	ROLLBACK;
END CATCH

-- [PROCEDURE] UPDATE BRAND

GO 
CREATE OR ALTER PROC usp_updateBrand(@ID int, @descricao varchar(100), @errorMessage varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

	IF EXISTS (SELECT '*' from Marca where descricao = @descricao AND Marca.ID != @ID)
		THROW 60001,'This Brand name is already in use, try again.' , 10

	declare @oldBrand varchar (50);
	set @oldBrand = (SELECT Marca.descricao from Marca where Marca.ID = @ID);

	update Marca set Marca.descricao = @descricao where Marca.ID = @ID	
	set @errorMessage = CONCAT('The Brand designation was changed from ', @oldBrand , ' to ', @descricao, '.');

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	ROLLBACK;
END CATCH

-- [PROCEDURE] DELETE BRAND

GO 
CREATE OR ALTER PROC usp_deleteBrand(@ID int, @errorMessage varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

	declare @oldBrand varchar (50);
	set @oldBrand = (SELECT Marca.descricao from Marca where Marca.ID = @ID);
	
	delete from Marca where Marca.ID = @ID
	set @errorMessage = Concat('The ',@oldBrand, ' Brand is now deleted.');

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	ROLLBACK;
END CATCH

-- [PROCEDURE] UPDATE CATEGORY

GO 
CREATE OR ALTER PROC usp_updateCategory(@ID int, @descricao varchar(100), @errorMessage varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

	IF EXISTS (SELECT '*' from Categoria where descricao = @descricao AND Categoria.ID != @ID)
		THROW 60001,'The Category name is already in use, try again.' , 10

	declare @oldCat varchar (50);
	set @oldCat = (SELECT Categoria.descricao from Categoria where Categoria.ID = @ID);

	update Categoria set Categoria.descricao = @descricao where Categoria.ID = @ID	
	set @errorMessage = CONCAT('The Category designation was changed from ', @oldCat , ' to ', @descricao, '.');

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	ROLLBACK;
END CATCH

-- [PROCEDURE] DELETE CATEGORY

GO 
CREATE OR ALTER PROC usp_deleteCategory(@ID int, @errorMessage varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

	declare @oldCat varchar (30);
	set @oldCat = (SELECT Categoria.descricao from Categoria where Categoria.ID = @ID);

	delete from Categoria where Categoria.ID = @ID
	set @errorMessage = Concat('The ',@oldCat, ' Category is now deleted.');

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	ROLLBACK;
END CATCH



-- [PROCEDURE] INSERT PRODUCTS BACKOFFICE - FILIPE

GO
create or alter proc usp_insertBackofficeProducts(@Codreferencia varchar(20),
												  @nome varchar(150),
												  @preco decimal(7,2),
												  @resumo varchar(50),
												  @descricao varchar(MAX),
												  @imagem varbinary(MAX),
												  @pdfFolheto varbinary(MAX),
												  @ID_Categoria int,
												  @ID_Marca int,
												  @precisaReceita bit,
												  @ref_generico varchar(20),
												  @Activo bit,
												  @Qtd int,
												  @QtdMin int,
												  @QtdMax int,
												  @errorMessage varchar(200) output)
AS
BEGIN TRY
BEGIN TRAN

	--ERRORS

	IF EXISTS (SELECT '*' FROM Produto WHERE Produto.Codreferencia = @Codreferencia)
		THROW 60001, 'Cannot insert duplicate product reference', 10

	IF EXISTS (SELECT '*' FROM Produto WHERE Produto.nome = @nome)
		THROW 60002, 'A product with that name already exists', 10

	--INSERTION !!WARNING!! THE PDF FLYER IS CURRENTLY BEING INSERTED AS NULL

	INSERT INTO Produto VALUES (@Codreferencia, @nome, @preco, @resumo, @descricao, @imagem, NULL, @ID_Categoria, @ID_Marca, @precisaReceita, @ref_generico, @Activo, 0)
	INSERT INTO StockArmazem values(@Codreferencia, @Qtd, @QtdMin, @QtdMax)

	DECLARE @pickupID as int
	DECLARE pickup_Cursor CURSOR FOR

	SELECT Pickup.ID FROM Pickup
	OPEN pickup_Cursor;
	FETCH NEXT from pickup_Cursor INTO @pickupID;
	WHILE @@FETCH_STATUS = 0	
		BEGIN
			insert into StockPickup values (@Codreferencia,@pickupID,0,0,1);
			Print @pickupID;
			FETCH NEXT FROM pickup_Cursor INTO @pickupID;
		END		
	CLOSE pickup_Cursor;  
	DEALLOCATE pickup_Cursor;  

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	print ERROR_MESSAGE();
	ROLLBACK;
END CATCH


-- [PROCEDURE] LIST PRODUCT BACKOFFICE REPEATER

GO
CREATE OR ALTER PROC usp_listBackofficeProducts AS
SELECT Produto.Codreferencia, Produto.imagem, Produto.nome, Produto.preco, StockArmazem.Qtd, Produto.Activo
from Produto inner join StockArmazem on Produto.Codreferencia = StockArmazem.Prod_Ref
where Produto.Descontinuado = 0

-- [PROCEDURE] LIST ARCHIVED PRODUCT BACKOFFICE REPEATER

GO
CREATE OR ALTER PROC usp_listArchivedBackofficeProducts AS
SELECT Produto.Codreferencia, Produto.imagem, Produto.nome, Produto.preco, StockArmazem.Qtd, Produto.Activo
from Produto inner join StockArmazem on Produto.Codreferencia = StockArmazem.Prod_Ref
where Produto.Descontinuado = 1

-- [PROCEDURE] LIST PRODUCT DETAILS BACKOFFICE

GO
CREATE OR ALTER PROC usp_listBackofficeProductDetails(@item varchar(20)) AS
SELECT * 
from Produto inner join StockArmazem on Produto.Codreferencia = StockArmazem.Prod_Ref
WHERE Produto.Codreferencia = @item


-- [QUERY] DELETE PRODUCT BACKOFFICE \\ Product is discontinued
GO
CREATE OR ALTER PROC usp_disableBackofficeProduct(@item varchar(20)) AS

BEGIN TRY
BEGIN TRAN

	if exists(select '*' from Compra where Compra.Prod_ref = @item)
	update produto set produto.Descontinuado = 1, produto.Activo = 0 where Produto.Codreferencia = @item

	else
		Delete from Produto where Produto.Codreferencia = @item --if product has never been ordered by anyone ever, delete it entirely

	COMMIT
END TRY
BEGIN CATCH
	print ERROR_MESSAGE();
	ROLLBACK;
END CATCH
-------------------------------------------

-- [QUERY] UPDATE PRODUCT BACKOFFICE \\ For updating existing products from the backOffice
GO
CREATE OR ALTER proc usp_updateBackofficeProducts(@Codreferencia varchar(20),
												  @nome varchar(150),
												  @preco decimal(7,2),
												  @resumo varchar(50),
												  @descricao varchar(MAX),
												  @imagem varbinary(MAX),
												  @pdfFolheto varbinary(MAX),
												  @ID_Categoria int,
												  @ID_Marca int,
												  @precisaReceita bit,
												  @ref_generico varchar(20),
												  @Activo bit,
												  @Qtd int,
												  @QtdMin int,
												  @QtdMax int,
												  @errorMessage varchar(200) output) 

AS
BEGIN TRY
BEGIN TRAN

	--ERRORS
				--truque para permitir o produto actualizar-se mantendo o proprio nome
	IF EXISTS (SELECT '*' FROM Produto WHERE Produto.nome = @nome AND Produto.Codreferencia != @Codreferencia )
		THROW 60003, 'Another product with that name already exists', 10

	--!!WARNING!! THE PDF FLYER IS CURRENTLY BEING INSERTED AS NULL

	UPDATE Produto
	Set nome = @nome, 
		preco = @preco, 
		resumo = @resumo, 
		descricao = @descricao, 
		imagem = IIF(LEN(@imagem) = 0, imagem , @imagem),
		pdfFolheto = null,
		ID_Categoria = @ID_Categoria,
		ID_Marca = @ID_Marca,
		precisaReceita = @precisaReceita,
		ref_generico = @ref_generico,
		Activo = @Activo
	Where Produto.Codreferencia = @Codreferencia

	UPDATE StockArmazem
	Set Qtd = @Qtd,
		QtdMin = @QtdMin,
		QtdMax = @QtdMax
	Where StockArmazem.Prod_Ref = @Codreferencia

COMMIT
END TRY
BEGIN CATCH
    set @errorMessage = ERROR_MESSAGE();
	print ERROR_MESSAGE();
	ROLLBACK;
END CATCH
GO



-- [QUERY] INSERT SHOP USERS INTO CLIENT  //for creating new clients
GO
CREATE OR ALTER proc usp_insertShopUser(@nome varchar(50),
										@email varchar(100),
										@password varchar(100),
										@morada varchar(300),
										@nif varchar(20),
										@nrSaude varchar(20),
										@sexo char(1),
										@dataNascimento date,
										@codPostal varchar(20),
										@errorMessage varchar(200) output)
AS
BEGIN TRY
BEGIN TRAN

	--ERRORS

	IF EXISTS (SELECT '*' FROM Cliente WHERE Cliente.email = @email)
		THROW 60005, 'An account with that email is already registered, please try again.', 10

	IF EXISTS (SELECT '*' FROM Cliente WHERE Cliente.nif = @nif)
		THROW 60006, 'An account with that NIF is already registered, please try again.', 10

	IF EXISTS (SELECT '*' FROM Cliente WHERE Cliente.nrSaude = @nrSaude)
		THROW 60007, 'An account with that Health Number is already registered, please try again.', 10

	INSERT INTO Cliente VALUES (@nome, @email, @password, @morada, 0, 1, @nif, @nrSaude, @sexo, @dataNascimento, @codPostal)

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	print ERROR_MESSAGE();
	ROLLBACK;
END CATCH
GO

-- [QUERY] UPDATE SHOP USERS INFO //for updating client info
GO
CREATE OR ALTER proc usp_updateShopUser(@id int,
										@nome varchar(50),
										@email varchar(100),
										@active bit,
										@firstActivation bit,
										@errorMessage varchar(200) output)
AS
BEGIN TRY
BEGIN TRAN

	--ERRORS

	IF EXISTS (SELECT '*' FROM Cliente WHERE Cliente.email = @email AND Cliente.ID != @id)
		THROW 60008, 'The updated email is already in use by another Shop User, no changes were made.', 10
	
	UPDATE Cliente
	Set nome = @nome, 
		email = @email, 
		activo = @active, 
		firstActivation = @firstActivation 
	Where Cliente.ID = @id

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	print ERROR_MESSAGE();
	ROLLBACK;
END CATCH
GO


-- [QUERY] LISTS SEASONAL ADS //for backoffice seasonal ad management
go
create or ALTER PROC usp_listSeasonalAds AS
SELECT Publicidade.ID, Publicidade.imagem, publicidade.ID_Pub_Sazonal, Pub_Sazonal.Descricao,Pub_Sazonal.DataStart, Pub_Sazonal.DataExpiracao
from Publicidade inner join Pub_Sazonal on Publicidade.ID_Pub_Sazonal = Pub_Sazonal.id
where Publicidade.Tipo = 1
GO

-- [QUERY] -CREATES SEASONAL ADS  //for backOffice seasonal ad Insertion into db
CREATE OR ALTER proc usp_insertAdSeasonal(
										    @imagem varbinary(max),										    
										    @id_pub_sazonal int,										
										    @errorMessage varchar(200) output)
AS
BEGIN TRY
BEGIN TRAN

	--ERRORS

	INSERT INTO Publicidade VALUES (@imagem,1,@id_pub_sazonal,null)

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	print ERROR_MESSAGE();
	ROLLBACK;
END CATCH
GO

-- [QUERY] LISTS CLIENT CENTRIC ADS //for backoffice Client ad management
go
create or ALTER PROC usp_listClientCentricAds AS
SELECT Publicidade.ID, Publicidade.imagem, publicidade.ID_Pub_Cliente, Pub_Cliente.Descricao, Pub_Cliente.DataStart, Pub_Cliente.DataExpiracao
from Publicidade inner join Pub_Cliente on Publicidade.ID_Pub_Cliente = Pub_Cliente.ID
where Publicidade.Tipo = 0
GO

-- [QUERY] -CREATES CLIENT CENTRIC ADS  //for backOffice Client ad Insertion into db
CREATE OR ALTER proc usp_insertAdClient(
										    @imagem varbinary(max),										    
										    @id_pub_cliente int,										
										    @errorMessage varchar(200) output)
AS
BEGIN TRY
BEGIN TRAN

	--ERRORS

	INSERT INTO Publicidade VALUES (@imagem,0,null,@id_pub_cliente)

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	print ERROR_MESSAGE();
	ROLLBACK;
END CATCH
GO

--- [USP] DELETES THE SELECTED ADVERTISEMENT
GO 
CREATE OR ALTER PROC usp_deleteAdvertisement(@id_advert int) AS
BEGIN TRY
BEGIN TRAN

	delete from publicidade where publicidade.ID = @id_advert

COMMIT
END TRY
BEGIN CATCH
	ROLLBACK;
END CATCH

-- [PROC] RETURNS ORDERS TO THE BACKOFFICE 

GO
create or alter proc usp_returnBackofficeOrders as
select enc_ref as 'Ref', datacompra, cliente.nome as 'clientName', sum(compra.Total) as 'orderTotal', id_estado, ultimaActualizacao 
from EncomendaHistorico inner join cliente on cliente.id = EncomendaHistorico.ID_Cliente
						inner join Compra on compra.ID_Encomenda = EncomendaHistorico.ENC_REF
group by enc_ref, datacompra, cliente.nome, id_estado, ultimaActualizacao 


-- [PROC] RETURNS ORDER DETAILS

GO
CREATE PROC usp_returnBackofficeOrderDetails (@EncRef int) as
select Produto.imagem, Produto.nome, Compra.Qtd, Compra.PriceAtTime, Compra.Total
from Produto inner join Compra on Compra.Prod_ref = Produto.Codreferencia
             inner join EncomendaHistorico on Compra.ID_Encomenda = EncomendaHistorico.ENC_REF
where EncomendaHistorico.ENC_REF = @EncRef



GO
create or alter proc usp_returnBackofficeOrderProducts (@ID int) as
select * from Compra inner join produto on compra.Prod_ref = Produto.Codreferencia
where id_encomenda = @ID

-- [PROC] UPDATES AN ORDER'S STATE

GO -- MUDAR MAIS TEMPO
create or alter proc usp_updateOrderStatus(@IDEncomenda int, @IDestado int) AS
begin try 
begin tran

	update encomendaHistorico 
	set EncomendaHistorico.ID_Estado = @IDestado, EncomendaHistorico.UltimaActualizacao = getdate()
	where EncomendaHistorico.ENC_REF = @IDEncomenda


commit
end try 
begin catch
	rollback;
end catch


-- [PROC] Retorno de informação para o backoffice-stock

GO
create or alter proc usp_infoStock AS
select * from StockArmazem inner join Produto on StockArmazem.Prod_Ref = Produto.Codreferencia 
where produto.activo = 1

-- [PROC] Update de stock do produto  -- FALTA TRATAR DAS EXCEPÇÕES

GO
create or alter proc usp_updateStock(@prodref varchar(50), @qtd int, @qtdmin int, @qtdmax int, @errormessage varchar(200) output) AS
begin try
begin tran


		update StockArmazem set qtd = @qtd,qtdmin = @qtdmin,qtdmax = @qtdmax
		where StockArmazem.Prod_Ref = @prodref
		
commit
end try
begin catch
	set @errormessage = ERROR_MESSAGE()
	rollback
end catch

-- [PROC] gathers all statistically relevant data.

GO
create or alter proc usp_gatherStatistics

AS
BEGIN TRY
BEGIN TRAN

select count(EncomendaHistorico.enc_ref) as 'Total Orders'
from EncomendaHistorico
--------
select count(EncomendaHistorico.enc_ref) as 'Orders this Month'
from EncomendaHistorico
where Month(EncomendaHistorico.DataCompra) = Month(GetDate()) and Year(EncomendaHistorico.DataCompra) = Year(GetDate())
--------
select count(EncomendaHistorico.enc_ref) as 'Orders today'
from EncomendaHistorico
where Day(EncomendaHistorico.DataCompra) = Day(GetDate()) and Month(EncomendaHistorico.DataCompra) = Month(GetDate())
and Year(EncomendaHistorico.DataCompra) = Year(GetDate())
------------------
select sum(total) AS 'Total Profit' from EncomendaHistorico 
inner join Compra on Compra.ID_Encomenda = EncomendaHistorico.ENC_REF
inner join Produto on Compra.Prod_ref = Produto.Codreferencia
------------------
select coalesce(sum(total),0) AS 'Monthly Profit' from EncomendaHistorico 
inner join Compra on Compra.ID_Encomenda = EncomendaHistorico.ENC_REF
inner join Produto on Compra.Prod_ref = Produto.Codreferencia
where Month(EncomendaHistorico.DataCompra) = Month(GetDate()) and Year(EncomendaHistorico.DataCompra) = Year(GetDate())
------------------
select coalesce(sum(total),0) AS 'Daily Profit' from EncomendaHistorico 
inner join Compra on Compra.ID_Encomenda = EncomendaHistorico.ENC_REF
inner join Produto on Compra.Prod_ref = Produto.Codreferencia
where Day(EncomendaHistorico.DataCompra) = Day(GetDate()) and Month(EncomendaHistorico.DataCompra) = Month(GetDate())
and Year(EncomendaHistorico.DataCompra) = Year(GetDate())
------------------
select count(Produto.codReferencia) as 'Total Unique Products'
from Produto
------------------
select count(Produto.codReferencia) as 'Prod Active'
from Produto where Produto.Activo = 1
------------------
select count(Produto.codReferencia) as 'Prod Inactive'
from Produto where Produto.Activo = 0
------------------
select count(Produto.codReferencia) as 'Prod Archived'
from Produto where Produto.Descontinuado = 1
------------------
select (select sum(StockArmazem.Qtd) from StockArmazem) + (select sum(StockPickup.Qtd) from StockPickup) as 'Total Items'
------------------
select sum(StockArmazem.Qtd) as 'Qty Items - Warehouse'
from StockArmazem
------------------
select sum(StockPickup.Qtd) as 'Qty Items - All ATMs'
from StockPickup
------------------
select count(Cliente.ID) as 'Total Shoppers'
from Cliente
------------------
select count(Cliente.ID) as 'Active'
from Cliente 
where activo = 1
------------------
select count(Cliente.ID) as 'Inactive'
from Cliente 
where activo = 0
------------------
select count(ExamesAnalises.id) as 'Total Exams'
from ExamesAnalises
------------------
select count(ExamesAnalises.id) as 'Exams this Month'
from ExamesAnalises
where Month(ExamesAnalises.DataPedido) = Month(GetDate()) and Year(ExamesAnalises.DataPedido) = Year(GetDate())
------------------
select count(ExamesAnalises.id) as 'Exams Today'
from ExamesAnalises
where Day(ExamesAnalises.DataPedido) = Day(GetDate()) and Month(ExamesAnalises.DataPedido) = Month(GetDate()) and 
Year(ExamesAnalises.DataPedido) = Year(GetDate())
------------------
SELECT top 1 Produto.Codreferencia,Produto.nome, Produto.imagem, count(Compra.prod_ref) as 'Most Popular'
from Produto inner join StockArmazem on Produto.Codreferencia = StockArmazem.Prod_Ref inner join Compra on Compra.Prod_Ref = Produto.Codreferencia
where Produto.Descontinuado = 0
group by Produto.Codreferencia,Produto.imagem, Produto.nome
order by 'Most Popular' desc
------------------
select top 1 Codreferencia as 'Ref', produto.nome as 'Name', produto.imagem, sum(Qtd) as 'Most Sold'
from Compra inner join produto on compra.Prod_ref = produto.Codreferencia
where Produto.Descontinuado = 0
group by Codreferencia, produto.nome, produto.imagem
order by 'Most Sold' DESC
------------------
Select top 3 Cliente.nome,DATEDIFF(year,datanascimento,GETDATE()) - iif(datepart(dayofyear,datanascimento) >datepart (dayofyear , getdate()),1,0) as 'age', Cliente.sexo
from cliente
order by Cliente.Id desc

COMMIT
END TRY
BEGIN CATCH
    --set @errorMessage = ERROR_MESSAGE();
	print ERROR_MESSAGE();
	ROLLBACK;
END CATCH
GO
-------------------------
exec usp_gatherStatistics
-------------------------

------inserts new seasonal ad types (winter, easter, xmas, etc)
GO
CREATE OR ALTER proc [dbo].[usp_insertSeasonalType](
										    @Description varchar(50),										    
										    @DateStart date,	
											@DateExpire date,
										    @errorMessage varchar(200) output)
AS
BEGIN TRY
BEGIN TRAN

IF EXISTS (SELECT '*' FROM Pub_Sazonal WHERE Pub_Sazonal.Descricao = @Description)
		THROW 70003, 'A Seasonal Type with that name already exists, try with a different name.', 10
	
	INSERT INTO Pub_Sazonal VALUES (@Description,@DateStart,@DateExpire)

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	print ERROR_MESSAGE();
	ROLLBACK;
END CATCH
GO
------------------------------
------inserts new client-centric ad types (male,female,child,teenager,adult,old,etc)
GO
CREATE OR ALTER proc [dbo].[usp_insertClientAdType](
										    @Description varchar(50),										    
										    @DateStart date,	
											@DateExpire date,
										    @errorMessage varchar(200) output)
AS
BEGIN TRY
BEGIN TRAN

IF EXISTS (SELECT '*' FROM Pub_Cliente WHERE Pub_Cliente.Descricao = @Description)
		THROW 70004, 'A Client-Centric Ad with that name already exists, try with a different name.', 10
	
	INSERT INTO Pub_Cliente VALUES (@Description,@DateStart,@DateExpire)

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	print ERROR_MESSAGE();
	ROLLBACK;
END CATCH
GO




/****************************************************

				[ SQL STORE FRONT ]

****************************************************/

-- [PROC] LOGIN
-- alteração: para introduzir conta guest 
GO
create or alter proc usp_clientLogin(@email varchar(100), @password varchar(100), @cookie varchar(50), @errorMessage varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

	IF NOT EXISTS(SELECT '*' FROM CLIENTE WHERE cliente.password = @password and cliente.email = @email)
		throw 60001, 'Email or password incorrect', 10

	IF NOT EXISTS(SELECT '*' FROM CLIENTE WHERE CLIENTE.EMAIL = @email and cliente.activo = 1)
		throw 60002, 'This account is currently inactive' , 10

	IF NOT EXISTS(SELECT '*' FROM CLIENTE WHERE CLIENTE.EMAIL = @email and cliente.firstActivation = 0)
		throw 60003, 'Please activate your account first' , 10

	UPDATE Carrinho 
	SET Carrinho.ID_Cliente = (select cliente.ID from Cliente where cliente.email = @email)
	WHERE Carrinho.Cookie = @cookie

	select * from cliente where cliente.email = @email

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	ROLLBACK;
END CATCH



-- [PROC] ALTER CLIENT DETAILS

GO
create or alter proc usp_recoverLoginPassword(@email varchar(100), @password varchar(50), @errorMessage varchar(200) output ) AS
BEGIN TRY
BEGIN TRAN

	if not exists(select '*' from cliente where cliente.email = @email)
		throw 60001, 'Email is incorrect or is not registered' , 10

	update cliente set cliente.password = @password where cliente.email = @email

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	ROLLBACK;
END CATCH



-- [PROC] CHANGE USER PASSWORD 
GO
create or alter proc usp_clientAlterPassword(@ID int, @oldPassword varchar(100), @newPassword varchar(100), @errorMessage varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

		IF NOT EXISTS(select '*' from Cliente where Cliente.password = @oldPassword)
			throw 60001, 'Inputed current password is incorrect.', 10;

		IF EXISTS (select cliente.password from cliente where cliente.password = @newPassword)
			throw 60003, 'The new password is the same as the old one.', 10

		update Cliente set cliente.password = @newPassword where cliente.ID = @ID
		set @errorMessage = 'Password is changed.'
COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	Rollback;
END CATCH


--[PROC] Activate user Account

select * from cliente

Go
create or alter PROCEDURE [dbo].[usp_activateAcc]
	
	@email varchar(100),
	@errorMessage varchar(200) output

AS
BEGIN TRY
BEGIN TRAN

    if exists (select '*' from Cliente where activo = 1 and email = @email)    
		throw 75001, 'This account is already activated.', 10;

    if exists (select '*' from Cliente where firstActivation = 0 and email = @email)
		throw 75002, 'This account has previously been through a first activation process.', 10;   
  
   update Cliente set activo = 1, firstActivation = 0 where email = @email      
 
COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();	
	ROLLBACK;
END CATCH
GO


-- [PROC] ALTER CLIENT DETAILS             
   
GO
CREATE OR ALTER PROC usp_editClientDetails(@ID int, 
										    @nome varchar(50), 
											@email varchar(100), 
											@morada varchar(300), 
											@nif varchar(20), 
											@codPostal varchar(20),
											@output varchar(200) output) AS
BEGIN TRY
BEGIN TRAN
			
			IF EXISTS(select '*' from cliente where cliente.nif = @nif AND Cliente.ID != @ID)
				THROW 60001, 'This NIF is already registered, if you think this is a mistake contact an administrator' , 10
			
	
			update Cliente set Cliente.nome = IIF(@nome = '', nome, @nome),
							   Cliente.email = IIF(@email = '', email, @email),
							   Cliente.morada = IIF(@morada = '', morada, @morada),
							   Cliente.nif = IIF(@nif = '', nif, @nif),
							   Cliente.codPostal = IIF(@codPostal = '', codPostal, @codPostal)
			where cliente.ID = @ID

COMMIT
END TRY
BEGIN CATCH
	set @output = ERROR_MESSAGE();
	ROLLBACK;
END CATCH

----------------------------------------------

--[PROC] RETURN SPECIFIC SELECTED ORDER DETAILS TO SPECIFIC USER
GO
create or alter proc usp_returnStoreFrontUserOrderDetails
						(@ID_cliente int,
						 @Enc_reference int)

AS
BEGIN TRY
BEGIN TRAN

select enc_ref as 'Ref', datacompra as'OrderDate',Estado.Descricao as 'Status', 
cliente.nome as 'clientName',cliente.morada as 'Address',EncomendaHistorico.ID_Pickup as 'pickupID', cliente.codPostal as 'zipCode', cliente.nif, cliente.email,
Compra.Prod_ref,Produto.nome as 'ProdName', Sum(Qtd) as 'Qty', Compra.PriceAtTime as 'Unit Price',
sum(compra.Total) as 'itemTotalPrice' 
from EncomendaHistorico inner join cliente on cliente.id = EncomendaHistorico.ID_Cliente
						inner join Compra on compra.ID_Encomenda = EncomendaHistorico.ENC_REF
						inner join Estado on estado.ID = EncomendaHistorico.ID_Estado
						inner join Produto on Produto.Codreferencia = Compra.Prod_ref
where EncomendaHistorico.ID_Cliente = @ID_cliente AND EncomendaHistorico.enc_ref = @Enc_reference
group by enc_ref, datacompra, cliente.nome, Estado.Descricao, cliente.morada,EncomendaHistorico.ID_Pickup, cliente.codPostal, cliente.nif, Compra.Prod_ref, Produto.nome, Compra.PriceAtTime, cliente.email

COMMIT
END TRY
BEGIN CATCH
	print ERROR_MESSAGE();	
	ROLLBACK;
END CATCH

-- [PROC] Returns the User's Orders

go
create or alter proc usp_repeaterOrderDetails(@enc_ref int) 


AS
BEGIN TRY
BEGIN TRAN
select Compra.Prod_ref,Produto.nome as 'ProdName', Sum(Qtd) as 'Qty', sum(Total) as 'Total', Compra.PriceAtTime as 'Unit Price' 
from EncomendaHistorico inner join Compra on Compra.ID_Encomenda = EncomendaHistorico.ENC_REF
						inner join Produto on Produto.Codreferencia = Compra.Prod_ref
					where Compra.ID_Encomenda = @enc_ref
					group by Prod_ref, Compra.PriceAtTime, Produto.Nome					

COMMIT
END TRY
BEGIN CATCH
	print ERROR_MESSAGE();	
	ROLLBACK;
END CATCH
-------------

--[PROC] RETURNS CART ITEMS FROM A SPECIFIED USER -- testar a precedência do OR
-- Comment da alteração: num OR que por é natureza boolean a 1º instrução é avaliada e se for true não corre a segunda fazendo o que se chama short-circuit 


go
create or alter proc usp_returnUserCartItems(@id_cliente int, @cookies varchar(50)) AS
BEGIN TRY
BEGIN TRAN

	    select
	    Produto.Codreferencia as 'Prod_Ref', 
		Produto.resumo as 'ProdSummary',
		Categoria.descricao as 'Category',
	    Produto.imagem as 'ProdImage',
	    Produto.nome as 'ProdName', 
	    Produto.preco as 'Unit Price', 
	    count(Carrinho.Prod_ref) as 'Qty', 
	    sum(Produto.preco) as 'itemTotalPrice' 

		from Produto inner join carrinho on Produto.Codreferencia = Carrinho.Prod_ref
					 inner join Categoria on Produto.ID_Categoria = Categoria.ID
		where Carrinho.ID_Cliente = IIF(@id_cliente = 0, null, @id_cliente) OR Carrinho.Cookie = @cookies 
		group by Produto.Codreferencia, Produto.imagem, Produto.nome, Produto.preco, produto.resumo, Categoria.descricao

COMMIT
END TRY
BEGIN CATCH
	print ERROR_MESSAGE();	
	ROLLBACK;
END CATCH

-----------

--[PROC] Delete selected Item from specific User's Cart
go
create or alter proc usp_DeleteSelectedCartItem(@id_cliente int, @Prod_Ref varchar(20), @Cookie varchar(50), @warning varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

	IF(@id_cliente = 0)
		Delete from carrinho where Prod_ref = @Prod_Ref AND Carrinho.Cookie = @Cookie
	ELSE
		Delete from carrinho where Prod_ref = @Prod_Ref AND Carrinho.ID_Cliente = @id_cliente 

COMMIT
END TRY
BEGIN CATCH
	set @warning = ERROR_MESSAGE();	
	ROLLBACK;
END CATCH

-- [PROC] displays products in the repeater AND SEARCHES

GO
create  or alter proc usp_displayShopProducts AS
select * from produto 
where Produto.Activo = 1

-- [PROC] searches products

GO
create  or alter proc usp_searchShopProducts(@query nvarchar(50)) AS
select * from produto 
where Produto.Activo = 1 AND (Produto.nome like '%' + @query + '%' OR Produto.descricao like '%' + @query + '%')


-- [PROC] adds items to the cart

GO
create or alter proc [dbo].[usp_addProdToCart](@ID int, @product varchar(20), @cookie varchar(50), @output varchar(200) output) AS
begin try
begin tran
		
    insert into Carrinho values(@ID, @product, @cookie)

commit
end try
begin catch
    set @output = ERROR_MESSAGE();
    rollback
end catch
GO

select * from Carrinho

-- [QUERYS] CATEGORY AND BRAND

-- Category

select Categoria.ID, Categoria.descricao , Count(Produto.ID_Categoria) as 'Count'
from Categoria left join Produto on Produto.ID_Categoria = Categoria.ID
group by Categoria.ID, Categoria.descricao

-- Brand

select Marca.ID, Marca.descricao , Count(Produto.ID_Marca) as 'Count'
from Marca left join Produto on Produto.ID_Categoria = Marca.ID
group by Marca.ID, Marca.descricao

-- SORTING 

-- PAGINAÇÃO ATRAVÉS DO SQL [EXEMPLO BACARDI SURF SHOP] 
-- Lógica: Se houver 500.000 produtos é melhor carregar apenas uma parte de cada vez do que todos.
/*
GO
create or alter proc productsPaginatedFiltered(@Campo varchar(100), @Ordem varchar(100), @Categoria varchar(100), @Pagina int, @ItemsPagina int) AS
SELECT produto.ID, 
	   produto.imagem, 
	   produto.titulo, 
	   produto.resumo, 
	   produto.preco, 
	   categoria.descricao 
FROM produto inner join categoria on produto.idCategoria = categoria.ID
WHERE categoria.descricao = IIF(@Categoria = 'Todos', categoria.descricao , @Categoria)
ORDER BY CASE WHEN @Campo = 'Preco' AND @Ordem = 'ASC' THEN produto.preco END,
		 CASE WHEN @Campo = 'Preco' AND @Ordem = 'DESC' THEN produto.preco END DESC,
		 CASE WHEN @Campo = 'Nome' AND @Ordem = 'ASC' THEN produto.titulo END,
		 CASE WHEN @Campo = 'Nome' AND @Ordem = 'DESC' THEN produto.titulo END DESC
OFFSET (@Pagina - 1) * @ItemsPagina ROWS
FETCH NEXT @ItemsPagina ROWS ONLY
*/
-- SORTING - AINDA SEM PAGINAÇÃO

GO
create or alter proc usp_productFiltering(@Campo varchar(50) , @Ordem varchar(50), @Categoria varchar(50), @Marca varchar(50)) AS
SELECT *
FROM produto inner join categoria on produto.ID_Categoria = categoria.ID
			 inner join marca on Produto.ID_Marca = Marca.ID
WHERE categoria.descricao = IIF(@Categoria = 'All', categoria.descricao , @Categoria) 
			 AND marca.descricao = IIF(@Marca = 'All', marca.descricao , @Marca) 
		     AND Produto.Activo = 1 
		     AND Produto.Descontinuado = 0
ORDER BY CASE WHEN @Campo = 'Preco' AND @Ordem = 'ASC' THEN produto.preco END,
		 CASE WHEN @Campo = 'Preco' AND @Ordem = 'DESC' THEN produto.preco END DESC,
		 CASE WHEN @Campo = 'Nome' AND @Ordem = 'ASC' THEN produto.nome END,
		 CASE WHEN @Campo = 'Nome' AND @Ordem = 'DESC' THEN produto.nome END DESC


-- [PROC] SOCIAL REGISTRY 

go
create or alter proc usp_socialLogin(@email varchar(50), 
								     @token varchar(300), 
									 @nome varchar(50), 
									 @cookie varchar(300),
									 @output varchar(200) output) AS
begin try
begin tran

		IF NOT EXISTS(SELECT '*' FROM CLIENTE WHERE CLIENTE.email = @EMAIL)
			INSERT INTO CLIENTE VALUES(@nome, @email, @token, null, 1 , 0 , null, null, null, null, null)

		IF @Cookie IS NOT NULL
		update carrinho
		set carrinho.ID_Cliente = (select Cliente.ID from Cliente where Cliente.email = @email)
		where carrinho.Cookie = @Cookie
commit
		select * from cliente where cliente.email = @email
end try
begin catch
	set @output = ERROR_MESSAGE();
	rollback
end catch


-- [ PROC ] ITEM DETAIL PAGE

GO
create or alter proc usp_returnItemDetailPage(@Reference varchar(20)) AS
select nome, preco, resumo, Produto.descricao, imagem, pdfFolheto,precisaReceita, Marca.descricao as 'Marca', Categoria.descricao as 'Categoria'
from produto inner join marca on produto.ID_Marca = marca.ID
			 inner join categoria on produto.ID_Categoria = Categoria.ID
where Produto.Codreferencia = @Reference
AND Produto.Activo = 1
AND Produto.Descontinuado = 0

-- [ PROC ] RELATED ITEM DETAIL PAGE

GO
create or alter proc usp_returnRelatedItemPage(@Reference varchar(20)) AS
select top(5) Codreferencia, nome, preco, resumo, Produto.descricao, imagem, pdfFolheto, Marca.descricao as 'Marca', Categoria.descricao as 'Categoria'
from produto inner join marca on produto.ID_Marca = marca.ID
			 inner join categoria on produto.ID_Categoria = Categoria.ID
where Produto.Codreferencia != @Reference
AND Produto.Activo = 1
AND Produto.Descontinuado = 0
AND Produto.ID_Categoria = (select Produto.ID_Categoria from Produto where Produto.Codreferencia = @Reference)

-- [ PROC ] RELATED ITEM DETAIL PAGE

GO
create or alter proc usp_returnRelatedGenericItem(@Reference varchar(20)) AS
select  Codreferencia, imagem
from Produto
where produto.ref_generico = @Reference
AND Produto.Activo = 1
AND Produto.Descontinuado = 0

-- [ PROC ] ITEM PAGE INSERT INTO CART

GO
create or alter proc usp_addDetailItemProduct(@ClientID int, @cookie varchar(50) , @reference varchar(20), @qty int) AS
begin try
begin tran

		WHILE(@qty> 0)
		BEGIN
			insert into carrinho values(@ClientID, @reference, @cookie)
			set @qty -= 1
		END

COMMIT
END TRY
BEGIN CATCH
	print ERROR_MESSAGE()
	ROLLBACK
END CATCH

-- [ PROC ] RETURN PERSONAL EXAMS 

GO
create or alter proc usp_returnExams(@ClientID int) AS
select * from ExamesAnalises inner join Estado on ExamesAnalises.ID_Estado = Estado.ID
							 inner join ExamesParceria on ExamesAnalises.ID_Parceria = ExamesParceria.ID
where ExamesAnalises.ID_Cliente = @ClientID

-- [ PROC ] SCHEDULE PERSONAL EXAMS

GO
create or alter proc usp_scheduleExam(@ClientID int, @DataPedido datetime, @ParceiroID int, @output varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

	IF EXISTS(select '*' from ExamesAnalises where ExamesAnalises.DataPedido = @DataPedido AND ExamesAnalises.ID_Parceria = @ParceiroID AND ExamesAnalises.ID_Cliente = @ClientID)
		throw 60001, 'There is already a scheduled exam for this date at this partner lab', 10

	insert into ExamesAnalises values(@ClientID, null, @DataPedido, 1, @ParceiroID)

COMMIT
END TRY
BEGIN CATCH
	set @output = ERROR_MESSAGE();
	ROLLBACK;
END CATCH

select * from ExamesAnalises

-- QUERY STOCK AVAILABILITY

select * from produto
select * from StockPickup

GO
create or alter proc usp_itemPageAvailability(@reference varchar(50)) AS

select 'Main Warehouse' as 'DistributionPoint', StockArmazem.Qtd as 'Qty', 
CASE
WHEN StockArmazem.Qtd between 1 and StockArmazem.QtdMin THEN 'Low Stock'
WHEN StockArmazem.Qtd < 1 THEN 'Out of Stock'
ELSE 'In Stock'
END AS StockStatus
from StockArmazem inner join Produto on StockArmazem.Prod_Ref = Produto.Codreferencia
where Produto.Codreferencia = @reference

UNION ALL

select Pickup.Descricao  as 'DistributionPoint', StockPickup.Qtd as 'Qty', 
CASE
WHEN StockPickup.Qtd between 1 and StockPickup.QtdMin THEN 'Low Stock'
WHEN StockPickup.Qtd < 1 THEN 'Out of Stock'
ELSE 'In Stock'
END AS StockStatus
from Pickup inner join StockPickup on Pickup.ID = StockPickup.ID_Stock_Pickup
			inner join Produto on Produto.Codreferencia = StockPickup.Prod_ref
where Produto.Codreferencia = @reference



-- [QUERY] Returns the stock of various ATMS

GO
create or alter proc usp_returnPickupStock(@PickupID int) AS
select * 
from StockPickup inner join Pickup on StockPickup.ID_Stock_Pickup = pickup.ID
				 inner join Produto on Produto.Codreferencia = StockPickup.Prod_ref
where Pickup.ID = @PickupID
AND Produto.Activo = 1 
AND Produto.Descontinuado = 0

select * from Pickup

-- [PROC] update the stock of a selected pickup atm

GO
create or alter proc usp_alterPickupStock (@pickupID int, @prodref varchar(50), @qtd int, @qtdmin int, @qtdmax int, @errorMessage varchar(200) output) AS
begin try
begin tran
		
		update StockPickup
		SET Qtd = IIF(@qtd >= 0, @qtd, qtd),
			QtdMin = IIF(@qtdmin >= 0, @qtdmin, QtdMin),
			QtdMax = IIF(@qtdmax >= 0, @qtdmax, QtdMax)
		WHERE StockPickup.Prod_ref = @prodref AND StockPickup.ID_Stock_Pickup = @pickupID

commit
end try
BEGIN catch
	set @errorMessage = ERROR_MESSAGE();
	rollback
END CATCH


/* LOG: TRIGGER */

-- 1º se existir algum registo modificado em que o produto final da mudança seja estado = 1 temos de procurar quais o items e quantidades
-- para fazer update no stock.

-- //Isto leva-nos a outro problema, porque preciso de saber se foi o stockarmazem ou o stockpickup -> resolvido no if com o ID.Pickup a null
-- //portanto preciso agora de saber quais as quantidades e os items da tabela, como é a tabela encomenda tenho de fazer o inner join com a compra
-- //e percorrer para saber que items e quantidades necessito de fazer update

-- Preciso de acrescentar segurança contra o administrador alterar o estado para 1 mesmo que não haja quantidade suficiente no stock para enviar
-- como fazer chegar-lhe este erro ? isto é um trigger 
-- preciso de fazer o caso em que é ATM
-- preciso de acrescentar o bit para que o trigger só corra se o estado só tenha sido alterado 1 vez


-- TESTING OUTCOME

--  1 encomenda, 1 item - funciona
--  1 encomenda, 1 item, mais de que 1 quantidade - funciona
--  1 encomenda, vários items, mais do que 1 quantidade - funciona


/* TESTE DE CASOS */

select * from EncomendaHistorico inner join Compra on EncomendaHistorico.ENC_REF = Compra.ID_Encomenda order by DataCompra DESC
select * from StockArmazem where Prod_Ref = 'G43434LO' -- QTD É 10 DE MOMENTO


select * from compra order by Compra.ID_Encomenda DESC

-- TESTE
UPDATE EncomendaHistorico SET ID_Estado = 1 WHERE ENC_REF = 63



-- TRIGGER PARA QUANTIDADES v1.0 (só está prepardo para update ainda não se tratou do insert)
GO
Alter trigger t_updateStockQts on EncomendaHistorico after insert, update AS 
begin TRY
begin TRAN

        -- VARIAVEIS
            DECLARE
                @cItem varchar(50),
                @cItemQty int;

        -- CASO 1 | retirar quantidades do armazém principal caso haja uma mudança de 0 para 1 numa compra do armazém principal
        IF EXISTS (select '*' from inserted inner join deleted on inserted.ENC_REF = deleted.ENC_REF where inserted.ID_Estado = 1 AND inserted.ID_Pickup is null)
        BEGIN

            -- DEBUGGING
            SELECT * from inserted inner join deleted on inserted.ENC_REF = deleted.ENC_REF where inserted.ID_Estado = 1 AND inserted.ID_Pickup is null

            -- CURSOR
            DECLARE CURSOR_COMPRA CURSOR
            FOR SELECT
                COMPRA.Prod_ref,
                COMPRA.Qtd
            FROM COMPRA INNER JOIN inserted ON COMPRA.ID_Encomenda = inserted.ENC_REF   -- porque precisamos de saber qual é a compra afecta

            -- percorrer a tabela compra para verificar os items e quantidades, relacionar com a inserted para obter o quê... a ENC_REF
            OPEN CURSOR_COMPRA;
            FETCH NEXT FROM CURSOR_COMPRA INTO
                @cItem,  -- O produto na compra
                @cItemQty; -- a quantidade do produto na compra
            
            WHILE @@FETCH_STATUS = 0
                BEGIN
                    update StockArmazem set StockArmazem.Qtd -= @cItemQty where StockArmazem.Prod_Ref = @cItem -- para retirar o stock do armazém do produto apropriado
                    FETCH NEXT FROM CURSOR_COMPRA INTO -- continuar a apanhar rows
                    @cItem,  -- O produto na compra
                    @cItemQty; -- a quantidade do produto na compra
                END

            CLOSE CURSOR_COMPRA;
            DEALLOCATE CURSOR_COMPRA;
        END

COMMIT
end TRY
begin CATCH
    PRINT ERROR_MESSAGE();
    PRINT ERROR_LINE();
    ROLLBACK;
END CATCH


-- [QUERY] returns all restock items

GO
alter proc usp_ItemsNeedingRestock AS
select 'Main Warehouse' as 'Warehouse', 0 AS 'warehouseID' , Produto.Codreferencia as 'ProductRef', Produto.nome as 'ProductName', StockArmazem.Qtd, StockArmazem.QtdMin, StockArmazem.QtdMax
from StockArmazem inner join Produto on StockArmazem.Prod_Ref = Produto.Codreferencia
where StockArmazem.Qtd <= StockArmazem.QtdMin
UNION ALL
select Pickup.Descricao as 'ATM', StockPickup.ID_Stock_Pickup AS 'warehouseID', Produto.Codreferencia as 'ProductRef', Produto.nome as 'ProductName', StockPickup.Qtd, StockPickup.QtdMin, StockPickup.QtdMax
from Pickup inner join StockPickup on  StockPickup.ID_Stock_Pickup = Pickup.ID
            inner join Produto on Produto.Codreferencia = StockPickup.Prod_ref
where StockPickup.Qtd <= StockPickup.QtdMin
order by Produto.nome -- determinar qual é a melhor coluna para se ordernar


-- [ PROC ] restock items, either all or just a selected few

GO
ALTER PROC usp_restockItems(@reference varchar(20), @Qty int, @IDpickup int, @warning varchar(200) output) AS
begin TRY
BEGIN TRAN


        IF @Qty < 0
            THROW 60001, 'Inserted quantity below 0, update failed' , 10

        IF @IDpickup > 0
            update StockPickup set StockPickup.Qtd = @Qty where StockPickup.Prod_ref = @reference AND StockPickup.ID_Stock_Pickup = @IDpickup
        ELSE 
            update StockArmazem set StockArmazem.Qtd = @Qty where StockArmazem.Prod_Ref = @reference

COMMIT
END TRY
BEGIN CATCH
    set @warning = ERROR_MESSAGE();
    ROLLBACK;
END CATCH


-- [QUERY] returns focused ads depending on the type of client shopping at the moment. [INCOMPLETE] needs to account for future client types

GO
ALTER PROC usp_getRelevantAds(@clientGender char(1), @clientBirthday date) AS
BEGIN TRY
BEGIN TRAN

    declare @clientAge int
    declare @clientType varchar(20) -- inicialização a nulo

    if(@clientBirthday is not null)
    BEGIN
        set @clientAge = DATEDIFF(year, @clientBirthday, GETDATE()) - iif(datepart(dayofyear, @clientBirthday) > datepart (dayofyear , getdate()), 1, 0)

        set @clientType = case 
            when @clientAge < 25 then 'Young'
            when @clientAge between 25 and 60 then 'Adult'
            when @clientAge > 60 then 'Old'
        end
    END

    SELECT Publicidade.Imagem, Pub_Sazonal.Descricao, Publicidade.Tipo as 'adType'
    FROM Publicidade inner join Pub_Sazonal on Publicidade.ID_Pub_Sazonal = Pub_Sazonal.ID
    WHERE getdate() between Pub_Sazonal.DataStart and Pub_Sazonal.DataExpiracao 

    UNION

    Select Publicidade.Imagem, Pub_Cliente.Descricao, Publicidade.Tipo as 'adType'
    FROM Publicidade inner join Pub_Cliente on Publicidade.ID_Pub_Cliente = Pub_cliente.ID
    WHERE Pub_Cliente.Descricao LIKE IIF(@clientType IS NULL, '[^MF]%', @clientType) OR LEFT(Pub_Cliente.Descricao, 1) LIKE IIF(@clientGender IS NULL, '[MF]%', @clientGender)
    
    COMMIT
    END TRY
    begin catch
        print error_message();
        rollback;
    end catch


    -- 1º teste nulo, nulo deve aparecer tudo check
    -- 2º teste genero, nulo deve aparecer tudo e apenas 1 genero check
    -- 3º teste nulo, idade deve aparecer todos os generos e apenas aquela idade check

    exec usp_getRelevantAds 'M', '1989-01-01'


	-- [ QUERY ] directed ads
GO
CREATE OR ALTER PROC [dbo].[usp_PersonalizedAds] (@ClienteID int, @Cookie varchar(100)) AS 
BEGIN TRY
BEGIN TRAN

DECLARE @interest table(
    cName varchar(100) null,
    cTimes int null
)

insert into @interest
select top 3 Categoria.descricao as 'Category', Count(Categoria.ID) as 'Category#'
from  EncomendaHistorico inner join Compra on EncomendaHistorico.ENC_REF = Compra.ID_Encomenda
                         inner join Cliente on EncomendaHistorico.ID_Cliente = Cliente.ID
                         inner join Produto on Compra.Prod_ref = Produto.Codreferencia
                         inner join Categoria on Produto.ID_Categoria = Categoria.ID
                         inner join Carrinho on Carrinho.Prod_ref = Produto.Codreferencia
where Carrinho.Cookie = @Cookie or EncomendaHistorico.ID_Cliente = IIF(@ClienteID = 0, null, @ClienteID)
GROUP by Categoria.descricao
ORDER BY 'Category#' desc


select Produto.imagem, Produto.nome, Produto.preco 
from Produto inner join Categoria on Produto.ID_Categoria = Categoria.ID
where Categoria.descricao in (select cName from @interest)
ORDER BY Produto.nome

COMMIT
END TRY
BEGIN CATCH
    ROLLBACK;
END CATCH