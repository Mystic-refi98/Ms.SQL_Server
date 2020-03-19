--1
SELECT BookId,
	BookTitle,
	[Book Authors] = UPPER(BookAuthors),
	BookPages,
	BookStock
FROM Book
WHERE BookStock > 10

--2
SELECT LoanId,
	m.MemberId, --> harus pake 'm.' buat nentuin dya diambil dari tabel mana
	MemberAddress,
	MemberPhone
FROM Loan l
	JOIN Member m
		ON l.MemberId = m.MemberId
WHERE DATEDIFF(DAY,LoanStartDate,LoanEndDate) > 5 --> kalau bingung pake DATEDIFF, di blok aja trus pencet F1 (help)

--3
SELECT [Publisher Name] = LOWER(PublisherName),
	[Book Stock] = SUM(BookStock),
	PublisherEmail
FROM Publisher p
	JOIN Book b
		ON p.PublisherId = b.PublisherId
WHERE BookAuthors like '%e%'
GROUP BY PublisherName,
	PublisherName

--4 union, ubah dari max ke min doank
SELECT [BookType] = 'Type ' + RIGHT(bt.BookTypeId,3),
	BookTypeName,
	Pages = 'Max ' + CAST(MAX(BookPages) AS VARCHAR)
FROM BookType bt,
	Book b
WHERE bt.BookTypeId = b.BookTypeId
	AND BookTypeName IN ('Academic','Engineering')
GROUP BY bt.BookTypeId,
	BookTypeName

UNION

SELECT [BookType] = 'Type ' + RIGHT(bt.BookTypeId,3),
	BookTypeName,
	Pages = 'Min ' + CAST(MIN(BookPages) AS VARCHAR)
FROM BookType bt,
	Book b
WHERE bt.BookTypeId = b.BookTypeId
	AND BookTypeName IN ('Academic','Engineering')
GROUP BY bt.BookTypeId,
	BookTypeName

--5
SELECT MemberName,
	MemberAddress,
	Phone = STUFF(MemberPhone,1,1,'+62')
FROM Member m,
	Loan l,
	DetailLoan dl
WHERE m.MemberId = l.MemberId
	AND l.LoanId = dl.LoanId
	AND BookId IN(
		SELECT BookId
		FROM Book
		WHERE BookTitle like '% % %'
			AND BookStock > 15
	)

--6 --> setelah dapet pesugihan
SELECT m.MemberId,
	[Count Book] = CAST(COUNT(dl.BookId) AS VARCHAR) + ' Book'
FROM Member m,
	Loan l,
	DetailLoan dl,
	(SELECT b.BookId,
		CHARINDEX('s',BookAuthors) AS author,
		RIGHT(PublisherAddress,2) AS number
	 FROM Publisher p
		JOIN Book b
			ON p.PublisherId = b.PublisherId
	) AS uyee
WHERE m.MemberId = l.MemberId
	AND l.LoanId = dl.LoanId
	AND dl.BookId = uyee.BookId
	AND uyee.author <> 0
	AND uyee.number > 60
GROUP BY m.MemberId

--7
CREATE VIEW [View Book]
AS 
	SELECT BookId,
		BookTitle,
		BookAuthors,
		[PublishDate] = CONVERT(VARCHAR,BookPublishDate,106)
	FROM Book
	WHERE YEAR(BookPublishDate) > 2010

GO							--> ini cuma buat cek aja create nya bener ato ga
SELECT * FROM [View Book]	--> ini cuma buat cek aja create nya bener ato ga

--8
CREATE VIEW ViewLoanDetail
AS
	SELECT [Total Loan] = COUNT(l.LoanId),
		MemberName,
		MemberAddress,
		MemberPhone
	FROM Loan l,
		Member m,
		DetailLoan dl,
		Book b
	WHERE l.MemberId = m.MemberId
		AND l.LoanId =dl.LoanId
		AND dl.BookId = b.BookId
		AND MONTH(LoanStartDate) > 3
		AND LEN(BookTitle) > 23
	GROUP BY MemberName,
		MemberAddress,
		MemberPhone

--9
ALTER TABLE Member
ADD Gender VARCHAR(10)
GO
ALTER TABLE Member
ADD CONSTRAINT checkMemberGender CHECK(Gender IN('Male','Female'))

--10
DELETE FROM Book
FROM Book b
	JOIN Publisher p
		ON b.PublisherId = p.PublisherId
WHERE SUBSTRING(PublisherName,2,1) like 'm'
	AND BookTypeId like 'BT002'
