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
	
	<div class="container mb-3">
		<h3>구매</h3>
	</div>
	
	<div class="container">
        <div class="mb-4">
                <div class="card mb-3">
                    <div class="card-header">
                        구매목록
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
						                </div>
						            </li>
						        </c:forEach>
						    </c:when>
						    <c:otherwise>
						        <li class="list-group-item">에러</li>
						    </c:otherwise>
						</c:choose>
                    </ul>
                </div>
                <p id="totalPrice">총 가격 : ###원</p>
                <form action="/purchaseProcess" method="POST" id="buy">
                	<input type="hidden" name="userID" value="${userID }"/>
                    <button type="button" class="btn btn-primary w-100 mb-2" onClick="check()">구매</button>
                </form>
            </div>
    </div>
    
    <script>
    	// 마이페이지에서 장바구니 표시할 때랑 같은 로직.
	    var price = document.querySelectorAll(".price");
		var totalPrice = 0;
		price.forEach(v=>{
			totalPrice += Number(v.innerHTML);
		})
		document.getElementById("totalPrice").innerHTML = "총 가격: " + totalPrice + "원";
		
		// 구매 전에 확인
		function check() {
			if(confirm("결제취소 기능 안 만들어서 취소 안됨")) {
				document.getElementById("buy").submit();
			}
		}
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>
</html>
