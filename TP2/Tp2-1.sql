

--*************************************************************
--                                                            *
--      auteur:         CHAOUKI Mohamed                       *
--      code permanent: CHAM27088802                          *
--      courriel:       chaouki.mohamed@courrier.uqam.ca      *
--                                                            *
--      auteur:         Christian Koy Okitapoy                *
--      code permanent: OKIK08078702                          *
--      courriel:       okitapoy@gmail.com                    *
--                                                            *
--                                                            *
--*************************************************************
PROMPT Creation des tables

SET ECHO ON

DROP TABLE Inscription
;
DROP TABLE GroupeCours
;
DROP TABLE Prealable
;
DROP TABLE Cours
;
DROP TABLE SessionUQAM
;
DROP TABLE Etudiant
;
DROP TABLE Professeur
;

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY'
;

CREATE TABLE Cours
(sigle 		CHAR(7) 	NOT NULL,
 titre 		VARCHAR(50) 	NOT NULL,
 nbCredits 	INTEGER 	NOT NULL,
 CONSTRAINT ClePrimaireCours PRIMARY KEY 	(sigle)
)
;

CREATE TABLE Prealable
(sigle 		CHAR(7) 	NOT NULL,
 siglePrealable CHAR(7) 	NOT NULL,
 CONSTRAINT ClePrimairePrealable PRIMARY KEY 	(sigle,siglePrealable),
 CONSTRAINT CEsigleRefCours FOREIGN KEY 	(sigle) REFERENCES Cours,
 CONSTRAINT CEsiglePrealableRefCours FOREIGN KEY 	(siglePrealable) REFERENCES Cours(sigle)
)
;

CREATE TABLE SessionUQAM
(codeSession 	INTEGER		NOT NULL,
 dateDebut 	DATE		NOT NULL,
 dateFin 	DATE		NOT NULL,
 CONSTRAINT ClePrimaireSessionUQAM PRIMARY KEY 	(codeSession)
)
;

CREATE TABLE Professeur
(codeProfesseur		CHAR(5)	NOT NULL,
 nom			VARCHAR(10)	NOT NULL,
 prenom		VARCHAR(10)	NOT NULL,
 CONSTRAINT ClePrimaireProfesseur PRIMARY KEY 	(codeProfesseur)
)
;

CREATE TABLE GroupeCours
(sigle 		CHAR(7) 	NOT NULL,
 noGroupe	INTEGER		NOT NULL,
 codeSession	INTEGER		NOT NULL,
 maxInscriptions	INTEGER		NOT NULL,
 codeProfesseur		CHAR(5)	NOT NULL,
CONSTRAINT ClePrimaireGroupeCours PRIMARY KEY 	(sigle,noGroupe,codeSession),
CONSTRAINT CESigleGroupeRefCours FOREIGN KEY 	(sigle) REFERENCES Cours,
CONSTRAINT CECodeSessionRefSessionUQAM FOREIGN KEY 	(codeSession) REFERENCES SessionUQAM,
CONSTRAINT CEcodeProfRefProfesseur FOREIGN KEY(codeProfesseur) REFERENCES Professeur 
)
;

CREATE TABLE Etudiant
(codePermanent 	CHAR(12) 	NOT NULL,
 nom		VARCHAR(10)	NOT NULL,
 prenom		VARCHAR(10)	NOT NULL,
 codeProgramme	INTEGER,
CONSTRAINT ClePrimaireEtudiant PRIMARY KEY 	(codePermanent)
)
;

CREATE TABLE Inscription
(codePermanent 	CHAR(12) 	NOT NULL,
 sigle 		CHAR(7) 	NOT NULL,
 noGroupe	INTEGER		NOT NULL,
 codeSession	INTEGER		NOT NULL,
 dateInscription DATE		NOT NULL,
 dateAbandon	DATE,
 note		INTEGER,
CONSTRAINT ClePrimaireInscription PRIMARY KEY  (codePermanent,sigle,noGroupe,codeSession),
CONSTRAINT CERefGroupeCours FOREIGN KEY 	(sigle,noGroupe,codeSession) REFERENCES GroupeCours,
CONSTRAINT CECodePermamentRefEtudiant FOREIGN KEY (codePermanent) REFERENCES Etudiant
)
;

PROMPT Insertion de donnees pour les essais

