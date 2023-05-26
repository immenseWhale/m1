package dao;
import java.sql.*;
import java.util.*;
import util.*;

public class TeacherDao {
/*
--mariaDB 문자열을  집계하는 GROUP_CONCAT(문자컬럼) 집계함수가 있다
SELECT 
	t.teacher_no,	t.teacher_id, 
	t.teacher_name, ts.subject_no, 
	GROUP_CONCAT(s.subject_name)
FROM 	teacher t 
	INNER JOIN teacher_subject ts
	ON t.teacher_no = ts.teacher_no
			INNER JOIN subject s
			ON ts.subject_no = s.subject_no;
GROUP BY t.teacher_no, t.teacher_id, t.teacher_name
LIMIT 0,10;
-- good/구원이/자바,C# -> TeacherDao.selectTeacerListByPage()

--> 교과목이 연결 안된 강사는 안 나온다. left join으로 바꾼다.
SELECT 
    t.teacher_no AS teacherNo, 
	 t.teacher_id AS teacherId, 
	 t.teacher_name AS teacherName,
    ts.subject_no AS subjectNo, 
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
	
	
	
	
	
	
	
	
	
	
	
}



