/**
	Lojinha
    @author Maria Fiori
    @version 1.0
*/

create database MariaTintas;
use MariaTintas;


create table usuarios(
	idusu int primary key auto_increment,
    usuario varchar(255) not null,
    login varchar(255) not null unique,
    senha varchar(255) not null,
    perfil varchar(255) not null
);

describe usuarios;

insert into usuarios (usuario,login,senha,perfil)
values ('Administrador','admin',md5('admin'),'admin');
insert into usuarios (usuario,login,senha,perfil)
values ('Maria','maria',md5('123456'),'usercaixa');

select * from usuarios;

select * from usuarios where login='admin' and senha=md5('admin');
-- ----------------------------------------------------------------------------------
create table fornecedores(
	idfor int primary key auto_increment,
    cnpj varchar(14) not null unique,
    ie varchar(14) unique,
    im varchar(14) unique,
    razao varchar(255) not null,
    fantasia varchar(255) not null,
    site varchar(255),
    telefone varchar(8),
    contato varchar(20),
    email varchar(50),
    cep varchar(8) not null,
    endereco varchar(255) not null,
    numero varchar(10)not null,
    complemento varchar(10),
    bairro varchar(255) not null,
    cidade varchar(255) not null,
    uf varchar(2) not null
);

insert into fornecedores(cnpj,ie,im,razao,fantasia,telefone,email,cep,numero,bairro,cidade,uf)
values(536478928390,5674,7483,'Luckscolor','Luckscolor tintas ltda','25346789','luckscolor@email.com',
08150190,314, 'jardim brasil','SP','SP');

insert into fornecedores(cnpj,ie,im,razao,fantasia,telefone,email,cep,numero,bairro,cidade,uf)
values (35489765490,7680,9034,'Tigre','Tigre materiais e soluções para construção ltda','25139087','tigresolucoes@email.com',
08576934,1276,'jardim vila alpina','SP','SP');

select * from fornecedores;
-- ----------------------------------------------------------------------------------

create table Produtos(
	idprod int primary key auto_increment,
    barcode varchar(13) unique,
	produto varchar(50) not null,
    lote varchar(12)not null,
    descricao varchar(255) not null,
    fabricante varchar(255) not null,
    datacad timestamp default current_timestamp,
    dataval date,
    estoque int not null,
    estoquemin int not null,
    unidade varchar(10) not null,
    localizacao varchar(255),
    custo decimal(10,2),
    lucro decimal(10,2),
    venda decimal(10,2),
    idfor int not null,
    foreign key(idfor) references fornecedores(idfor)
);

describe Produtos;

insert into Produtos (barcode,produto,lote,descricao,fabricante,dataval,estoque,estoquemin,unidade,
localizacao,custo,lucro,venda,idfor)
values (
'123456789045','Tinta Cinza chumbo','M647G','Tinta cinza chumbo 18L','Luckscolor',20210523,20,5,'UN','Setor 7, prateleleira 3',75.00,100,150.00,1);

insert into Produtos (barcode,produto,lote,descricao,fabricante,dataval,estoque,estoquemin,unidade,
localizacao,custo,lucro,venda,idfor)
values (246810456456,'Solvente','Solvente Luckscolor 900ml','457GH','Luckscolor','20200921',8,4,'UN','Setor 6, fileira 8',13.50,100,27.90,1);

insert into Produtos (barcode,produto,lote,descricao,fabricante,estoque,estoquemin,unidade,
localizacao,custo,lucro,venda,idfor)
values (112233356789,'Kit para pintura',63892,'Kit para pintura 3 peças Tigre','Tigre',12,9,'UN','Prateleira 3',10.00,100,20.00,2);

insert into Produtos (barcode,produto,lote,descricao,fabricante,estoque,estoquemin,unidade,
localizacao,custo,lucro,venda,idfor)
values (454342567890,'Rolo de lã',92893,'Rolo de lã anti respingo 15cm Tigre','Tigre',1,3,'UN','Prateleira 3',2.50,100,5.00,2);

insert into Produtos (barcode,produto,lote,descricao,fabricante,estoque,estoquemin,unidade,
localizacao,custo,lucro,venda,idfor)
values (3132335643214,'Folha de lixa d´agua',73948,'Folha de lixa d´agua Tigre','Tigre',10,25,'UN','Prateleira 1',1.50,100,3.00,2);

select * from Produtos;

/* relatórios */
-- inventário do estoque (patrimônio do dono) 
-- sum() função de soma no banco de dados
select sum(estoque*custo) as total from Produtos;

