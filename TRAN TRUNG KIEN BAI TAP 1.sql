DROP DATABASE IF EXISTS testing_system;
CREATE DATABASE testing_system;
USE testing_system;

CREATE TABLE department (
	department_id 				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    department_name 			NVARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE `position`(
	position_id					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    position_name				NVARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE `account`(
	account_id 					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email 			        	VARCHAR(30) NULL UNIQUE,
    username 			 		VARCHAR(20) NOT NULL ,
    fullname		 			NVARCHAR(30) NOT NULL,
    department_id	 			TINYINT UNSIGNED NOT NULL,
    position_id					TINYINT UNSIGNED NOT NULL,
    create_date					DATE,
    FOREIGN KEY (position_id) 	REFERENCES `position`(position_id),
    FOREIGN KEY (department_id) REFERENCES department (department_id)
);

CREATE TABLE `group` (
	group_id					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    group_name					NVARCHAR(30) UNIQUE ,
    creator_id					TINYINT UNSIGNED NOT NULL UNIQUE,
    create_date					DATE
);

CREATE TABLE group_acount (
	group_id					TINYINT UNSIGNED PRIMARY KEY,
    account_id					TINYINT UNSIGNED UNIQUE,
    join_date					DATE,
    FOREIGN KEY (group_id) 		REFERENCES `group`(group_id),
    FOREIGN KEY (account_id) 	REFERENCES  `account`(account_id)
);

CREATE TABLE type_question (
	type_id						TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	type_name					VARCHAR(30)
);

CREATE TABLE category_question(
 category_id TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 Category_Name NVARCHAR(50) NOT NULL UNIQUE KEY
);

CREATE TABLE question (
	question_id 				TINYINT UNSIGNED  AUTO_INCREMENT PRIMARY KEY,
    content						NVARCHAR(100) NOT NULL,
    category_id 				TINYINT UNSIGNED NOT NULL,
    type_id 					TINYINT UNSIGNED NOT NULL,
    creator_id 					TINYINT UNSIGNED ,
    create_date					DATE,
    FOREIGN KEY (category_id) 	REFERENCES category_question (category_id),
    FOREIGN KEY(type_id) 		REFERENCES type_question(type_id),
	FOREIGN KEY(creator_id) 	REFERENCES `account`(account_id)
);

CREATE TABLE answer (
	answer_id					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    content						NVARCHAR(50),
    question_id 				TINYINT UNSIGNED,
    iscorrect					VARCHAR(50),
    FOREIGN KEY (question_id) REFERENCES question(question_id )
);

CREATE TABLE exam ( 
	exam_id						TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `code`						CHAR(10) NOT NULL,
    title						NVARCHAR(50) NOT NULL,
    category_id					TINYINT UNSIGNED NOT NULL,
    duration					TINYINT UNSIGNED NOT NULL,
    creator_id					TINYINT UNSIGNED NOT NULL,
    create_date					DATE,
    FOREIGN KEY (category_id) REFERENCES category_question(category_id),
    FOREIGN KEY (creator_id) REFERENCES `account`(account_id)
);

DROP TABLE IF EXISTS exam_question;
CREATE TABLE exam_question (
	exam_id						TINYINT UNSIGNED PRIMARY KEY,
    question_id					TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (exam_id) REFERENCES exam(exam_id),
    FOREIGN KEY (question_id) REFERENCES question(question_id)
);

INSERT INTO department (department_name)
VALUES				  	('Giam Doc'),
						('Sale'),
                        ('Bao ve'),
                        ('Nhan su');
                        
INSERT INTO `position` 	(position_name)
VALUES					('Dev'),
						('test'),
                        ('Scrum Master');
                        
INSERT INTO `account` 	(email, username, fullname, department_id, position_id, create_date)
Values 					('trantrungkien0510@gmail.com','trankien','trantrungkien','3','1','2020-03-05'),
						('taphuc@gmail.com','phucbua','taluuphuc','2','3','2020-03-06');

INSERT INTO `group`		(group_name, creator_id, create_date)
VALUES					('testing_System', '5','2019-03-05'),
						('Development', '1','2020-03-07'),
						('VTI Sale 01', '2','2020-03-09'),
						('VTI Sale 02', '3','2020-03-10');
                        
INSERT INTO group_acount (group_id, account_id, join_date)
VALUES					(1,1,'2019-03-05');

INSERT INTO type_question (type_name)
VALUES					('Essay' ), 
						('Multiple-Choice' );

INSERT INTO category_question (Category_Name )
VALUES 					('Java' ),
						('ADO.NET' ),
						('SQL' ),
						('Postman' ),
						('Ruby' ),
						('Python' ),
						('C++' ),
						('C Sharp' ),
						('PHP' );
                        
INSERT INTO question (content, category_id, type_id, creator_id, create_date)
VALUES 					('C??u h???i v??? Java' , 1 , '1' , '2' ,'2020-04-05'),
						('C??u H???i v??? PHP' , 9 , '2' , '2' ,'2020-04-05'),
						('H???i v??? C#' , 9 , '2' , '2' ,'2020-04-06'),
						('H???i v??? Ruby' , 6 , '1' , '2' ,'2020-04-06'),
						('H???i v??? Postman' , 5 , '1' , '2' ,'2020-04-06'),
						('H???i v??? ADO.NET' , 3 , '2' , '2' ,'2020-04-06'),
						('H???i v??? ASP.NET' , 2 , '1' , '1' ,'2020-04-06'),
						('H???i v??? C++' , 8 , '1' , '1' ,'2020-04-07'),
						('H???i v??? SQL' , 4 , '2' , '2' ,'2020-04-07'),
						('H???i answerv??? Python' , 7 , '1' , '1' ,'2020-04-07');
                        
INSERT INTO answer (content, question_id, iscorrect)
VALUES 					('Tr??? l???i 01' , 1 , 0),
						('Tr??? l???i 02' , 1 , 1),
						('Tr??? l???i 03', 1 , 0 ),
						('Tr??? l???i 04', 1 , 1 ),
						('Tr??? l???i 05', 2 , 1 ),
						('Tr??? l???i 06', 3 , 1 ),
						('Tr??? l???i 07', 4 , 0 ),
						('Tr??? l???i 08', 8 , 0 ),
						('Tr??? l???i 09', 9 , 1 ),
						('Tr??? l???i 10', 10 , 1 );
                        
INSERT INTO exam 		(`code`, title, category_id, duration, creator_id, create_date)
VALUES 					('VTIQ001' , '????? thi C#' ,1 , 60 , '2' ,'2019-04-05'),
						('VTIQ002' , '????? thi PHP' ,9 , 60 , '2' ,'2019-04-05'),
						('VTIQ003' , '????? thi C++' , 9 ,120 , '2' ,'2019-04-07'),
						('VTIQ004' , '????? thi Java' , 6 , 60, '1' ,'2020-04-08'),
						('VTIQ005' , '????? thi Ruby' , 5 , 120, '2' ,'2020-04-10'),
						('VTIQ006' , '????? thi Postman' , 3 ,60 , '1' ,'2020-04-05'),
						('VTIQ007' , '????? thi SQL' , 2 ,60 , '2' ,'2020-04-05'),
						('VTIQ008' , '????? thi Python' , 8 ,60 , '1' ,'2020-04-07'),
						('VTIQ009' , '????? thi ADO.NET' , 4 ,90 , '2' ,'2020-04-07'),
						('VTIQ010' , '????? thi ASP.NET' , 7 ,90 , '1' ,'2020-04-08');
INSERT INTO exam_question (exam_id, question_id) 
VALUES 					( 1 , 5 ),
						( 2 , 10 ), 
						( 3 , 4 ), 
						( 4 , 3 ), 
						( 5 , 7 ), 
						( 6 , 10 ), 
						( 7 , 2 ), 
						( 8 , 10 ), 
						( 9 , 9 ), 
						( 10 , 8 );
                        
                        


-- Question 1: Th??m ??t nh???t 10 record v??o m???i table
USE testing_system;
INSERT INTO department	(department_name)
VALUES					('b???c v??c'),
						('k??? to??n'),
                        ('h??nh ch??nh')
;


INSERT INTO `account` (email				, username		,		 fullname, 	department_id,	position_id		,		 create_date)
VALUES 				('tranhailong@gmail.com','hailong'		,'tr???n h???i long',			'4',	'2'				,'2020-01-03'),
					('tranngoclong@gmail.com','tranlong'	,'tr???n ng???c long',			'5',	'2'				,'2020-01-03'),
					('tranngocphong@gmail.com','ngocphong'	,'tr???n ng???c phong',			'3',	"1"				,'2020-02-03'),
                    ('phankimlien@gmail.com','kimlien'		,'phan kim li??n',			'1',	'3'				,'2020-02-04'),
					('rolondinhon@gmail.com','rolon'		,	'dolondinho',			'2',	'3'				,'2020-01-04'),
                    ('tranmoccac@gmail.com','moccac'		,'tr???n m???c c???c',			'5',	'3'				,'2020-02-04'),
                    ('taymonkhanh@gmail.com','monkhanh'		,'t??y m??n kh??nh',			'6',	'2'				,'2020-03-04'),
                    ('huanhoahong@gmail.com','huanrose'		,'hu???n hoa h???ng',			'3',	'2'				,'2020-04-04'),
                    ('tienbip@gmail.com'	,'tienbip'		,'nguy???n vi???t ti???n',		'2',	'3'				,'2020-05-04'),
                    ('duongnguyen@gmail.com','duongnguyen'	,'nguy???n tu???n d????ng',		'3',	'1'				,'2020-06-04')
;

INSERT INTO  `group` (group_name	, 	creator_id,	 create_date)
VALUES				('VTI Sale 03'	, '8'		,'2020-03-09'),
					('VTI Sale 04'	, '4'		,'2020-03-09'),
                    ('VTI Sale 05'	, '11'		,'2020-03-09'),
                    ('VTI Sale 06'	, '6'		,'2020-03-09'),
                    ('VTI Sale 07'	, '7'		,'2020-03-09'),
                    ('VTI Sale 08'	, '9'		,'2020-03-09'),
                    ('VTI Sale 09'	, '10'		,'2020-03-09')
;

-- Question 2: l???y ra t???t c??? c??c ph??ng ban
SELECT* From department;


-- Question 3: l???y ra id c???a ph??ng ban "Sale"
SELECT department_id
From department
WHERE department_name = "Sale  "
;

-- Question 4: l???y ra th??ng tin account c?? full name d??i nh???t
SELECT  *
FROM `account`
WHERE LENGTH(fullname) = (SELECT MAX(LENGTH(fullname)) FROM `account`)
ORDER BY fullname DESC;


-- Question 5: L???y ra th??ng tin account c?? full name d??i nh???t v?? thu???c ph??ng ban c?? id= 3
WITH `account` AS
(
SELECT * FROM `account` WHERE department_id =3
)
SELECT * FROM  `account`
WHERE LENGTH(fullname) = (SELECT MAX(LENGTH(fullname)) FROM `account`) 
ORDER BY fullname ASC;

-- Question 6: L???y ra t??n group ???? t???o tr?????c ng??y 20/12/2019
SELECT group_name
FROM `group` 
WHERE create_date < '2019-12-20';


-- Question 7: L???y ra ID c???a question c?? >= 4 c??u tr??? l???i
SELECT * FROM testing_system.`answer`;
SELECT question_id, COUNT(question_id) AS SL FROM `answer` 
GROUP BY question_id
HAVING count(question_id) >= 4;


-- Question 8: L???y ra c??c m?? ????? thi c?? th???i gian thi >= 60 ph??t v?? ???????c t???o tr?????c ng??y 20/12/2019
SELECT `code` 
FROM `exam`
WHERE Duration >= 60 AND create_date < '2019-12-20';


-- Question 9: L???y ra 5 group ???????c t???o g???n ????y nh???t
SELECT * 
FROM `Group`
ORDER BY create_date DESC 
LIMIT 5;


-- Question 10: ?????m s??? nh??n vi??n thu???c department c?? id = 2
SELECT department_id, COUNT(account_id) AS SL 
FROM `account`
WHERE department_id = 2;


-- Question 11: L???y ra nh??n vi??n c?? t??n b???t ?????u b???ng ch??? "D" v?? k???t th??c b???ng ch??? "o"
SELECT fullname 
FROM `account`
WHERE (SUBSTRING_INDEX(fullname, ' ', -1)) LIKE 'D%o' ;


-- Question 12: X??a t???t c??? c??c exam ???????c t???o tr?????c ng??y 20/12/2019
DELETE 
FROM `exam`
WHERE create_date < '2019-12-20';

-- Question 13: X??a t???t c??? c??c question c?? n???i dung b???t ?????u b???ng t??? "c??u h???i"
DELETE 
FROM `question`
WHERE (SUBSTRING_INDEX(content,' ',2)) ='c??u h???i';


-- Question 14: Update th??ng tin c???a account c?? id = 5 th??nh t??n "Nguy???n B?? L???c" v?? email th??nh loc.nguyenba@vti.com.vn
UPDATE `account` 
SET Fullname = N'Nguy???n B?? L???c', 
Email = 'loc.nguyenba@vti.com.vn'
WHERE account_id = 5;


-- Question 15: update account c?? id = 5 s??? thu???c group c?? id = 4
UPDATE `group_acount` SET account_id = 5 
WHERE group_id = 4;





