-- 8. heten zh

-- ket tabla joinolasa
select * from konyvtar.konyv k inner join konyvtar.konyvszerzo ksz on k.konyv_azon = ksz.konyv_azon;

-- azok a temak amikbol 3-nal kevesebb van
select tema from konyvtar.konyv group by tema having count(konyv_azon) < 3;

-- azok a kiadok akiknek van legalabb 3 olyan konyve melyek 200 oldalnal hosszabbak
select kiado from konyvtar.konyv where oldalszam > 200 group by kiado having count(konyv_azon) >= 3;

-- azok a szerzok akik majusban szulettek, az altaluk szerzett konyv pontosan 2 db 'a'-t tartalmaz es 100-nal tobb honororiumot kaptak konyvarusitasonkent
select * from konyvtar.konyv k inner join konyvtar.konyvszerzo ksz on k.konyv_azon = ksz.konyv_azon inner join konyvtar.szerzo sz on ksz.szerzo_azon = sz.szerzo_azon
where extract(month from szuletesi_datum) = 5 and lower(cim) like '%a%a%' and lower(cim) not like '%a%a%a%' and honorarium > 100;

-- hany konyvtari konyveket koncsonzott ki Acsi Milan
select count(*) from konyvtar.tag t inner join konyvtar.kolcsonzes k on t.olvasojegyszam = k.tag_azon where vezeteknev like 'Ácsi' and keresztnev like 'Milán';

-- mely konyveket irta jokai mor
select * from konyvtar.konyv k inner join konyvtar.konyvszerzo ksz on k.konyv_azon = ksz.konyv_azon inner join konyvtar.szerzo sz on ksz.szerzo_azon = sz.szerzo_azon
where vezeteknev like 'Jókai' and keresztnev like 'Mór';

-- krimi es horror temai konyvek cim es szerzoi
select cim, vezeteknev || ' ' || keresztnev from konyvtar.konyv k inner join konyvtar.konyvszerzo ksz on k.konyv_azon = ksz.konyv_azon inner join konyvtar.szerzo sz on ksz.szerzo_azon = sz.szerzo_azon
where tema in ('horror','krimi');

-- a szerzok hany KULONBOZO kiadonak dolgoztak
select vezeteknev || ' ' || keresztnev ,count(distinct kiado) from konyvtar.konyv k inner join konyvtar.konyvszerzo ksz on k.konyv_azon = ksz.konyv_azon inner join konyvtar.szerzo sz on ksz.szerzo_azon = sz.szerzo_azon
group by (vezeteknev, keresztnev, sz.szerzo_azon);

-- egyes konyveknek hany szerzoje van
select ksz.konyv_azon, cim, count(*) from konyvtar.konyv k inner join konyvtar.konyvszerzo ksz on k.konyv_azon = ksz.konyv_azon inner join konyvtar.szerzo sz on ksz.szerzo_azon = sz.szerzo_azon
group by ksz.konyv_azon, cim, kiado, tema;

-- melyik szerzo irt haromnal kevesebb konyvet
select  vezeteknev, keresztnev, count(*) from konyvtar.konyv k inner join konyvtar.konyvszerzo ksz on k.konyv_azon = ksz.konyv_azon inner join konyvtar.szerzo sz on ksz.szerzo_azon = sz.szerzo_azon
group by sz.szerzo_azon, vezeteknev, keresztnev having count(*) < 3;

-- ki irta a napolen c. konyvet
select vezeteknev, keresztnev from konyvtar.konyv k inner join konyvtar.konyvszerzo ksz on k.konyv_azon = ksz.konyv_azon inner join konyvtar.szerzo sz on ksz.szerzo_azon = sz.szerzo_azon
where cim like 'Napóleon';

-- 40 evnel fiatalabb olvasok altal kikolcsonzott konyvek leltari szama
select ko.leltari_szam from konyvtar.tag t inner join konyvtar.kolcsonzes ko on t.olvasojegyszam = ko.tag_azon
where months_between(sysdate, szuletesi_datum)/12 > 40;

-- melyik olvaso fiatalabb frei tamasnal?
select t.vezeteknev, t.keresztnev from konyvtar.szerzo sz, konyvtar.tag t where sz.vezeteknev = 'Frei' and sz.keresztnev = 'Tamás' and sz.szuletesi_datum < t.szuletesi_datum; 

-- azok a kiadok akik 1M-nel kevesebb osszhonorariumot osztottak ki azoknak aszerzoknek akik 1950 elott szulettek, lista legyen rendezve
select kiado, sum(ksz.honorarium) from konyvtar.konyvszerzo ksz inner join konyvtar.szerzo sz on ksz.szerzo_azon = sz.szerzo_azon inner join konyvtar.konyv k on k.konyv_azon = ksz.konyv_azon
where to_date('1950','yyyy') > sz.szuletesi_datum group by kiado having sum(nvl(ksz.honorarium,0)) < 1000000 order by kiado;

-- hogy hivjak a sales reszleg dolgozoi
select first_name, last_name from hr.jobs j inner join hr.employees e on j.job_id = e.job_id inner join hr.departments d on d.department_id = e.department_id
where d.department_name like 'Sales';

-- Steven King melyik reszleg vezetoje
select department_name from hr.jobs j inner join hr.employees e on j.job_id = e.job_id inner join hr.departments d on d.department_id = e.department_id
where first_name like 'Steven' and last_name like 'King' and job_title = 'President';

select department_name from hr.employees emp inner join hr.departments dep on emp.employee_id = dep.manager_id where first_name like 'Steven' and last_name like 'King'