-- relatório de reposição de estoque 1
select * from Produtos where estoque < estoquemin;

-- relatório de reposição de estoque 2
-- date_format() (função usada para formatar a data)
-- %d/%m/Y% = dia/mês/aaaa ou %d/%m/%y = dia/mês/aa

select idprod as ID,Produto,
date_format(dataval,'%d/%m/%Y') as data_validade,
estoque,estoquemin as estoque_mínimo
from Produtos where estoque < estoquemin;

-- relatório de validade de produtos 1
select idprod as ID,Produto,
date_format(dataval,'%d/%m/%Y') as data_validade
from Produtos;

-- relatório de validade de produtos 2
-- datediff() calcula a diferença em dias
-- curdate() obtém a data atual
select idprod as ID,produto,
date_format(dataval,'%d/%m/%Y') as data_validade,
datediff(dataval,curdate()) as dias_faltantes
from Produtos;

-- --------------------------------------------------------------------------------------------
create table clientes(
	idcli int primary key auto_increment,
    nome varchar(255) not null,
	datanasc date not null,
    telefone varchar(20) not null,
    cpf varchar(14),
    email varchar(255),
    marketing varchar(3) not null,
    cep varchar(8),
    endereco varchar(255),
    bairro varchar(255),
    cidade varchar(255),
    uf char(2)
);

 insert into clientes (nome,datanasc,telefone,cpf,email,marketing,cep,bairro,cidade,uf)
 values ('Gustavo Rene',20030412,11997785647,54678920509,'gustarene@email.com','Sim',08495890,'jardim palmeiras','São Paulo','SP');
 
insert into clientes (nome,datanasc,telefone,cpf,email,marketing,cep,endereco,bairro,cidade,uf)
 values ('Maria',20030422,119977925986,56789012356,'mariamaria@email.com','Não',08150190,'rua toquinho da silva','jardim robru','São Paulo','SP');

-- relatório contatos
 select idcli as ID,Nome,Telefone,email
from clientes;

-- relatório marketing
 select email from clientes where marketing=('Sim');
 
select * from clientes;
describe clientes;

-- ----------------------------------------------------------------------------------------------
create table pedidos(
	pedido int primary key auto_increment,
    dataped timestamp default current_timestamp,
    total decimal (10,2),
    idcli int not null,
    foreign key(idcli) references clientes(idcli)
); 

insert into pedidos(idcli) 
values(1);
insert into pedidos(idcli) 
values(2);


select * from pedidos;

select * from pedidos inner join clientes on pedidos.idcli = clientes.idcli;

select pedidos.pedido, date_format(pedidos.dataped,'%d%/%m/%Y - %H:%i') as data_ped,
clientes.nome as clientes, clientes.telefone as telefone
from pedidos inner join clientes on pedidos.idcli = clientes.idcli;

-- ----------------------------------------------------------------------------------------------

select 
	Produtos.idprod as Produtos,
    Produtos.produto as Produto,
    date_format(Produtos.datacad,'%d%/%m/%Y - %H:%i') as Data_cad,
	fornecedores.fantasia as Fornecedores, 
	fornecedores.telefone as Telefone
	from fornecedores inner join Produtos on fornecedores.idfor = Produtos.idfor;
-- ------------------------------------------------------------------------------------------
create table carrinho(
	pedido int not null,
    idprod int not null,
    quantidade int not null,
    foreign key(pedido) references pedidos(pedido),
    foreign key(idprod) references Produtos(idprod)
);

insert into carrinho (pedido,idprod,quantidade)
values (1,1,3);
insert into carrinho (pedido,idprod,quantidade)
values (2,2,5);

select * from carrinho;

-- exibir o carrinho 
select pedidos.pedido as Pedidos,
carrinho.idprod as Código,
Produtos.produto as Produtos,
carrinho.quantidade as Quantidade,
Produtos.venda,
Produtos.venda*carrinho.quantidade as Subtototal
from (carrinho inner join pedidos on carrinho.pedido = pedidos.pedido)
inner join Produtos on carrinho.idprod = Produtos.idprod;

-- total do pedido que está no carrinho "Fechamento"
select sum(Produtos.venda*carrinho.quantidade) as Total
from carrinho inner join Produtos on carrinho.idprod = Produtos.idprod;

-- atualização do estoque
update carrinho 
inner join Produtos on carrinho.idprod = Produtos.idprod
set Produtos.estoque = Produtos.estoque - carrinho.quantidade 
where carrinho.quantidade > 0;