-- requêtes création des tables

DROP TABLE IF EXISTS village CASCADE; 
DROP TABLE IF EXISTS habitant CASCADE;
DROP TABLE IF EXISTS resserre CASCADE;
DROP TABLE IF EXISTS trophee CASCADE;
DROP TABLE IF EXISTS province CASCADE;
DROP TABLE IF EXISTS categorie CASCADE;
DROP TABLE IF EXISTS qualite CASCADE;
DROP TABLE IF EXISTS potion CASCADE;
DROP TABLE IF EXISTS absorber CASCADE;
DROP TABLE IF EXISTS fabriquer CASCADE;

CREATE TABLE province  (
  num_province SERIAL PRIMARY KEY,
  nom_province VARCHAR(30) NOT NULL ,
  nom_gouverneur VARCHAR(30) NOT NULL 
);


CREATE TABLE categorie  (
  code_cat CHAR (3) PRIMARY KEY,
  nom_categ VARCHAR(50),
  nb_points INT
); 



CREATE TABLE qualite  (
  num_qualite SERIAL PRIMARY KEY ,
  lib_qualite VARCHAR(30)
);



CREATE TABLE village  (
  num_village SERIAL PRIMARY KEY ,
  nom_village VARCHAR(30) NOT NULL ,
  nb_huttes INT NOT NULL DEFAULT 1,
  num_province INT NOT NULL,
  constraint fk_province FOREIGN KEY (num_province) REFERENCES province (num_province)
) ;



CREATE TABLE resserre (
  num_resserre SERIAL PRIMARY KEY ,
  nom_resserre VARCHAR(30) NOT NULL ,
  superficie INT NOT NULL DEFAULT 0,
  num_village INT NOT NULL,
  CONSTRAINT fk_village FOREIGN KEY (num_village) REFERENCES village (num_village)
) ;



CREATE TABLE habitant (
  num_hab SERIAL PRIMARY KEY,
  nom VARCHAR(30),
  age INT,
  num_qualite INT,
  num_village INT,
  CONSTRAINT fk_qualite FOREIGN KEY (num_qualite) REFERENCES qualite (num_qualite),
  CONSTRAINT fk_village FOREIGN KEY (num_village) REFERENCES village (num_village)
);



CREATE TABLE trophee  (
  num_trophee SERIAL PRIMARY KEY ,
  date_prise DATE NOT NULL,
  code_cat CHAR(3),
  num_preneur INT,
  num_resserre INT,
  CONSTRAINT fk_habitant FOREIGN KEY (num_preneur) REFERENCES habitant (num_hab),
  CONSTRAINT fk_resserre FOREIGN KEY (num_resserre) REFERENCES resserre(num_resserre),
  CONSTRAINT fk_categorie FOREIGN KEY (code_cat) REFERENCES categorie (code_cat)
);



CREATE TABLE potion (
  num_potion SERIAL PRIMARY KEY ,
  lib_potion VARCHAR(40),
  formule VARCHAR(30),
  constituant_principal VARCHAR(30)
);


CREATE TABLE absorber  (
  num_potion INT NOT NULL,
  date_a DATE,
  num_hab INT,
  quantite INT,
  PRIMARY KEY (date_a, num_potion, num_hab),
  constraint fk_potion FOREIGN KEY (num_potion) REFERENCES potion (num_potion),
  CONSTRAINT fk_habitant FOREIGN KEY (num_hab) REFERENCES habitant (num_hab)
);



CREATE TABLE fabriquer (
    num_potion INT NOT NULL ,
    num_hab INT NOT NULL,  
    PRIMARY KEY (num_potion , num_hab),
    CONSTRAINT fk_habitant FOREIGN KEY (num_hab) REFERENCES habitant(num_hab),
    CONSTRAINT fk_potion FOREIGN KEY (num_potion) REFERENCES potion(num_potion)
);

-- requêtes insertion des données 

Insert Into province (nom_province, nom_gouverneur) 
VALUES ('Armorique','Garovirus'),
('Averne','Nenpeuplus'),
('Aquitaine','Yenapus');

INSERT INTO categorie (code_cat, nom_categ, nb_points)
VALUES ('BCN',	'Bouclier de Centurion',	6),
('BDN',	'Bouclier de Décurion',	4),
('BLE',	'Bouclier de Légionnaire',	3),
('BLT',	'Bouclier de Légat',	10),
('CCN',	'Casque de Centurion',	3),
('CDN',	'Casque de Décurion',	2),
('CLE',	'Casque de Légionnaire',	1),
('CLT',	'Casque de Légat',	4);

