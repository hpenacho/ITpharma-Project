create database ProjectoFinal
use ProjectoFinal


--Criação de Tabelas


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
	PDF varbinary(MAX)
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
	DataExpiracao date null check(DataExpiracao > getdate()),
)

create table Publicidade(

	ID int identity primary key,
	Imagem varbinary(MAX) not null,
	Tipo bit, -- 0 info do cliente, 1 sazonal
	ID_Pub_Sazonal int references Pub_Sazonal(ID)
)


-- INSERTS, UPDATES, DELETES

/* COMENTÁRIOS 

BUGS - É POSSÍVEL O PRODUTO SER O SEU PRÓPRIO GENÉRICO
	   É POSSÍVEL REACTIVAR UM PRODUTO COM MARCA E CATEGORIA NULA	
	   [ATENÇÃO: CRIAR REFERENCIA ÚNICA INACTIVA PARA UM GENERICO SEM PAI]

DECISÕES -

	    NÃO SE APAGA PRODUTOS, fica INACTIVO

*/

SELECT * FROM Produto
select * from Categoria
select * from marca
insert into Produto values('XY1', 'XOXOTA', 9898.98, 'RESUMO', 'DESCRICAO DESTA PORRA ENORMA', NULL, NULL, 2,2,0, NULL, 1 )
insert into Produto values('XY2', 'XOXOTA GENERICA', 9898.98, 'RESUMO', 'DESCRICAO DESTA PORRA ENORMA', NULL, NULL, 3,3,0, 'ZX4', 1 )
insert into Produto values('ZX3', 'XOXOTA GENERICA 3', 9898.98, 'RESUMO', 'DESCRICAO DESTA PORRA ENORME', NULL, NULL , 3,3,0, null, 1 )
insert into Produto values('ZX4', 'XOXOTA GENERICA 4', 9898.98, 'RESUMO', 'DESCRICAO DESTA PORRA ENORME', NULL, NULL , 3,3,0, null, 1 )
insert into Produto values('GEN2', 'XOXOTA GENERICA 2', 9898.98, 'RESUMO', 'DESCRICAO DESTA PORRA ENORME', NULL, NULL , 3,3,0, 'ZX4', 1 )


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
								   @PDF varbinary(MAX)) as
begin try
begin tran 
		
		insert into EncomendaHistorico values(@IDcliente, 1, getdate(), getdate(), @MoradaEntrega, @Pickup, @PDF)

		insert into compra
		select (select Max(EncomendaHistorico.ENC_REF) from EncomendaHistorico), Prod_ref AS 'Produto', count(Prod_ref) AS 'QTD' , sum(produto.preco) AS 'Total'
		from Carrinho inner join Produto on Carrinho.Prod_ref = Produto.Codreferencia
		where Carrinho.ID_Cliente = @IDcliente
		group by Prod_ref

		DELETE FROM carrinho WHERE carrinho.ID_Cliente = @IDcliente;

commit
end try
begin catch
	print ERROR_Message()
	rollback;
end catch

-- QUERY PARA UTILIZADOR VER A SUA ENCOMENDA NA ÁREA PESSOAL

select EncomendaHistorico.ENC_REF, Estado.Descricao AS 'Estado', EncomendaHistorico.UltimaActualizacao, EncomendaHistorico.DataCompra, sum(Compra.Qtd) ,sum(Compra.Total) , EncomendaHistorico.PDF
from  EncomendaHistorico inner join Compra on EncomendaHistorico.ENC_REF = Compra.ID_Encomenda 
						 inner join Estado on EncomendaHistorico.ID_Estado = Estado.ID
						 inner join Cliente on EncomendaHistorico.ID_Cliente = Cliente.ID
where Cliente.ID = @IDCLIENTE 
group by EncomendaHistorico.ENC_REF, Estado.Descricao, EncomendaHistorico.UltimaActualizacao, EncomendaHistorico.DataCompra, EncomendaHistorico.MoradaEntrega, EncomendaHistorico.PDF


