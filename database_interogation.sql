select cl.id_client, cl.nume||' '||cl.prenume as nume_complet, co.id_cont, co.tip_cont
from clienti_banca cl, conturi_banca co
where cl.id_client=co.id_client
minus
select cl.id_client, cl.nume||' '||cl.prenume as nume_complet, co.id_cont, co.tip_cont
from clienti_banca cl, conturi_banca co, tranzactii_banca tr
where cl.id_client=co.id_client and co.id_cont=tr.id_cont
order by id_client;

select cl.id_client, cl.nume, cl.prenume, co.id_client,
(CASE when co.sold<3000 then 'client mic'
when co.sold between 3000 and 6000 then 'client mediu'
else 'client mare'
END) categorie_client
from clienti_banca cl, conturi_banca co
where cl.id_client=co.id_client;


select cl.id_client, cl.nume, cl.prenume, cr.id_credit, cr.suma_totala
from clienti_banca cl, credite_banca cr
where cl.id_client=cr.id_client
and rata_dobanzii>(select avg(rata_dobanzii) from credite_banca)
minus
select cl.id_client, cl.nume, cl.prenume, cr.id_credit, cr.suma_totala
from clienti_banca cl, credite_banca cr
where cl.id_client=cr.id_client
and durata_luni>(select avg(durata_luni) from credite_banca);

select cl.id_client, cl.nume||' '||cl.prenume as nume_complet , cl.tip_client,
decode(cr.status,'activ','indatorat','inchis','liber')as datorii_banca
from clienti_banca cl, credite_banca cr
where cl.id_client=cr.id_client;


select cl.id_client, cl.nume, cl.prenume, cl.tip_client
from clienti_banca cl, tranzactii_banca tr, conturi_banca co
where cl.id_client=co.id_client and co.id_cont=tr.id_cont
intersect
select cl.id_client, cl.nume, cl.prenume, cl.tip_client
from clienti_banca cl
join credite_banca cr
on cl.id_client=cr.id_client;

select cl.id_client, cl.nume||' '||cl.prenume as nume_complet , sum(tr.suma)
from clienti_banca cl, conturi_banca co, tranzactii_banca tr
where cl.id_client=co.id_client and co.id_cont=tr.id_cont
group by cl.id_client, cl.nume, cl.prenume
order by sum(tr.suma) desc
fetch next 5 rows only;


select s.id_sucursala, s.denumire, s.buget_anual, sum(c.suma_totala) as suma_credite
from sucursale_banca s
join angajati_banca a on s.id_sucursala=a.id_sucursala
join credite_banca c on c.id_angajat=a.id_angajat
group by s.id_sucursala, s.denumire, s.buget_anual
order by sum(c.suma_totala) desc
fetch next 3 rows only;


select id_credit, id_client, status from credite_banca
where status='inchis'
union
select c.id_credit, c.id_client, c.status
from credite_banca c, plati_credite_banca p
where c.id_credit=p.id_credit and extract(year from p.data_plata)=2025;



select cl.id_client, cl.nume, cl.prenume
from clienti_banca cl, conturi_banca co
where cl.id_client=co.id_client
and co.sold>(select avg(cb.sold) from conturi_banca cb
join tranzactii_banca t on cb.id_cont=t.id_cont);


select cl.id_client, cl.nume, cl.prenume
from clienti_banca cl join conturi_banca co on co.id_client=cl.id_client
join tranzactii_banca t on t.id_cont=co.id_cont
where t.data_tranzactie between add_months(sysdate,-6) and sysdate
union
select cl.id_client, cl.nume, cl.prenume
from clienti_banca cl join credite_banca cr on cl.id_client=cr.id_client
join plati_credite_banca p on p.id_credit=cr.id_credit
where p.data_plata between add_months(sysdate,-6) and sysdate;


select trunc(co.sold*cv.valoare_ron,2) as sold_ron, co.id_client, co.tip_cont
from conturi_banca co, curs_valutar cv, carduri_banca c
where co.id_cont=c.id_cont and c.nume_moneda=cv.nume_moneda
and c.nume_moneda!='EUR'
and co.sold*cv.valoare_ron>7500;


select cl.id_client, cl.nume, cl.prenume from clienti_banca cl
join conturi_banca co on cl.id_client=cl.id_client
join carduri_banca ca on ca.id_cont=co.id_cont
union
select cl.id_client, cl.nume, cl.prenume from clienti_banca cl
join credite_banca cr on cr.id_client=cl.id_client
minus
select cl.id_client, cl.nume, cl.prenume from clienti_banca cl
join conturi_banca co on co.id_client=cl.id_client
join tranzactii_banca t on t.id_cont=co.id_cont;

create or replace view v_profil_financiar_client as
select cl.id_client, cl.nume, cl.prenume, sum(co.sold) as sold_total
from clienti_banca cl, conturi_banca co
where cl.id_client=co.id_client
group by cl.id_client, cl.nume, cl.prenume;



