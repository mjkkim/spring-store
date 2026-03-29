package com.spring.store.Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.databind.ObjectMapper;

import com.spring.store.Model.Cart;
import com.spring.store.Model.Purchase;
import com.spring.store.Model.User;
import com.spring.store.Service.UserService;

@Controller
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	// 의존성 주입
	@Autowired
	UserService userService;
	
	/* 로그인 페이지로 이동 */
	@GetMapping("/signin")
	public String SigninForm() {
		
		return "user/signin";
	}
	
	/* 회원가입 페이지로 이동 */
	@GetMapping("/signup")
	public String SignupForm() {
		
		return "user/signup";
	}
	
	
	/* 로그아웃 처리 */
	@GetMapping("/signout")
	public String Signout(HttpSession session) {
		
		session.invalidate();

	    return "redirect:/";
	}
	
	
	/* 로그인 처리 */
	@PostMapping("/signin")
	public String ProcessSigninForm(
			@RequestParam("loginID") String loginID,
			@RequestParam("loginPW") String loginPW,
			HttpSession session) {
		
		User user = userService.signinUser(loginID, loginPW);
		
		if (user != null) {
	        session.setAttribute("userID", user.getUserID());
	        session.setAttribute("usertype", user.getUsertype());

	        return "redirect:/";
	    } else {
	        return "user/signin";
	    }
	}

	/* Ajax, 아이디 중복 체크 */
	@RequestMapping(value = "/checkUserID", produces = "application/text; charset=utf8")
	@ResponseBody
	public String checkUserID(@RequestParam("signupid") String signupid) {
	    boolean exists = userService.checkUserIDExists(signupid);
	    
	    if (exists) {
	        return "이미 사용중인 아이디입니다.";
	    } else {
	        return "사용 가능한 아이디입니다.";
	    }
	}
	
	/* 회원가입 처리 */
	@PostMapping("/signup")
	public String ProcessSignupForm(
			@RequestParam("signupID") String signupID,
			@RequestParam("signupPW") String signupPW,
			@RequestParam("signupEmail") String signupEmail,
			@RequestParam("user-type") String user_type) {
		
		boolean registerSuccess = userService.registerUser(signupID, signupPW, signupEmail, user_type);
		
		if(registerSuccess) {
			return "redirect:/signin";
		} else {
			// 에러창 나올듯
			return null;
		}
	}
	
	/* 회원 탈퇴 처리 */ 
	@GetMapping("/deleteUser")
	public String deleteUser(@RequestParam("userID") String userID) {
		userService.deleteUser(userID);
		return "redirect:/";
	}
	
	/* 마이페이지 */
	@GetMapping("/mypage")
	public String Mypage(@RequestParam("userID") String userID, Model model) {
		
		if(userID.equals("admin")) {
			List<Purchase> purchase = userService.getPurchase();
			model.addAttribute("purchaseList", purchase);
		} else {
			List<Cart> cart = userService.getCart(userID);
			model.addAttribute("cartList", cart);
		}
		
		return "user/mypage";
	}
	
	/* 구매 화면 표시 */
	@GetMapping("/purchase")
	public String purchase(@RequestParam("userID") String userID, Model model) {
		
		List<Cart> cart = userService.getCart(userID);
		model.addAttribute("cartList", cart);
		
		return "user/purchase";
	}
	
	/* 실제 구매 처리 */
	@PostMapping("/purchaseProcess")
	public String purchaseProcess(@RequestParam("userID") String userID, Model model) {
		
		List<Cart> cart = userService.getCart(userID);
		String json = convertToJson(cart);
		
		boolean success = userService.purchase(userID, json);
		
		return "fo/purchase_success";
	}
	
	public static String convertToJson(List<Cart> cart) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.writeValueAsString(cart);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
	
}
