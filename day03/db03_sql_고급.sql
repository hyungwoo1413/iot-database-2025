-- 내장함수
-- 4-1 (-78)과 (78)의 절댓값을 구하시오
SELECT ABS(-78), ABS(78);

-- 4-2 4.875를 소숫점 첫번째 자리까지 반올림하시오
SELECT ROUND(4.875, 1) AS 결과;

-- 4-3 고객별 평균 주문 금액을 100원단위로 반올림한 값을 구하시오
SELECT custid, ROUND(AVG(saleprice),-2) AS '평균금액'
FROM Orders
GROUP BY custid;

-- 문자열 내장함수
-- 4-4 도서 제목에서 야구가 포함된 도서명을 농구로 변경한 후 출력하시오
SELECT bookid,
	   REPLACE(bookname, '야구', '농구') AS bookname,
       publisher,
       price
FROM   Book;

-- 추가
SELECT 'Hello' 'MySQL';

SELECT CONCAT('Hello', 'MySQL');

-- 4-5 굿스포츠에서 출판한 도서의 제목과 제목의 문자수, 바이트수를 구하시오
SELECT	bookname AS '제목', 
		char_length(bookname) AS '제목 문자수',	-- 글자 길이를 구할때
        length(bookname) AS '제목 바이트수' -- utf8에서 한 글자의 바이트 수는 3byte 띄어쓰기는 1byte
FROM	Book
WHERE 	publisher = '굿스포츠';

-- 4-6 고객 중 성이 같은 사람이 몇명이나 되는지 성씨별 인원수를 구하시오
-- SUBSTR(자를 원본 문자열, 시작인덱스, 길이)
SELECT SUBSTR('가나다', 1, 2); 

SELECT 		substr(name,1,1) AS '성씨', 
			count(*) AS '인원수'
FROM 		Customer
GROUP BY	substr(name,1,1);

-- 추가. trim(), 파이썬 strip()과 동일
SELECT CONCAT('--', TRIM('     HELLO     '), '--');
SELECT CONCAT('--', LTRIM('     HELLO     '), '--');
SELECT CONCAT('--', RTRIM('     HELLO     '), '--');

SELECT TRIM('=' FROM '===-HELLO-===');

-- 날짜시간 함수
SELECT SYSDATE(); -- Docker 서버시간을 따라서 GMT(그리니치 표준시)를 따름 + 9hour

SELECT ADDDATE(SYSDATE(), INTERVAL 9 HOUR) AS '한국시간';

-- 4-7 마당서점은 주문일부터 10일 후에 매출을 확정합니다. 각 주문의 확정일자를 구하시오.
SELECT 	orderid AS '주문번호',
		orderdate AS '주문일자',
        ADDDATE(orderdate, INTERVAL 10 DAY) AS '확정일자'
FROM	Orders;

-- 추가, 나라별 날짜, 시간을 표현하는 포맷이 다름
SELECT SYSDATE() AS '기본날짜/시간',
	   DATE_FORMAT(SYSDATE(), '%M/%d/%Y %H:%i:%s');
       
-- 4-8 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 나타내시오.
-- 단, 주문일은 %Y-%m-%d 형태로 표시한다.
-- %Y = 년도전체, %y = 년도 뒤2자리, %M = July(월이름), %b = Jul(월약어), %m = 07(월숫자) 
-- %d = 일, %H = 16(24시간), %h = 04(오후도), %W = Monday, %w = 1(요일은 일요일부터 시작 : 0)
SELECT orderid AS '주문번호',
	   date_format(orderdate, '%Y/%b/%d') AS '주문일',
       custid AS '고객번호',
       bookid AS '도서번호'
FROM   Orders;

-- DATEDDIFF: D-day
SELECT DATEDIFF(SYSDATE(), '2025-02-03');

-- NULL = 파이썬 None 동일, 모든 다른 프로그래밍 언어에서는 전부 NULL, NUL
-- 추가. 금액이 NULL일때 발생되는 현상
SELECT price - 5000
  FROM MyBook
 WHERE bookid = 3;
 
-- 핵심. 집계함수가 다 꼬임
SELECT SUM(price) AS '합산은 문제없음'
	 , AVG(price) AS '평균은 NULL이 빠져서 꼬임'
	 , COUNT(*)	  AS '모든 행의 개수는 일치'
     , COUNT(price) AS 'NULL값은 개수에서 빠짐'
  FROM MyBook;
  
-- NULL값 확인. NULL은 비교연산자 사용 불가
SELECT *
  FROM MyBook
 WHERE price IS NULL;
 
 SELECT *
  FROM MyBook
 WHERE price = NULL;
