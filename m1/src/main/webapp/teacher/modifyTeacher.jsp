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
    float: right;
    position: relative;
    left: -50%;
  }
</style>
</head>
<body>
<div class="container">	
<!-- teacher List 출력 --------------------------->
	<div>
		<h1>선생님 상세 정보</h1>
	</div>
	
	<div>
		<form action="<%=request.getContextPath()%>/teacher/modifyTeacherAction.jsp" method="post">
		<table class="table table-bordered ">
			<tr>
				<th>Teacher No</th>
				<td>
					<%=teacher.getTeacherNo()%>
					<input type="hidden" name="teacherNo" value="<%=teacher.getTeacherNo()%>">
				</td>
			</tr>
			<tr>
				<th>ID</th>
				<td>
					<input type="text" name="teacherId" value="<%=teacher.getTeacherId()%>">
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="teacherName" value="<%= teacher.getTeacherName() %>">
				</td>
			</tr>
			<tr>
				<th>경력 사항</th>
				<td>
					<textarea rows="3" cols="60" name="teacherHistory">
					<%=teacher.getTeacherHistory()%>
					</textarea>
				</td>
			</tr>
			<tr>
				<th>수정일</th>
				<td><%=teacher.getUpdatedate()%></td>
			</tr>
			<tr>
				<th>등록일</th>
				<td><%=teacher.getCreatedate()%></td>
			</tr>
		</table>
		<button type="submit">수정</button>
		</form>
	</div>
</div>
</body>
</html>