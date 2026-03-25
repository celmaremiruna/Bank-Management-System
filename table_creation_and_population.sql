create table sucursale_banca(
id_sucursala number(4) primary key
denumire varchar2(50) not null,
oras varchar2(50) not null,
adresa varchar2(100),
buget_anual number(10,2)
);


create table angajati_banca(
id_angajat number(5) primary key,
id_sucursala number(4),
nume varchar2(100) not NULL,
prenume varchar2(100) not null,
functie varchar2(50),
salariu number(10,2) constraint ck_salariul check(salariu>0),
data_angajarii date,
foreign key(id_sucursala) references sucursale_banca(id_sucursala)
);


create table clienti_banca(
id_client number(5) primary key,
nume varchar2(100) not null,
prenume varchar2(100) not null,
cnp varchar2(13) constraint ck_cnp check (cnp is not null),
telefon varchar2(10),
email varchar2(50),
tip_client varchar2(20) constraint ck_tip_client check(tip_client in ('persoana fizica', 'persoana juridica'))
);


create table credite_banca(
id_credit number(4) primary key,
id_client number(5) references clienti_banca(id_client),
id_angajat number(5) references angajati_banca(id_angajat),
suma_totala number(10,2),
rata_dobanzii number(5,2),
durata_luni number(3),
status varchar2(20) constraint ck_status check(status in ('activ','inchis','neachitat')),
data_acordare date
);


create table plati_credite_banca(
id_plata number(4) primary key,
id_credit number(4) references credite_banca(id_credit),
data_plata date,
suma number(10,2),
metoda_plata varchar2(20) constraint ck_met_plata check(metoda_plata in ('card','cash','transfer'))
);



create table conturi_banca(
id_cont number(4),
id_client number(5) references clienti_banca(id_client),
tip_cont varchar2(30) check(tip_cont in ('curent', 'economii','business')),
sold number(12,2),
data_deschidere date
);


create table tranzactii_banca(
id_tranzactie number(8) primary key,
id_cont number(4) references conturi_banca(id_cont),
data_tranzactie date,
suma number(10,2) check(suma>0),
tip_tranzactie varchar2(20) constraint ck_tranzactie check(tip_tranzactie in ('Depunere','Retragere','Transfer','Plata')),
descriere varchar2(100)
);


create table curs_valutar(
nume_moneda varchar2(3) primary key,
valoare_ron number(8,4),
data_actualizare date default sysdate
);


create table carduri_banca(
id_card number(4) primary key,
id_cont number(4) references conturi_banca(id_cont),
tip_card varchar2(20) constraint ck_tip_card check(tip_card in ('Debit','Credit')),
nr_card varchar2(16) not null,
data_expirare date,
cvv varchar2(3),
nume_moneda varchar2(3) references curs_valutar(nume_moneda)
);


alter table credite_banca add suma_ramasa number(10,2) constraint ck_suma_ramasa check(suma_ramasa>=0);
alter table credite_banca add constraint ck_rata_dobanzii check(rata_dobanzii between 0 and 100);
alter table conturi_banca add constraint pk_id_cont primary key(id_cont);
alter table credite_banca add constraint ck_suma_totala check(suma_totala is not null);

insert into sucursale_banca values(26,'Sucursala centrala','Suceava','Bd. G. Enescu nr 22', 1278953.11);
insert into sucursale_banca values(27,'Sucursala Nord','Suceava','Str. Alexandru cel Bun nr. 15', 845321.50);
insert into sucursale_banca values(28,'Sucursala Est','Suceava','Str. Universității nr. 8', 653219.75);
insert into sucursale_banca values(29,'Sucursala Vest','Suceava','Str. 1 Mai nr. 102', 721456.90);
insert into sucursale_banca values(30,'Sucursala Burdujeni','Suceava','Str. Cernăuți nr. 45', 512784.30);
insert into sucursale_banca values(31,'Sucursala Obcini','Suceava','Str. Stațiunii nr. 12', 438927.80);
insert into sucursale_banca values(32,'Sucursala Ițcani','Suceava','Str. Traian Popovici nr. 5', 389540.60);
insert into sucursale_banca values(33,'Sucursala Zamca','Suceava','Str. Mitropoliei nr. 27', 564780.25);
insert into sucursale_banca values(34,'Sucursala Areni','Suceava','Str. Aleea Dumbrăvii nr. 30', 602394.10);
insert into sucursale_banca values(35,'Sucursala Fălticeni','Fălticeni','Str. Republicii nr. 18', 458930.00);
insert into sucursale_banca values(36,'Sucursala Rădăuți','Rădăuți','Str. Piața Unirii nr. 7', 689210.55);
insert into sucursale_banca values(37,'Sucursala Gura Humorului','Gura Humorului','Str. Bucovinei nr. 3', 512679.80);


