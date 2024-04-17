-- Trigger in Usrs
delimiter $$
create or replace trigger EncodePW
before insert on usrs
for each row
begin
    SET NEW.usr_PW = SHA2(NEW.usr_PW, 256);
    
end$$
delimiter ;


-- Procedure for check Login
delimiter $$
drop procedure if exists checkUsr $$
create procedure checkUsr (usrID varchar(30), usrPW varchar(64)) 
begin
    declare EncodePW varchar(64);
    set EncodePW = SHA2(usrPW, 256);
    select count(*) as existsOrNot, usr_ID, firstName, lastName, permission 
    from usrs 
    where usr_ID = usrID and usr_PW = EncodePW;
    
end$$
delimiter ;

-- Procedure for check Register
delimiter $$
drop procedure if exists checkRegister $$
create procedure checkRegister (usrID varchar(30))
begin   
    select firstName, lastName
    from usrs
    where usr_ID = usrID;
end$$
delimiter ;