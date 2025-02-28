-- 행번호
-- 4-11 고객목록에서 고객번호, 이름, 전화번호를 앞의 2명만 출력하시오

SET @seq := 0;  -- 변수선언 SET으로 시작, @를 붙임, 값 할당은 :=

SELECT @seq := @seq + 1 AS '행번호'
	 , custid
	 , name
     , phone
  FROM Customer
 WHERE @seq < 2;
 
SELECT custid
	 , name
     , phone
  FROM Customer LIMIT 2;  -- 순차적인 일부 데이터 추출에는 훨씬 탁월
  
-- 특정범위 추출, 3번째 다음 행부터 2개를 추출
SELECT custid
	 , name
     , phone
  FROM Customer LIMIT 2 OFFSET 3;
  

