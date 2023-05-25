<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//유효성검사
	if(request.getParameter("subjectNo")==null
	||request.getParameter("subjectNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");	
		System.out.println("파라미터검사에서 튕긴다 <--parm-- removeSubjectAction.jsp");
		return;	
	}
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	//모델 호출
	SubjectDao subjectDao = new SubjectDao();

	if(subjectDao.deleteSubject(subjectNo)==1){
		System.out.println("삭제성공 <-- removeSubjectAction.jsp");
	}else{
		System.out.println("삭제실패 <-- removeSubjectAction.jsp");
	}
	System.out.println("리스트로 돌아갑니다. <-- removeSubjectAction.jsp");
	response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");
	return;

%>