package util;

import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception{
										//예외처리 
		//DB 호출에 필요한 변수 생성
		Class.forName("org.mariadb.jdbc.Driver");
		String dbUrl = "jdbc:mariadb://127.0.0.1:3306/m1";
		String dbUser = "root";
		String dbPw = "java1234";	
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);	
		
		return conn;
	}
}