INSERT INTO qualite (lib_qualite)
VALUES ('Chef'), 
('Druide'), 
('Barde'), ('Guerrier'), 
('Chasseur'), 
('Livreur de menhirs'), 
('Facteur'), 
('Poissonnière'), 
('Serveuse');

INSERT INTO village (nom_village, nb_huttes, num_province) 
VALUES ('Aquilona', 52, 1), 
( 'Lutèce', 25, 2), 
('Aginum', 33, 3), 
('Calendes Aquae', 42, 2), 
('Condate', 38, 1), 
('Gergovie', 55, 3), 
('Aquae Calidae', 35, 2);

INSERT INTO resserre (nom_resserre, superficie, num_village) 
VALUES ('Albinus',	720,	4),
('Vercingetorix',	500,	6),
('Sintrof',	895,	1);

INSERT INTO habitant (nom, age, num_qualite, num_village) 
VALUES 
('Abraracourcix', 65, 1, 1), 
('Amnésix', 56, 2,	7), 
('Barometrix', 68, 2, 3), 
('Panoramix', 79,	2, 1), 
('Assurancetourix', 53,	3, 1),
('Zérozérosix',	75, 2, 4), 
('Astérix', 35, 4, 1), 
('Bellodalix', 32, 4, 7), 
('Cétyounix',	32,	4,	4), 
('Homéopatix',	48,	5,	6), 
('Obélix',	38,	6,	1),
('Plantaquatix', 30, 5, 5), 
('Moralélastix',67,	1,	2), 
('Pneumatix',	26,	7,	1), 
('Pronostix',	35,	4,	5), 
('Goudurix',	38,	4,	2),
('Océanix', 40,	5, 5), 
('Asdepix', 53,	1, 5), 
('Eponine',	48,	8,	2), 
('Falbala',	26,	9,	1), 
('Gélatine',	65,	NULL,	6), 
('Fanzine', 21,	NULL,	3);

INSERT INTO trophee (date_prise, code_cat, num_preneur, num_resserre)
VALUES 
('2052-04-03 00:00:00',	'BLE',	7,	3),
('2052-04-03 00:00:00',	'BLT',	11,	3),
('2052-05-05 00:00:00',	'CDN',	15,	1),
('2052-05-05 00:00:00',	'CLE',	16,	2),
('2052-06-06 00:00:00',	'CCN',	16,	2),
('2052-06-06 00:00:00',	'BLT',	 8,	1),
('2052-08-18 00:00:00',	'CCN',	8,	1),
('2052-09-20 00:00:00',	'CLT',	1,	3),
('2052-10-23 00:00:00',	'CDN',	7,	2),
('2052-10-23 00:00:00',	'CLE',	16,	1);

INSERT INTO potion (lib_potion, formule, constituant_principal)
VALUES ('Potion magique n°1' ,	NULL,	'Gui'),
('Potion magique n°2',	'4V3C2VA', 'Vin'), 
('Potion magique n°3',	'2C1B',	'Calva'), 
('Potion Zen',	NULL,	'Jus de Betterave'), 
('Potion Anti Douleur', '5C3J1T',	'Calva');

INSERT INTO absorber (num_potion, date_a, num_hab, quantite)
VALUES (1,'2052-02-18 00:00:00',7,3),
(2,'2052-02-18 00:00:00',12,4),
(1,'2052-02-20 00:00:00',2,2),
(1,'2052-02-20 00:00:00',8,2),
(3,'2052-02-20 00:00:00',7,1),
(1,'2052-04-03 00:00:00',7,1),
(1,'2052-04-03 00:00:00',15,2),
(2,'2052-04-03 00:00:00',13,5),
(3,'2052-04-03 00:00:00',10,4),
(4,'2052-05-05 00:00:00',15,2),
(5,'2052-05-10 00:00:00',1,4),
(5,'2052-05-10 00:00:00',2,1),
(1,'2052-06-06 00:00:00',13,2),
(2,'2052-06-06 00:00:00',7,1),
(3,'2052-06-06 00:00:00',8,4),
(5,'2052-06-07 00:00:00',1,2),
(5,'2052-07-17 00:00:00',7,1),
(2,'2052-07-18 00:00:00',7,3),
(1,'2052-08-18 00:00:00',8,3),
(1,'2052-08-18 00:00:00',16,1),
(3,'2052-08-18 00:00:00',10,2),
(4,'2052-08-18 00:00:00',7,2),
(3,'2052-09-20 00:00:00',7,5),
(4,'2052-09-20 00:00:00',1,2),
(2,'2052-10-23 00:00:00',7,4),
(3,'2052-10-23 00:00:00',13,1),
(4,'2052-10-23 00:00:00',13,3),
(1,'2052-11-26 00:00:00',10,2),
(2,'2052-11-26 00:00:00',8,2),
(5,'2052-11-26 00:00:00',13,2),
(5,'2052-11-26 00:00:00',16,2);

