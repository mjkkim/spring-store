<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>

<%
HttpSession session = request.getSession(false);
String isUserId = null;
String userType = null;

if (session != null) {
    isUserId = (String) session.getAttribute("userID");
    userType = (String) session.getAttribute("usertype");
}

request.setAttribute("userID", isUserId);
request.setAttribute("userType", userType);
%>

	<jsp:include page="../common/nav.jsp" />
	
	<div class="container">
		<p>${userID }님, 안녕하세요</p>
	</div>
	
	<c:choose>
		<c:when test="${userID == 'admin'}">
			<div class="container">
		        <div class="row">
		            <div class="col-md-8 mb-4">
		                <div class="card mb-3">
		                    <div class="card-header">
		                        구매 내역
		                    </div>
		                    <ul class="list-group list-group-flush" id="list-group">
		                    	<c:choose>
		                    		<c:when test="${not empty purchaseList }">
		                    			<c:forEach var="purchaseList" items="${purchaseList }">
		                    				<li class="list-group-item item-list" id="purchase-${purchaseList.purchaseID }">
								                <div class="row">
								                    <div class="col-2">${purchaseList.time}</div>
								                    <div class="col-2">${purchaseList.userID}</div>
								                    <div class="col-8">${purchaseList.purchaseDetails }</div>
								                </div>
								            </li>
		                    			</c:forEach>
		                    		</c:when>
		                    		<c:otherwise>
								        <li class="list-group-item">구매내역이 없습니다.</li>
								    </c:otherwise>
		                    	</c:choose>
		                    </ul>
		                </div>

		            </div>
		            <div class="col-md-4 mb-4">
		                <div class="card">
		                    <div class="card-header">
		                        유저 관리
		                    </div>
		                    <ul class="list-group list-group-flush">
		                        <li class="list-group-item"><a href="/signout">로그아웃</a></li>
		                    </ul>
		                </div>
		            </div>
		        </div>
		    </div>
		</c:when>
		<c:otherwise>
			<div class="container">
		        <div class="row">
		            <div class="col-md-8 mb-4">
		                <div class="card mb-3">
		                    <div class="card-header">
		                        장바구니
		                    </div>
		                    <ul class="list-group list-group-flush" id="list-group">
		                    	<c:choose>
								    <c:when test="${not empty cartList}">
								        <c:forEach var="cartItem" items="${cartList}">
								            <li class="list-group-item item-list" id="item-${cartItem.itemID }">
								                <div class="row">
								                    <div class="col-5">${cartItem.itemName}</div>
								                    <div class="col-2 price">${cartItem.price * cartItem.quantity}</div>
								                    <div class="col-2">구매 갯수 : ${cartItem.quantity}</div>
								                    <div class="col-2">
								                        <button onClick="removeToCart('${cartItem.itemID}', '${userID }')" id="removeToCart" class="btn btn-Primary">제거</button>
								                    </div>
								                </div>
								            </li>
								        </c:forEach>
								    </c:when>
								    <c:otherwise>
								        <li class="list-group-item">장바구니가 비어 있습니다.</li>
								    </c:otherwise>
								</c:choose>
		                    </ul>
		                </div>
		                <p id="totalPrice">총 가격 : ###원</p>
		                <form action="/purchase" method="GET">
		                	<input type="hidden" name="userID" value="${userID }"/>
		                    <button type="submit" class="btn btn-primary w-100 mb-2" id="buy" disabled="true">구매</button>
		                </form>
		            </div>
		            <div class="col-md-4 mb-4">
		                <div class="card">
		                    <div class="card-header">
		                        유저 관리
		                    </div>
		                    <ul class="list-group list-group-flush">
		                        <li class="list-group-item"><a href="/signout">로그아웃</a></li>
		                        <li class="list-group-item" id="newItem"><a href="/newitem">신규 상품 등록</a></li>
		                        <li class="list-group-item">
		                        	<form action="deleteUser" method="get" id="quit">
				                        <input type="hidden" value="${userID }" name="userID"/>
				                        <button type="button" class="btn btn-primary w-100" onClick="quit()">회원 탈퇴</button>
			                		</form>
		                        </li>
		                    </ul>
		                </div>
		            </div>
		        </div>
		    </div>
		</c:otherwise>
	</c:choose>
    
    <script>
    	// 총 가격 표시
	    var price = document.querySelectorAll(".price");
		var totalPrice = 0;
		price.forEach(v=>{
			totalPrice += Number(v.innerHTML);
		})
		document.getElementById("totalPrice").innerHTML = "총 가격: " + totalPrice + "원";
	
		// 신규 아이템 등록 버튼 표시
    	var newItemlist = document.getElementById('newItem');	
    	if("${userType}" == "일반") {
    		newItemlist.style.display = "none";
    	} else {
    		newItemlist.style.display = "block";
    	}
    	
    	// 장바구니에 아이템이 담겨 있을 때만 구매버튼 활성화
    	var cartItems = document.querySelectorAll(".item-list");
	    if (cartItems.length != 0) {
	        document.getElementById("buy").disabled = false;
	    } else {
	    	document.getElementById("buy").disabled = true;
	    }
    	
	    // 회원 탈퇴
    	function quit() {
    		if(confirm("해당 작업은 취소할 수 없습니다.\n정말 진행하시겠습니까?")) {
    			// 일단 Ajax로 로그아웃 먼저, 세션이 남아있으니까 회원탈퇴 이후에도 마이페이지 접근이 됨
    			var xhr = new XMLHttpRequest();
    		    xhr.open("GET", "/signout", true);
    		    xhr.onreadystatechange = function() {
    		        if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
    		            console.log("ok");
    		        }
    		    }
    		    xhr.send();
    		    
    			document.getElementById('quit').submit();
    		}
    	}
    	
	    // 장바구니에 있는 아이템 제거
    	function removeToCart(itemid, userid) {
    		var xhr = new XMLHttpRequest();
    		xhr.open("GET", "/removeItem?itemID=" + itemid + "&userID=" + userid, true);
    		xhr.onreadystatechange = function() {
		        if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
		            var itemElement = document.getElementById("item-" + itemid);
		            if (itemElement) {
		                itemElement.remove();
		                
		                updateCartStatus();
		                updateTotalPrice();
		            }
		        }
		    }
		    xhr.send();
    	}
	    
    	// 장바구니 비어있는지 체크
    	function updateCartStatus() {
    	    var cartItems = document.querySelectorAll(".item-list");
    	    if (cartItems.length === 0) {
    	        var cartList = document.getElementById("list-group");
    	        cartList.innerHTML = "<li class='list-group-item'>장바구니가 비어 있습니다.</li>";
    	        document.getElementById("buy").disabled = true;
    	    } else {
    	    	document.getElementById("buy").disabled = false;
    	    }
    	}
    	
    	// 총 가격 표시 업데이트
    	function updateTotalPrice() {
    		var price = document.querySelectorAll(".price");
    		var totalPrice = 0;
    		price.forEach(v=>{
    			totalPrice += Number(v.innerHTML);
    		})
    		document.getElementById("totalPrice").innerHTML = "총 가격: " + totalPrice + "원";
    	}
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>
</html>
