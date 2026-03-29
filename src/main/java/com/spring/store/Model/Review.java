package com.spring.store.Model;

public class Review {
	private int reviewID;
	private int itemID;
	private String userID;
	private int score;
	private String review;
	private String time;
	
	public Review(String userID, int score, String review, String time) {
		this.userID = userID;
		this.score = score;
		this.review = review;
		this.time = time;
	}
	
	public int getReviewID() {
		return reviewID;
	}
	public void setReviewID(int reviewID) {
		this.reviewID = reviewID;
	}
	public int getItemID() {
		return itemID;
	}
	public void setItemID(int itemID) {
		this.itemID = itemID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
	
	
}
