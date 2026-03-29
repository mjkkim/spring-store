<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>

<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<jsp:include page="../common/nav.jsp" />
    <!-- carousel -->
    <div class="container p-4">
        <div id="carouselFade" class="carousel slide carousel-fade">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="w-100" style="background-color: grey; height: 560px;">
                    	<img src="../../resources/img/temp2.jpg" alt="에러남" style="width: 100%; height: 100%; object-fit: cover;" >
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="w-100" style="background-color: grey; height: 560px;">
                    	<img src="../../resources/img/temp1.jpg" alt="에러남" style="width: 100%; height: 100%; object-fit: cover;" >
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselFade" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselFade" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>

    <!-- 상품목록표시 -->
    <div class="container p-4">
        <h4>상품 목록</h4>
        <hr />
        <div class="container p-0">
            <div class="row mb-3"> <!-- 동적 생성해야 하는 UI -->
                <c:choose>
                	<c:when test="${not empty items }">
                		<c:forEach var="item" items="${items}" varStatus="loopStatus">
		                	<div class="col-lg-3 col-md-6 mb-3">
			                    <div class="card w-100 ">
			                        <div class="card-img-top" style="height: 200px; background-image: url('data:image/jpeg;base64,${item.thumbnailBase64}'); background-size: contain;
										background-repeat: no-repeat;  background-position: center;"></div>
			                        <div class="card-body">
			                            <h5 class="card-title">${item.itemName }</h5>
			                            <p class="card-text">\ ${item.price }원</p>
			                            <form action="/info" method="get" class="mb-0">
			                                <input type="hidden" value="${item.itemID }" name="itemid"/>
			                                <input type="submit" class="btn btn-primary" value="상세정보">
			                            </form>
			                        </div>
			                    </div>
		                	</div>
		                	
		                	<c:if test="${loopStatus.index % 4 == 3 or loopStatus.last}">
		                		</div>
		                		<c:if test="${not loopStatus.last }">
		                			<div class="row mb-3">
		                		</c:if>
		                	</c:if>
		                </c:forEach>
                	</c:when>
                	<c:otherwise>
                		<div class="d-flex justify-content-center">
                		<h4>등록된 상품이 없습니다</h4>
                		</div>
                	</c:otherwise>
                </c:choose>
            </div>
        </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>
</html>
