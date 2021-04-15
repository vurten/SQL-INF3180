
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

SET serveroutput ON

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
INSERT INTO Inscription VALUES('VANV05127201','INF3180',30,32003,'16/08/2003','20/09/2003',50)
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
INSERT INTO Inscription VALUES('MONC05127201','INF5180',10,12004, '19/12/2003','22/01/2004',70)
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
/

-- Fonction qui verifie si un etudiant a eu une bonne performance

CREATE OR REPLACE FUNCTION BonnePerformance(cs IN VARCHAR, cp IN VARCHAR) RETURN
BOOLEAN IS
    note INTEGER;
BEGIN
    SELECT MIN(note)
    INTO note
    FROM Inscription
    WHERE  codePermanent  = cp
    AND  codeSession = cs
    GROUP BY codePermanent, codeSession;
    IF (note < 95) THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
exception
    WHEN no_data_found THEN
        RETURN FALSE;
END;
/

-- Fonction qui verifie si un etudiant a eu une mauvaise performance

CREATE OR REPLACE FUNCTION MauvaisePerformance(cs IN VARCHAR, cp IN VARCHAR) RETURN
BOOLEAN IS
    moyenne INTEGER;
BEGIN
    SELECT AVG(note)
    INTO moyenne
    FROM Inscription
    WHERE  codePermanent  = cp
    AND  codeSession = cs
    GROUP BY codePermanent, codeSession;
    IF (moyenne > 25) THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
exception
    WHEN no_data_found THEN
        RETURN FALSE;
END;
/


-- Procedure qui affiche les etudiants excellents / mediore dans la session et meme s'ils n'existent pas durante une session X

CREATE OR REPLACE PROCEDURE EtudiantPerformances (cs IN INTEGER) IS
    compteur INTEGER;
    mediocre BOOLEAN;
    excellent BOOLEAN;

BEGIN
    
    DBMS_OUTPUT.PUT_LINE('Voici la liste des etudiants mediocres de la session ' || cs);
    FOR Etudiant IN (
        SELECT DISTINCT(codePermanent) as cp FROM Inscription WHERE Inscription.codeSession = cs
    ) 
    LOOP
        mediocre := MauvaisePerformance(cs, Etudiant.cp);
        IF (mediocre = TRUE) THEN
	    compteur := compteur +1;
            DBMS_OUTPUT.PUT_LINE(Etudiant.cp);
            
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Voici la liste des etudiants excellents de la session ' || cs);
    compteur := 0;
    FOR Etudiant IN (
        SELECT DISTINCT(codePermanent) as cp FROM Inscription WHERE Inscription.codeSession = cs
    ) 
    LOOP
        excellent := BonnePerformance(cs, Etudiant.cp);
        IF (excellent = TRUE) THEN
            compteur := compteur +1;
            DBMS_OUTPUT.PUT_LINE(Etudiant.cp);

        END IF;
    END LOOP;
    IF (compteur = 0) THEN
        raise_application_error(-20010, ('Pas d etudiants excellents/mediocres pendant la session'));
    END IF;
END;
/

-- Insertions pour les tests
INSERT INTO Cours VALUES ('XXX0000', 'Cours Test', 3);
INSERT INTO SessionUQAM VALUES (00000, '15/01/2019', '29/04/2019');
INSERT INTO GroupeCours VALUES ('XXX0000', 1, 00000, 50, 'GALE9');
INSERT INTO Inscription VALUES('MARA25087501', 'XXX0000', 1, 00000, '01/02/2019', NULL, 99);
INSERT INTO Inscription VALUES('VANV05127201', 'XXX0000', 1, 00000, '01/02/2019', NULL, 95);
INSERT INTO Inscription VALUES('STEG03106901', 'XXX0000', 1, 00000, '01/02/2019', NULL, 97);
INSERT INTO Inscription VALUES('DUGR08085001', 'XXX0000', 1, 00000, '01/02/2019', NULL, 50);
INSERT INTO Inscription VALUES('TREY09087501', 'XXX0000', 1, 00000, '01/02/2019', NULL, 70);
INSERT INTO Inscription VALUES('LAVP08087001', 'XXX0000', 1, 00000, '01/02/2019', NULL, 20);
INSERT INTO Inscription VALUES('TREJ18088001', 'XXX0000', 1, 00000, '01/02/2019', NULL, 15);
INSERT INTO Inscription VALUES('DEGE10027801', 'XXX0000', 1, 00000, '01/02/2019', NULL, 25);
/

-- Test fonctionnel qui affiche la liste des excellents et mediocres etudiants
EXECUTE ETUDIANTPERFORMANCES(00000);
/
-- Test fonctionnel qui affiche qu'il n y a aucun etudiant excellent / mediocre dans la session
EXECUTE ETUDIANTPERFORMANCES(12004);
/

