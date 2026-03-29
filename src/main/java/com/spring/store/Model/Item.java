package com.spring.store.Model;

import java.util.Base64;

public class Item {
	private int itemID;
	private String itemName;
	private int price;
	private String info;
	private byte[] img;
	private byte[] thumbnail;
	private int inventory;
	private int categoryID;
	private String categoryName;
	
	// base64
	private String imgBase64;
	private String thumbnailBase64;
	
	public Item(int itemID, byte[] thumbnail, String itemName, int price) {
		this.itemID = itemID;
		this.thumbnail = thumbnail;
		this.itemName = itemName;
		this.price = price;
		this.thumbnailBase64 = Base64.getEncoder().encodeToString(thumbnail);
	}
	
	public Item(int itemID, String itemName, int price, String info, byte[] img, int inventory, int categoryID, String categoryName) {
		this.itemID = itemID;
		this.itemName = itemName;
		this.price = price;
		this.info = info;
		this.img = img;
		this.inventory = inventory;
		this.categoryID = categoryID;
		this.categoryName = categoryName;
		
		this.imgBase64 = Base64.getEncoder().encodeToString(img);
	}

	/* Getter & Setter */
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

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public byte[] getImg() {
		return img;
	}

	public void setImg(byte[] img) {
		this.img = img;
	}

	public byte[] getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(byte[] thumbnail) {
		this.thumbnail = thumbnail;
	}

	public int getInventory() {
		return inventory;
	}

	public void setInventory(int inventory) {
		this.inventory = inventory;
	}

	public int getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(int categoryID) {
		this.categoryID = categoryID;
	}

	public String getImgBase64() {
		return imgBase64;
	}

	public void setImgBase64(String imgBase64) {
		this.imgBase64 = imgBase64;
	}

	public String getThumbnailBase64() {
		return thumbnailBase64;
	}

	public void setThumbnailBase64(String thumbnailBase64) {
		this.thumbnailBase64 = thumbnailBase64;
	}	
	
	public String getCategoryName() {
		return categoryName;
	}
	
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
}
