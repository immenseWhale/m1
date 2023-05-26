<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*"%>
<%
	//모델 호출
	SubjectDao subjectDao = new SubjectDao();
	//subject 목록 출력을 위한 메소드
	ArrayList<Subject> subjectList  = subjectDao.selectSubjectName();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Teacher</title>
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
	.center {
    float: right;
    position: relative;
    left: -50%;
  }
</style>
</head>
<body>
<div class="container">	
	<div>
		<h1>선생님 등록</h1>
	</div>
	<hr>
		
	<div>
		<form action="<%=request.getContextPath()%>/teacher/addTeacherAction.jsp" method="post">
		<table class="table table-bordered ">
			<tr>
				<th>ID</th>
				<td>
					<input type="text" name="teacherId">
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="teacherName">
				</td>
			</tr>
			<tr>
				<th>경력 사항</th>
				<td>
					<textarea rows="3" cols="60" name="teacherHistory">
					</textarea>
				</td>
			</tr>
			<tr>
				<th>교과목</th>
				<td>
					<select name="subjectNo">
				<%
					for(Subject s : subjectList){
				%>
						<option value="<%=s.getSubjectNo()%>"><%=s.getSubjectName() %></option>

				<%
					}
				%>
					</select>
				</td>
			</tr>
		</table>
		<button type="submit">추가</button>
		</form>
	</div>
</div>
</body>
</html>