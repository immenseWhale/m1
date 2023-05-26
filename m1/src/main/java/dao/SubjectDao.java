package dao;
import java.util.*;
import java.sql.*;
import util.*;
import vo.*;


public class SubjectDao {
	//1)과목 목록										//현재 페이지, 페이지당 보여줄 행의 개수, 페이지 목록 몇개 보여줄건지의 개수
	public ArrayList<Subject> selectSubjectListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Subject> list = new ArrayList<Subject>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String mainSql = "SELECT subject_no subjectNo, subject_name subjectName, subject_time subjectTime, createdate, updatedate FROM subject LIMIT ?, ?";
		PreparedStatement mainStmt = conn.prepareStatement(mainSql);
		//페이징 처리를 위한 SQL 쿼리문에서의 인덱스는 0부터 시작하므로 beginRow를 1을 빼서 0부터 시작하도록 설정

		mainStmt.setInt(1, beginRow - 1);
		mainStmt.setInt(2, rowPerPage);
		
		ResultSet mainRs = mainStmt.executeQuery();
		while(mainRs.next()){
			Subject s = new Subject();
			s.setSubjectNo(mainRs.getInt("subjectNo"));
			s.setSubjectName(mainRs.getString("subjectName"));
			s.setSubjectTime(mainRs.getInt("subjectTime"));
			s.setCreatedate(mainRs.getString("createdate"));
			s.setUpdatedate(mainRs.getString("updatedate"));
			list.add(s);
		}
		//System.out.println(list+ "<--ArrayList-- SubjectDao.selectSubjectListByPage");

		return list;
	}	
	
	
	//2)과목 추가
	public int insertSubject(Subject subject) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String addSql ="INSERT INTO subject(subject_name,subject_time,createdate,updatedate) values(?,?, NOW(),NOW());";
		PreparedStatement addStmt = conn.prepareStatement(addSql);
		addStmt.setString(1, subject.getSubjectName());
		addStmt.setInt(2, subject.getSubjectTime());
		row = addStmt.executeUpdate();
		if(row != 0) {
			System.out.println(row+ "행 추가되었습니다.. <-- SubjectDao.insertSubject");
		}
		return row;
	}
	
	//3)과목 삭제
	public int deleteSubject(int subjectNo) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String delSql = "DELETE FROM subject WHERE subject_no = ?";
		PreparedStatement delStmt = conn.prepareStatement(delSql);
		delStmt.setInt(1, subjectNo);
		row = delStmt.executeUpdate();
		if(row != 0) {
			System.out.println(row+ "행 수정되었습니다. <-- SubjectDao.updateSubject");
		}		
		return row;
	}
	
	//4)과목 수정
	public int updateSubject(Subject subject) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		String modSql = "UPDATE subject SET subject_name=?, subject_time=?, updatedate=NOW() WHERE subject_no=?";
		PreparedStatement modStmt = conn.prepareStatement(modSql);
		modStmt.setString(1, subject.getSubjectName());
		modStmt.setInt(2, subject.getSubjectTime());
		modStmt.setInt(3, subject.getSubjectNo());
		row = modStmt.executeUpdate();
		if(row != 0) {
			System.out.println(row+ "행 수정되었습니다. <-- SubjectDao.updateSubject");
		}		
		return row;
	}
	
	//5)과목 상세
	public Subject selectSubjectOne(int subjectNo) throws Exception  {
		Subject subject = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String oneSql = "SELECT subject_no subjectNo, subject_name subjectName, subject_time subjectTime, createdate, updatedate FROM subject WHERE subject_no=?";
		PreparedStatement stmt = conn.prepareStatement(oneSql);
		stmt.setInt(1, subjectNo);
		ResultSet rs = stmt.executeQuery();
		
		//어차피 한개의 결과만 나오기 때문에 배열이 아닌 단일 값으로 가져오겠다.
		if (rs.next()){
			subject = new Subject();	
			subject.setSubjectNo(rs.getInt("subjectNo"));
			subject.setSubjectName(rs.getString("subjectName"));
			subject.setSubjectTime(rs.getInt("subjectTime"));
			subject.setCreatedate(rs.getString("createdate"));
			subject.setUpdatedate(rs.getString("updatedate"));
		}
		return subject;
	}

	
	//5)과목 전체 row
	public int selectSubjectCnt() throws Exception {
	//검색을 하거나, 특정 where절이 있으면 입력값이 필요할 수 있다.
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM subject"; 
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("COUNT(*)");
		}
		
		return row;
	}
	
	//6)과목 목록만 가져오기
	public ArrayList<Subject> selectSubjectName() throws Exception{
		ArrayList<Subject> result = new ArrayList<Subject>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql="SELECT DISTINCT  subject_no subjectNo, subject_name subjectName FROM subject";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
			Subject s = new Subject();
			s.setSubjectNo(rs.getInt("subjectNo"));
			s.setSubjectName(rs.getString("subjectName"));
			result.add(s);
		}
		
		return result;
	}
	
}
