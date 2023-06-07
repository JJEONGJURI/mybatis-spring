<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />    
<%-- /shop1/src/main/webapp/layout/gdulayout.jsp --%>    

<!DOCTYPE html>
<html>
<head> 
<title><sitemesh:write property="title" /></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src= 
"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/standard/ckeditor.js"></script>
<style>
html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
</style>
<sitemesh:write property="head" />
</head>
<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large" style="z-index:4">
  <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i> &nbsp;Menu</button>
  <span class="w3-bar-item w3-right">
	<c:if test="${empty sessionScope.loginUser}"> <!-- 로그아웃상태 -->
	 <a href="${path}/user/login">로그인</a>
	 <a href="${path}/user/join">회원가입</a>
	</c:if>   
	<c:if test="${!empty sessionScope.loginUser}"> <!-- 로그인 된 상태 -->
	${sessionScope.loginUser.username}님이 로그인 하셨습니다.&nbsp;&nbsp;
	 <a href="${path}/user/logout">로그아웃</a>
	</c:if>   
  </span>
</div>
<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s4">
      <img src="${path}/image/logo.png" 
         class="w3-circle w3-margin-right" style="width:100px">
    </div>
    <div class="w3-col s8 w3-bar">
      <c:if test="${!empty sessionScope.loginUser}">
      <span>반갑습니다, <strong>${sessionScope.loginUser.username}님</strong></span><br>
      </c:if>
      <c:if test="${empty sessionScope.loginUser}">
      <span><strong>로그인하세요</strong></span><br>
      </c:if>
    </div>
  </div>
  <hr>
  <div class="w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>&nbsp; Close Menu</a>
    <a href="${path}/user/mypage?userid=${sessionScope.loginUser.userid}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url == "user"}'>w3-blue</c:if>">
    <i class="fa fa-users fa-fw"></i>&nbsp; 회원관리</a>
    <a href="${path}/item/list" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url == "item"}'>w3-blue</c:if>">
    <i class="fa fa-eye fa-fw"></i>&nbsp; 상품관리</a>
    <a href="${path}/chat/chat" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url == "chat"}'>w3-blue</c:if>">
    <i class="fa fa-eye fa-fw"></i>&nbsp; 채팅하기</a>
    <hr>
    <!--파라미터값 boardid=1 -->
    <a href="${path}/board/list?boardid=1" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url == "board" && boardid=="1"}'>w3-blue</c:if>">
    <i class="fa fa-eye fa-fw"></i>&nbsp; 공지사항</a>
    <a href="${path}/board/list?boardid=2" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url == "board" && boardid=="2"}'>w3-blue</c:if>">
    <i class="fa fa-eye fa-fw"></i>&nbsp; 자유게시판</a>
    <a href="${path}/board/list?boardid=3" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url == "board" && boardid=="3"}'>w3-blue</c:if>">
    <i class="fa fa-eye fa-fw"></i>&nbsp; QnA</a>
  </div>
  
  <!-- 크롤링 시작 : 수출입은행 환율 정보 표시 영역 -->
	
  	<div id="exchange" style="margin:10px;"></div>

  
  
  <!-- 크롤링  끝 -->
  
  
  
</nav>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

  <!-- Header -->
  <header class="w3-container" style="padding-top:22px">
    <h5><b><i class="fa fa-dashboard"></i>게시판현황</b></h5>
  </header>

  <div class="w3-row-padding w3-margin-bottom">
    <div class="w3-half">
      <div class="w3-container w3-padding-16 w3-center">
     	 <input type="radio" name="pie" onchange="piegraph(2)" checked="checked">자유게시판 &nbsp;&nbsp;
     	 <input type="radio" name="pie" onchange="piegraph(3)" >QNA &nbsp;&nbsp;
     	 <div id = "piecontainer " style="width:100%; border:1px solid #ffffff">
     		<canvas id="canvas1" style="width:100%"></canvas>
     	 </div>
      </div>
    </div>
    <div class="w3-half">
    <%--최근 7일간의 등록된 게시글 건수 막대그래프와 선그래프로 동시에 출력 --%>
      <div class="w3-container  w3-padding-16 w3-center">
     	 <input type="radio" name="barline" onchange="barlinegraph(2)" checked="checked">자유게시판 &nbsp;&nbsp;
     	 <input type="radio" name="barline" onchange="barlinegraph(3)" >QNA &nbsp;&nbsp;
     	 <div id = "barcontainer " style="width:100%; border:1px solid #ffffff">
     		<canvas id="canvas2" style="width:100%"></canvas>
      	</div>
    	</div>
  	</div>
  </div>

  <div class="w3-panel">
  <sitemesh:write property="body" />
  </div>
  <hr>
  <!-- Footer -->
  <footer class="w3-container w3-padding-16 w3-light-grey">
    <h4>FOOTER</h4>
    <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>
    <hr>
    <div>
    	<span id="si">
    		<select name="si" onchange="getText('si')">
    			<option value="">시도를 선택하세요</option>
    		</select>
    	</span>
    	<span id="gu">
    		<select name="gu" onchange="getText('gu')">
    			<option value="">구군을 선택하세요</option>
    		</select>
    	</span>
    	<span id="dong">
    		<select name="dong">
    			<option value="">동리를 선택하세요</option>
    		</select>
    	</span>   
    </div>
  </footer>

  <!-- End page content -->
