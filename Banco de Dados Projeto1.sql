use ecommerce;

#criar tabela cliente
create table clients(
idClient int auto_increment primary key,
Fname varchar(10),
Minit varchar(3),
Lname varchar(30),
CPF char(11) not null,
Address varchar(40),
constraint unique_cpf_client unique (CPF)
);

#tabela produto
#size tamanho do produto
create table product(
idProduct int auto_increment primary key,
Pname varchar(10),
classification_kids bool default false,
category enum("Eletrônicos","Vestuário","Brinquedos","Livros"),
avaliacao float default 0,
size varchar(10)
);

###aba do pagamento
create table payments(
idClient int,
idpayments int auto_increment primary key,
accepted_cards enum("Visa","Master Card","American Express","Nubank")not null,
cc_number varchar (16)not null,
cc_sec_code int not null,
cc_exp_month int not null,
cc_exp_year int not null,
limitAvailable float,
constraint fk_clients foreign key (idClient) references clients(idClient)
);

#criando tabela pedido

create table orders(
idOrder int auto_increment primary key,
idOrderClient int,
orderStatus enum("Canceclado","Confirmado","Em Processamento")default ("Procesando pedido"),
orderDescription varchar(255),
sendValue float default 10,
idPayment int,
constraint fk_payments foreign key (idPayment) references payments(idpayments),
constraint fk_orders_client foreign key(idOrderClient) references clients(idClient)
);


#criar tabela estoque
create table productStorage(
idProdStorage int auto_increment primary key,
storageLocation varchar(255),
quantity int default 0
);
#tabela fornecedor
create table supplier(
idSupplier int auto_increment primary key,
SocialName varchar (255)not null,
CNPJ char(15) not null,
contact char(11) not null,
constraint unique_supplier unique(CNPJ)
);

#tabela vendedor
create table seller(
idSeller int auto_increment primary key,
SocialName varchar(255) not null,
AbstName varchar(255),
CNPJ char(15),
CPF CHAR(11),
location varchar (255),
contact char(12) not null,
constraint unique_cnpj_seller unique (CNPJ),
constraint unique_cpf_seller unique (CPF)
);

create table productSeller(
idPseller int,
idPproduct int,
prodQuantity int default 1,
constraint fk_product_seller foreign key(idPseller) references seller(idSeller),
constraint fk_product_product foreign key(idPproduct) references product(idProduct)
);

create table productOrder(
idPOproduct int,
idPOorder int,
poQuantity int default 1,
poStatus enum("Disponível","Sem estoque") default ("Disponível"),
primary key (idPOproduct,idPOorder),
constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
idLproduct int,
idLstorage int,
location varchar(255) not null,
primary key(idLproduct,idLstorage),
constraint fk_storage_location_seller foreign key (idLproduct) references product(idProduct),
constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
idPsSupplier int,
idPsProduct int,
quantity int not null,
primary key (idPsSupplier,idPsProduct),
constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);


show tables;

alter table clients auto_increment=1;

insert into Clients(Fname,Minit,Lname,CPF,Address)
     values('Monica','L','Oliveira',1231231433,'rua Oscar Wilde,46,Ouro e Prata-SP'),
	    ('Camila','L','Torres',12212232232,'rua Ursula LeGueen,90,Limeira-SP'),
		('Carlos','M','Borba',11122233323,'rua Carolina M Jesus,62,São Paulo-SP'),
        ('Tomas','L','Franco',1231231233,'rua Machado de Assis,219,Oliveira-SP'),
	    ('Alice','P','Alencar',33322211122,'alamenda Jose de Alencar,20,Lucíola-SP'),
        ('Bartolomeu','F','Gomes',33321331233,'rua Mary Shelley,33,Segredos-MG');
        
alter table product auto_increment=1;

insert into product(Pname,classification_kids,category,avaliacao,size)
          values('Fone',false,"Eletrônicos",'7',null),
				('Pelúcia',true,"Brinquedos",'4',null),
                ('Camiseta P',false,"Vestuário",'6','M'),
                ('Microfone',false,"Eletrônicos",'9',null),
				('Senhora',false,"Livros",'10',null),
                ('vestido',false,"Vestuário",'5',null);
                
alter table orders auto_increment=1;
show tables;
select concat(Fname,'',Lname),CPF,Address from clients;
select concat(Fname,'',Lname)as 'name',CPF,Address from clients;
select concat(Fname,'',Lname)as 'name',CPF,Address as Endereço from clients;
select idClient, concat(Fname,'',Lname)as 'name',CPF,Address as Endereço from clients;

