<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*"%>
<%
	//유효성검사
	if(request.getParameter("teacherNo")==null
	||request.getParameter("teacherName")==null
	||request.getParameter("teacherNo").equals("")
	||request.getParameter("teacherName").equals("")){
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");	
		System.out.println("teacherNo,teacherName이 없어서 리턴<--addTeacherSubject");
		return;	
	}
	//메소드 호출을 위한 변수 선언과 형변환
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	String teacherName = request.getParameter("teacherName");
	
	//모델 호출
	SubjectDao subjectDao = new SubjectDao();
	ArrayList<Subject> subjectList  = subjectDao.selectSubjectName();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Teacher Subject</title>
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
		<h1>선생님 과목 추가</h1>
	</div>
	<hr>
	<div>
		<form action="<%=request.getContextPath()%>/teacherSubject/addTeacherSubjectAction.jsp" method="post">
		<table class="table table-bordered ">
			<tr>
				<th>Teacher No</th>
				<td>
					<%=teacherNo%>
					<input type="hidden" name="teacherNo" value="<%=teacherNo%>">
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
				<%=teacherName%>
				<input type="hidden" name="teacherName" value="<%=teacherName%>">
				</td>
			</tr>
			<tr>
				<th>과목 선택</th>
				<td>
					<select name="subjectNo" multiple="multiple" >
					<%
						for(Subject m : subjectList){
					%>				
						<option value="<%=m.getSubjectNo()%>">
							<%=m.getSubjectName() %>
						</option>
					<%
						}
					%>
					</select>
				</td>
			</tr>
		</table>
		<button type="submit">과목 추가</button>
		</form>
	</div>
</div>
</body>
</html>