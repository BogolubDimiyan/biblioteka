use master
go
  
CREATE SERVER AUDIT HIPAA_Audit  
    TO FILE ( FILEPATH ='C:\SQLAudit\' );


CREATE SERVER AUDIT SPECIFICATION HIPAA_Audit_Specification  
FOR SERVER AUDIT HIPAA_Audit  
    ADD (FAILED_LOGIN_GROUP),
	ADD (BACKUP_RESTORE_GROUP),
    ADD (SERVER_OBJECT_CHANGE_GROUP);  
GO  

  
ALTER SERVER AUDIT HIPAA_Audit  
WITH (STATE = ON);  
GO


BACKUP DATABASE Библиотека
TO DISK = 'C:\SQLBackups\Biblioteka.bak'
WITH FORMAT, 
     INIT,   
     NAME = 'BackupBiblioteka',
     STATS = 10; 

CREATE LOGIN TestUser WITH PASSWORD = '12345';

SELECT *       
FROM sys.fn_get_audit_file('C:\SQLAudit\*.sqlaudit', DEFAULT, DEFAULT);


CREATE LOGIN User22 WITH PASSWORD = '0000';
ALTER SERVER ROLE sysadmin ADD MEMBER User22;


SELECT name, is_disabled 
FROM sys.sql_logins
WHERE name = 'TestUser';

SELECT name, is_disabled 
FROM sys.sql_logins
WHERE name = 'User22';