

--*************************************************************
--                                                            *
--      auteur:         CHAOUKI Mohamed                       *
--      code permanent: CHAM27088802                          *
--      courriel:       chaouki.mohamed@courrier.uqam.ca      *
--                                                            *
--     auteur:         Christian Koy Okitapoy                 *
--      code permanent: OKIK08078702                          *
--      courriel:       okitapoy@gmail.com                    *
--                                                            *
--                                                            *
--*************************************************************

--Req#1.
--Donnez les informations sans répétition des sigles, titres des cours pris par l’étudiant Lavoie Paul ainsi que les noms des professeurs qui donnent ces cours.

select distinct Cours.sigle,titre,Professeur.nom,Professeur.prenom
from Etudiant,Inscription,GroupeCours,Professeur,Cours
where Etudiant.nom = 'Lavoie' AND
Etudiant.prenom = 'Paul' AND
Etudiant.codePermanent = Inscription.codePermanent AND
Inscription.sigle = groupeCours.sigle AND
cours.Sigle = GroupeCours.sigle AND
Inscription.noGroupe = GroupeCours.noGroupe AND
GroupeCours.codeProfesseur = Professeur.codeProfesseur
/

--REQ#2.
--On cherche les code et noms des professeurs, sans répétition, qui ont enseigné à la fois les cours
--INF3180 et INF2110, durant la session dont le code est 12004. Aussi, les code et noms des
--professeurs, sans répétition, qui ont enseigné les cours INF1130 ou INF1110, durant la session dont le code est 32003

select distinct Professeur.codeProfesseur,nom
from GroupeCours,Professeur
where(professeur.codeProfesseur = GroupeCours.codeProfesseur AND
sigle = 'INF3180' AND sigle = 'INF2110' AND codeSession = '12004') AND
(Professeur.codeProfesseur = GroupeCours.codeProfesseur AND
sigle = 'INF1130' OR sigle = 'INF1110' AND codeSession = '32003')
/

--REQ#3.
--On cherche les informations sur différents étudiants qui ont reçu la même note pour le même cours
--(sigle) à la même session (codesession). Le résultat doit être affiché avec les attributs suivants (codepermanent 1, code permanent 2, sigle, codesession, note).

SELECT Inscription.codePermanent,Inscription2.codePermanent,Inscription.sigle,Inscription.codeSession,Inscription.note
FROM Inscription,Inscription Inscription2
WHERE Inscription.codePermanent != Inscription2.codePermanent AND
Inscription.codeSession = Inscription2.codeSession AND
Inscription.sigle = Inscription2.sigle AND
Inscription.note = Inscription2.note
/

--REQ#4.
--On cherche les codes permanents, noms et prénoms des étudiants inscrits aux cours dont les sigles
--commencent par les lettres ‘InF’, enseignés par le professeur dont le nom est 'De Vinci' des
--sessions 32003 ou 12004. Ces étudiants sont considérés n’avoir pas abandonné le cours durant cette session.

SELECT Etudiant.codePermanent,Etudiant.nom,Etudiant.prenom
FROM Etudiant,Inscription,GroupeCours,Professeur
WHERE Etudiant.codePermanent = Inscription.codePermanent AND
Inscription.sigle LIKE 'INF%' AND
Inscription.Sigle = GroupeCours.sigle AND
Inscription.codeSession = GroupeCours.codeSession AND
(Inscription.codeSession = 32003 OR Inscription.codeSession = 12004 ) AND
GroupeCours.codeProfesseur = Professeur.codeProfesseur AND
Professeur.nom = 'De Vinci' AND
dateAbandon IS NULL
/


--REQ#5.
--On cherche les codes et les noms des professeurs, sans répétition, qui ont enseigné au plus un cours offert à la session 32003 ou au moins un cours offert aux deux sessions (toutes les deux) dont les codes sont 12004 et 22005.

SELECT DISTINCT GroupeCours.codeprofesseur, Professeur.nom
FROM      professeur , groupecours 
WHERE     Professeur.codeprofesseur = GroupeCours.codeprofesseur AND
          GroupeCours.codesession = '32003' OR (GroupeCours.codesession = '12004' AND 
GroupeCours.codesession = '22005')
GROUP BY  GroupeCours.codeprofesseur, Professeur.nom
HAVING count(*) = 1
/

--REQ#6.
--Lister les codes permanents et les noms des étudiants dont le nom commence par la lettre ‘T‘ et
--contient au moins la lettre ‘a’ quelque soit sa position.

SELECT codePermanent, nom 
FROM Etudiant
WHERE nom LIKE 'T%a%'
/


--REQ#7.
--Retourner les sigles des cours non encore enseignés par le professeur dont le nom est
--'Galois','Evariste'.


SELECT DISTINCT sigle
FROM GroupeCours,Professeur
WHERE GroupeCours.codeProfesseur = Professeur.codeProfesseur AND
nom NOT LIKE 'Galois' AND prenom NOT LIKE 'Evariste' AND
sigle NOT IN (SELECT sigle
FROM GroupeCours,Professeur
WHERE GroupeCours.codeProfesseur = Professeur.codeProfesseur AND
nom LIKE 'Galois' AND prenom LIKE 'Evariste')
/

--REQ#8.
--Afficher la différence entre la moyenne des notes des cours donnés durant la session dont le code
--est 32203 et ceux de la session dont le code est 12204.

-- PS : la requete marche avec les bon codeSession le resulat est -5.41... mais dans la question les
-- codes de session ne sont pas les bons alors il n y  a rien qui s'affiche

SELECT DISTINCT
(SELECT AVG(note) FROM Inscription WHERE codeSession = 32203)
-
(SELECT AVG(note)  FROM Inscription WHERE codeSession = 12204)
FROM Inscription
/


--REQ#9.
--Pour chaque code session et sigle d’un cours, retourner le sigle du cours et son titre et la différence entre la meilleure et la plus mauvaise note pour un cours donné.

SELECT titre,Inscription.sigle, MAX(note) - MIN(note)
FROM Inscription,GroupeCours,Cours
WHERE Inscription.codeSession = GroupeCours.codeSession AND
Inscription.sigle = GroupeCours.sigle AND Inscription.sigle = Cours.sigle
GROUP BY Inscription.sigle,titre
/


--REQ#10.
--Pour tous les cours qui ont une moyenne des notes supérieure ou égale à 80 pour la session
--dont le code est 32003, mettre à jour la colonne dateFin de la table SessionUQAM en la mettant
--au 22 décembre 2003.


UPDATE SessionUQAM 
SET dateFin = '22/12/2003'
WHERE codesession = '32003' AND EXISTS (
SELECT    i.sigle, AVG(i.note) AS MOYENNE
FROM      inscription i
WHERE     i.codesession = '32003'
GROUP BY  i.sigle
HAVING    AVG(i.note) >= 80
)
/


--Req 11
--Supprimer les colonnes dateAbandon et maxInscriptions de(s) la table(s) concernée(s). Afficher
--le(s) contenu(s) de(s) la table(s) concernée(s).

Alter table Inscription drop column dateAbandon
/

Select * from Inscription
/

Alter table GroupeCours drop column maxInscriptions
/
Select * from GroupeCours
/

--Req 12 
--Supprimer tous les étudiants de la base de données à l’exception des étudiants dont le nom
--commence par la lettre ‘T’. Afficher le(s) contenu(s) de(s) la table(s) concernée(s).

Delete from Inscription where codePermanent not like 'T%'
/

Delete from Etudiant where nom not like 'T%'
/

Select * from Etudiant
/



