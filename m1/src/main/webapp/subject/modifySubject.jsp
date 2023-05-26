<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//유효성검사
	if(request.getParameter("subjectNo")==null
	||request.getParameter("subjectNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/subjectList.jsp");	
		System.out.println("subjectNo가 없어서 리턴");
		return;	
	}
	//메소드 호출을 위한 변수 선언과 형변환
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	//모델 호출
	SubjectDao subjectDao = new SubjectDao();

	Subject subject = subjectDao.selectSubjectOne(subjectNo);
%>
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
		<h1>Subject List</h1>
	</div>
	
	<div>
		<form action="<%=request.getContextPath()%>/subject/modifySubjectAction.jsp" method="post">
			<table class="table table-bordered ">
				<tr>
					<th>No</th>
					<th>과목명</th>
					<th>시수</th>
					<th>만든 날짜</th>
					<th>수정 날짜</th>
				</tr>		
				<tr>
					<td>
						<%=subject.getSubjectNo()%>
						<input type="hidden" name="subjectNo" value="<%=subject.getSubjectNo()%>">
					</td>
					<td>
						<input type="text" name="subjectName" value="<%= subject.getSubjectName() %>">
					</td>
					<td>
						<input type="number" min="0" name="subjectTime" value="<%= subject.getSubjectTime() %>">
					</td>
					<td><%=subject.getCreatedate()%> </td>
					<td><%=subject.getUpdatedate()%> </td>
				</tr>
			</table>
			<button type="submit">수정</button>
		</form>
	</div>
</body>
</html>