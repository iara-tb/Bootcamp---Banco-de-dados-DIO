create database Oficina;

use oficina;

create table cliente(
idCliente int auto_increment primary key,
nome varchar (30),
nomeDoMeio varchar(25),
sobrenome varchar (40),
CPF varchar (12) not null,
dataNascimento date,
gênero enum('Mulher','Homem','MulherT','HomemT','Não Binário') not null,
endereco_rua_n  varchar(150),
bairro varchar(35),
cidade varchar(200),
estado varchar(2),
placaCarro varchar(8),
modelo varchar(20),
observacoes varchar (500),
corCarro varchar(15),
anoCarro varchar(4),
fone varchar(15)not null,
email varchar(40));


alter table clienteOS add column solicitacaoCliente varchar(500);
create table mecanico(
idMecanico int auto_increment primary key,
nome varchar (30),
nomeDoMeio varchar(25),
sobrenome varchar (40),
CPF varchar (12) not null,
dataNascimento date,
gênero enum( 'Mulher','Homem','MulherT','HomemT','Não Binário') not null,
endereco_rua_n  varchar(150),
bairro varchar(35),
cidade varchar(200),
estado varchar(2),
fone varchar(15)not null,
email varchar(40),
especialidade varchar(200));

create table clienteOS(
idOScliente int,
nome varchar (30),
sobrenome varchar (40),
dataEntrada datetime,
constraint fk_idOS foreign key (idOSCliente) references OS(idOS));

create table pagamento(
idCliente int,
idpayments int auto_increment primary key,
accepted_cards enum("Visa","Master Card","American Express","Nubank",'Dinheiro')not null,
constraint fk_idCliente foreign key (idCliente) references cliente(idCliente));

create table OS(
idOS int auto_increment primary key,
idMecanico int,
status enum("Fazendo orçamento","Orçamento aprovado","Orçamento negado","Em reparo","Aguardando test drive","Solicita contato Supervisão","OS encerrada"),
placaCarro varchar(8),
dataEntrada datetime,
dataLiberacao date,
pecasUtilizadas varchar(500),
valorTotal float,
feedbackCliente enum('Ruim','Regular','Bom','Excelente'),
reparos varchar(500),
idPagamento int,
constraint fk_idMecanico foreign key (idMecanico) references mecanico(idMecanico),
constraint fk_idPagamento foreign key (idPagamento) references pagamento(idpayments)
);

create table estoque(
idEstoque  int auto_increment primary key,
pecaCode varchar(10),
quantidade int,
nomePeca varchar(50),
localisacaoEstoque varchar(15));

#idOSEstoque código de identificação do estoque
#idOSpecas corresponde ao número da OS correspondente as pecas solicitadas pelo mecânico.
create table mecanicoPecasEstoque(
dataInicioAtendimento date,
idMecanicoEstoque int,
idOSEstoque int,
idOSpecas int,
quantidade int,
peca int,
constraint fk_idMecanico_Estoque foreign key (idMecanicoEstoque) references mecanico(idMecanico),
constraint fk_idOS_Estoque foreign key (idOSEstoque) references estoque(idEstoque),
constraint fk_idOS_pecas foreign key (idOSpecas) references OS(idOS)
);


create table feedbackCliente(
idFeedback  int auto_increment primary key,
idcliente int,
idOS int,
constraint fk_idCliente_feedback foreign key (idcliente) references cliente(idCliente),
constraint fk_idOS_feedback foreign key (idOS) references OS(idOS),
observação varchar(200));

create table tabelaServicos(
codigoServico int auto_increment primary key,
descricaoServico varchar(500),
valorServico float);