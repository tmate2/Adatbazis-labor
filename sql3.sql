-- 'A'-val kezdodo es 'a'-val vegzodo keresztneve tagok listaja
select vezeteknev || ' ' || keresztnev, to_char(szuletesi_datum, 'yyyy.mm.dd') from konyvtar.tag where keresztnev like 'A%a';

-- minden konyv aminek az isbn szam 2. karaktere 7, tema szerint csokkeno sorrendben 
select cim, isbn from konyvtar.konyv where isbn like '_7%' order by tema desc;

-- olyan tagok, akiknek a teljes neveben 3 darab 'a' betu van
select vezeteknev || ' ' || keresztnev from konyvtar.tag where lower(concat(vezeteknev,keresztnev)) like '%a%a%a%' and lower(concat(vezeteknev,keresztnev)) not like '%a%a%a%a%';

-- mai datum
select to_char(sysdate, 'yyyy.month.dd') from dual;

-- mai datum + 1 nap
select to_char(sysdate+1, 'yyyy.month.dd') from dual;

-- mai datum + 1 honap
select to_char(add_months(sysdate,1), 'yyyy.month.dd') from dual;

-- egy ev hozzaadasa az aktualis datumhoz
select to_char(add_months(sysdate,12), 'yyyy.month.dd') from dual;

-- mai datum, oraval egyutt kiirva 24-es formatumban
select to_char(sysdate, 'yyyy.month.dd hh24:mi') from dual;

-- mai datum + 1 ora
select to_char(sysdate+(1/24), 'yyyy.month.dd hh24:mi:ss') from dual;

-- mai datum + 1 perc
select to_char(sysdate+(1/24/60), 'yyyy.month.dd hh24:mi:ss') from dual;

-- mai datum + 5 perc
select to_char(sysdate+(1/24/60)*5, 'yyyy.month.dd hh24:mi') from dual;

-- mai datum + 5 perc mas megoldassal
select to_char(sysdate+(5/24/60), 'yyyy.month.dd hh24:mi') from dual;

-- csak az aktualis honap
select to_char(sysdate, 'month') from dual;

-- csak az aktualis honap szammal
select to_char(sysdate, 'mm') from dual;

-- extract számot ad vissza, a to_char pedig karaktert
select to_char(sysdate, 'mm'), extract(month from sysdate) from dual;

-- konyvek aminek temaja vagy horror vagy kevesebb mint 30 oldal es vagy 'A'-val kezdodik a cime vagy pedig nincs kiadoja
select cim from konyvtar.konyv where tema like 'horror' or (oldalszam < 30 and (cim like 'A%' or kiado is null));

-- 100-nal idosebb szerzok honap szerint rendezve
select vezeteknev || ' ' || keresztnev from konyvtar.szerzo where floor(months_between(sysdate,szuletesi_datum)/12) > 100 order by extract(month from szuletesi_datum) desc;

-- 1970 es 2006 kozott megjelent 50 oldalnal hosszabb termeszettudomanyi, krimi es horror konyvek
select cim from konyvtar.konyv where (tema in 'természettudomány' or tema in 'krimi' or tema in 'horror') and oldalszam > 50 and  extract(year from kiadas_datuma)>1970 and extract(year from kiadas_datuma)<2006;

-- ugyan az mint az elozo csak elegansabb megoldassal
select cim from konyvtar.konyv where tema in ('természettudomány', 'krimi','horror') and oldalszam > 50 and  extract(year from kiadas_datuma) between 1970 and 2006;

-- minden olyan tag aki nem Debreceni es nem 20 es 30 ev kozotti, szuletesi datum es teljes nev szerint rendezve
select vezeteknev || ' ' || keresztnev, floor(months_between(sysdate,szuletesi_datum)/12), cim  from konyvtar.tag where cim not like '_____Debrecen%' and not floor(months_between(sysdate,szuletesi_datum)/12) between 20 and 30 order by extract(year from szuletesi_datum) desc, concat(vezeteknev,keresztnev) desc;

-- 30 evnel idosebb tagok ev szerint csokkeno, honap szerint novekvobe rendezve
select vezeteknev, ' ', keresztnev, to_char(szuletesi_datum,'yyyy - mm') from konyvtar.tag where floor(months_between(sysdate,beiratkozasi_datum)/12) > 30 order by extract(year from szuletesi_datum) desc,extract(month from szuletesi_datum) asc;

-- olyan ferfi tagok, akok 1980.03.02 elott szulettek
select vezeteknev, ' ', keresztnev, to_char(szuletesi_datum,'yyyy.mm.dd') from konyvtar.tag where szuletesi_datum < to_date('1980.03.02', 'yyyy.mm.dd.') and nem = 'f'; 
