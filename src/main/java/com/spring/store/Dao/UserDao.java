package com.spring.store.Dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.spring.store.Model.Cart;
import com.spring.store.Model.Purchase;
import com.spring.store.Model.User;

@Component
public class UserDao {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder; // 비밀번호 암호화
	
	/* 신규 회원 등록 */
	public boolean createUser(String signupID, String signupPW, String signupEmail, String user_type) {
		String sql = "INSERT INTO user values(?, ?, ?, ?)";
		String hashedPassword = passwordEncoder.encode(signupPW);
		int result = 0;
		if(signupID.equals("admin")) {
			result = jdbcTemplate.update(sql, signupID, hashedPassword, signupEmail, "관리");
		} else {
			result = jdbcTemplate.update(sql, signupID, hashedPassword, signupEmail, user_type);
		}
		
		if(result == 1) {
			return true;
		}
		else return false;
	}
	
	/* 로그인 처리, 아이디랑 비밀번호 같은지 체크 */
	public User checkUser(String loginID, String loginPW) {
	    String sql = "SELECT userPW, userID, usertype FROM user WHERE userID = ?";

	    try {
	        User user = jdbcTemplate.queryForObject(sql, new RowMapper<User>() {
	            @Override
	            public User mapRow(ResultSet rs, int rowNum) throws SQLException {
	            	// 편의상 admin계정은 DB상에서 바로 INSERT를 해 줬는데, 그 덕에 비밀번호 암호화가 안되어 있어서 별도 처리
	                if(loginID.equals("admin")) {
	                	if(rs.getString("userPW").equals("admin")) {
		                    User user = new User();
		                    user.setUserID(rs.getString("userID"));
		                    user.setUsertype(rs.getString("usertype"));
		                    return user;
		                } else {
		                    return null;
		                }
	                } else {
	                	String storedPassword = rs.getString("userPW");
		                if(passwordEncoder.matches(loginPW, storedPassword)) {
		                    User user = new User();
		                    user.setUserID(rs.getString("userID"));
		                    user.setUsertype(rs.getString("usertype"));
		                    return user;
		                } else {
		                    return null;
		                }
	                }
	            }
	        }, loginID);

	        return user;
	    } catch (EmptyResultDataAccessException e) {
	        return null;
	    }
	}
	
	/* 아이디 중복 체크 */
	public boolean checkUserIDExists(String username) {
        String sql = "SELECT COUNT(*) FROM user WHERE userID = ?";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{username}, Integer.class);
        return count != null && count > 0; // 중복되면 true
    }
	
	/* 특정 사용자의 장바구니 정보 가져오기 */
	@SuppressWarnings("deprecation")
	public List<Cart> getCart(String userID) {
		String sql = "SELECT c.itemID, i.itemName, i.price, c.quantity FROM cart c JOIN item i ON c.itemID = i.itemID WHERE c.userID = ?";
		
		return jdbcTemplate.query(sql, new Object[]{userID}, new RowMapper<Cart>() {
            @Override
            public Cart mapRow(ResultSet rs, int rowNum) throws SQLException {
                int itemID = rs.getInt("itemID");
                String itemName = rs.getString("itemName");
                int price = rs.getInt("price");
                int quantity = rs.getInt("quantity");

                return new Cart(itemID, itemName, price, quantity);
            }
        });
	}
	
	/* 회원 탈퇴 */
	public void deleteUser(String userID) {
		String sql = "DELETE FROM user WHERE userID = ?";
        jdbcTemplate.update(sql, userID);
	}
	
	/* 구매 테이블에 데이터 추가 */
	public boolean purchase(String userID, String json) {
		String sql = "INSERT INTO purchase(userID, purchaseDetails) VALUE (?, ?)";
		int result = jdbcTemplate.update(sql, userID, json);
		
		String deleteCart = "DELETE FROM cart where userID = ?";
		jdbcTemplate.update(deleteCart, userID);
		
		if(result == 1) {
			return true;
		}
		else return false;
	}
	
	/* admin계정 전용 - 구매 내역 전부 불러오기 */
	@SuppressWarnings("deprecation")
	public List<Purchase> getPurchase() {
		String sql = "SELECT * FROM purchase";
		
		return jdbcTemplate.query(sql, new Object[]{}, new RowMapper<Purchase>() {
            @Override
            public Purchase mapRow(ResultSet rs, int rowNum) throws SQLException {
                int purchaseID = rs.getInt("purchaseID");
                String userID = rs.getString("userID");
                String time = rs.getString("time");
                String purchaseDetails = rs.getString("purchaseDetails");

                return new Purchase(purchaseID, userID, time, purchaseDetails);
            }
        });
	}
}