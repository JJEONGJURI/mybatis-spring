	  	  create table exchange(
	  		eno int primary key,
	  		code varchar(10), #통화코드
	  		name varchar(50), #통화명
	  		primeamt float,   #매매기준율
	  		sellamt float, 	 #매도율
	       buyamt float, 	 #매입율
	       edate	varchar(10) #환율기준일
	  		)
	  		
	  		select * from exchange
	  		select infull(max(eno),0) from exchange
	  		drop table exchange
	  		
	  		# auto_increment 오라클에는 없는 기능
	  			: 자동으로 값을 생성
	  		# 오라클 : 시퀀스 사용
	  		# 기존테이블에 auto_increment 기능 추가
	  		Alter table exchange modify column eno int auto_increment;