INSERT INTO Cours VALUES('INF3180','Fichiers et bases de donnees',3)
;

INSERT INTO Cours VALUES('INF5180','Conception et exploitation d''une base de donnees',3)
;

INSERT INTO Cours VALUES('INF1110','Programmation I',3)
;

INSERT INTO Cours VALUES('INF1130','Mathematiques pour informaticien',3)
;

INSERT INTO Cours VALUES('INF2110','Programmation II',3)
;

INSERT INTO Cours VALUES('INF3123','Programmation objet',3)
;

INSERT INTO Cours VALUES('INF2160','Paradigmes de programmation',3)
;

INSERT INTO Prealable VALUES('INF2110','INF1110')
;

INSERT INTO Prealable VALUES('INF2160','INF1130')
;

INSERT INTO Prealable VALUES('INF2160','INF2110')
;

INSERT INTO Prealable VALUES('INF3180','INF2110')
;

INSERT INTO Prealable VALUES('INF3123','INF2110')
;

INSERT INTO Prealable VALUES('INF5180','INF3180')
;

INSERT INTO SessionUQAM VALUES(32003,'3/09/2003','17/12/2003')
;

INSERT INTO SessionUQAM VALUES(12004,'8/01/2004','2/05/2004')
;

INSERT INTO Professeur VALUES('TREJ4','Tremblay','Jean')
;

INSERT INTO Professeur VALUES('DEVL2','De Vinci','Leonard')
;

INSERT INTO Professeur VALUES('PASB1','Pascal','Blaise')
;

INSERT INTO Professeur VALUES('GOLA1','Goldberg','Adele')
;

INSERT INTO Professeur VALUES('KNUD1','Knuth','Donald')
;

INSERT INTO Professeur VALUES('GALE9','Galois','Evariste')
;

INSERT INTO Professeur VALUES('CASI0','Casse','Illa')
;

INSERT INTO Professeur VALUES('SAUV5','Sauve','Andre')
;

INSERT INTO GroupeCours VALUES('INF1110',20,32003,100,'TREJ4')
;

INSERT INTO GroupeCours VALUES('INF1110',30,32003,100,'PASB1')
;
INSERT INTO GroupeCours VALUES('INF1130',10,32003,100,'PASB1')
;
INSERT INTO GroupeCours VALUES('INF1130',30,32003,100,'GALE9')
;
INSERT INTO GroupeCours VALUES('INF2110',10,32003,100,'TREJ4')
;
INSERT INTO GroupeCours VALUES('INF3123',20,32003,50,'GOLA1')
;
INSERT INTO GroupeCours VALUES('INF3123',30,32003,50,'GOLA1')
;
INSERT INTO GroupeCours VALUES('INF3180',30,32003,50,'DEVL2')
;
INSERT INTO GroupeCours VALUES('INF3180',40,32003,50,'DEVL2')
;
INSERT INTO GroupeCours VALUES('INF5180',10,32003,50,'KNUD1')
;
INSERT INTO GroupeCours VALUES('INF5180',40,32003,50,'KNUD1')
;
INSERT INTO GroupeCours VALUES('INF1110',20,12004,100,'TREJ4')
;
INSERT INTO GroupeCours VALUES('INF1110',30,12004,100,'TREJ4')
;
INSERT INTO GroupeCours VALUES('INF2110',10,12004,100,'PASB1')
;
INSERT INTO GroupeCours VALUES('INF2110',40,12004,100,'PASB1')
;
INSERT INTO GroupeCours VALUES('INF3123',20,12004,50,'GOLA1')
;
INSERT INTO GroupeCours VALUES('INF3123',30,12004,50,'GOLA1')
;
INSERT INTO GroupeCours VALUES('INF3180',10,12004,50,'DEVL2')
;
INSERT INTO GroupeCours VALUES('INF3180',30,12004,50,'DEVL2')
;
INSERT INTO GroupeCours VALUES('INF5180',10,12004,50,'DEVL2')
;
INSERT INTO GroupeCours VALUES('INF5180',40,12004,50,'GALE9')
;

