IF EXISTS (SELECT name FROM sys.databases WHERE name = N'����������')
BEGIN
    ALTER DATABASE ���������� SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ����������;
END


create database ����������

use ����������

create table ���������� 
(
    ���_���������� int primary key,
    �������� nvarchar(50) not null, 
    ����� nvarchar(max) not null,
    ����� nvarchar(40) not null
);

create table ����_���������� 
(	
    ���_�����_���������� int primary key,
    ��������_����� nvarchar(70) not null, 
    ���������� int not null, 
    ����������_���� int not null, 
    ����������_�������� int not null, 
    ����������_����� int not null, 
    ����������_��������� int not null, 
    ����������_����������� int not null, 
    ����������_��������� int not null,
    foreign key (����������) references ����������(���_����������)
);

create table ���_���������� 
(
    ���_����_���������� int primary key,
    ��������_���� nvarchar(30) not null
);

create table ����������
(
    ���_���������� int primary key,
    �������_���������� nvarchar(20) not null,
    ���������� int not null, 
    ��������� nvarchar(30) not null, 
    ���_�������� date not null, 
    ���_�����������_��_������ int not null, 
    ����������� nvarchar(30) not null,
    �������� decimal not null,
    foreign key (����������) references ����������(���_����������)
);

create table ����������_����� 
(
    ���_���������� int primary key,
    ���_�����_���������� int not null,
    ���_���������� int not null,
    ����_���������� date not null,
    ��������_���������_���������� nvarchar(100) not null,
    ���_����_���������� int not null,
    ������������ nvarchar(100) not null,
    ����_������� date not null,
    ����������_����������� int not null,
    
    foreign key (���_�����_����������) references ����_����������(���_�����_����������),
    foreign key (���_����������) references ����������(���_����������),
    foreign key (���_����_����������) references ���_����������(���_����_����������)
);
----------------------------------------------------------------------------------------------





