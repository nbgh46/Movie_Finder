
 public class movie {

	String name; //영화제목
	String score;   //영화평점
	String director; //감독
	String actor; //배우
	String story; //줄거리
	String url; //크롤링 url
	String img_url; //썸네일 url 
	
	
	
	public movie(String name, String score, String director, String actor, String story, String url, String img_url) {
		super();
		this.name = name;
		this.score = score;
		this.director = director;
		this.actor = actor;
		this.story = story;
		this.url = url;
		this.img_url = img_url;
	}
	
	
	
}
