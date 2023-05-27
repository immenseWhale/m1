package dao;
import java.sql.*;
import java.util.*;
import vo.*;
import util.*;

public class TeacherDao {
/*
--mariaDB 문자열을  집계하는 GROUP_CONCAT(문자컬럼) 집계함수가 있다
SELECT 
	t.teacher_no,	t.teacher_id, 
	t.teacher_name, ts.teacher_no, 
	GROUP_CONCAT(s.teacher_name)
FROM 	teacher t 
	INNER JOIN teacher_teacher ts
	ON t.teacher_no = ts.teacher_no
			INNER JOIN teacher s
			ON ts.teacher_no = s.teacher_no;
GROUP BY t.teacher_no, t.teacher_id, t.teacher_name
LIMIT 0,10;
-- good/구원이/자바,C# -> TeacherDao.selectTeacerListByPage()

--> 교과목이 연결 안된 강사는 안 나온다. left join으로 바꾼다.
SELECT 
    t.teacher_no AS teacherNo, t.teacher_id AS teacherId, 
    t.teacher_name AS teacherName, ts.subject_no AS subjectNo, 
	 GROUP_CONCAT(s.subject_name) AS subjects
FROM 
	teacher t
	LEFT JOIN 
	teacher_subject ts 
	ON t.teacher_no = ts.teacher_no
		LEFT JOIN 
		subject s 
		ON ts.subject_no = s.subject_no
GROUP BY
t.teacher_no, t.teacher_id, t.teacher_name
LIMIT ?, ?;


*/
	public ArrayList<HashMap<String, Object>> selectTeacherListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String mainSql = "SELECT  t.teacher_no teacherNo, t.teacher_id teacherId, t.teacher_name teacherName, ts.subject_no subjectNo, GROUP_CONCAT(s.subject_name) subjects FROM teacher t LEFT JOIN  teacher_subject ts ON t.teacher_no = ts.teacher_no LEFT JOIN subject s ON ts.subject_no = s.subject_no GROUP BY t.teacher_no, t.teacher_id, t.teacher_name LIMIT ?, ?";
		PreparedStatement mainStmt = conn.prepareStatement(mainSql);
		//페이징 처리를 위한 SQL 쿼리문에서의 인덱스는 0부터 시작하므로 beginRow를 1을 빼서 0부터 시작하도록 설정
		mainStmt.setInt(1, beginRow-1);
		mainStmt.setInt(2, rowPerPage);
		
		ResultSet mainRs = mainStmt.executeQuery();
		
		while(mainRs.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("teacherNo", mainRs.getInt("teacherNo"));
			m.put("teacherId", mainRs.getString("teacherId"));
			m.put("teacherName", mainRs.getString("teacherName"));
			m.put("subjectNo", mainRs.getInt("subjectNo"));
			m.put("subjects", mainRs.getString("subjects"));
			
			list.add(m);
		}
		System.out.println(list+ "<--ArrayList-- TeacherDao.selectTeacherListByPage");
		return list;
	}
	
//페이징을 위한 총 행 구하기
	public int selectTeacherCnt () throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM teacher";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("COUNT(*)");
		}
		return row;
	}
	
	
//강사 1명 상세 보기
	public Teacher selectTeacherOne(int teacherNo)  throws Exception {
		Teacher teacher = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String oneSql = "SELECT teacher_no teacherNo, teacher_id teacherId, teacher_name teacherName, teacher_history teacherHistory, createdate, updatedate FROM teacher WHERE teacher_no=?";
		PreparedStatement stmt = conn.prepareStatement(oneSql);
		stmt.setInt(1, teacherNo);
		ResultSet rs = stmt.executeQuery();
		
		//어차피 한개의 결과만 나오기 때문에 배열이 아닌 단일 값으로 가져오겠다.
		if (rs.next()){
			teacher = new Teacher();	
			teacher.setTeacherNo(rs.getInt("teacherNo"));
			teacher.setTeacherId(rs.getString("teacherId"));
			teacher.setTeacherName(rs.getString("teacherName"));
			teacher.setTeacherHistory(rs.getString("teacherHistory"));;
			teacher.setCreatedate(rs.getString("createdate"));
			teacher.setUpdatedate(rs.getString("updatedate"));
		}
		return teacher;
	}
	
//수정
	public int updateTeacher(Teacher teacher) throws Exception {
		int result = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		String modSql = "UPDATE teacher SET teacher_id=?, teacher_name=?, teacher_history=?, updatedate=NOW() WHERE teacher_no=?";
		PreparedStatement modStmt = conn.prepareStatement(modSql);
		modStmt.setString(1, teacher.getTeacherId());
		modStmt.setString(2, teacher.getTeacherName());
		modStmt.setString(3, teacher.getTeacherHistory());
		modStmt.setInt(4, teacher.getTeacherNo());
		result = modStmt.executeUpdate();
		if(result != 0) {
			System.out.println(result+ "행 수정되었습니다. <-- TeacherDao.updateTeacher");
		}		
		return result;
	}
	
//삭제
	public int deleteTeacher(int teacherNo) throws Exception {
		int result = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String delSql = "DELETE FROM teacher WHERE teacher_no = ?";
		PreparedStatement delStmt = conn.prepareStatement(delSql);
		delStmt.setInt(1, teacherNo);
		result = delStmt.executeUpdate();
		if(result != 0) {
			System.out.println(result+ "행 삭제되었습니다. <-- TeacherDao.deleteTeacher");
		}
		
		return result;
	}
	
//선생님 추가													
	public int insertTeacher(Teacher teacher) throws Exception {
		int result = 0;
/*
INSERT INTO teacher (teacher_id, teacher_name, teacher_history, createdate, updatedate)
VALUES ('test7', 'test7', '메모메모메모', NOW(), NOW());
*/
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		//teacher 테이블에 먼저 삽입
		String thSql ="INSERT INTO teacher(teacher_id, teacher_name, teacher_history, createdate, updatedate) VALUES (?, ?, ?, NOW(), NOW())";
		PreparedStatement addStmt = conn.prepareStatement(thSql);
		addStmt.setString(1, teacher.getTeacherId());
		addStmt.setString(2, teacher.getTeacherName());
		addStmt.setString(3, teacher.getTeacherHistory());
		System.out.println(addStmt + " <--stmt-- TeacherDao.insertTeacher");
		//teacher 테이블 PK 구한다
		
		result = addStmt.executeUpdate();
		if(result != 0) {
			System.out.println(result+ "행 추가되었습니다..  <-- TeacherDao.insertTeacher");
		}
		
		return result;
	}
	
	
	
	
	
	
	
	
	
	
}