INSERT INTO Etudiant VALUES('TREJ18088001','Tremblay','Jean',7416)
;
INSERT INTO Etudiant VALUES('TREL14027801','Tremblay','Lucie',7416)
;
INSERT INTO Etudiant VALUES('DEGE10027801','Degas','Edgar',7416)
;
INSERT INTO Etudiant VALUES('MONC05127201','Monet','Claude',7316)
;
INSERT INTO Etudiant VALUES('VANV05127201','Van Gogh','Vincent',7316)
;
INSERT INTO Etudiant VALUES('MARA25087501','Marshall','Amanda',null)
;
INSERT INTO Etudiant VALUES('STEG03106901','Stephani','Gwen',7416)
;
INSERT INTO Etudiant VALUES('EMEK10106501','Emerson','Keith',7416)
;
INSERT INTO Etudiant VALUES('DUGR08085001','Duguay','Roger',null)
;
INSERT INTO Etudiant VALUES('LAVP08087001','Lavoie','Paul',null)
;
INSERT INTO Etudiant VALUES('TREY09087501','Tremblay','Yvon',7316)
;

INSERT INTO Inscription VALUES('TREJ18088001','INF1110',20,32003,'16/08/2003',null,80)
;
INSERT INTO Inscription VALUES('LAVP08087001','INF1110',20,32003,'16/08/2003',null,80)
;
INSERT INTO Inscription VALUES('TREL14027801','INF1110',30,32003,'17/08/2003',null,90)
;
INSERT INTO Inscription VALUES('MARA25087501','INF1110',20,32003,'20/08/2003',null,80)
;
INSERT INTO Inscription VALUES('STEG03106901','INF1110',20,32003,'17/08/2003',null,70)
;
INSERT INTO Inscription VALUES('TREJ18088001','INF1130',10,32003,'16/08/2003',null,70)
;
INSERT INTO Inscription VALUES('TREL14027801','INF1130',30,32003,'17/08/2003',null,80)
;
INSERT INTO Inscription VALUES('MARA25087501','INF1130',10,32003,'22/08/2003',null,90)
;
INSERT INTO Inscription VALUES('DEGE10027801','INF3180',30,32003,'16/08/2003',null,90)
;
INSERT INTO Inscription VALUES('MONC05127201','INF3180',30,32003,'19/08/2003',null,60)
;
INSERT INTO Inscription VALUES('VANV05127201','INF3180',30,32003,'16/08/2003','20/09/2003',null)
;
INSERT INTO Inscription VALUES('EMEK10106501','INF3180',40,32003,'19/08/2003',null,80)
;
INSERT INTO Inscription VALUES('DUGR08085001','INF3180',40,32003,'19/08/2003',null,70)
;
INSERT INTO Inscription VALUES('TREJ18088001','INF2110',10,12004,'19/12/2003',null,80)
;
INSERT INTO Inscription VALUES('TREL14027801','INF2110',10,12004,'20/12/2003',null,90)
;
INSERT INTO Inscription VALUES('MARA25087501','INF2110',40,12004,'19/12/2003',null,90)
;
INSERT INTO Inscription VALUES('STEG03106901','INF2110',40,12004, '10/12/2003',null,70)
;
INSERT INTO Inscription VALUES('VANV05127201','INF3180',10,12004, '18/12/2003',null,90)
;
INSERT INTO Inscription VALUES('DEGE10027801','INF5180',10,12004, '15/12/2003',null,90)
;
INSERT INTO Inscription VALUES('MONC05127201','INF5180',10,12004, '19/12/2003','22/01/2004',null)
;
INSERT INTO Inscription VALUES('EMEK10106501','INF5180',40,12004, '19/12/2003',null,80)
;
INSERT INTO Inscription VALUES('DUGR08085001','INF5180',10,12004, '19/12/2003',null,80)
;
COMMIT
;

PROMPT Contenu des tables
SELECT * FROM Cours
;
SELECT * FROM Prealable
;
SELECT * FROM SessionUQAM
;
SELECT * FROM Professeur
;
SELECT * FROM GroupeCours
;
SELECT * FROM Etudiant
;
SELECT * FROM Inscription
;

--C1 Créez un déclencheur, qui est lancé avant chaque nouvelle commande INSERT ou UPDATE dans la table SessionUQAM et qui vérifie si la dateFin est inférieure à la dateDebut ». Un message d’erreur sera affiché dans le cas positif justifiant cette erreur. Exemple: « la date de fin de session ne devrait pas être inférieure à la date de début de session ». Dans ce le cas contraire, l’opération LMD a lieu.
--Faites deux tests : le premier pour une opération d’insertion et le deuxième pour une opération de mise à jour d’un tuple existant.

