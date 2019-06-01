<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<!DOCTYPE html>
<html>
<head>
<%
class movie {

	String name; //영화제목
	String score;   //영화평점
	String director; //감독
	String actor; //배우
	String url; //크롤링 url
	String img_url; //썸네일 url 
	
	
	
	public movie(String name, String score, String director, String actor,  String url, String img_url) {
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
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>

<%

	String name; //영화제목
	String score;   //영화평점
	String director; //감독
	String actor; //배우
	String url; //크롤링 url
	String img_url; //썸네일 url 
	String getUrl = request.getParameter("search");
	String crawling_url = "https://movie.naver.com/movie/search/result.nhn?query=" +getUrl+ "&section=all&ie=utf8";
	
	
	try{
	
	Document doc = Jsoup.connect(crawling_url).get();
	Elements search = doc.select("ul.search_list_1 li");
	int count = search.size();
	ArrayList<movie> search_list = new ArrayList<movie>();
	
	
	for(int i=0; i<count; i++){
		 name = doc.select("ul.search_list_1 li dt a").eq(i).text();    		
		score = doc.select("ul.search_list_1 li dd.point em.num").eq(i).text(); 
		director = doc.select("ul.search_list_1 li").eq(i).select("dd.etc").eq(1).select("a").eq(0).text(); 
		actor= doc.select("ul.search_list_1 li").eq(i).select("dd.etc").eq(1).select("a").eq(0).nextAll().text(); 
		img_url=doc.select("ul.search_list_1 li p.result_thumb a img").eq(i).attr("src");
		url="http://movie.naver.com/."+doc.select("ul.search_list_1 li p.result_thumb a").eq(i).attr("href");
		search_list.add(i, new movie(name,score,director,actor,url,img_url));
		
	}
	
	for(int j=0;j< search_list.size();j++){
		%>
		<form method="POST" action="input_db.jsp">
		 <table border="1">
		  	<tr>
		         <td rowspan="6">
		         <a href="<%=search_list.get(j).url %>"><!-- 크롤링 url-->
		            <img src="<%=search_list.get(j).img_url %>"> <!-- 이미지 -->
		            </a>
		         </td>   
		         <td>   
			        
			         <tr><td>제목: <%=search_list.get(j).name %></td></tr> <!-- 영화제목-->
			         <tr><td>평점: <%=search_list.get(j).score %></td></tr> <!-- 영화평점-->
			         <tr><td>감독: <%=search_list.get(j).director %></td></tr> <!-- 감독-->
			         <tr><td>배우: <%=search_list.get(j).actor %></td></tr> <!-- 배우-->
			         <tr><td><input type="submit" value="즐겨찾기 추가하기"  onclick="" ></td></tr> <!-- db 넣기-->
			         
		         </td>
		    </tr>
		    
		    <div id="input" style ="display:none">
    			    <input name = "name" value= "<%=search_list.get(j).name %>" >
    			    <input name = "score" value= "<%=search_list.get(j).score  %>" >
    			    <input name = "director" value= "<%=search_list.get(j).director %>" >
    			    <input name = "actor" value= "<%=search_list.get(j).actor     %>" >
    			    <input name = "url" value= "<%=search_list.get(j).url %>" >
    			    <input name = "img_url" value= "<%=search_list.get(j).img_url %>" >
    			    
    		</div>
			      
		    </table>
		    
		   </form>
		    <br>=======================================================================<br>
		<%
	
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	
%>

</body>
</html>