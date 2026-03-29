<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신규 상품 등록</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
    <!-- nav -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
            <div class="row w-100">
                <div class="col-2 col-lg-1 d-flex justify-content-center justify-content-lg-start">
                    <a class="navbar-brand" href="/">Store</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- login form -->
    <div class="container" style="padding: 30px 100px 30px 100px">
        <div class="d-flex justify-content-center">
            <h3>신규상품등록</h3>
        </div>
        <form action="/insertNewItem" method="post" enctype="multipart/form-data" id="insertform">
            <div class="mb-3">
              <label for="itemName" class="form-label">상품명</label>
              <input type="text" class="form-control" name="itemName" id="itemName" aria-describedby="itemNameHelp" autocomplete="off" placeholder="상품이름" required>
              <div id="itemNameHelp" class="form-text">상품의 이름을 입력하세요</span><br /></div>
            </div>
            
            <div class="mb-3">
            	<label for="category" class="form-label">상품 카테고리</label>
  				<select class="form-select" name="category" id="category">
  					<c:forEach var="category" items="${category }" varStatus="loopStatus">
  						<option value="${category.categoryID }">${category.categoryName }</option>
  					</c:forEach>
  					
  				</select>
  				<div id="categoryHelp" class="form-text">db에 저장되어 있는거 불러와야 됨</span><br /></div>
            </div>

            <div class="mb-3">
              <label for="price" class="form-label">상품 가격</label>
              <input type="text" class="form-control" name="price" id="price" aria-describedby="priceHelp" autocomplete="off" placeholder="가격" required>
              <div id="priceHelp" class="form-text">상품의 가격을 입력하세요</span><br /></div>
            </div>
            
            <div class="mb-3">
              <label for="info" class="form-label">상품 정보</label>
              <input type="text" class="form-control" name="info" id="info" aria-describedby="infoHelp" autocomplete="off" placeholder="임시" required>
              <div id="infoHelp" class="form-text">임시. 가능하면 네이버 에디터 같은거 쓰면 편하지 않을까했는데 그냥 이대로...</span><br /></div>
            </div>
            
            <div class="mb-3">
              <label for="inventory" class="form-label">재고</label>
              <input type="text" class="form-control" name="inventory" id="inventory" aria-describedby="inventoryHelp" autocomplete="off" placeholder="임시" required>
              <div id="inventoryHelp" class="form-text">재고 수량을 입력하세요</span><br /></div>
            </div>
            
            <div class="mb-3">
            	<label for="thumbnail" class="form-label">썸네일</label>
  				<input class="form-control" type="file" name="thumbnail" id="thumbnail" accept="image/jpeg, image/jpg, image/png">
  				<div id="thumbnailHelp" class="form-text">메인 화면에 표시될 썸네일, 200px x 200px 파일권장</span><br /></div>
            </div>
            
            <div class="mb-3">
            	<label for="img" class="form-label">상품이미지</label>
  				<input class="form-control" type="file" name="img" id="img" accept="image/jpeg, image/jpg, image/png">
  				<div id="thumbnailHelp" class="form-text">상품의 이미지</span><br /></div>
            </div>
            
            
            <button type="button" onClick="checkReg()" class="btn btn-primary w-100">신규 등록</button>
          </form>
    </div>

	<script>
		// 숫자만 들어가야 하는 곳이 있음
		const onlyNum = /^[1-9][0-9]*$/;
		
		function checkReg() {
			var price = document.getElementById("price").value;
			var inventory = document.getElementById("inventory").value;
			
			if(onlyNum.test(price) && onlyNum.test(inventory)) {
				document.getElementById("insertform").submit();
			} else {
				alert("가격이랑 재고 제대로 입력했는지 체크하쇼");
			}
		}
	</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
    crossorigin="anonymous"></script>
</body>
</html>
