-- 사용자 정의함수. 내장함수 반대. 개발자가 직접 만드는 함수
-- 저장프로시저와 유사. RETURNS 유무 차이
-- 1행 1열, 스칼라값 리턴
SELECT char_length('HELLO WORLD')

DELIMITER //
CREATE FUNCTION fnc_Interest(
	price INTEGER
) RETURNS INTEGER
BEGIN
	DECLARE myInterest INTEGER;
    -- 가격이 3만원 이상이면 10%, 아니면 5%
    IF price >= 30000 THEN SET myInterest = price * 0.1;
    ELSE SET myInterest = price * 0.05;
    END IF;
    RETURN myInterest;
END;
// DELIMITER ;

-- 실행
SELECT custid, orderid, saleprice, fnc_Interest(saleprice) 이익금
FROM Orders;