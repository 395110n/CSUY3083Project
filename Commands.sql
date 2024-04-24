-- Trigger in Usrs
delimiter $$
create or replace trigger EncodePW
before insert on usrs
for each row
begin
    SET NEW.usr_PW = SHA2(NEW.usr_PW, 256);
    
end$$
delimiter ;

-- Trigger in Usrs
DELIMITER $$
CREATE OR REPLACE TRIGGER EncodeNewPW
BEFORE UPDATE ON usrs
FOR EACH ROW
BEGIN
    -- Check if the usr_PW column is being updated
    IF NEW.usr_PW IS NOT NULL AND OLD.usr_PW != NEW.usr_PW THEN
        SET NEW.usr_PW = SHA2(NEW.usr_PW, 256);
    END IF;
END$$
DELIMITER ;

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