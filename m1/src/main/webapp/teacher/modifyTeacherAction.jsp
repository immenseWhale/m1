<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	request.setCharacterEncoding("utf-8");
	//유효성검사
	if(request.getParameter("teacherNo")==null
	||request.getParameter("teacherName")==null
	||request.getParameter("teacherId")==null
	||request.getParameter("teacherHistory")==null
	||request.getParameter("teacherNo").equals("")
	||request.getParameter("teacherId").equals("")
	||request.getParameter("teacherName").equals("")
	||request.getParameter("teacherHistory").equals("")){
		response.sendRedirect(request.getContextPath()+"/teacher/modifyTeacher.jsp?teacherNo="+request.getParameter("teacherNo"));	
		System.out.println("파라미터검사에서 튕긴다 <--parm-- modifyTeacherAction.jsp");
		return;	
	}
	//모델 호출
	TeacherDao teacherDao = new TeacherDao();
	//vo에 담기
	Teacher teacher = new Teacher();	
	teacher.setTeacherNo(Integer.parseInt(request.getParameter("teacherNo")));
	teacher.setTeacherId(request.getParameter("teacherId"));
	teacher.setTeacherName(request.getParameter("teacherName"));
	teacher.setTeacherHistory(request.getParameter("teacherHistory"));
	teacher.setUpdatedate(request.getParameter("updatedate"));
	
	System.out.println(teacher + "<--vo-- modifyTeacherAction.jsp");
	
	if(teacherDao.updateTeacher(teacher)==1){
		System.out.println("수정성공 <-- modifyTeacherAction.jsp");
	}else{
		System.out.println("수정실패 <-- modifyTeacherAction.jsp");
	}
	System.out.println("리스트로 돌아갑니다. <-- modifyTeacherAction.jsp");
	response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");
	return;
%>