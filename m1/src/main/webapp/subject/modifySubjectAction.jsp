<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//유효성검사
	if(request.getParameter("subjectNo")==null
	||request.getParameter("subjectName")==null
	||request.getParameter("subjectTime")==null
	||request.getParameter("subjectNo").equals("")
	||request.getParameter("subjectName").equals("")
	||request.getParameter("subjectTime").equals("")){
		response.sendRedirect(request.getContextPath()+"/subject/modifySubject.jsp");	
		System.out.println("파라미터검사에서 튕긴다 <--parm-- modifySubjectAction.jsp");
		return;	
	}
	//모델 호출
	SubjectDao subjectDao = new SubjectDao();
	//vo에 담기
	Subject subject = new Subject();	
	subject.setSubjectNo(Integer.parseInt(request.getParameter("subjectNo")));
	subject.setSubjectTime(Integer.parseInt(request.getParameter("subjectTime")));
	subject.setSubjectName(request.getParameter("subjectName"));
	
	
	if(subjectDao.updateSubject(subject)==1){
		System.out.println("수정성공 <-- modifySubjectAction.jsp");
	}else{
		System.out.println("수정실패 <-- modifySubjectAction.jsp");
	}
	System.out.println("리스트로 돌아갑니다. <-- modifySubjectAction.jsp");
	response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");
	return;
%>