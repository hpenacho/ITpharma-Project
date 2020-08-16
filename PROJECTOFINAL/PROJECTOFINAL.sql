create database ProjectoFinal
use ProjectoFinal


--Cria��o de Tabelas


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
	dataNascimento date not null
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
	Activo bit default 1
)

create table Carrinho(

	ID_Cliente int references Cliente(ID) ON DELETE CASCADE,
	Prod_ref varchar(20) references Produto(Codreferencia) ON DELETE CASCADE,
	Cookie varchar(50) null
)

create table Compra(
	
	ID_Encomenda int references EncomendaHistorico(ENC_REF) ON DELETE CASCADE,
	Prod_ref varchar(20) references Produto(Codreferencia),
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
	ID_Receita int references Receita(REC_REF), -- na eventualidade de dar bid�, meter on delete cascade
	primary key(Prod_ref, ID_Receita)
)

create table Receita( -- � partida n�o se apaga receita 
	
	REC_REF int identity primary key,
	Cod_Medico varchar(50) not null,
	DataExpiracao date default Dateadd(day, 15, getdate()),
	Levantada bit,
	NrSaude varchar(20) null, -- N�O EST� LIGADA EM SQL MAS SERVE DE AUTENTICA��O NO C#
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

/* COMENT�RIOS 

BUGS - � POSS�VEL O PRODUTO SER O SEU PR�PRIO GEN�RICO
	   � POSS�VEL REACTIVAR UM PRODUTO COM MARCA E CATEGORIA NULA	
	   [ATEN��O: CRIAR REFERENCIA �NICA INACTIVA PARA UM GENERICO SEM PAI]

	   TESTE DE PULLS, PUSH, MERGES *!*!*!*!**!*!*!*!*!!*!*!**
	   !**!!*!*!*!**!*!*!*!!*!*
	   *!**!*!*!*!*!*!*!!!** BUMBUM

	   Coment�rio filipe cancelinha 
	   Coment�rio Hugo Penacho

DECIS�ES -

	    N�O SE APAGA PRODUTOS, fica INACTIVO

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

--	APAGAR PRODUTO TENDO EM CONTA O GEN�RICO [ATEN��O: CRIAR REFERENCIA �NICA INACTIVA PARA UM GENERICO SEM PAI]

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

select * from produto
delete from produto

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
	   StockArmazem.Qtd As 'Stock Armaz�m', 
	   StockPickup.Qtd As 'Stock Pickup', StockPickup.QtdMin As 'Stock Min', 
	   StockPickup.QtdMax  As 'Stock Max', 
	   case 
	   when StockPickup.Qtd <= StockPickup.QtdMin then 'Pedir Stock'
	   when StockPickup.Qtd > StockPickup.QtdMax then 'Excesso Stock'
	   ELSE 'Nominal'
       END AS 'Estado do Armaz�m'

from Pickup inner join StockPickup on Pickup.ID = StockPickup.ID_Stock_Pickup
			inner join Produto on Produto.Codreferencia = StockPickup.Prod_ref
			inner join StockArmazem on StockArmazem.Prod_Ref = Produto.Codreferencia


-- Inserir uma Encomenda ap�s compra 

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

commit
end try
begin catch
	print ERROR_Message()
	rollback;
end catch

-- QUERY PARA UTILIZADOR VER A SUA ENCOMENDA NA �REA PESSOAL

select EncomendaHistorico.ENC_REF, Estado.Descricao AS 'Estado', EncomendaHistorico.UltimaActualizacao, EncomendaHistorico.DataCompra, sum(Compra.Qtd) ,sum(Compra.Total) , EncomendaHistorico.PDF
from  EncomendaHistorico inner join Compra on EncomendaHistorico.ENC_REF = Compra.ID_Encomenda 
						 inner join Estado on EncomendaHistorico.ID_Estado = Estado.ID
						 inner join Cliente on EncomendaHistorico.ID_Cliente = Cliente.ID
where Cliente.ID = @IDCLIENTE 
group by EncomendaHistorico.ENC_REF, Estado.Descricao, EncomendaHistorico.UltimaActualizacao, EncomendaHistorico.DataCompra, EncomendaHistorico.MoradaEntrega, EncomendaHistorico.PDF

--

select * from produto

