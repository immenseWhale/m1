<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import ="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	//유효성검사
	if(request.getParameter("teacherNo")==null
	|| request.getParameterValues("subjectNo") == null
	||request.getParameter("teacherNo").equals("")
    || request.getParameterValues("subjectNo").length == 0){
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");	
		System.out.println("파라미터검사에서 튕긴다 <--parm-- addTeacherSubjectAction");
		return;	
	}
	//파라미터 받아오기
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	String[] subjectNoStrings = request.getParameterValues("subjectNo");
	//int 배열로 변환
	int[] subjectNos = new int[subjectNoStrings.length];
	for (int i = 0; i < subjectNoStrings.length; i++) {
	    subjectNos[i] = Integer.parseInt(subjectNoStrings[i]);
	}


	//모델 호출
	TeacherSubjectDao TSDao = new TeacherSubjectDao();
	int result = TSDao.insertTeacherSubject(teacherNo, subjectNos);
	if( result != 0){
		System.out.println(result + "추가 성공 <-- addTeacherAction.jsp");
	}else{
		System.out.println(result + "추가 실패 <-- addTeacherAction.jsp");
	}

	response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");
	return;

%>