insert into angajati_banca values(100,30,'Martole','Ilinca','Administrator zonal',2248902.99,to_date('26.01.2018','dd.mm.yyyy'));
insert into angajati_banca values(101,26,'Popescu','Andrei','Manager sucursală',18500.75, to_date('12.03.2017','dd.mm.yyyy'));
insert into angajati_banca values(102,27,'Ionescu','Maria','Consilier financiar',7200.00, to_date('05.07.2019','dd.mm.yyyy'));
insert into angajati_banca values(103,28,'Rusu','Teodor','Analist credite',8100.50, to_date('22.11.2020','dd.mm.yyyy'));
insert into angajati_banca values(104,29,'Lazar','Oana','Casier',5400.00, to_date('14.02.2021','dd.mm.yyyy'));
insert into angajati_banca values(105,30,'Varga','Stefan','Consilier clienți',6900.00, to_date('30.08.2018','dd.mm.yyyy'));
insert into angajati_banca values(106,31,'Neagu','Laura','Responsabil operațiuni',9300.00, to_date('01.04.2016','dd.mm.yyyy'));
insert into angajati_banca values(107,32,'Balan','Cristian','Ofițer credite',7800.25, to_date('19.06.2019','dd.mm.yyyy'));
insert into angajati_banca values(108,33,'Serban','Alina','Casier',5100.00, to_date('08.10.2022','dd.mm.yyyy'));
insert into angajati_banca values(109,34,'Toma','Alexandra','Specialist bancar',8700.40, to_date('27.09.2015','dd.mm.yyyy'));
insert into angajati_banca values(110,35,'Hordila','Rares','Consilier financiar',7350.00, to_date('17.01.2020','dd.mm.yyyy'));
insert into angajati_banca values(111,36,'Mihalache','Denisa','Analist risc',9100.80, to_date('03.03.2018','dd.mm.yyyy'));
insert into angajati_banca values(112,37,'Pavel','Iulian','Casier',4950.60, to_date('12.12.2021','dd.mm.yyyy'));

insert into clienti_banca values(20,'Grosu','Paul','1234567891235','0757572661','paulg@gmail.com','persoana fizica');
insert into clienti_banca values(21,'Popa','Andreea','2980101223344','0723456789','andreea.popa@gmail.com','persoana fizica');
insert into clienti_banca values(22,'Iftimie','George','1950905123456','0734567890','george.iftimie@yahoo.com','persoana fizica');
insert into clienti_banca values(23,'Lungu','Raluca','2960506221123','0745678901','raluca.lungu@gmail.com','persoana fizica');
insert into clienti_banca values(24,'Pintilie','Teodor','1930420123987','0756789012','teodor.pintilie@gmail.com','persoana fizica');
insert into clienti_banca values(25,'Apostol','Bianca','2920304332123','0767890123','bianca.apostol@yahoo.com','persoana fizica');
insert into clienti_banca values(26,'Grigoras','Alexandru','1911205123456','0778901234','alex.grigoras@gmail.com','persoana fizica');
insert into clienti_banca values(27,'Munteanu','Simona','2940706223345','0789012345','simona.munteanu@yahoo.com','persoana fizica');
insert into clienti_banca values(28,'Tudor','Mihai','1900215334455','0790123456','mihai.tudor@gmail.com','persoana fizica');
insert into clienti_banca values(29,'Nichita','Elena','2970909222233','0725567890','elena.nichita@gmail.com','persoana fizica');
insert into clienti_banca values(30,'Stan','Ionut','1931211331122','0736678901','ionut.stan@yahoo.com','persoana fizica');
insert into clienti_banca values(31,'Baciu','Corina','2950415223321','0747789012','corina.baciu@gmail.com','persoana fizica');
insert into clienti_banca values(32,'Barbu','Cristian','1920501123456','0758890123','cristian.barbu@gmail.com','persoana juridica'); 19
insert into clienti_banca values(33,'Serban','Adrian','1900115223344','0769901234','adrian.serban@company.ro','persoana juridica');

