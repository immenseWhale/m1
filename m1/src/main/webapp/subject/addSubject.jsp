<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Subject List</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
	a{
		/* 링크의 라인 없애기  */
		text-decoration: none;
	}
	a:link { 	/* 방문한 적 없는 글자색  */
		color:#4C4C4C; 
	}
	a:visited { /* 방문한 글자색  */
		color:#747474;
	}
</style>
</head>
<body>
<div class="container">	
	<!-- subject List 출력 -->
	<div>
		<h1>Add Subject</h1>
	</div>
	
	<div>
		<form action="<%=request.getContextPath()%>/subject/addSubjectAction.jsp" method="post">
			<table class="table table-bordered ">
				<tr>
					<th>과목명</th>
					<th>시수</th>
				</tr>		
				<tr>

					<td>
						<input type="text" name="subjectName">
					</td>
					<td>
						<input type="number" min="0" name="subjectTime">
					</td>
				</tr>
			</table>
			<button type="submit">추가</button>
		</form>
	</div>
</body>
</html>