INSERT INTO fabriquer (num_potion, num_hab)
VALUES (1,4),
(2,2),
(3,3),
(4,4),
(4,6),
(5,2),
(5,4);

--1. Liste des potions : Numéro, libellé, formule et constituant principal. (5 lignes)

SELECT num_potion FROM  potion;
SELECT lib_potion FROM  potion;
SELECT formule FROM  potion;
SELECT constituant_principal FROM  potion;

select num_potion, lib_potion, formule, constituant_principal FROM  potion

--2. Liste des noms des trophées rapportant 3 points. (2 lignes)

select nom_categ 
from categorie 
where nb_points = 3;

--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)

select nom_village 
from village 
where nb_huttes > 35;

--4. Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)

select num_trophee 
from trophee where date_prise 
between '2052-05-05' and '2052-06-06';

--5. Noms des habitants commençant par 'a' et contenant la lettre 'r'. (3 lignes)

select * from habitant where nom LIKE 'A%' and nom LIKE '%r%';

--6. Numéros des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)

select num_hab 
from absorber 
where num_potion = 1 or num_potion = 3 or num_potion = 4
group by num_hab;

--7. Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10lignes)

SELECT trophee.num_trophee, trophee.date_prise, trophee.num_preneur, categorie.nom_categ
FROM trophee
JOIN categorie ON trophee.code_cat = categorie.code_cat;

--8. Nom des habitants qui habitent à Aquilona. (7 lignes)

SELECT habitant.nom
FROM habitant
JOIN village ON habitant.num_village = village.num_village
WHERE village.nom_village = 'Aquilona';

--9. Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)

SELECT DISTINCT habitant.nom
FROM habitant
JOIN trophee ON habitant.num_hab = trophee.num_preneur
JOIN categorie ON trophee.code_cat = categorie.code_cat
WHERE categorie.nom_categ = 'Bouclier de Légat';


--10. Liste des potions (libellés) fabriquées par Panoramix : libellé, formule et constituantprincipal. (3 lignes)

SELECT potion.lib_potion, potion.formule, potion.constituant_principal
FROM potion
JOIN fabriquer ON potion.num_potion = fabriquer.num_potion
JOIN habitant ON fabriquer.num_hab = habitant.num_hab
WHERE habitant.nom = 'Panoramix';

--11. Liste des potions (libellés) absorbées par Homéopatix. (2 lignes)

SELECT DISTINCT potion.lib_potion
FROM potion
JOIN absorber ON potion.num_potion = absorber.num_potion
JOIN habitant ON absorber.num_hab = habitant.num_hab
WHERE habitant.nom = 'Homéopatix';

--12. Liste des habitants (noms) ayant absorbé une potion fabriquée par l'habitant numéro 3. (4 lignes)

SELECT DISTINCT habitant.nom
FROM habitant
JOIN absorber ON habitant.num_hab = absorber.num_hab
JOIN fabriquer ON absorber.num_potion = fabriquer.num_potion
WHERE fabriquer.num_hab = 3;

--13. Liste des habitants (noms) ayant absorbé une potion fabriquée par Amnésix. (7 lignes)

SELECT DISTINCT habitant.nom
FROM habitant
JOIN absorber ON habitant.num_hab = absorber.num_hab
JOIN fabriquer ON absorber.num_potion = fabriquer.num_potion
JOIN habitant AS fab_habitant ON fabriquer.num_hab = fab_habitant.num_hab
WHERE fab_habitant.nom = 'Amnésix';

--14. Nom des habitants dont la qualité n'est pas renseignée. (2 lignes)