CREATE OR REPLACE TRIGGER declencheurC1
BEFORE INSERT OR UPDATE ON SessionUQAM
FOR EACH ROW
BEGIN
IF :NEW.datefin < :NEW.datedebut THEN
RAISE_APPLICATION_ERROR(-20000,'la date de fin de session ne devrait pas etre inferieure a la date de debut de session');
END IF;
END;
/

-- Tester C1
INSERT INTO SessionUQAM VALUES('63589', '15/01/2019', '29/04/2018');
UPDATE SessionUQAM SET datefin = '29/04/2003' WHERE codesession ='12004';
/



--C2 Créez un déclencheur qui spécifie qu’on ne peut mettre à jour que la note et la dateAbandon dans la table Inscription mais pas les autres attributs. Faites deux tests de mise à jour lié chacun à un de ces attributs.

CREATE OR REPLACE TRIGGER declencheurC2
BEFORE UPDATE ON Inscription
BEGIN
CASE
WHEN UPDATING ('note') THEN
	DBMS_OUTPUT.PUT_LINE('Mise a jour reussie pour Inscription.note');
WHEN UPDATING ('dateAbandon') THEN
	DBMS_OUTPUT.PUT_LINE('Mise a jour reussie pour Inscription.note');
ELSE
RAISE_APPLICATION_ERROR(-20010,'On ne peut mettre a jour que la note et la dateAbandon');
END CASE;
END;
/

-- Tester C2
UPDATE Inscription SET codeSession = 12004 WHERE codepermanent ='STEG03106901';
UPDATE Inscription SET sigle = 'INF3180' WHERE codepermanent ='MARA25087501';
/


--C3 Créez un déclencheur qui interdit de faire diminuer la valeur de la note d’un étudiant de plus de 10% lors d’une mise à jour. Si la valeur de la note est inférieure à zéro, générer un message d’erreur. En plus, cette dernière manipulation serait interdite et se stabiliserait à la note zéro. Faites deux tests de mise à jour dont un test qui aurait une diminution en bas de zéro et stabiliserait la note à zéro.

CREATE OR REPLACE TRIGGER declencheurC3
BEFORE UPDATE ON Inscription
FOR EACH ROW
BEGIN
IF ((:OLD.note - :NEW.note)/:OLD.note) > 0.1 AND :NEW.note > 0 THEN
RAISE_APPLICATION_ERROR(-20020,'Il est interdit de faire diminuer la valeur de la note d un etudiant de plus de 10% lors d une mise a jour.');
ELSIF :NEW.note < 0 THEN
:NEW.note := 0;
RAISE_APPLICATION_ERROR(-20030,'Il est interdit de donner une note negative a un etudiant. Cette derniere manipulation est interdite. Elle se stabiliserait a la note zero.');
END IF;
END;
/

-- Tester C3
UPDATE Inscription SET note = 71 WHERE codePermanent ='DUGR08085001';
UPDATE Inscription SET note = -1 WHERE codePermanent ='MARA25087501';
/


--C4 Ajoutez une colonne intitulée fréquence à la tale Cours, de type entier. Créez un déclencheur qui rajouterait des valeurs numériques à cette colonne commençant par 1 suite à une nouvelle insertion d’un cours. Les valeurs de cette colonne s’incrémenteront à chaque nouvelle insertion.Faites un test en insérant trois nouveaux cours (INF5080, INF9320, INF7654). Faites un affichage du contenu de la table Cours (select * from Cours;).

ALTER TABLE Cours ADD frequence INTEGER;
CREATE OR REPLACE TRIGGER declencheurC4
BEFORE INSERT ON Cours
FOR EACH ROW
DECLARE
frequence INTEGER;
BEGIN
SELECT MAX (frequence)
INTO frequence
FROM Cours;
IF frequence IS NULL THEN
frequence :=0;
END IF;
:NEW.frequence := frequence + 1;
END;
/

-- Tester C4
INSERT INTO cours VALUES('INF5080', 'Nouveau cours I', 3, NULL);
INSERT INTO cours VALUES('INF9320', 'Nouveau cours II', 3, NULL);
INSERT INTO cours VALUES('INF7654', 'Nouveau cours III', 3, NULL);
SELECT * FROM cours;
/