insert into credite_banca values(500, 20,107,200000,5.6,12,'activ',to_date('15.03.2025','dd.mm.yyyy'),46000.78);
insert into credite_banca values(501,21,101,150000,4.8,24,'activ',to_date('10.02.2024','dd.mm.yyyy'),92000.50);
insert into credite_banca values(502,22,102,98000,5.2,18,'activ',to_date('05.11.2023','dd.mm.yyyy'),45500.00);
insert into credite_banca values(503,23,103,250000,6.1,36,'inchis',to_date('20.07.2020','dd.mm.yyyy'),0);
insert into credite_banca values(504,24,104,75000,4.3,12,'activ',to_date('01.09.2024','dd.mm.yyyy'),38000.20);
insert into credite_banca values(505,25,105,180000,5.9,30,'neachitat',to_date('12.04.2022','dd.mm.yyyy'),143500.75);
insert into credite_banca values(506,26,106,220000,6.4,48,'activ',to_date('28.01.2023','dd.mm.yyyy'),167200.40);
insert into credite_banca values(507,27,107,65000,3.9,12,'inchis',to_date('14.06.2019','dd.mm.yyyy'),0);
insert into credite_banca values(508,28,108,134000,4.7,24,'activ',to_date('22.08.2023','dd.mm.yyyy'),89000.90);
insert into credite_banca values(509,29,109,300000,6.8,60,'activ',to_date('30.03.2024','dd.mm.yyyy'),251000.33);
insert into credite_banca values(510,30,110,90000,5.0,18,'activ',to_date('17.12.2024','dd.mm.yyyy'),61000.00);

insert into plati_credite_banca values(400,504,to_date('12.05.2025','dd.mm.yyyy'),1200,'card');
insert into plati_credite_banca values(401,501,to_date('15.03.2024','dd.mm.yyyy'),2500,'card');
insert into plati_credite_banca values(402,502,to_date('10.12.2023','dd.mm.yyyy'),1800,'cash');
insert into plati_credite_banca values(403,503,to_date('05.08.2020','dd.mm.yyyy'),7200,'transfer');
insert into plati_credite_banca values(404,504,to_date('01.10.2024','dd.mm.yyyy'),1500,'card');
insert into plati_credite_banca values(405,505,to_date('20.05.2022','dd.mm.yyyy'),3100,'transfer');
insert into plati_credite_banca values(406,506,to_date('05.03.2023','dd.mm.yyyy'),2900,'cash');
insert into plati_credite_banca values(407,507,to_date('17.07.2019','dd.mm.yyyy'),2600,'card');
insert into plati_credite_banca values(408,508,to_date('30.09.2023','dd.mm.yyyy'),2700,'transfer');
insert into plati_credite_banca values(409,509,to_date('10.04.2024','dd.mm.yyyy'),5400,'card');
insert into plati_credite_banca values(410,510,to_date('05.01.2025','dd.mm.yyyy'),2100,'cash');
insert into plati_credite_banca values(411,500,to_date('20.03.2025','dd.mm.yyyy'),3500,'transfer');
insert into plati_credite_banca values(412,503,to_date('12.09.2020','dd.mm.yyyy'),4100,'cash');

insert into conturi_banca values(1001,20,'curent',5800.75,to_date('10.02.2021','dd.mm.yyyy'));
insert into conturi_banca values(1002,21,'economii',15200.40,to_date('05.06.2020','dd.mm.yyyy'));
insert into conturi_banca values(1003,22,'curent',3200.00,to_date('12.11.2019','dd.mm.yyyy'));
insert into conturi_banca values(1004,23,'economii',8900.25,to_date('01.04.2022','dd.mm.yyyy'));
insert into conturi_banca values(1005,24,'business',45200.00,to_date('18.09.2023','dd.mm.yyyy'));
insert into conturi_banca values(1006,25,'curent',2700.55,to_date('27.03.2021','dd.mm.yyyy'));
insert into conturi_banca values(1007,26,'economii',13450.90,to_date('08.12.2018','dd.mm.yyyy'));
insert into conturi_banca values(1008,27,'curent',5100.00,to_date('20.07.2020','dd.mm.yyyy'));
insert into conturi_banca values(1009,28,'business',60300.10,to_date('11.02.2022','dd.mm.yyyy'));
insert into conturi_banca values(1010,29,'curent',4100.45,to_date('09.05.2023','dd.mm.yyyy'));
insert into conturi_banca values(1011,30,'economii',17800.00,to_date('03.01.2021','dd.mm.yyyy'));
insert into conturi_banca values(1012,31,'curent',2900.30,to_date('22.06.2024','dd.mm.yyyy'));
insert into conturi_banca values(1013,32,'business',72400.80,to_date('15.08.2023','dd.mm.yyyy'));
insert into conturi_banca values(1014,33,'curent',3500.60,to_date('30.10.2020','dd.mm.yyyy'));

