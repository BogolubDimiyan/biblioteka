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

SELECT 
    event_time,         
    action_id,          
    succeeded,          
    session_server_principal_name, 
    database_name,      
    object_name,        
    statement           
FROM sys.fn_get_audit_file('C:\SQLAudit\*.sqlaudit', DEFAULT, DEFAULT);


CREATE LOGIN User22 WITH PASSWORD = '0000';
ALTER SERVER ROLE sysadmin ADD MEMBER User22;


drop Login TestUser

--SELECT 
--    session_id, 
--    login_name, 
--    host_name, 
--    program_name, 
--    status
--FROM sys.dm_exec_sessions
--WHERE login_name = 'TestUser';

--KILL 89;
--KILL 68;

--SELECT name, is_disabled 
--FROM sys.sql_logins
--WHERE name = 'TestUser';

--SELECT name, is_disabled 
--FROM sys.sql_logins
--WHERE name = 'User22';