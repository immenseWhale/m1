<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*" %>
<%
	//유효성검사
	if(request.getParameter("teacherNo")==null
	||request.getParameter("teacherNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/teacherList.jsp");	
		System.out.println("teacherNo가 없어서 리턴");
		return;	
	}
	//메소드 호출을 위한 변수 선언과 형변환
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	//모델 호출
	TeacherDao teacherDao = new TeacherDao();
	Teacher teacher = teacherDao.selectTeacherOne(teacherNo);	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Teacher One</title>
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
    float: center;
    position: relative;
	}
</style>
</head>
<body>
<div class="container">	
<!-- teacher List 출력 --------------------------->
	<div>
		<h1>선생님 상세 정보</h1>
	</div>
	<hr>
		<div style="float:right;">
			<form action="<%=request.getContextPath()%>/teacher/removeTeacherActrion.jsp" method="post">
				<input type="hidden" name="teacherNo" value="<%=teacher.getTeacherNo()%>">
				<button class="btn btn-primary btn-lg" type="submit">과목 추가</button>
			</form>
		</div>
	<div class="center">
		<table class="table table-bordered ">
			<tr>
				<th>Teacher No</th>
				<th>ID</th>
				<th>이름</th>
				<th>경력 사항</th>
				<th>수정일</th>
				<th>등록일</th>
			</tr>		
			<tr>	
				<td>
					<%=teacher.getTeacherNo()%> 
				</td>
				<td><%=teacher.getTeacherId()%> </td>
				<td><%=teacher.getTeacherName()%> </td>
				<td><%=teacher.getTeacherHistory()%></td>
				<td><%=teacher.getUpdatedate()%></td>
				<td><%=teacher.getCreatedate()%></td>
			</tr>
		</table>
		<div class="row">
			
			<div class="col-5 text-center">
				<form action="<%=request.getContextPath()%>/teacher/modifyTeacher.jsp" method="post">
					<input type="hidden" name="teacherNo" value="<%=teacher.getTeacherNo()%>">
					<button class="btn btn-warning btn-lg" type="submit">수정</button>
				</form>
			</div>
			<div class="col-6 text-center">
				
				<form action="<%=request.getContextPath()%>/teacher/removeTeacherActrion.jsp" method="post">
					<input type="hidden" name="teacherNo" value="<%=teacher.getTeacherNo()%>">
					<button class="btn btn-warning btn-lg" type="submit">삭제</button>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>