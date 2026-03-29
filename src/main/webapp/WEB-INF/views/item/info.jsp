<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Info</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<% 
    HttpSession session = request.getSession(false);
    boolean isUserLoggedIn = false;
    String isUserId = null;
    if (session != null) {
        isUserId = (String) session.getAttribute("userID");
        isUserLoggedIn = isUserId != null;
    }
    request.setAttribute("isUserLoggedIn", isUserLoggedIn);
    request.setAttribute("isUserId", isUserId);
    %>

	<jsp:include page="../common/nav.jsp" />
    <!-- carousel -->
    <div class="container">
    	<div class="card-img-top mb-5" style="height: 500px; background-image: url('data:image/jpeg;base64,${imgBase64}'); background-size: contain;
								background-repeat: no-repeat;  background-position: center;"></div>
    </div>

    <!-- 구매 -->
    <div class="container mb-5">
        <div class="row">
            <div class="col-lg-6 mb-3">
                <h4>${itemName }</h4>
                <h5>${price }</h5>
                <h6>${categoryID }</h6>
            </div>
            <div class="col-lg-6 mb-3">
                <c:choose>
                	<c:when test="${isUserId != 'admin' }">
                	<form action="/addToCart" class="w-100" method="POST" id="purchase">
	                	<input type="hidden" value="${itemid }" name="itemID"/>
	                	<input type="hidden" value="${isUserId }" name="userID"/>
	                    <div id="pqHelp" class="form-text">구매 개수 입력</div>
	                    <input type="text" class="form-control mb-2" name="quantity" id="quantity" aria-describedby="inventoryHelp" autocomplete="off" placeholder="재고" required>
	                    <div id="inventoryHelp" class="form-text mb-1"><span id="quantity-event" style="color:red;">구매 개수를 확인하세요</span><br /></div>
	                    <div id="loginHelp" class="form-text mb-1"><span id="login-event" style="color:red;"></span><br /></div>
	                    
	                    <!-- 재고 없으면 버튼 disabled 되어야 함 -->
	                    <button type="button" class="btn btn-outline-primary w-100 mb-2" id="set-cart" disabled="true" onclick="submitForm('cart')">장바구니 담기</button>
	                    <button type="button" class="btn btn-primary w-100 mb-2" id="buy" disabled="true" onclick="submitForm('buy')">바로 구매</button>
	                    <p id="inventory">재고 : ${inventory } 개</p>
	                    
	                    <input type="hidden" name="purchase-type" id="purchase-type" value="" />
	                </form>
                </c:when>
                </c:choose>
            </div>
        </div>
    </div>
	
    <!-- 상세정보 -->
    <div class="container mb-3">
        ${item_info}
    </div>

    <!-- 상품평 -->
    <div class="container">
        <h3>상품평</h3><hr />

        <div class="w-100">
            <c:forEach var="review" items="${reviews }" varStatus="loopReviews">
        		<div class="row mb-3">
		       		<div class="col-1"><span style="white-space: nowrap;">${review.userID }</span></div>
	               	<div class="col-2"><span style="white-space: nowrap;">
	               		<c:forEach begin="1" end="${review.score }">
	               			<span>★</span>
	               		</c:forEach>
	               	</span></div>
	               	<div class="col-7"><span>${review.review }</span></div>
	               	<div class="col-2"><span style="white-space: nowrap;">${review.time }</span></div>
                </div>
        	</c:forEach>
        </div>
        

        <div class="w-100">
            <form action="/insertReview", method="GET">
            	<input type="hidden" name="itemid" value="${itemID }" />
            	<input type="hidden" name="userid" value="${isUserId }" />
                <div class="form-floating mb-2">
                    <div id="taHelp" class="form-text">상품에 대한 리뷰를 남겨주세요!&nbsp(삭제 안됨)</div>
                    <textarea class="form-control" id="floatingTextarea2" style="height: 100px" aria-describedby="taHelp" required name="review"></textarea>
                </div>
                <div class="d-flex">
                    <select class="form-select form-select-sm, me-2" name="score" style="width: 150px" required>
					  <option value="1">★☆☆☆☆</option>
					  <option value="2">★★☆☆☆</option>
					  <option value="3">★★★☆☆</option>
					  <option value="4">★★★★☆</option>
					  <option value="5">★★★★★</option>
					</select>
                    <button type="submit" class="btn btn-outline-primary" id="review"><span id="reviewHelp">작성</span></button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
	    var buyButton = document.getElementById('buy');
	    var cartButton = document.getElementById('set-cart');
	    var purchaseQuantityInput = document.getElementById('quantity');
	    var text = document.getElementById('quantity-event'); 
	    
	    var reviewButton = document.getElementById('review');
	    
	    if(${isUserLoggedIn}) {
	    	document.getElementById("login-event").innerHTML = "";
	    } else {
	    	document.getElementById("login-event").innerHTML = "로그인 상태를 확인하세요";
	    }
	
	    purchaseQuantityInput.addEventListener("input", function(e) {
	        var quantity = parseInt(e.target.value);
	        if (!isNaN(quantity) && quantity <= ${inventory } && quantity > 0 && ${isUserLoggedIn}) {
	            buyButton.disabled = false;
	            cartButton.disabled = false;
	            text.innerHTML = '';
	        } else {
	            buyButton.disabled = true;
	            cartButton.disabled = true;
	            text.innerHTML = '구매 개수를 확인하세요';
	            text.style.color = 'red';
	        }
	    });
	    
	    if(${isUserLoggedIn}) {
	    	reviewButton.disabled = false;
	    } else {
	    	document.getElementById("reviewHelp").innerHTML = '회원만 가능합니다'
	    	reviewButton.disabled = true;
	    }
	    
	    function submitForm(purchaseType) {
	        document.getElementById("purchase-type").value = purchaseType;
	        document.getElementById("purchase").submit();
	    }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>
</html>