-- STORED PROCEDURE loginBackOffice
-- esta usp simplesmente verifica se os dados introduzidos no login sao simultaneamente validos
--caso nao sejam, será devolvida msg de erro, cuja falta de presença implica login com sucesso. 
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


-- [PROCEDURE] INSERT BRANDS BACKOFFICE - FILIPE
GO
create or alter proc usp_insertCategory (@descricao varchar(100), @errorMessage varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

	IF EXISTS (SELECT '*' from Categoria where descricao = @descricao)
		THROW 60001,'The category specified already exists' ,10

	insert into Categoria values(@descricao)

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	ROLLBACK;
END CATCH

-- [PROCEDURE] INSERT CATEGORIES BACKOFFICE - FILIPE

GO
create or alter proc usp_insertBrand(@descricao varchar(100), @errorMessage varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

	IF EXISTS (SELECT '*' from Marca where descricao = @descricao)
		THROW 60001,'The brand specified already exists' ,10

	insert into Marca values(@descricao)

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
		THROW 60001,'The brand specified already exists' , 10

	update Marca set Marca.descricao = @descricao where Marca.ID = @ID

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	ROLLBACK;
END CATCH

-- [PROCEDURE] DELETE BRAND

GO 
CREATE OR ALTER PROC usp_deleteBrand(@ID int) AS
BEGIN TRY
BEGIN TRAN

	delete from Marca where Marca.ID = @ID

COMMIT
END TRY
BEGIN CATCH
	ROLLBACK;
END CATCH

-- [PROCEDURE] UPDATE CATEGORY

GO 
CREATE OR ALTER PROC usp_updateCategory(@ID int, @descricao varchar(100), @errorMessage varchar(200) output) AS
BEGIN TRY
BEGIN TRAN

	IF EXISTS (SELECT '*' from Categoria where descricao = @descricao AND Categoria.ID != @ID)
		THROW 60001,'The category specified already exists' , 10

	update Categoria set Categoria.descricao = @descricao where Categoria.ID = @ID

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	ROLLBACK;
END CATCH

-- [PROCEDURE] DELETE CATEGORY

GO 
CREATE OR ALTER PROC usp_deleteCategory(@ID int) AS
BEGIN TRY
BEGIN TRAN

	delete from Categoria where Categoria.ID = @ID

COMMIT
END TRY
BEGIN CATCH
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

-- [PROCEDURE] LIST PRODUCT DETAILS BACKOFFICE

GO
CREATE OR ALTER PROC usp_listBackofficeProductDetails(@item varchar(20)) AS
SELECT * 
from Produto inner join StockArmazem on Produto.Codreferencia = StockArmazem.Prod_Ref
WHERE Produto.Codreferencia = @item


-- [QUERY] DELETE PRODUCT BACKOFFICE \\ Product is discontinued

GO
CREATE OR ALTER PROC usp_disableBackofficeProduct(@item varchar(20)) AS
update produto set produto.Descontinuado = 1, produto.Activo = 0 where Produto.Codreferencia = @item


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

	INSERT INTO Cliente VALUES (@nome, @email, @password, @morada, 0, 1, @nif, @nrSaude, @sexo, @dataNascimento)

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
SELECT Publicidade.ID, Publicidade.imagem, publicidade.ID_Pub_Sazonal, Pub_Sazonal.Descricao, Pub_Sazonal.DataExpiracao
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

	INSERT INTO Publicidade VALUES (@imagem,1,@id_pub_sazonal)

COMMIT
END TRY
BEGIN CATCH
	set @errorMessage = ERROR_MESSAGE();
	print ERROR_MESSAGE();
	ROLLBACK;
END CATCH
GO

--- [USP] DELETES THE SELECTED SEASONAL AD
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

GO
create or alter proc usp_returnBackofficeOrderProducts (@ID int) as
select * from Compra inner join produto on compra.Prod_ref = Produto.Codreferencia
where id_encomenda = @ID

-- [PROC] UPDATES AN ORDER'S STATE

GO
create or alter proc usp_updateOrderStatus() -- MUDAR MAIS TEMPO