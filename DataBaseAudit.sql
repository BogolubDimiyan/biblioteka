CREATE SERVER AUDIT Database_Audit
TO FILE 
(FILEPATH = 'C:\SQLAudit\',
 MAXSIZE = 10 MB,
 MAX_ROLLOVER_FILES = 5,
 RESERVE_DISK_SPACE = ON);
GO

CREATE DATABASE AUDIT SPECIFICATION Database_Audit_Specification
FOR SERVER AUDIT Database_Audit  
    ADD (INSERT ON dbo.���������� BY dbo),  
    ADD (UPDATE ON dbo.���������� BY dbo), 
    ADD (DELETE ON dbo.���������� BY dbo);
GO

ALTER SERVER AUDIT Database_Audit  
WITH (STATE = ON);  
GO


ALTER DATABASE AUDIT SPECIFICATION Database_Audit_Specification
WITH (STATE = ON);
GO


-- ������� ������ � ������� "����������"
INSERT INTO ���������� (���_����������, ��������, �����, �����)
VALUES 
(1, '����������� ����������', '��. ������, 10', '������'),
(2, '��������� ����������', '��. �������, 5', '�����-���������'),
(3, '�������� ����������', '��. ��������, 15', '�����������');

-- ���������� ������ � ������� "����������"
UPDATE ����������
SET ����� = '��. ������, 20'
WHERE ���_���������� = 1;

-- �������� ������ �� ������� "����������"
DELETE FROM ����������
WHERE ���_���������� = 3;

SELECT event_time, action_id, succeeded, object_name, statement
FROM sys.fn_get_audit_file('C:\SQLAudit\*.sqlaudit', DEFAULT, DEFAULT)
WHERE object_name = '����������';

