package com.spring.store.Dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.spring.store.Model.Category;
import com.spring.store.Model.Item;
import com.spring.store.Model.Review;
import com.spring.store.Model.User;

@Component
public class ItemDao {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
		
	/* 제품 상세 페이지 정보 가져오기 */
	@SuppressWarnings("deprecation")
	public Item itemInfo(int itemid) {
	    String sql = "SELECT i.itemID, i.itemName, i.price, i.info, i.img, i.inventory, i.categoryID, c.categoryName FROM item i join category c on i.categoryID = c.categoryID where itemID = ?";

	    try {
	        return jdbcTemplate.queryForObject(sql, new Object[]{itemid}, (rs, rowNum) -> {
	        	int itemID = rs.getInt("itemid");
	            String itemName = rs.getString("itemName");
	            int price = rs.getInt("price");
	            String info = rs.getString("info");
	            byte[] img = rs.getBytes("img");
	            int inventory = rs.getInt("inventory");
	            int categoryID = rs.getInt("categoryID");
	            String categoryName = rs.getString("categoryName");

	            return new Item(itemID, itemName, price, info, img, inventory, categoryID, categoryName);
	        });
	    } catch (EmptyResultDataAccessException e) {
	        return null;
	    }
	}


	
	/* Info에서 표시되는 상품에 대한 Review 불러오기 */
	@SuppressWarnings("deprecation")
	public List<Review> getReview(int itemid) {
		String sql = "SELECT userID, score, review, time from review where itemID = ?";
		
		try {
			return jdbcTemplate.query(sql, new Object[] {itemid}, new RowMapper<Review>() {
				@Override
				public Review mapRow(ResultSet rs, int rowNum) throws SQLException {
					String userID = rs.getString("userID");
					int score = rs.getInt("score");
					String review = rs.getString("review");
					String time = rs.getString("time");
					
					return new Review(userID, score, review, time);
				}
			});
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	/* 검색, 반환하는 정보는 Home과 동일 */
	@SuppressWarnings("deprecation")
	public List<Item> srcItem(String query) {
		String sql = "SELECT itemID, thumbnail, itemName, price FROM item where itemName LIKE ?";
		
		return jdbcTemplate.query(sql, new Object[] {"%" + query + "%"} ,new RowMapper<Item>() {
			@Override
			public Item mapRow(ResultSet rs, int rowNum) throws SQLException {
				int itemID = rs.getInt("itemID");
                byte[] thumbnail = rs.getBytes("thumbnail");
                String itemName = rs.getString("itemName");
                int price = rs.getInt("price");
                
                return new Item(itemID, thumbnail, itemName, price);
			}
		});
	}


	/* review 테이블에 데이터 삽입 */
	public boolean InsertReview(String userid, int itemid, String review, int score) {
		String sql = "INSERT INTO review(itemID, userID, score, review) values(?, ?, ?, ?)";
		try {
			int result = jdbcTemplate.update(sql, itemid, userid, score, review);
			
			if(result == 1) {
				return true;
			} else {
				return false;
			}
		} catch(Exception e) {
			return false;
		}
	}
	
	/* cart 테이블에 데이터 삽입 */
	public void addToCart(int itemid, String userid, int quantity) {
		String sql = "INSERT INTO cart (itemID, userID, quantity) VALUES (?, ?, ?)";
		try {
	        jdbcTemplate.update(sql, itemid, userid, quantity);
	    } catch (DataIntegrityViolationException e) {
	        
	    }
	}
	
	/* cart에서 데이터 삭제 */
	public void removeToCart(int itemid, String userid) {
		String sql = "DELETE FROM cart WHERE itemID = ? AND userID = ?";
		try {
	        jdbcTemplate.update(sql, itemid, userid);
	    } catch (DataIntegrityViolationException e) {
	        
	    }
	}
	
	/* newItem화면에서 표시될 category 불러오기 */
	@SuppressWarnings("deprecation")
	public List<Category> getCategory() {
		String sql = "SELECT * FROM category";
		
		return jdbcTemplate.query(sql, new Object[] {}, new RowMapper<Category>() {
			@Override
			public Category mapRow(ResultSet rs, int rowNum) throws SQLException {
				int categoryID = rs.getInt("categoryID");
				String categoryName = rs.getString("categoryName");
				
				return new Category(categoryID, categoryName);
			}
		});
	}
	
	/* item 테이블에 신규 상품 등록 */
	public boolean insertNewItem(String itemName, int price, String info, byte[] imgBytes, byte[] thumbnailBytes, int inventory, int categoryId) {
		String sql = "INSERT INTO item(itemName, price, info, img, thumbnail, inventory, categoryID) values(?, ?, ?, ?, ?, ?, ?)";
		int result = jdbcTemplate.update(sql, itemName, price, info, imgBytes, thumbnailBytes, inventory, categoryId);
		
		if(result == 1) {
			return true;
		} else {
			return false;
		}
	}
}
