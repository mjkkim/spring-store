<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>

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
            <h3>회원가입</h3>
        </div>
        <form action="/signup" method="post" id="signupform">
            <div class="mb-3">
                <label for="signupID" class="form-label">아이디</label>
                <input type="text" class="form-control mb-1" name="signupID" id="signupID"
                    autocomplete="off" placeholder="ID" required>
                <button type="button" class="btn btn-secondary" onclick="checkUsername()">아이디 중복 확인</button>
                <div id="idHelp" class="form-text"><span>영문 소문자, 숫자만 포함하여 6자 이상, 12자 이하</span><br /></div>
				<div id="usernameCheckResult"></div>
            </div>

            <div class="mb-3">
                <label for="signupPW" class="form-label">비밀번호</label>
                <input type="password" class="form-control" name="signupPW" id="signupPW"
                    placeholder="PW" required>
                <div id="pwHelp" class="form-text"><span>대소문자 + 숫자 + 특수문자가 *각각 1개 이상 + 6~16자리 사이 </span><br /></div>
            </div>

            <div class="mb-3">
                <label for="checkPW" class="form-label">비밀번호 재 입력</label>
                <input type="password" class="form-control" name="checkPW" id="checkPW"
                    placeholder="PW" required>
                <div class="form-text"><span id="isSamePw-text"></span></div>
            </div>

            <div class="mb-3">
                <label for="signupEmail" class="form-label">이메일</label>
                <input type="text" class="form-control" name="signupEmail" id="signupEmail"
                    autocomplete="off" placeholder="Email" required>
            </div>
            
            <div class="mb-3">
            	<input type="radio" name="user-type" checked value="일반">일반</input>
            	<input type="radio" name="user-type" class="ms-3" value="판매">판매</input>
            </div>
            
            <button type="button" onClick="checkReg()" class="btn btn-primary" id="sub" disabled="true">회원가입</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
        
    <script>
	    var isSamePw = false; // 비밀번호 일치 여부
	    var isSignupIdAvailable = false; // 아이디 중복 여부
	    
	    // 비밀번호 제대로 확인 되어야 버튼 활성화
	    function buttonState() {
	        var button = document.getElementById('sub');
	        button.disabled = !(isSamePw && isSignupIdAvailable);
	    }
	    
	    // 표시 내용 변경
	    document.querySelector('#checkPW').addEventListener("input", e=>{
	    	var text = document.getElementById('isSamePw-text'); 
	        if(document.getElementById('signupPW').value == document.getElementById('checkPW').value) {
	            text.innerHTML = '비밀번호가 같습니다';
	            text.style.color = 'green';
	            isSamePw = true;
	        } else {
	        	text.innerHTML = '비밀번호가 다릅니다';
	        	text.style.color = 'red';
	        	isSamePw = false;
	        }
	        buttonState();
	    })
	    
	    // 아이디 중복체크. Ajax쓰는게 더 좋을 것 같음
	    function checkUsername() {
		    var signupid = document.getElementById("signupID").value;
		    var xhr = new XMLHttpRequest();
		    xhr.open("GET", "/checkUserID?signupid=" + signupid, true);
		    xhr.onreadystatechange = function() {
		        if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
		            document.getElementById("usernameCheckResult").innerHTML = this.responseText;
		            isSignupIdAvailable = (this.responseText === "사용 가능한 아이디입니다.");
		            buttonState();
		        }
		    }
		    xhr.send();
		}
	    
	    // 정규식 검사
	    const idReg = /^[a-z0-9]{6,12}$/;
	    const pwReg = /^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{6,16}$/;
	    const emailReg = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
	    
	    function checkReg() {
	    	var signupID = document.getElementById("signupID").value;
	    	var signupPW = document.getElementById("signupPW").value;
	    	var signupEmail = document.getElementById("signupEmail").value;
	    	
	    	if(idReg.test(signupID) && pwReg.test(signupPW) && emailReg.test(signupEmail)) {
	    		document.getElementById("signupform").submit();
	    	} else {
	    		alert("양식 맞추쇼");
	    	}
	    }
    </script>
</body>
</html>
