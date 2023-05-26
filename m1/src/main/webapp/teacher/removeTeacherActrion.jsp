<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//유효성검사
	if(request.getParameter("teacherNo")==null
	||request.getParameter("teacherNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");	
		System.out.println("파라미터검사에서 튕긴다 <--parm-- removeteacherAction.jsp");
		return;	
	}
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	//모델 호출
	TeacherDao teacherDao = new TeacherDao();

	if(teacherDao.deleteTeacher(teacherNo)==1){
		System.out.println("삭제성공 <-- removeTeacherAction.jsp");
	}else{
		System.out.println("삭제실패 <-- removeTeacherAction.jsp");
	}
	System.out.println("리스트로 돌아갑니다. <-- removeTeacherAction.jsp");
	response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");
	return;

%>