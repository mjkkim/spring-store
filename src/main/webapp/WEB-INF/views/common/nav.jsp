<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>


<%
// 세션 확인
HttpSession session = request.getSession(false);
boolean isUserLoggedIn = false;
String isUserId = null;

if (session != null) {
    isUserId = (String) session.getAttribute("userID");
    isUserLoggedIn = isUserId != null;
}

request.setAttribute("isUserLoggedIn", isUserLoggedIn);
%>

<!-- nav -->
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <div class="row w-100">
            <div class="col-2 col-lg-1 d-flex justify-content-center justify-content-lg-start">
                <a class="navbar-brand" href="/">Store</a>
            </div>
            <div class="col-8 col-lg-10 d-flex justify-content-center">
                <form class="d-flex w-100" action="/search">
                    <input class="form-control me-2" type="search" placeholder="검색" aria-label="Search" name="q">
                    <button class="btn btn-outline-primary" type="submit">Search</button>
                </form>
            </div>
            <div class="col-2 col-lg-1 d-flex justify-content-center justify-content-lg-end">
                <c:choose>
				    <c:when test="${isUserLoggedIn}">
				        <!-- 로그인 상태일 때 표시할 내용 -->
				        <form action="/mypage" method="get">
				        	<input type="hidden" name="userID" value="<%= isUserId %>"/>
				            <button type="submit" class="btn btn-outline-primary" style="white-space: nowrap;">mypage</button>
				        </form>
				    </c:when>
				    <c:otherwise>
				        <!-- 로그아웃 상태일 때 표시할 내용 -->
				        <form action="/signin" method="get">
				            <button type="submit" class="btn btn-outline-primary" style="white-space: nowrap;">로그인</button>
				        </form>
				    </c:otherwise>
				</c:choose>
            </div>
        </div>
    </div>
</nav>