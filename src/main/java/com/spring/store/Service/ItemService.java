package com.spring.store.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.store.Dao.ItemDao;
import com.spring.store.Model.Category;
import com.spring.store.Model.Item;
import com.spring.store.Model.Review;

@Service
public class ItemService {
	
	@Autowired
	ItemDao itemDao;
	
	public Item itemInfo(int itemid) {
		return itemDao.itemInfo(itemid);
	}
	
	public List<Review> getReview(int itemid) {
		return itemDao.getReview(itemid);
	}
	
	public boolean InsertReview(String userid, int itemid, String review, int score) {
		return itemDao.InsertReview(userid, itemid, review, score);
	}
	
	public List<Item> srcItem(String query) {
		return itemDao.srcItem(query);
	}
	
	public void addToCart(int itemid, String userid, int quantity) {
		itemDao.addToCart(itemid, userid, quantity);
	}
	
	public void removeToCart(int itemid, String userid) {
		itemDao.removeToCart(itemid, userid);
	}
	
	public List<Category> getCategory() {
		return itemDao.getCategory();
	}
	
	public boolean insertNewItem(String itemName, int price, String info, byte[] imgBytes, byte[] thumbnailBytes, int inventory, int categoryId ) {
		return itemDao.insertNewItem(itemName, price, info, imgBytes, thumbnailBytes, inventory, categoryId);
	}
}