select idProduct,Pname,classification_kids,category,avaliacao,size from product;

alter table payments auto_increment=1;


#"Visa","Master Card","American Express","Nubank"
insert into payments(idClient,accepted_cards,cc_number,cc_sec_code,cc_exp_month,cc_exp_year,limitAvailable)
			values(19,"American Express",33344451,22,3,2026,500.00),
                  (20,"Visa",22233315,10,4,2025,1000),
                  (21,"Nubank",333322215,44,5,2022,800),
                  (22,"Visa",3333222255,50,6,2024,900),
                  (23,"American Express",332211111,51,1,2023,2500.00),
                  (24,"Visa",4444433322,11,2,2024,2000.00);
select idpayments,idClient,accepted_cards,cc_number,cc_sec_code,cc_exp_month,cc_exp_year,limitAvailable from payments;
                  
alter table orders auto_increment =1;

#("Canceclado","Confirmado","Em Processamento").
insert into orders(idOrderClient,orderStatus,orderDescription,sendValue,idPayment)
           values(19,"Confirmado","Vestido azul de verão tamanho M",100.00,1),
                 (20,"Em Processamento","Livro da editora Rocco",50.00,2),
                 (21,"Confirmado","Microfone Samsung",150.00,3),
                 (22,"Em Processamento","Camiseta Preta A Forma da Água",49.90,4),
                 (23,"Confirmado","Pelúcia de coelho",60.00,5),
                 (24,"Em Processamento","Fone de ouvido LG",80.00,6);
                 
select  idOrder,idOrderClient,orderStatus,orderDescription,sendValue,idPayment from orders;
                 
alter table productStorage auto_increment=1;
                 
insert into productStorage(storageLocation,quantity)
             values("Rio de Janeiro",1000),
                   ("Rio de Janeiro",500),
                   ("São Paulo",600),
                   ("São Paulo",200),
                   ("Campinas",2000),
                   ("Limeira",500);
                   
                   
select idProdStorage,idProdStorage,storageLocation,quantity from productStorage;


alter table supplier auto_increment=25;


insert into supplier(SocialName,CNPJ,contact)
         values("Mega Eletronicos LTDA",14333000112,2232222222),
                ("AILI Eletronicos LTDA",3333333000115,2232323232),
                ("Criança Feliz LTDA",444444000123,1122434343),
                ("Cleópatra Roupas e Acessórios",111112000123,1133333333),
                ("Alexandria Livros LTDA",121013000133,1932413232);
select idSupplier,SocialName,CNPJ,contact  from supplier;
         
alter table seller auto_increment=30;

insert into seller(SocialName,AbstName,CNPJ,CPF,location,contact)
			values("site presentes perfeitos",null,232323444400011,NULL,"São Paulo-SP",1132323333),
                  ("app maçã presentes",null,45455555000112,null,"Rio de Janeiro-RJ",2232323333),
                  ("site melhoresprecos",null,5555000123,null,"São Paulo-SP",1132547877);
select idSeller,SocialName,AbstName,CNPJ,CPF,location,contact from seller;

select*from product;
insert into productSeller(idPseller,idPproduct,prodQuantity)
           values(30,7,20),
				(31,8,1),
                (32,9,15),
                (30,10,2),
                (31,11,1),
                (30,12,3);
select*from product;

insert into productOrder(idPOproduct,idPOorder,poQuantity,poStatus)
            values(7,1,20,"Disponível"),
                  (8,2,1,"Disponível"),
                  (9,3,15,"Disponível"),
                  (10,4,2,"Disponível"),
                  (11,5,1,"Disponível"),
                  (12,6,3,"Disponível");
select*from productOrder;


insert into storageLocation(idLproduct,idLstorage,location)
          values(7,1,"Rua: das Margaridas,255,Centro, Rio de Janeiro-RJ"),
                 (8,2,"Rua: Ouro,55,Centro,Rio de Janeiro-RJ"),
                 (9,3,"Rua:Trevo,13,Bairro das Flores,São Paulo-SP"),
                 (10,4,"Rua:Das Oliveiras,1200,Centro,São Paulo-SP"),
                 (11,5,"Rua:Itapuan,15,Centro,Campinas-SP"),
                 (12,6,"Rua:Boa Esperança,11,Centro,Limeira-SP");
                 
select*from supplier;

insert into productSupplier(idPsSupplier,idPsProduct,quantity)
             values(25,7,30),
                   (26,10,2),
                   (27,8,1),
                   (28,12,3),
                   (29,11,1),
                   (28,9,15);


                  

