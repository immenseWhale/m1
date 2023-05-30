<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*"%>
<%
	//모델 호출
	SubjectDao subjectDao = new SubjectDao();
	//리스트를 위한 변수 선언
	//현재 페이지
	int currentPage=1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//페이지에 보여주고 싶은 행의 개수
	int rowPerPage = 4;
	if(request.getParameter("rowPerPage")!=null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		System.out.println(rowPerPage + "<--crt-- subjectList.jsp 새로 들어간 페이지 당 행의 수");
	}
	//페이지 주변부에 보여주고싶은 리스트의 개수
	int pageRange = 2;
	//시작 행
	int beginRow = (currentPage-1) * rowPerPage + 1;
	
	//총 행을 구하기 위한 sql
	int totalRow = subjectDao.selectSubjectCnt();
	
	//마지막 페이지
	int lastPage = totalRow / rowPerPage;
	//마지막 페이지는 딱 나누어 떨어지지 않으니까 몫이 0이 아니다 -> +1
	if(totalRow % rowPerPage != 0){
		lastPage += 1;
	}
	//페이지 목록 중 가장 작은 숫자의 페이지
	int minPage = ((currentPage - 1) / pageRange ) * pageRange + 1;
	//페이지 목록 중 가장 큰 숫자의 페이지
	int maxPage = minPage + (pageRange - 1 );
	//maxPage 가 last Page보다 커버리면 안되니까 lastPage를 넣어준다
	if (maxPage > lastPage){
		maxPage = lastPage;
	}
	//subject 목록 출력을 위한 메소드
	ArrayList<Subject> subjectList  = subjectDao.selectSubjectListByPage(beginRow, rowPerPage);


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
<!-- 상단 메인 메뉴 추가 -->
	<div>
		<jsp:include page="/home.jsp"></jsp:include>
	</div>
	
	<!-- subject List 출력 -->
	<div>
		<h1>Subject List</h1>
	</div>
	<hr>
	<!-- rowPerPage 선택 form -->
	<div style="float:left;">
		<form action="<%=request.getContextPath()%>/subject/subjectList.jsp" method="post">
			<select name="rowPerPage" onchange="this.form.submit()"> <!-- 옵션 선택시 바로 submit -->
			<%
				for (int i = 2; i < 31; i = i + 2) {
			%>
					<option value="<%=i%>" <%if (rowPerPage == i) {%> selected <%}%>>
						<%=i%>개씩
					</option>
			<%
				}
			%>
			</select>
		</form>	
	</div>
	<div style="float:right;">
		<a href = "<%=request.getContextPath()%>/subject/addSubject.jsp">추가</a>
	</div>

	<div>
		<table class="table table-bordered ">
			<tr>
				<th>과목명</th>
				<th>시수</th>
				<th>만든 날짜</th>
				<th>수정 날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		<%
			for(Subject m : subjectList){
		%>				
				<tr>	
					<td><%=m.getSubjectName()%> </td>
					<td><%=m.getSubjectTime()%> </td>
					<td><%=m.getCreatedate()%> </td>
					<td><%=m.getUpdatedate()%> </td>
					<td>
						<a href = "<%=request.getContextPath()%>/subject/modifySubject.jsp?subjectNo=<%=m.getSubjectNo()%>">수정</a>
					</td>
					<td>
						<a href = "<%=request.getContextPath()%>/subject/removeSubjectAction.jsp?subjectNo=<%=m.getSubjectNo()%>">삭제</a>
					</td>
				</tr>
		<%
			}
		%>
		</table>
	</div>
<!--페이지 리스트 ---------------------------->
	<div align="center">
	<%
		//1번 페이지보다 작은데 나오면 음수로 가버린다
		if (minPage > 1) {
	%>
			<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=minPage-pageRange%>">이전</a>
	
	<%	
		}
		for(int i=minPage; i <= maxPage; i=i+1){
			if ( i == currentPage){		
	%>
				<span><%=i %></span>
	<%
			}else{
	%>
				<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=i%>"><%=i %></a>
	<%
			}
		}
	
		//maxPage와 lastPage가 같지 않으면 여분임으로 마지막 페이지목록일거다.
		if(maxPage != lastPage ){
	%>
			<!-- maxPage+1해도 동일하다 -->
			<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=minPage+pageRange%>">다음</a>
	<%
		}
	%>
	
	</div>

</div>
</body>
</html>