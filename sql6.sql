-- hajo sema 1. zh-n

-- listazzuk ki az idoben leghosszabb utat
select max(erkezesi_ido-indulasi_ido) from hajo.s_ut;

-- listazzuk ki a pragai ugyfeleket (ha van(de nincs))
select * from hajo.s_ugyfel u inner join hajo.s_helyseg h on u.helyseg = h.helyseg_id where helysegnev = 'Prága';

-- noi kajak-kenu versenyszamok
select * from olimpia.o_versenyszamok vsz inner join olimpia.o_sportagak s on vsz.sportag_azon = s.azon where vsz.ferfi_noi = 'női' and nev = 'Kajak-kenu';

-- europai orszagok eredmenyei, aranyk ezust, bronz szerint IS csokkenoben
select * from olimpia.o_orszagok os inner join olimpia.o_erem_tabla erem on os.azon = erem.orszag_azon
where os.foldresz='Európa' order by erem.arany desc, erem.ezust desc, erem.bronz desc;

-- egyes szerzok hany konyvet irtak
select sz.vezeteknev, sz.keresztnev, sz.szerzo_azon, count(konyv_azon) from konyvtar.konyvszerzo ksz inner join konyvtar.szerzo sz on ksz.szerzo_azon = sz.szerzo_azon
group by sz.vezeteknev, sz.keresztnev, sz.szerzo_azon;

-- beagyazott select
-- ki a legidosebb tag
select vezeteknev, keresztnev from konyvtar.tag
where szuletesi_datum = ( select min(szuletesi_datum) from konyvtar.tag);

-- krimi temaju konyvek kozul melyik a legdragabb
select * from konyvtar.konyv where tema = 'krimi' and ar = (select max(ar) from konyvtar.konyv where tema = 'krimi');

-- kik azok a tagok akik kevesebb tagdijat fizetnek mint a nyugdijas es a diak besorolasu tagok atlagos tagdija
select * from konyvtar.tag where tagdij < (select avg(tagdij) from konyvtar.tag where besorolas in ('nyugdíjas','diák'));

-- listazzuk ki az elso 10 konyvet a vim szerint lexografikus sorrendben
select cim from konyvtar.konyv order by cim fetch first 10 rows only;

-- listazzuk ki az elso 10 konyvet a vim szerint lexografikus sorrendben
select cim from konyvtar.konyv order by cim offset 10 rows fetch next 10 rows only;
