<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
    /* 전체 링크 스타일 */
    a {
        text-decoration: none; /* 링크의 밑줄 제거 */
    }
    
    /* 방문한 링크 스타일 */
    a:visited {
        color: #747474; /* 방문한 링크의 글자색 설정 */
    }
    
    /* 제목 스타일 */
    h1 {
        color: #3296D7; /* 제목의 글자색 설정 */
        font-size: 24px; /* 제목의 글자 크기 설정 */
        font-weight: bold; /* 제목의 글자 굵기 설정 */
    }
    
    /* 메뉴 스타일 */
    .menu {
        margin-top: 20px; /* 메뉴와 위쪽 여백 설정 */
    }
    
    .menu a {
        margin-bottom: 10px; /* 메뉴 항목 간격 설정 */
        color: #A5D8FA; /* 메뉴 항목의 글자색 설정 */
    }
</style>
</head>
<body>
<div class="container">	
	<div>
		<h1>Home</h1>
	</div>
	<hr>
	
	<!-- subject폴더 보내기 -->
	<div class="menu">
		<a href="<%=request.getContextPath()%>/subject/subjectList.jsp">Subject</a>
	</div>
	
	<!-- teacher폴더 보내기 -->
	<div class="menu">
		<a href="<%=request.getContextPath()%>/teacher/teacherList.jsp">Teacher</a>
	</div>
	
	<!-- 
		teacherSubject 목록을 출력? 상단에 항상 홈으로 올 수 있게 추가?
	 -->
</div>
</body>
</html>