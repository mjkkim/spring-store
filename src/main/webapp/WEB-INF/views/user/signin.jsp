<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>

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
        <div class="d-flex justify-content-center mb-3">
            <h3>로그인</h3>
        </div>
       
        <form action="signin" method="post" id="signin">
            <div class="mb-3">
              <label for="loginID" class="form-label">아이디</label>
              <input type="text" class="form-control" name="loginID" id="loginID" aria-describedby="idHelp" autocomplete="off" placeholder="ID" required>
              <div id="idHelp" class="form-text"><span>회원이 아니신가요? <a href="/signup">회원가입</a></span><br /></div>
            </div>

            <div class="mb-3">
              <label for="loginPW" class="form-label">비밀번호</label>
              <input type="password" class="form-control" name="loginPW" id="loginPW" aria-describedby="pwHelp" placeholder="PW" required>
              <div id="pwHelp" class="form-text"><span>비밀번호를 잊으셨나요? 비밀번호 찾기 (안만들었음)</span></div>
            </div>
            <button type="submit" class="btn btn-primary">로그인</button>
          </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
    crossorigin="anonymous"></script>
</body>
</html>
