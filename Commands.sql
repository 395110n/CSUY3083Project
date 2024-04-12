create table Criminals(
    Criminal_ID INT(6),
    LastName VARCHAR(15),
    FirstName VARCHAR(10),
    Street VARCHAR(30),
    City VARCHAR(20),
    State CHAR(2), 
    Zip CHAR(5),
    Phone CHAR(10),
    V_status CHAR(1) default 'N', 
    P_status CHAR(1) default 'N',
    primary key (Criminal_ID),
    check  (V_status in ('N', 'Y') and 
            P_status in ('N', 'Y'))
);

create table Alias (
    Alias_ID INT(6),
    Criminal_ID INT(6) references Criminals(Criminal_ID),
    Alias VARCHAR(20),
    primary key (Alias_ID)
);

create table Crimes(
    Crime_ID INT(9) primary key, 
    Criminal_ID INT(6) references Criminals(Criminal_ID),
    Classification CHAR(1) default 'U',
    Date_charged DATE, 
    Status CHAR(2) not null,
    Hearing_Date DATE,
    Appeal_cut_date Date,
    check (Classification in ('F', 'M', 'O', 'U') and 
           Status in ('J', 'H', 'P') and
           Hearing_Date > Date_charged)
);

create table Sentences(
    Sentence_ID INT(6) primary key,
    Criminal_ID INT(6) references Criminals(Criminal_ID),
    Type CHAR(1),
    Prob_ID INT(5) references Prob_officers(Prob_ID),
    Start_date Date,
    End_date Date, 
    Violations INT(3) not null,
    check (Type in ('J', 'H', 'P') and 
           End_date > Start_date)
);

create table Prob_officers(
    Prob_ID INT(5) primary key,
    LastName VARCHAR(15),
    FirstName VARCHAR(10),
    Street VARCHAR(30),
    City VARCHAR(20),
    State CHAR(2), 
    Zip CHAR(5),
    Phone CHAR(10),
    Email VARCHAR(30),
    Status CHAR(1) not null,
    check (Status in ('A', 'I'))
);

create table Crime_charges(
    Charge_ID INT(10) primary key,
    Crime_ID INT(9) references Crimes(Crime_ID), 
    Crime_code INT(3) references Crime_codes(Crime_code),
    Charge_status CHAR(2), 
    Fine_amount DECIMAL(7, 2),
    Court_fee DECIMAL(7, 2),
    Amount_paid DECIMAL(7, 2),
    Pay_due_date DATE,
    check (Charge_status in ('PD', 'GL', 'NG'))
);

create table Crime_officers(
    Crime_ID INT(9) references Crimes(Crime_ID),
    Officer_ID INT(8) references Officers(Officer_ID),
    primary key(Crime_ID, Officer_ID)
);

create table Officers(
    Officer_ID INT(8) primary key,
    LastName VARCHAR(15),
    FirstName VARCHAR(10),
    Precinct CHAR(4) not null,
    Badge VARCHAR(14) unique, 
    Phone CHAR(10),
    Status CHAR(1) default 'A'
    check (Status in ('A', 'I'))
);

create table Appeals(
    Appeal_ID INT(5) primary key,
    Crime_ID INT(9) references Crimes(Crime_ID),
    Filing_date DATE,
    Hearing_date DATE,
    Status CHAR(1) default 'P'
    check (Status in ('P', 'A', 'D'))
);

create table Crime_codes(
    Crime_code INT(3) primary key not null, 
    Code_description VARCHAR(30) not null unique
);

grant
select * on Alias,
select (Criminal_ID, FirstName, LastName, V_status, P_status) on Criminals,
select * on Crimes, 
select * on Sentences,
select (Prob_ID, FirstName, LastName, Status) on Prob_officers, 
select * on Crime_charges, 
select * on Crime_officers,
select (Officer_ID, FirstName, LastName, Precinct, Badge, Status) on Officers,
select * on Appeals,
select * on Crime_codes to viewer;

delimiter $$

create or replace trigger EncodePW
after insert on usrs
for each row
begin
    declare encodedPW varchar(64);
    select usr_PW into encodedPW
    where usr_ID = 
end$$

delimiter ;