</div>

<script>
// Get the Sidebar
var mySidebar = document.getElementById("mySidebar");

// Get the DIV with overlay effect
var overlayBg = document.getElementById("myOverlay");

// Toggle between showing and hiding the sidebar, and add overlay effect
function w3_open() {
  if (mySidebar.style.display === 'block') {
    mySidebar.style.display = 'none';
    overlayBg.style.display = "none";
  } else {
    mySidebar.style.display = 'block';
    overlayBg.style.display = "block";
  }
}

// Close the sidebar with the close button
function w3_close() {
  mySidebar.style.display = "none";
  overlayBg.style.display = "none";
}
</script>

<!-- ajax 하려고 추가한거 -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
	<script type="text/javascript">
		$(function(){ //문서가 준비되면
			getSido() //문서 시작하고 getSido 호출 //sido.txt 파일을 읽어서 시도 정보 조회
//			exchangeRate() //수출입은행 환율 정보 조회
			exchangeRate2() //수출입은행 환율 정보 조회
			piegraph(2)	//글쓴이별 게시글 건수를 파이그래프로 출력
			barlinegraph(2) //최근 7일간 막대선 그래프 출력
		})
		function getSido() {  //서버에서 리스트 객체를 배열로 직접 전달 받음
			$.ajax({ //ajax으로 서버에 요청 ${path} = shop1
				url : "${path}/ajax/select",
				//arr : 서버에서 전달 받는 리스트 객체를 배열로 인식함 
				success : function(arr) { //controller 의 if 문장 실행
					console.log(arr)
					$.each(arr,function(i,item){
						// i : 인덱스. 첨자. 0부터 시작
						// itme : 배열의 요소
						$("select[name=si]").append(function(){
							return "< option>"+item+"</option>"
						})
					})
				}
			})
		}
		function getSido2() { //서버에서 문자열로 전달 받음 => 한글깨짐
			//클라이언트로 문자열 전송. 인코딩 설정 필요
			$.ajax({ //ajax으로 서버에 요청 ${path} = shop1
				url : "${path}/ajax/select2",
				//data : [서울특별시,... 제주특별자치도], 문자열
				success : function(data) {
					console.log(data)
					//arr : 배열객체
					let arr = data.substring(data.indexOf('[')+1, data.indexOf(']')).split(",");
					$.each(arr,function(i,item){
						$("select[name=si]").append(function(){
							return "<option>"+item+"</option>"
						})
					})
				}
			})
		}
		function getText(name) { //getText 함수 호출 name 에는 si 들어감
			let city = $("select[name='si']").val();	//시도 선택값
			let gu = $("select[name='gu']").val();		//구군 선택값
			let disname;
			let toptext="구군을 선택하세요";
			let params = ''
			if(name=='si') {	//시도 선택한 경우
				params = "si=" + city.trim()
				disname = "gu"
			} else if(name=='gu') { 	//구군 선택한 경우
				params = "si=" + city.trim()+"&gu="+gu.trim()
				disname = "dong"
				toptext = "동리를 선택하세요";
			} else {
				return 
			}
			$.ajax({
				url : "${path}/ajax/select",
				type : "POST",
				data :  params,
				success : function(arr){
					$("select[name="+disname+"] option").remove() //출력 selelct 태그의 option 객체를 제거해 
					$("select[name="+disname+"]").append(function(){
						return "<option value=''>"+toptext+"</option>" // 구군을 선택하세요
					})
					//구에 밑에 데이터를 넣어줌
					$.each(arr,function(i,item){ //서버에서 전송 받은 배열값을 option 객체에 추가해준다
						$("select[name="+disname+"]").append(function(){
							return "<option>"+item+"</option>"
						})	
					})
				}
			})	
		}
	function exchangeRate() {
		$.ajax("${path}/ajax/exchange",{
			success : function(data) {
				console.log(data)
				$("#exchange").html(data) //서버단에서 데이터 만들어 전송
			},
			error : function(e) {
				alert("환율 조회시 서버 오류 발생 :" + e.status)
			}
		})
	}
	<%--
	function exchangeRate2() {
		$.ajax("${path}/ajax/exchange2",{ //list로 데이터 수신 
			success : function(arr) {
				let html = "<table class='w3-table-all w3-margin-right'>"
				html += "<tr><th>통화</th><th>기준율</th><th>받으실때</th><th>보내실때</th></tr>"
				$.each(arr,function(i,tds){ //tds : 배열
					html += "<tr><td>"+tds[0]+"<br>"+tds[1]+"</td><td>"+tds[4]+"</td>"
							+ "<td>"+tds[2]+"</td><td>"+tds[3]+"</td><tr>"
				})
				html += "</table>"
				$("#exchange").html(html) //서버단에서 데이터 만들어 전송
			},
			error : function(e) {
				alert("환율 조회시 서버 오류 발생 :" + e.status)
			}
		})
	}
	--%>
	function exchangeRate2() {
		$.ajax("${path}/ajax/exchange2",{ //Map로 데이터 수신 
			success : function(json) {
				console.log(json)
				let html = "<h4 class='w3-center'>수출입은행<br>"+json.exdate+"</h4>"
				html += "<table class='w3-table-all w3-margin-right'>"
				html += "<tr><th>통화</th><th>기준율</th><th>받으실때</th><th>보내실때</th></tr>"
				$.each(json.trlist,function(i,tds){ //tds : 배열
					html += "<tr><td>"+tds[0]+"<br>"+tds[1]+"</td><td>"+tds[4]+"</td>"
							+ "<td>"+tds[2]+"</td><td>"+tds[3]+"</td><tr>"
				})
				html += "</table>"
				$("#exchange").html(html) //서버단에서 데이터 만들어 전송
			},
			error : function(e) {
				alert("환율 조회시 서버 오류 발생 :" + e.status)
			}
		})
	}
	let randomColorFactor = function() {
		return Math.round(Math.random() * 255) //0~255사이의 임의의 수
	}
	let randomColor = function(opa) {
		return "rgba(" + randomColorFactor() + "," 
					   + randomColorFactor() + ","
					   + randomColorFactor() + ","
					   + (opa || '.3') + ")" //투명도
	}
	function piegraph(id) { //id:2 //id:3
		$.ajax("${path}/ajax/graph1?id="+id, {
			success : function(json) {	//json : [{홍길동:10},{김삿갓:7},...] 배열 객체로 전달
				let canvas = "<canvas id='canvas1' style='width:100%'></canvas>"
				$("#piecontainer").html(canvas)	//새로운 canvas 객체로 생성
				pieGraphPrint(json,id)
			},
			error : function(e) {
				alert("서버오류:" + e.status)
			}
		})
	}
	function barlinegraph(id) {
		$.ajax("${path}/ajax/graph2?id="+id, {
			success : function(arr) { //arr :{"2023-06-01":10},{"2023-05-30":20},...}
				let canvas = "<canvas id='canvas2' style='width:100%'</canvas>"
				$("#barcontainer").html(canvas) //새로운 canvas 객체로 생성
				barlineGraphPrint(arr,id) //그래프 작성
			},
			error : function(e) {
				alert("서버오류:" + e.status)
			}
		})
	}
	//json : 서버에서 전송해준 데이터값.
	//json : [{"홍길동":10},{"김삿갓":7},...]
	function pieGraphPrint(arr,id) {
		let colors = []	//임의의 색상 지정
		let writers = []	//글쓴이 목록 배열로 설정
		let datas = [] //글작성 건수 목록 설정
		$.each(arr,function(index) {
			colors[index] = randomColor(0.5)	//임의의 색상 설정
			for(key in arr[index]) {	//arr[index] : {"홍길동":10}
				//key : 홍길동
				writers.push(key) //글쓴이
				datas.push(arr[index][key]) //글작성건수
			}
		})
		let title = (id == 2)?"자유게시판":"QNA"
		let config = {
				type: 'pie', //그래프 종류
				data : { //데이터 정보
					datasets : [{data:datas,
								 backgroundColor : colors}],
					labels  : writers
				},
				options : {
					responsive : true, 	//반응형 웹
					legend : {display:true, position:"right"},
					title : {
						display : true,
						text : '글쓴이 별 ' + title + " 등록건수",
						position : 'bottom'
					}
				}
		}
		let ctx = document.getElementById("canvas1")
		new Chart(ctx,config)
	}
	

	function barlineGraphPrint(arr,id) {
		let colors = [] //임의의 색상 설정
		let regdates = [] //작성일자 목록 설정
		let datas = [] //글작성 건수 목록 설정
		$.each(arr,function(index) {
			colors[index] = randomColor(0.5) //임의의 색상 설정
			for(key in arr[index]) {  //arr[index] : {"2023-06-01":10}
				regdates.push(key) //작성일자
				datas.push(arr[index][key]) //글작성건수
			}
		})
		let title = (id == 2)?"자유게시판":"QNA"
		let config = {
				type : 'bar', //그래프 종류
				data :  {
					datasets : [{
						type : 'line',
						boarderWidth : 2,
						boarderColor : colors,
						label : '건수',
						fill : false,
						data : datas
					
					},{
						type : 'bar',
						label : '건수',
						backgroundColor : colors,
						data : datas
					}],
					labels : regdates,
				},
				options: {
					responsive : true,
					legend : {diplay : false},
					title : {display : true,
						text : '최근 7일 ' + title + " 등록건수",
						position : 'bottom'
					},
					scales : {
						xAxes : [{display : true, 
							scaleLabel : {display :true, labelString :"작성일자"}
						}],
						yAxes : [{scaleLabel : {display :true, labelString :"게시물 등록 건수"},
								  ticks : {beginAtZero : true}	
						}]
					}
				}
		}
		let ctx = document.getElementById("canvas2")
		new Chart(ctx,config)
	}
	</script>

	<!-- ajax 하려고 추가한거 끝 -->
</body>
</html>