insert into tranzactii_banca values(1,1001,to_date('05.03.2024','dd.mm.yyyy'),1200.50,'Depunere','Depunere salariu');
insert into tranzactii_banca values(2,1002,to_date('10.06.2023','dd.mm.yyyy'),500.00,'Retragere','Retragere numerar ATM');
insert into tranzactii_banca values(3,1003,to_date('15.01.2024','dd.mm.yyyy'),320.75,'Plata','Plata factura utilitati');
insert into tranzactii_banca values(4,1004,to_date('22.07.2023','dd.mm.yyyy'),1500.00,'Depunere','Transfer de la alt cont');
insert into tranzactii_banca values(5,1005,to_date('30.09.2023','dd.mm.yyyy'),7800.20,'Transfer','Transfer catre furnizor');
insert into tranzactii_banca values(6,1006,to_date('05.02.2024','dd.mm.yyyy'),420.00,'Retragere','Retragere numerar la ghiseu');
insert into tranzactii_banca values(7,1007,to_date('18.03.2022','dd.mm.yyyy'),950.50,'Depunere','Depunere economii');
insert into tranzactii_banca values(8,1008,to_date('12.11.2023','dd.mm.yyyy'),2100.00,'Plata','Plata factura internet');
insert into tranzactii_banca values(9,1009,to_date('25.05.2024','dd.mm.yyyy'),1340.75,'Transfer','Transfer catre cont business');
insert into tranzactii_banca values(10,1010,to_date('02.08.2023','dd.mm.yyyy'),600.00,'Retragere','Retragere numerar ATM');
insert into tranzactii_banca values(11,1011,to_date('19.12.2022','dd.mm.yyyy'),1700.40,'Depunere','Depunere salariu');
insert into tranzactii_banca values(12,1012,to_date('07.04.2024','dd.mm.yyyy'),450.00,'Plata','Plata abonament telefon');
insert into tranzactii_banca values(13,1013,to_date('11.09.2023','dd.mm.yyyy'),6500.00,'Transfer','Transfer catre furnizor'); 24

insert into curs_valutar values('USD',4.7500,to_date('11.11.2025','dd.mm.yyyy'));
insert into curs_valutar values('EUR',5.1500,to_date('11.11.2025','dd.mm.yyyy'));
insert into curs_valutar values('GBP',6.0000,to_date('11.11.2025','dd.mm.yyyy'));
insert into curs_valutar values('CHF',5.2000,to_date('11.11.2025','dd.mm.yyyy'));
insert into curs_valutar values('JPY',0.0345,to_date('11.11.2025','dd.mm.yyyy'));
insert into curs_valutar values('CAD',3.4500,to_date('11.11.2025','dd.mm.yyyy'));
insert into curs_valutar values('AUD',3.2000,to_date('11.11.2025','dd.mm.yyyy'));
insert into curs_valutar values('NOK',0.4800,to_date('11.11.2025','dd.mm.yyyy'));
insert into curs_valutar values('SEK',0.5000,to_date('11.11.2025','dd.mm.yyyy'));
insert into curs_valutar values('DKK',0.6900,to_date('11.11.2025','dd.mm.yyyy'));

insert into carduri_banca values(5000,1001,'Debit','4000123412341234',to_date('11.12.2028','dd.mm.yyyy'),'123','USD');
insert into carduri_banca values(5001,1002,'Credit','4000567812345678',to_date('05.06.2027','dd.mm.yyyy'),'456','EUR');
insert into carduri_banca values(5002,1003,'Debit','4000987612349876',to_date('15.01.2026','dd.mm.yyyy'),'789','GBP');
insert into carduri_banca values(5003,1004,'Credit','4000345612343456',to_date('22.07.2029','dd.mm.yyyy'),'234','CHF');
insert into carduri_banca values(5004,1005,'Debit','4000654312346543',to_date('30.09.2027','dd.mm.yyyy'),'567','JPY');
insert into carduri_banca values(5005,1006,'Debit','4000765412347654',to_date('05.02.2028','dd.mm.yyyy'),'890','CAD');
insert into carduri_banca values(5006,1007,'Credit','4000876512348765',to_date('18.03.2029','dd.mm.yyyy'),'345','AUD');
insert into carduri_banca values(5007,1008,'Debit','4000987612349875',to_date('12.11.2026','dd.mm.yyyy'),'678','NOK');
insert into carduri_banca values(5008,1009,'Credit','4000123498761233',to_date('25.05.2028','dd.mm.yyyy'),'901','SEK');
insert into carduri_banca values(5009,1010,'Debit','4000234512342344',to_date('02.08.2027','dd.mm.yyyy'),'234','DKK');
insert into carduri_banca values(5010,1011,'Credit','4000345612343455',to_date('19.12.2029','dd.mm.yyyy'),'567','USD');
insert into carduri_banca values(5011,1012,'Debit','4000456712344566',to_date('07.04.2028','dd.mm.yyyy'),'890','EUR');






