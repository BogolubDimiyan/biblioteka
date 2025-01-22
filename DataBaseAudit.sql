CREATE SERVER AUDIT Database_Audit
TO FILE 
(FILEPATH = 'C:\SQLAudit\',
 MAXSIZE = 10 MB,
 MAX_ROLLOVER_FILES = 5,
 RESERVE_DISK_SPACE = ON);
GO

CREATE DATABASE AUDIT SPECIFICATION Database_Audit_Specification
FOR SERVER AUDIT Database_Audit  
    ADD (INSERT ON dbo.библиотеки BY dbo),  
    ADD (UPDATE ON dbo.библиотеки BY dbo), 
    ADD (DELETE ON dbo.библиотеки BY dbo);
GO

ALTER SERVER AUDIT Database_Audit  
WITH (STATE = ON);  
GO


ALTER DATABASE AUDIT SPECIFICATION Database_Audit_Specification
WITH (STATE = ON);
GO


-- Вставка данных в таблицу "библиотеки"
INSERT INTO библиотеки (код_библиотеки, название, адрес, город)
VALUES 
(1, 'Центральная библиотека', 'ул. Ленина, 10', 'Москва'),
(2, 'Городская библиотека', 'ул. Пушкина, 5', 'Санкт-Петербург'),
(3, 'Районная библиотека', 'ул. Гагарина, 15', 'Новосибирск');

-- Обновление данных в таблице "библиотеки"
UPDATE библиотеки
SET адрес = 'ул. Ленина, 20'
WHERE код_библиотеки = 1;

-- Удаление данных из таблицы "библиотеки"
DELETE FROM библиотеки
WHERE код_библиотеки = 3;

SELECT event_time, action_id, succeeded, object_name, statement
FROM sys.fn_get_audit_file('C:\SQLAudit\*.sqlaudit', DEFAULT, DEFAULT)
WHERE object_name = 'библиотеки';

