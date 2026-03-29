package com.spring.store.Controller;

import java.io.IOException;
import java.util.Base64;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.store.Model.Category;
import com.spring.store.Model.Item;
import com.spring.store.Model.Review;
import com.spring.store.Service.ItemService;

@Controller
public class ItemController {

	@Autowired
	ItemService itemService;
	
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

	/* 상품 상세페이지 표시 */
	@GetMapping("/info")
	public String Info(@RequestParam("itemid") int itemid, Model model) {
		Item item = itemService.itemInfo(itemid);
		List<Review> review = itemService.getReview(itemid);
		
		model.addAttribute("imgBase64", item.getImgBase64());
		model.addAttribute("itemid", item.getItemID());
		model.addAttribute("itemName", item.getItemName());
		model.addAttribute("price", item.getPrice());
		model.addAttribute("categoryID", item.getCategoryName());
		model.addAttribute("item_info", item.getInfo());
		model.addAttribute("inventory", item.getInventory());
		
		// Review 설정
		model.addAttribute("reviews", review);
		
		// itemID 설정
		model.addAttribute("itemID", item.getItemID());
		
		return "item/info";
	}
	
	/* 검색 화면 표시 */
	@GetMapping("/search")
	public String Search(@RequestParam("q") String query, Model model) {
		List<Item> rs = itemService.srcItem(query);
		
		model.addAttribute("items", rs);
		
		return "item/search";
	}
	
	/* 리뷰 삽입 */
	@GetMapping("/insertReview")
	public String InsertReview(
			@RequestParam("userid") String userID,
			@RequestParam("itemid") int itemID,
			@RequestParam("review") String review,
			@RequestParam("score") int score, 
			Model model) {
	
		if(itemService.InsertReview(userID, itemID, review, score)) {
			return "redirect:/info?itemid="+itemID;
		} else {
			// 에러 나는 상황은 테이블 제약조건 걸리는 상황밖에 없는 듯
			return "redirect:/info?itemid="+itemID;
		}
	}
	
	/* 신규 아이템 등록 화면 표시. 카테고리는 DB에서 가져와 표시 */
	@GetMapping("/newitem")
	public String NewItem(Model model) {
		List<Category> category = itemService.getCategory();
		
		model.addAttribute("category", category);
		
		return "item/newItem";
	}
	
	/* DB에 신규 item 삽입 */
	@PostMapping("/insertNewItem")
	public String InsertNewItem(
			@RequestParam("itemName") String itemName,
            @RequestParam("category") int categoryId,
            @RequestParam("price") int price,
            @RequestParam("info") String info,
            @RequestParam("inventory") int inventory,
            @RequestParam("thumbnail") MultipartFile thumbnail,
            @RequestParam("img") MultipartFile img) {
		
		try {
            byte[] thumbnailBytes = thumbnail.getBytes();
            byte[] imgBytes = img.getBytes();
            
            boolean success = itemService.insertNewItem(itemName, price, info, imgBytes, thumbnailBytes, inventory, categoryId);
            
            if(success) {
            	// 완료
            	return "redirect:/";
            } else {
            	// 실패
            	return "redirect:/";
            }

        } catch (IOException e) {
            e.printStackTrace();
            
            return "redirect:/";
        }
	}
	
	/* 장바구니에 아이템 삽입 */
	@PostMapping("/addToCart")
	public String addToCart(
			@RequestParam("itemID") int itemid,
			@RequestParam("userID") String userid,
			@RequestParam("quantity") int quantity,
			@RequestParam("purchase-type") String type) {
		
		if(type.equals("cart")) {
			itemService.addToCart(itemid, userid, quantity);
			return "redirect:/mypage?userID=" + userid;
		} else {
			itemService.addToCart(itemid, userid, quantity);
			return "redirect:/purchase?userID=" + userid;
		}
	}
	
	/* 장바구니에서 아이템 제거 */
	@GetMapping("/removeItem")
	@ResponseBody
	public String removeItem(
			@RequestParam("itemID") int itemid,
			@RequestParam("userID") String userid) {
		
		itemService.removeToCart(itemid, userid);
		
		return "success";
	}
	
}
