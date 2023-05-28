package dao;
import java.sql.*;
import java.util.*;
import vo.*;
import util.*;

public class TeacherSubjectDao {
	
	public int insertTeacherSubject(int teacherNo, int[] subjectNos) throws Exception {
		/*
INSERT INTO teacher_subject (teacher_no, subject_no, createdate, updatedate)
VALUES (LAST_INSERT_ID(), 2, NOW(), NOW());
		 * */
		System.out.println(teacherNo + "teacherNo. <-- TeacherSubjectDao.insertTeacherSubject");
		System.out.println(subjectNos + "teacherNo. <-- TeacherSubjectDao.insertTeacherSubject");

		int result = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql ="INSERT INTO teacher_subject (teacher_no, subject_no, createdate, updatedate)\r\n"
				+ "VALUES (?, ?, NOW(), NOW());";
		PreparedStatement stmt = conn.prepareStatement(sql);
		for (int subjectNo : subjectNos) {
			stmt.setInt(1, teacherNo);
			stmt.setInt(2, subjectNo);
			stmt.addBatch();  // 배치에 추가
		}
/* 배치(Batch): 배치는 한 번에 여러 개의 SQL 문을 한 번에 실행하는 메커니즘
*  PreparedStatement 객체의 addBatch() 메서드를 사용하여 
*  배치에 SQL 문을 추가할 수 있습니다. */
		
		int[] batchResult = stmt.executeBatch();  // 배치 실행
/* executeBatch() : 배치에 추가된 SQL 문을 한 번에 실행
 * 이 때, 데이터베이스는 배치에 추가된 SQL 문을 최적화하여 한 번에 처리하므로 성능이 향상
 * 실행 결과로 int 배열을 반환. 이 배열은 각 배치의 실행 결과를 나타냅니다. 
 * 일반적으로 배열의 각 요소는 해당 배치의 영향 받는 행(row)의 수 */

		
		for (int count : batchResult) {
			result += count;
			System.out.println(result + "<--batchResult--");
		}
/* batchResult 배열의 각 요소 값을 반복하여 전체 결과를 계산합니다. 
 * 각 요소는 해당 배치에서 영향 받는 행의 수를 나타내므로, 
 * 전체 결과는 각 배치의 영향 받는 행의 수의 합으로 나타납니다. */
		
		
		if (result != 0) {
			System.out.println(result + "행 삽입되었습니다. <-- TeacherSubjectDao.insertTeacherSubject");
		}
		return result;
		
	}






}


