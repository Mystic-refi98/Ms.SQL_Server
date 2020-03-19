CREATE DATABASE BluejackLibrary
--DROP DATABASE BluejackLibrary
go
USE BluejackLibrary


--Table BookType
CREATE TABLE BookType(
	BookTypeId CHAR(5) PRIMARY KEY,
	BookTypeName VARCHAR(20) NOT NULL,
	CONSTRAINT cBookTypeId CHECK(BookTypeId LIKE 'BT[0-9][0-9][0-9]')
)


--Table Publisher
CREATE TABLE Publisher(
	PublisherId CHAR(5) PRIMARY KEY,
	PublisherName VARCHAR(30) NOT NULL,
	PublisherEmail VARCHAR(30) NOT NULL,
	PublisherPhone VARCHAR(12) NOT NULL,
	PublisherAddress VARCHAR(30) NOT NULL,
	CONSTRAINT cPublisherId CHECK(PublisherId LIKE 'PU[0-9][0-9][0-9]')
)

--Table Book
CREATE TABLE Book(
	BookId CHAR(5) PRIMARY KEY,
	BookTypeId CHAR(5) NOT NULL,
	PublisherId CHAR(5) NOT NULL,
	BookTitle VARCHAR(30) NOT NULL,
	BookAuthors VARCHAR(30) NOT NULL,
	BookPublishDate DATE NOT NULL,
	BookPages INT NOT NULL,
	BookStock INT NOT NULL,
	CONSTRAINT cBookId CHECK (BookId LIKE 'BO[0-9][0-9][0-9]'),
	CONSTRAINT cBookTypeId2 CHECK(BookTypeId LIKE 'BT[0-9][0-9][0-9]'),
	CONSTRAINT cPublisherId2 CHECK(PublisherId LIKE 'PU[0-9][0-9][0-9]'),
	FOREIGN KEY (BookTypeId) REFERENCES BookType(BookTypeId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (PublisherId) REFERENCES Publisher(PublisherId) ON DELETE CASCADE ON UPDATE CASCADE
)

--Table Member
CREATE TABLE Member(
	MemberId CHAR (5) PRIMARY KEY,
	MemberName VARCHAR(30) NOT NULL,
	MemberAddress VARCHAR(30) NOT NULL,
	MemberPhone VARCHAR(12) NOT NULL,
	CONSTRAINT cMemberId CHECK(MemberId LIKE 'ME[0-9][0-9][0-9]'),
)


--Table Loan
CREATE TABLE Loan(
	LoanId CHAR(5) PRIMARY KEY,
	MemberId CHAR(5) NOT NULL,
	LoanStartDate DATE NOT NULL,
	LoanEndDate DATE NOT NULL,
	CONSTRAINT cLoanId2 CHECK(LoanId LIKE 'LO[0-9][0-9][0-9]'),
	CONSTRAINT cMemberId2 CHECK(MemberId LIKE 'ME[0-9][0-9][0-9]'),
	FOREIGN KEY (MemberId) REFERENCES Member(MemberId) ON DELETE CASCADE ON UPDATE CASCADE
)


--Table DetailLoan
CREATE TABLE DetailLoan(
	BookId CHAR(5),
	LoanId CHAR(5),
	PRIMARY KEY(BookId, LoanId),
	FOREIGN KEY (BookId) REFERENCES Book(BookId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (LoanId) REFERENCES Loan(LoanId) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT cBookId3 CHECK (BookId LIKE 'BO[0-9][0-9][0-9]'),
	CONSTRAINT cLoanId3 CHECK(LoanId LIKE 'LO[0-9][0-9][0-9]'),
)


-- Insert BookType
INSERT INTO BookType VALUES('BT001', 'Academic');
INSERT INTO BookType VALUES('BT002', 'Design');
INSERT INTO BookType VALUES('BT003', 'Computer');
INSERT INTO BookType VALUES('BT004', 'Engineering');


--Insert Publisher
INSERT INTO Publisher VALUES ('PU001', 'Gramedia', 'fiksi@gramedia.com', '081922548621', 'Mango Street No.20')
INSERT INTO Publisher VALUES ('PU002', 'Erlangga', 'media@erlangga.com', '087795364852', 'Anggrek Street No.128')
INSERT INTO Publisher VALUES ('PU003', 'SmartBooks', 'smartbooks@lysoos.com', '081254696547', 'Kijang Street No.55')
INSERT INTO Publisher VALUES ('PU004', 'TransMedia', 'books@transmedia.com', '081364259781', 'Kijang Street No.55')
INSERT INTO Publisher VALUES ('PU005', 'Grasindo', 'grasindo@gmail.com', '081762486654', 'Syahdan Street No.63')


--Insert Book
INSERT INTO Book VALUES('BO001', 'BT001', 'PU004', 'Fundamentals of Physics', 'Robert Resnick', '04-25-1960', 485, 9)
INSERT INTO Book VALUES('BO002', 'BT002', 'PU003', 'Tips Photoshop CS6', 'Peter Ramot', '05-21-2016', 178, 10)
INSERT INTO Book VALUES('BO003', 'BT003', 'PU005', 'Data Structure', 'Reema Thereja', '08-04-2014', 354, 39)
INSERT INTO Book VALUES('BO004', 'BT004', 'PU003', 'Mechanics of Materials', 'Ferdinand Beer', '02-25-1981', 178, 7)
INSERT INTO Book VALUES('BO005', 'BT004', 'PU002', 'Vector Mechanics for Engineers', 'Bruce Roy', '01-01-1992', 485, 11)
INSERT INTO Book VALUES('BO006', 'BT002', 'PU001', 'Interior Design Architecture', 'Mark Hinchman', '07-26-2013', 369, 17)
INSERT INTO Book VALUES('BO007', 'BT001', 'PU005', 'Discrete Mathematics', 'Sussana Morris', '09-18-2010', 241, 10)
INSERT INTO Book VALUES('BO008', 'BT003', 'PU003', 'Learn C++ Programming', 'James Petterson', '02-21-1992', 208, 4)


--Insert Member
INSERT INTO Member VALUES('ME001', 'Jefry Chang', 'Banana Street No.201', '081946522568')
INSERT INTO Member VALUES('ME002', 'Nicholas Alexandra', 'Pluit Street No.138', '081299856472')
INSERT INTO Member VALUES('ME003', 'Michelle Sya', 'Orange Street No.201', '081778963312')
INSERT INTO Member VALUES('ME004', 'Andy Fudiko', 'Golden Street No.118', '087763301456')
INSERT INTO Member VALUES('ME005', 'Pribadi Ridwan', 'Tanjung Duren Street No.239', '081396154789')
INSERT INTO Member VALUES('ME006', 'William Juanda', 'Lovinghut Street No.393', '081250054677')
INSERT INTO Member VALUES('ME007', 'Tju Eric', 'Kebon Jeruk Street No.211', '085621796690')
INSERT INTO Member VALUES('ME008', 'Taufik Barbar', 'Senayan Street No.172', '081932112399')
INSERT INTO Member VALUES('ME009', 'Goldwin Effendi', 'Sudirman Street No.119', '081963300015')
INSERT INTO Member VALUES('ME010', 'Hendra Japar', 'Tomang Street No.04', '081969998523')


--Insert Loan
INSERT INTO Loan VALUES('LO001', 'ME003', '02-23-2016', '02-29-2016')
INSERT INTO Loan VALUES('LO002', 'ME010', '03-05-2016', '03-10-2016')
INSERT INTO Loan VALUES('LO003', 'ME003', '03-15-2016', '03-23-2016')
INSERT INTO Loan VALUES('LO004', 'ME001', '04-17-2016', '04-22-2016')
INSERT INTO Loan VALUES('LO005', 'ME006', '04-19-2016', '04-24-2016')
INSERT INTO Loan VALUES('LO006', 'ME004', '05-01-2016', '05-08-2016')
INSERT INTO Loan VALUES('LO007', 'ME008', '05-13-2016', '05-19-2016')
INSERT INTO Loan VALUES('LO008', 'ME009', '05-13-2016', '05-19-2016')

--Insert DetailLoan
INSERT INTO DetailLoan VALUES('BO001', 'LO001')
INSERT INTO DetailLoan VALUES('BO001', 'LO004')
INSERT INTO DetailLoan VALUES('BO002', 'LO003')
INSERT INTO DetailLoan VALUES('BO002', 'LO001')
INSERT INTO DetailLoan VALUES('BO003', 'LO002')
INSERT INTO DetailLoan VALUES('BO003', 'LO005')
INSERT INTO DetailLoan VALUES('BO004', 'LO007')
INSERT INTO DetailLoan VALUES('BO004', 'LO005')
INSERT INTO DetailLoan VALUES('BO005', 'LO008')
INSERT INTO DetailLoan VALUES('BO005', 'LO006')
INSERT INTO DetailLoan VALUES('BO006', 'LO006')
INSERT INTO DetailLoan VALUES('BO006', 'LO001')
INSERT INTO DetailLoan VALUES('BO007', 'LO002')
INSERT INTO DetailLoan VALUES('BO007', 'LO005')
INSERT INTO DetailLoan VALUES('BO008', 'LO003')
INSERT INTO DetailLoan VALUES('BO008', 'LO001')

SELECT * FROM Book
SELECT * FROM BookType
SELECT * FROM Publisher
SELECT * FROM Member
SELECT * FROM Loan
SELECT * FROM DetailLoan