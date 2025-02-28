-- 5-2 동일도서를 파악후 있으면 도서가격 변경, 없으면 삽입하는 프로시저
delimiter //
CREATE PROCEDURE BookInsertOrUpdate(
	mybookid integer,
    mybookname varchar(40),
    mypublisher varchar(40),
    myprice integer
)
BEGIN
	/* 변수 선언 */
	DECLARE mycount INTEGER;
    -- 1. 데이터가 존재하는지 파악
    SELECT COUNT(*) INTO mycount
      FROM Book
	 WHERE bookname LIKE CONCAT('%', mybookname, '%');
     
     -- 2. mycount 가 0보다 크면 동일 도서가 존재
	IF mycount!=0 THEN
		SET SQL_SAFE_UPDATES=0;
        UPDATE Book SET price = myprice
			WHERE bookname LIKE CONCAT('%', mybookname, '%');
	ELSE
		INSERT INTO Book(bookid, bookname, publisher, price)
			VALUES(mybookid, mybookname, mypublisher, myprice);
	END IF;
END;
// delimiter ;

CALL BookInsertOrUpdate(33, '스포츠 즐거움', '마당과학서적', 25000);
SELECT * FROM Book;

CALL BookInsertOrUpdate(33, '스포츠 즐거움', '마당과학서적', 20000);
SELECT * FROM Book;
