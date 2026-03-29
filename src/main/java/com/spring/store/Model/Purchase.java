package com.spring.store.Model;

public class Purchase {
	private int purchaseID;
	private String userID;
	private String time;
	private String purchaseDetails;
	
	public Purchase(int purchaseID, String userID, String time, String purchaseDetails) {
		this.purchaseID = purchaseID;
		this.userID = userID;
		this.time = time;
		this.purchaseDetails = purchaseDetails;
	}

	public int getPurchaseID() {
		return purchaseID;
	}

	public void setPurchaseID(int purchaseID) {
		this.purchaseID = purchaseID;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getPurchaseDetails() {
		return purchaseDetails;
	}

	public void setPurchaseDetails(String purchaseDetails) {
		this.purchaseDetails = purchaseDetails;
	}
	
	
}
