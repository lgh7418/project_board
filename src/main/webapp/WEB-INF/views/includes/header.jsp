<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
  <head>
    <title>Home</title>
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
      crossorigin="anonymous"
    />
    <link
	  rel="stylesheet"
	  href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
	  integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay"
	  crossorigin="anonymous"
    />
    <link rel="stylesheet" href="/resources/css/styles.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="/resources/js/bootstrap.min.js" type="text/javascript"></script>
    <script>
    	$(document).ready(function() {
    		if("<c:out value='${loginModal}'/>"!==""){
    			$("#login").click();
    		}

    		if("<c:out value='${msg}'/>"!==""){
    			alert("<c:out value='${msg}'/>");
    		}
    		
    		// 게시글 검색
    		// form 태그로 URL의 이동 처리
    	    var actionForm = $("#actionForm");
    		$(".page-item a").on("click", function(e) {
    			// a 태그를 클릭해도 페이지 이동이 없도록함
    			e.preventDefault();

    			// form 태그 내 pageNum 값을 href 속성값으로 변경
    			actionForm.find("input[name='pageNum']")
    					.val($(this).attr("href"));
    			actionForm.submit();
    		});
    		
    		 var searchForm = $("#searchForm");
    		 $("#searchForm button").on("click", function(e) {
    			if (!searchForm.find("input[name='keyword']").val()) {
    				alert("키워드를 입력하세요");
    				return false;
    			}
    			// 검색 결과 페이지가 1페이지부터 시작하도록 처리
    			searchForm.find("input[name='pageNum']").val("1");
    			e.preventDefault();
    			searchForm.submit();
    		});
    	});
    </script>
  </head>
  <body>
    <header>
        <h1 onclick="location.href='/board/list'">Community</h1>
        <c:choose>
        <c:when test="${empty userid}">
        <div class="login-box">
        	<!-- <a href="/login" class="btn btn-outline-secondary" id="login">로그인</a> -->
        	<button
	          type="button"
	          data-toggle="modal"
	          data-target="#loginModal"
	          class="btn btn-outline-secondary"
	          id="login"
	        >
	          로그인
	        </button>
	        <button
	          type="button"
	          data-toggle="modal"
	          data-target="#signupModal"
	          class="btn btn-secondary"
	          id="register"
	        >
	          회원가입
	        </button>  
        </div>
        </c:when>
        <c:otherwise>
        <div class="dropdown">
	        <button
	          class="btn dropdown-toggle"
	          type="button"
	          id="profile"
	          data-toggle="dropdown"
	          aria-haspopup="true"
	          aria-expanded="true"
	        >
			  <div class="btn btn-group" role="group">
		        <div class="profile">
		          <img src="//www.gravatar.com/avatar/e2b95f79a5b08dcc676a5cc0f9c645e3?d=identicon&s=40" />
		        </div>
		        <div class="profile-text"><c:out value="${userid }"/></div>
		      </div>
		       <span class="caret"></span>
	        </button>
	        <ul class="dropdown-menu" aria-labelledby="profile">
	          <li>
	            <a href="/member/info/${userid }"><i class="fa fa-user"></i>마이페이지</a>
	          </li>
	          <li role="separator" class="dropdown-divider"></li>
	          <li>
	            <a href="/member/logout"><i class="fas fa-sign-out-alt"></i>로그아웃</a>
	          </li>
	        </ul>
		</div>
	   </c:otherwise>
	   </c:choose>
	</header>
    
    <!-- 로그인 -->
    <div class="modal fade member" id="loginModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="login-form">
              <form action="/member/login" method="post">
                <div class="form-group">
                    <input
                      type="text"
                      class="form-control"
                      name="userid"
                      placeholder="아이디"
                      required="required"
                    />

                </div>
                <div class="form-group">
                 
                    <input
                      type="password"
                      class="form-control"
                      name="userpw"
                      placeholder="비밀번호"
                      required="required"
                    />

                </div>
                <div class="form-group">
                  <button type="submit" class="btn btn-success btn-block btn-lg login-btn">로그인</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 회원가입 -->
    <div class="modal fade member" id="signupModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="signup-form">
              <form action="/member/join" method="post" id="joinForm">
                <div class="form-group">
                  <input
                    type="text"
                    class="form-control"
                    name="userid"
                    placeholder="아이디"
                    required="required"
                  />
                </div>
                <div class="form-group">
                  <input
                    type="username"
                    class="form-control"
                    name="username"
                    placeholder="이름"
                    required="required"
                  />
                </div>
                <div class="form-group">
                  <input
                    type="password"
                    class="form-control"
                    name="userpw"
                    placeholder="비밀번호"
                    required="required"
                  />
                </div>
                <div class="form-group">
                  <input
                    type="password"
                    class="form-control"
                    name="userpwCk"
                    placeholder="비밀번호 확인"
                    required="required"
                  />
                </div>
                <div class="form-group">
                  <button type="button" class="btn btn-primary btn-block btn-lg">회원가입</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script>
    $(document).ready(function() {
    	var joinForm = $("#joinForm");
    	var joinBtn = joinForm.find(".btn");
    	joinBtn.on("click", function(e) {
    		e.preventDefault();
    		
    		var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
    	    	
   	    	var id = joinForm.find("input[name='userid']");
   	    	var pw = joinForm.find("input[name='userpw']");
   	    	var pwck = joinForm.find("input[name='userpwCk']");
   	    	if(!check(re,id,"아이디는 4~12자의 영문 대소문자와 숫자만 가능합니다.")) {
   	    	    return false;
	    	}

   	    	if(!check(re,pw,"비밀번호는 4~12자의 영문 대소문자와 숫자만 가능합니다.")) {
   	    	    return false;
   	    	}

   	    	if(pw.val() != pwck.val()) {
 	    	    alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
 	    	    pwck.val("");
 	    	    return false;
   	    	}
   	    	
   	    	$.ajax({
   	    		type: "post",
   	    		url: "/member/checkJoin",
   	    		data: {
   	    			"userid": id.val()
   	    		},
   	    		success: function(data){
   	    			if($.trim(data)=="yes"){
   	    				joinForm.submit();
   	    			}else {
   	    				alert("이미 가입된 아이디입니다.");
   	    				id.val("");
   	    				id.focus();
   	    			}
   	    		},
   	    		error : function(xhr, status, err) {
   					if (error) {
   						error(err);
   					}
   				}
   	    	});
   	    	
    	});
    	
    	function check(re, what, message) {
    	       if(re.test(what.val())) {
    	           return true;
    	       }
    	       alert(message);
    	       what.val("");
    	       what.focus();
    	   }
    	
    	
    });
    
   
    </script>