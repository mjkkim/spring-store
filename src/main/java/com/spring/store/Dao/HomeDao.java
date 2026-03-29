package com.spring.store.Dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.mysql.cj.protocol.Resultset;
import com.spring.store.Model.Item;

@Component
public class HomeDao {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	/* 메인 페이지에 아이템 표시 */
	public List<Item> getItem() {
		List<Item> itemList = new ArrayList<>();
		
		String sql = "SELECT itemID, thumbnail, itemName, price FROM item";
		
		return jdbcTemplate.query(sql, new RowMapper<Item>() {
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
}
