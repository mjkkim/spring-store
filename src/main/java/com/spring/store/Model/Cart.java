package com.spring.store.Model;

public class Cart {
	private int itemID;
	private String itemName;
	private int price;
	private int quantity;
	
	public Cart(int itemID, String itemName, int price, int quantity) {
		this.itemID = itemID;
		this.itemName = itemName;
		this.price = price;
		this.quantity = quantity;
	}
	
	public int getItemID() {
		return itemID;
	}
	public void setItemID(int itemID) {
		this.itemID = itemID;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	
}
