package com.spring.store.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.store.Dao.HomeDao;
import com.spring.store.Model.Item;

@Service
public class HomeService {

	@Autowired
	HomeDao homeDao;

	public List<Item> getItem() {
		return homeDao.getItem();
		
	}
}
