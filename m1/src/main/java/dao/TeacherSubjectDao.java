package dao;
import java.sql.*;
import java.util.*;
import vo.*;
import util.*;

public class TeacherSubjectDao {
	
	public int insertTeacherSubject(int teacherNo, int subjectNo) throws Exception {
		/*
INSERT INTO teacher_subject (teacher_no, subject_no, createdate, updatedate)
VALUES (LAST_INSERT_ID(), 2, NOW(), NOW());
		 * */
		int result = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql ="INSERT INTO teacher_subject (teacher_no, subject_no, createdate, updatedate)\r\n"
				+ "VALUES (?, ?, NOW(), NOW());";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, teacherNo);
		stmt.setInt(2, subjectNo);
		System.out.println(stmt + " <--stmt-- TeacherSubejctDao.insertTeacherSubject");
		
		result = stmt.executeUpdate();
		if(result != 0) {
			System.out.println(result+ "행 cnrk되었습니다. <-- TeacherSubejctDao.insertTeacherSubject");
		}
		
		return result;
	}

}
