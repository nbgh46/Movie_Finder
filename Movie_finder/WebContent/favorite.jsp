<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>

<%
	class movie {

		String name; //��ȭ����
		String score; //��ȭ����
		String director; //����
		String actor; //���
		String url; //ũ�Ѹ� url
		String img_url; //����� url 

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
	Connection conn = null; // null�� �ʱ�ȭ �Ѵ�.

	PreparedStatement pstmt = null;
	ResultSet rs=null;
	try {

		String db_url = "jdbc:mysql://localhost:3306/movie?useUnicode=true&characterEncoding=EUC-KR&useSSL=false";
		String id = "root"; 
		String pw = "abcd1234"; 
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(db_url, id, pw);

		String sql = "SELECT * FROM movie"; // sql ����
		pstmt = conn.prepareStatement(sql); // prepareStatement���� �ش� sql�� �̸� �������Ѵ�.

		 rs = pstmt.executeQuery(); // ������ �����ϰ� ����� ResultSet ��ü�� ��´�.

		while (rs.next()) { // ����� �� �྿ ���ư��鼭 �����´�.

			favoriteList.add(new movie(rs.getString(1).toString(),rs.getString(2).toString(),
rs.getString(3).toString(),rs.getString(4).toString(),rs.getString(6).toString(),rs.getString(5).toString()));
%>
<%
	}

	} catch (Exception e) { // ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�.
		e.printStackTrace();

	} finally { // ������ ���� �Ǵ� ���п� ������� ����� �ڿ��� ���� �Ѵ�.  (�����߿�)

		if (rs != null)
			try {
				rs.close();
			} catch (SQLException sqle) {
			} // Resultset ��ü ����

		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException sqle) {
			} // PreparedStatement ��ü ����

		if (conn != null)
			try {
				conn.close();
			} catch (SQLException sqle) {
			} // Connection ����

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
		         <a href="<%=favoriteList.get(j).url %>"><!-- ũ�Ѹ� url-->
		            <img src="<%=favoriteList.get(j).img_url %>"> <!-- �̹��� -->
		            </a>
		         </td>   
		         <td>   
			        
			         <tr><td>����: <%=favoriteList.get(j).name %></td></tr> <!-- ��ȭ����-->
			         <tr><td>����: <%=favoriteList.get(j).score %></td></tr> <!-- ��ȭ����-->
			         <tr><td>����: <%=favoriteList.get(j).director %></td></tr> <!-- ����-->
			         <tr><td>���: <%=favoriteList.get(j).actor %></td></tr> <!-- ���-->
			         
		         </td>
		    </tr>
	  
		    </table>
		    
		   </form>
		    <br>=======================================================================<br>
		    
		    <%} %>
</body>
</html>