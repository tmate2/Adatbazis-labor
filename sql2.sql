-- oszlopok elnevezese
select kolcsonzesi_datum mikor_vette_ki, visszahozasi_datum mikor_hozta_vissza from KONYVTAR.kolcsonzes;

-- no nemu diakok, keresztnev szerint csokkeno sorrendben
select vezeteknev, keresztnev from konyvtar.tag where nem = 'n' and besorolas = 'diák' order by keresztnev desc;

select cim, ar, oldalszam, ar/oldalszam arany from konyvtar.konyv order by arany desc;

-- matematikai muveletek a dual tablaval
select 7*8 from dual;

select floor(3.7), round(4.7457,2) from dual;

-- string osszefuzes. concat()-al csak ket elemet lehet osszefuzni, vagyolassal tobbet is
select concat('alma','fa'), 'alma' || 'fa' || 'más' from dual;

select vezeteknev || ' ' || keresztnev from konyvtar.tag;

-- initcap( ) minden szó első betüje nagybetű lesz

-- upper( ) -minden betu nagybetu, lower( ) -minden betu kisbetu

-- minden 'halal' szót kicserel 'cica'-ra a cimben
select replace(cim, 'halál', 'cica') from konyvtar.konyv;

-- a 3. karaktert koveto 7 karaktert adja vissza
select cim, substr(cim, 3, 7) from konyvtar.konyv;

select cim, length(cim) from konyvtar.konyv;

-- legalabb 20 karakteru cimek, csokkeno sorrendben
select cim from konyvtar.konyv where length(cim) > 20 order by length(cim) desc;

-- kiadoval rendelkezo konyveket listazza ki
select cim, kiado from konyvtar.konyv where kiado is not null;

-- nvl() kicsereli a megadott szovegre a null erteket
select cim, nvl(kiado, 'nincs kiadó megadva') from konyvtar.konyv;

-- aktualis ido
select sysdate from dual;

-- aktualis ido szebb megjelenitese
select to_char(sysdate, 'yyyy. mm. dd. hh24:mi:ss') from dual;

select to_char(sysdate, 'yyyy. month dd. Day hh24:mi:ss') from dual;

-- sql szerinti datum formatumba valo formazas
select to_date('1960. 08. 30.', 'yyyy. mm. dd.') from dual;

-- a megadott datum utan szuletettek listaja
select vezeteknev || ' ' || keresztnev || ' - ' || szuletesi_datum from konyvtar.tag where to_date('1993. 10. 09.', 'yyyy. mm. dd.') < szuletesi_datum;

-- 50 nap hozzaadasa a mai datumhoz, majd szebb kiirasa
select to_char(sysdate+50, 'yyyy. month dd. Day hh24:mi:ss') from dual;

-- 3 honap hozzaadasa a mai datumhoz
select to_char(add_months(sysdate,3), 'yyyy. month dd. Day hh24:mi:ss') from dual;

-- kor kiszamitasa megadott datum alapjan
select floor(months_between(sysdate, to_date('1973. 07. 02.', 'yyyy. mm. dd.'))/12) from dual;

-- minden torzstag, akinek a keresztneveben legalabb egy 'a' betu szerepel, vezeteknev szerint novekvo sorrendben
select vezeteknev, keresztnev, besorolas from konyvtar.tag where lower(keresztnev) like '%a%' and besorolas like 'törzstag' order by vezeteknev asc;

-- minden tag, akinek a keresztneve 'Z'-vel es a vezetekneve 'P'-vel kezdodik
select vezeteknev, keresztnev from konyvtar.tag where keresztnev like 'Z%' and vezeteknev like 'P%';

-- a budapesti lakhelyu diakok tagdijjanak csokkentese 60%-al
select vezeteknev, keresztnev, tagdij, tagdij*0.4 csökkentett_tagdij from konyvtar.tag where cim like '_____Budapest%' and besorolas like 'diák';

-- minden konyv aminek az isbn szam 4. karaktere 0
select cim, isbn from konyvtar.konyv where isbn like '___0%' order by cim desc;

-- 30 evnel fiatalabb tagok kilistazasa
select vezeteknev,keresztnev, floor(months_between(sysdate, szuletesi_datum)/12) from konyvtar.tag where floor(months_between(sysdate, szuletesi_datum)/12) < 30;
