create database livraria;

use livraria;

create table Cliente (
	idCliente int primary key not null,
    nome varchar(50) not null,
    telefone varchar(20) not null,
    email varchar(50) not null,
    endereco varchar(100) not null
);

create table Pedido (
	idPedido int primary key not null,
    idCliente int not null,
    dataPedido date not null,
    valorPedido decimal(5,2) not null,
    foreign key (idCliente) references Cliente(idCliente)
);

create table Editora (
	idEditora int primary key not null,
    nome varchar(50) not null, 
    telefone varchar(20) not null,
    email varchar(50) not null,
    endereco varchar(100) not null
);    

create table Livro (
	idLivro int primary key not null,
    idEditora int not null, 
    titulo varchar(100) not null,
    autor varchar(50) not null,
    ano int not null,
    ISBN varchar(20) not null,
    preco decimal (5,2) not null,
    foreign key (idEditora) references Editora(idEditora)
);

create table ItemPedido (
	idPedido int not null,
    idLivro int not null,
    quantidade int not null,
    valorItemPedido decimal (5,2) not null,
    foreign key (idPedido) references Pedido(idPedido),
    foreign key (idLivro) references Livro(idLivro)
);

create table Estoque (
	idLivro int not null,
    quantidade int not null,
    foreign key (idLivro) references Livro(idLivro)
);


select count(idLivro) as 'Quantidade de livros cadastrados' from Livro;


select nome as 'Nome dos clientes cadastrados' from Cliente order by nome asc;


select nome as 'Editora', titulo as 'Titulo dos livros/Editora'
from Livro
inner join Editora
on Livro.idEditora = Editora.idEditora
order by nome desc;


select Editora.nome as 'Editora', avg(livro.preco) as 'Média de preço dos livros/editora' from Editora, livro
where Editora.idEditora = livro.idEditora
group by nome;


select Cliente.nome as 'Nome da totalidade de clientes', sum(ItemPedido.quantidade) as 'Quantidade de livros comprados/cliente' from Cliente, ItemPedido
where Cliente.idCliente = ItemPedido.idPedido
group by Cliente.idCliente
having count(quantidade) = count(ItemPedido.valorItemPedido) and count(ItemPedido.valorItemPedido) = count(ItemPedido.idPedido);

