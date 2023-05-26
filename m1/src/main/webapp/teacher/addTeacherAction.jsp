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
	||request.getParameter("subjectNo")==null
	||request.getParameter("teacherId").equals("")
	||request.getParameter("teacherName").equals("")
	||request.getParameter("teacherHistory").equals("")
	||request.getParameter("subjectNo").equals("0")){
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");	
		System.out.println("파라미터검사에서 튕긴다 <--parm-- addTeacherAction.jsp");
		return;	
	}
	//파라미터 받아오기
	Subject subject = new Subject();
	subject.setSubjectNo(Integer.parseInt(request.getParameter("subjectNo")));
	Teacher teacher = new Teacher();
	teacher.setTeacherId( request.getParameter("teacherId"));
	teacher.setTeacherName(request.getParameter("teacherName"));
	teacher.setTeacherHistory(request.getParameter("teacherHistory"));


	//HashMap에 담기
	HashMap<String, Object> map = new HashMap<>();
	map.put("subject", subject);
	map.put("teacher", teacher);

	//모델 호출
	TeacherDao teacherDao = new TeacherDao();
	TeacherSubjectDao TSDao = new TeacherSubjectDao();
	
	//teacherNo구한다
	int teacherNo = teacherDao.insertTeacher(map);
	System.out.println(teacherNo + "<--teacherNo-- addTeacherAction.jsp");
	//유효성검사
	if(request.getParameter("teacherNo")==null
	||request.getParameter("teacherNo").equals("0")){
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");	
		System.out.println("PK를 받아오지 못했다 <--RETURN_GENERATED_KEYS-- addTeacherAction.jsp");
		return;	
	}
	
	if(TSDao.insertTeacherSubject(teacherNo, subject.getSubjectNo())==1){
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