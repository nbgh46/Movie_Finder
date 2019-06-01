<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>

<%
	class movie {

		String name; //영화제목
		String score; //영화평점
		String director; //감독
		String actor; //배우
		String url; //크롤링 url
		String img_url; //썸네일 url 

		public movie(String name, String score, String director, String actor, String url, String img_url) {
			super();
			this.name = name;
			this.score = score;
			this.director = director;
			this.actor = actor;
			this.url = url;
			this.img_url = img_url;
		}

	}
%>

<%
	ArrayList<movie> favoriteList = new ArrayList<movie>();
	Connection conn = null; // null로 초기화 한다.

	PreparedStatement pstmt = null;
	ResultSet rs=null;
	try {

		String db_url = "jdbc:mysql://localhost:3306/movie?useUnicode=true&characterEncoding=EUC-KR&useSSL=false";
		String id = "root"; 
		String pw = "abcd1234"; 
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(db_url, id, pw);

		String sql = "SELECT * FROM movie"; // sql 쿼리
		pstmt = conn.prepareStatement(sql); // prepareStatement에서 해당 sql을 미리 컴파일한다.

		 rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.

		while (rs.next()) { // 결과를 한 행씩 돌아가면서 가져온다.

			favoriteList.add(new movie(rs.getString(1).toString(),rs.getString(2).toString(),
rs.getString(3).toString(),rs.getString(4).toString(),rs.getString(6).toString(),rs.getString(5).toString()));
%>
<%
	}

	} catch (Exception e) { // 예외가 발생하면 예외 상황을 처리한다.
		e.printStackTrace();

	} finally { // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)

		if (rs != null)
			try {
				rs.close();
			} catch (SQLException sqle) {
			} // Resultset 객체 해제

		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException sqle) {
			} // PreparedStatement 객체 해제

		if (conn != null)
			try {
				conn.close();
			} catch (SQLException sqle) {
			} // Connection 해제

	}
%>




<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<% 
	for(int j=0;j< favoriteList.size();j++){
		%>
		<form method="POST" action="input_db.jsp">
		 <table border="1">
		  	<tr>
		         <td rowspan="5">
		         <a href="<%=favoriteList.get(j).url %>"><!-- 크롤링 url-->
		            <img src="<%=favoriteList.get(j).img_url %>"> <!-- 이미지 -->
		            </a>
		         </td>   
		         <td>   
			        
			         <tr><td>제목: <%=favoriteList.get(j).name %></td></tr> <!-- 영화제목-->
			         <tr><td>평점: <%=favoriteList.get(j).score %></td></tr> <!-- 영화평점-->
			         <tr><td>감독: <%=favoriteList.get(j).director %></td></tr> <!-- 감독-->
			         <tr><td>배우: <%=favoriteList.get(j).actor %></td></tr> <!-- 배우-->
			         
		         </td>
		    </tr>
	  
		    </table>
		    
		   </form>
		    <br>=======================================================================<br>
		    
		    <%} %>
</body>
</html>