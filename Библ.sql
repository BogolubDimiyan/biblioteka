IF EXISTS (SELECT name FROM sys.databases WHERE name = N'Библиотека')
BEGIN
    ALTER DATABASE Библиотека SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Библиотека;
END


create database Библиотека

use Библиотека

create table библиотеки 
(
    код_библиотеки int primary key,
    название nvarchar(50) not null, 
    адрес nvarchar(max) not null,
    город nvarchar(40) not null
);

create table фонд_библиотеки 
(	
    код_фонда_библиотеки int primary key,
    название_фонда nvarchar(70) not null, 
    библиотека int not null, 
    количество_книг int not null, 
    количество_журналов int not null, 
    количество_газет int not null, 
    количество_сборников int not null, 
    количество_диссертаций int not null, 
    количество_рефератов int not null,
    foreign key (библиотека) references библиотеки(код_библиотеки)
);

create table тип_литературы 
(
    код_типа_литературы int primary key,
    название_типа nvarchar(30) not null
);

create table сотрудники
(
    код_сотрудника int primary key,
    фамилия_сотрудника nvarchar(20) not null,
    библиотека int not null, 
    должность nvarchar(30) not null, 
    год_рождения date not null, 
    год_поступления_на_работу int not null, 
    образование nvarchar(30) not null,
    зарплата decimal not null,
    foreign key (библиотека) references библиотеки(код_библиотеки)
);

create table пополнение_фонда 
(
    код_пополнения int primary key,
    код_фонда_библиотеки int not null,
    код_сотрудника int not null,
    дата_пополнения date not null,
    название_источника_литературы nvarchar(100) not null,
    код_типа_литературы int not null,
    издательство nvarchar(100) not null,
    дата_издания date not null,
    количество_экземпляров int not null,
    
    foreign key (код_фонда_библиотеки) references фонд_библиотеки(код_фонда_библиотеки),
    foreign key (код_сотрудника) references сотрудники(код_сотрудника),
    foreign key (код_типа_литературы) references тип_литературы(код_типа_литературы)
);
----------------------------------------------------------------------------------------------

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

SELECT 
    event_time,         
    action_id,          
    succeeded,          
    session_server_principal_name, 
    database_name,      
    object_name,        
    statement           
FROM sys.fn_get_audit_file('C:\SQLAudit\*.sqlaudit', DEFAULT, DEFAULT);




