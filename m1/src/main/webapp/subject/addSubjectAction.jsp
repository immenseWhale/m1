<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	request.setCharacterEncoding("utf-8");
	//유효성검사
	if(request.getParameter("subjectName")==null
	||request.getParameter("subjectTime")==null
	||request.getParameter("subjectName").equals("")
	||request.getParameter("subjectTime").equals("0")){
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");	
		System.out.println("파라미터검사에서 튕긴다 <--parm-- addSubjectAction.jsp");
		return;	
	}
	//subject에 담기
	Subject subject = new Subject();
	subject.setSubjectName(request.getParameter("subjectName"));
	subject.setSubjectTime(Integer.parseInt(request.getParameter("subjectTime")));

	//모델 호출
	SubjectDao subjectDao = new SubjectDao();

	if(subjectDao.insertSubject(subject)==1){
		System.out.println("추가 성공 <-- addSubjectAction.jsp");
		System.out.println("리스트로 돌아갑니다. <-- addSubjectAction.jsp");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");
	}else{
		System.out.println("추가 실패 <-- addSubjectAction.jsp");
		System.out.println("추가 페이지로 돌아갑니다.. <-- addSubjectAction.jsp");
		response.sendRedirect(request.getContextPath()+"/subject/addSubject.jsp");
	}
	return;

%>