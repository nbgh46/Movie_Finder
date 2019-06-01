<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	 request.setCharacterEncoding("utf-8");  //Set encoding
	 String name   = request.getParameter("name");  
	 String score   = request.getParameter("score");  
	 String director   = request.getParameter("director");  
	 String actor   = request.getParameter("actor");  
	 String img_url   = request.getParameter("img_url");  
	 String url   = request.getParameter("url");  
	
	 
	 
	try {
//		String url = "jdbc:mysql://localhost:3306/bravovo";
		String db_url = "jdbc:mysql://localhost:3306/movie?useUnicode=true&characterEncoding=EUC-KR";
		String id = "root"; 
		String pw = "abcd1234"; 
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(db_url, id, pw);
		out.println("db 연결성공");
		
		//conn = DriverManager.getConnection(url, id, pw);
        String sql = "INSERT INTO movie(name, score, director,actor,img_url,url)  VALUES('"+name+"','"+score+"','"+director+"','"+actor+"','"+img_url+"','"+url+"')";               
	    pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		out.println("insert");		
		pstmt.close();
		conn.close();
		 }
		 catch(Exception e){
		  out.println( e );
		 }
	//	 response.sendRedirect("chart.jsp");
		%>
		<a href="index.jsp"><h2>메인화면으로 돌가아기</h2></a>

