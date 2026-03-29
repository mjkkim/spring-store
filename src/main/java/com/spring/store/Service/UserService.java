package com.spring.store.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.store.Dao.UserDao;
import com.spring.store.Model.Cart;
import com.spring.store.Model.Purchase;
import com.spring.store.Model.User;

@Service
public class UserService {

	@Autowired
	UserDao userDao;
	
	public boolean registerUser(String signupID, String signupPW, String signupEmail, String user_type) {
		return userDao.createUser(signupID, signupPW, signupEmail, user_type); 
	}
	
	public void deleteUser(String userID) {
		userDao.deleteUser(userID);
	}
	
	public User signinUser(String loginID, String loginPW) {
        return userDao.checkUser(loginID, loginPW);
    }
	
	public boolean checkUserIDExists(String username) {
        return userDao.checkUserIDExists(username);
    }
	
	public List<Cart> getCart(String userID) {
		return userDao.getCart(userID);
	}
	
	public boolean purchase(String userID, String json) {
		return userDao.purchase(userID, json);
	}
	
	public List<Purchase> getPurchase() {
		return userDao.getPurchase();
	}
}
