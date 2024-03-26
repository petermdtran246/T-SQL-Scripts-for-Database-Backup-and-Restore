/* 1. Write a backup statement to perform a backup of the AdventureWorks2019 database 
which stores it in c:\temp\backups */

--Create a new folder called backups
EXEC master.sys.xp_create_subdir 'c:\temp\backups';

-- Backup the datadabase
BACKUP DATABASE AdventureWorks2019
TO DISK = 'c:\temp\backups\AdventureWorks2019.bak'; 


/* 2. Once the database has been backed up, 
write a restore statement to create a new copy of this database called AdventureWorksNew */

USE master;
-- Create a new folder called restore
EXEC master.sys.xp_create_subdir 'c:\restore';

-- Retrieve the logical file names
RESTORE FILELISTONLY 
FROM DISK = 'c:\temp\backups\AdventureWorks2019.bak';

-- Restore the database
RESTORE DATABASE AdventureWorksNew
FROM DISK = 'c:\temp\backups\AdventureWorks2019.bak'
WITH 
    MOVE 'AdventureWorks2017' TO 'c:\restore\AdventureWorksNew.mdf',
    MOVE 'AdventureWorks2017_log' TO 'c:\restore\AdventureWorksNew_log.ldf',
    REPLACE;
