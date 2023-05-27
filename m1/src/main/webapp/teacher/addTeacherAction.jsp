<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import ="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	//유효성검사
	if(request.getParameter("teacherId")==null
	||request.getParameter("teacherName")==null
	||request.getParameter("teacherHistory")==null
	||request.getParameter("teacherId").equals("")
	||request.getParameter("teacherName").equals("")
	||request.getParameter("teacherHistory").equals("")){
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");	
		System.out.println("파라미터검사에서 튕긴다 <--parm-- addTeacherAction.jsp");
		return;	
	}
	//파라미터 받아오기
	Teacher teacher = new Teacher();
	teacher.setTeacherId( request.getParameter("teacherId"));
	teacher.setTeacherName(request.getParameter("teacherName"));
	teacher.setTeacherHistory(request.getParameter("teacherHistory"));


	//모델 호출
	TeacherDao teacherDao = new TeacherDao();
	
	if(teacherDao.insertTeacher(teacher)==1){
		System.out.println("추가 성공 <-- addTeacherAction.jsp");
		System.out.println("리스트로 돌아갑니다. <-- addTeacherAction.jsp");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");
	}else{
		System.out.println("추가 실패 <-- addTeacherAction.jsp");
		System.out.println("추가 페이지로 돌아갑니다.. <-- addTeacherAction.jsp");
		response.sendRedirect(request.getContextPath()+"/teacher/addTeacher.jsp");
	}
	return;

%>