SELECT nom
FROM habitant
LEFT JOIN qualite ON habitant.num_qualite = qualite.num_qualite
WHERE qualite.num_qualite IS NULL;

--15. Nom des habitants ayant consommé la Potion magique n°1 (c'est le libellé de lapotion) en février 52. (3 lignes)

 SELECT nom, a.date_a  FROM habitant h 
 JOIN absorber a ON h.num_hab =a.num_hab 
 WHERE (a.num_potion = (SELECT p.num_potion  FROM potion p  WHERE p.lib_potion ='Potion magique n°1') AND a.date_a BETWEEN '2052-01-01' AND '2052-02-29')
 --Je me suis fais aidé par Kanzia

--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)
 
 SELECT nom, age
 FROM habitant
 ORDER BY nom ASC;

--17. Liste des resserres classées de la plus grande à la plus petite : nom de resserre et nom du village. (3 lignes)

SELECT resserre.nom_resserre, village.nom_village
FROM resserre
JOIN village ON resserre.num_village = village.num_village
ORDER BY resserre.superficie DESC;

--***

--18. Nombre d'habitants du village numéro 5. (4)

SELECT COUNT(*)
FROM habitant
WHERE num_village = 5;

--19. Nombre de points gagnés par Goudurix. (5)

SELECT SUM(categorie.nb_points) AS points_gagnes
FROM trophee
JOIN categorie ON trophee.code_cat = categorie.code_cat
JOIN habitant ON trophee.num_preneur = habitant.num_hab
WHERE habitant.nom = 'Goudurix';

--20. Date de première prise de trophée. (03/04/52)

SELECT MIN(date_prise) AS oldest_date
FROM trophee;

--21. Nombre de louches de Potion magique n°2 (c'est le libellé de la potion) absorbées. (19)

SELECT SUM(quantite) AS louches_prises
FROM absorber
JOIN potion ON absorber.num_potion = potion.num_potion
WHERE lib_potion = 'Potion magique n°2';

--22. Superficie la plus grande. (895)

SELECT MAX(superficie) AS superficie_maximale
FROM resserre;

--***

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)

SELECT village.nom_village, COUNT(habitant.num_hab) AS nombre_habitants
FROM village
LEFT JOIN habitant ON village.num_village = habitant.num_village
GROUP BY village.num_village, village.nom_village;

--24. Nombre de trophées par habitant (6 lignes)

select distinct  h.nom, count(t.num_trophee) AS nombre_de_trophees
from habitant h
join trophee t on h.num_hab = t.num_preneur
group by h.nom
order by nombre_de_trophees;
-- Katia m'a aidé

--25. Moyenne d'âge des habitants par province (nom de province, calcul). (3 lignes)

SELECT village.num_province, AVG(habitant.age) AS moyenne_age
FROM village
JOIN habitant ON village.num_village = habitant.num_village
GROUP BY village.num_province;


--26. Nombre de potions différentes absorbées par chaque habitant (nom et nombre). (9lignes)

SELECT habitant.nom, COUNT(DISTINCT absorber.num_potion) AS nombre_potions_differentes
FROM habitant
JOIN absorber ON habitant.num_hab = absorber.num_hab
GROUP BY habitant.num_hab, habitant.nom;

--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)

SELECT habitant.nom
FROM habitant
JOIN absorber ON habitant.num_hab = absorber.num_hab
JOIN potion ON absorber.num_potion = potion.num_potion
WHERE potion.lib_potion = 'Potion Zen' AND absorber.quantite > 2;
--Elle ma donné du fil a retordre celle la!

--***
--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)

SELECT DISTINCT village.nom_village
FROM village
JOIN resserre ON village.num_village = resserre.num_village;

--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)

SELECT nom_village
FROM village
WHERE nb_huttes = (
    SELECT MAX(nb_huttes)
    FROM village
);

--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes).

SELECT habitant.nom
FROM habitant
JOIN trophee ON habitant.num_hab = trophee.num_preneur
WHERE habitant.num_hab != (
    SELECT num_hab
    FROM habitant
    WHERE nom = 'Obélix'
) 
GROUP BY habitant.nom
HAVING COUNT(trophee.num_trophee) > (
    SELECT COUNT(num_trophee)
    FROM trophee
    JOIN habitant ON habitant.num_hab = trophee.num_preneur
    WHERE habitant.nom = 'Obélix'
);
-- je me suis fait aidé

