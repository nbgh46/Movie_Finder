<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  JSP에서 jsoup을 사용하기 위해 import -->
<%@ page import="java.util.*" %>
<%@ page import = "java.sql.*" %>



<!DOCTYPE html>
<html>
<head>



<meta charset="EUC-KR">
<title>Insert title here</title>
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

<%


		%>


</head>
<body>
    <h1>영화 검색 프로그램</h1>
    <form action="search.jsp" method="POST">
        <input type="text" name="search"><input type="submit" value="검색">

    </form>
    
    <a href="favorite.jsp"><h2>즐겨찾기한 영화 보기</h2></a>
    
    <H2>영화순위</H2>
	<%  /*웹 크롤링으로 실시간 영화 순위 가져오기 */
		String name;
    	String score;
    	String director;
    	String actor;
    	String img_url;
		String source_url = "https://movie.naver.com/movie/running/current.nhn";
		String url;
		ArrayList<movie> movieArrayList = new ArrayList<movie>();
		
    	try{
    		for(int i=0; i<10 ; i++){
    		Document doc = Jsoup.connect(source_url).get();
    		 name = doc.select("div#container div#content div.article " 
    				 +"div.obj_section div.lst_wrap ul.lst_detail_t1 li dl.lst_dsc dt.tit a").eq(i).text();    		
    		score = doc.select("div#container div#content div.article " 
   				 +"div.obj_section div.lst_wrap ul.lst_detail_t1 li dl.lst_dsc dd.star dl.info_star dd div.star_t1 span.num").eq(i).text(); 
    		director = doc.select("div#container div#content div.article " 
      				 +"div.obj_section div.lst_wrap ul.lst_detail_t1 li dd dl.info_txt1 dt.tit_t2").next().eq(i).text(); 
       		actor= doc.select("div#container div#content div.article " 
     				 +"div.obj_section div.lst_wrap ul.lst_detail_t1 li dd dl.info_txt1 dt.tit_t3").next().eq(i).text(); 
       		img_url=doc.select("div#container div#content div.article "  
   				 +"div.obj_section div.lst_wrap ul.lst_detail_t1 li div.thumb a img").eq(i).attr("src");
       		url="http://movie.naver.com/"+doc.select("div#container div#content div.article " 
      				 +"div.obj_section div.lst_wrap ul.lst_detail_t1 li div.thumb a").eq(i).attr("href");
       		movieArrayList.add(i, new movie(name,score,director,actor,url,img_url));
          			/*
    		out.println("영화제목:"+name+"<br>");
    		out.println("평점:"+score+"<br>");
    		out.println("감독:"+director+"<br>");
    		out.println("배우:"+actor+"<br>");
    		out.println("이미지url:"+img_url+"<br>");
    		out.println("url:"+url+"<br>");
    		*/
    	}
    		for(int j=0;j< movieArrayList.size();j++){
    			%>
    			<form method="POST" action="input_db.jsp">
    			 <table border="1" >
    			  	<tr>
    			         <td rowspan="7">
    			         <a href="<%=movieArrayList.get(j).url %>"><!-- 크롤링 url-->
    			            <img src="<%=movieArrayList.get(j).img_url %>"> <!-- 이미지 -->
    			            </a>
    			         </td>   
    			         <td>   
	    			          <tr><td>순위:<%=j+1 %></td></tr>
	    			         <tr><td><%=movieArrayList.get(j).name %></td></tr> <!-- 영화제목-->
	    			         <tr><td><%=movieArrayList.get(j).score %></td></tr> <!-- 영화평점-->
	    			         <tr><td><%=movieArrayList.get(j).director %></td></tr> <!-- 감독-->
	    			         <tr><td><%=movieArrayList.get(j).actor %></td></tr> <!-- 배우-->
	    			
	    			         <tr><td><input type="submit" value="즐겨찾기 추가하기"  onclick="" ></td></tr> <!-- db 넣기-->
    			         </td>
    			    </tr>
    				      
    			    </table>
    			    
    			    <div id="input" style ="display:none">
    			    <input name = "name" value= "<%=movieArrayList.get(j).name %>" >
    			    <input name = "score" value= "<%=movieArrayList.get(j).score %>" >
    			    <input name = "director" value= "<%=movieArrayList.get(j).director %>" >
    			    <input name = "actor" value= "<%=movieArrayList.get(j).actor%>" >
    			    <input name = "url" value= "<%=movieArrayList.get(j).url %>" >
    			    <input name = "img_url" value= "<%=movieArrayList.get(j).img_url %>" >
    			    
    			    </div>
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