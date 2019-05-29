<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

	<%@include file="../includes/header.jsp" %>
	
    <div class="board">
	    <div class="read">
	      <div class="card">
	        <div class="card-header">
	          <div class="article-title">
	            <h5><c:out value="${board.title }" /></h5>
	            <div class="btn-group" role="group"">
	            <div class="profile">
	              <img
	                src="//www.gravatar.com/avatar/e2b95f79a5b08dcc676a5cc0f9c645e3?d=identicon&s=40"
	              />
	            </div>
	            <a href="#" class="profile-text"><c:out value="${board.writer }" /></a>
	          </div>
	        </div>
	        <div class="article-date">
	          <p>
	            <fmt:formatDate pattern="yyyy.MM.dd kk:mm" value="${board.regdate }"/> |
	            <!-- <a href='/board/modify?bno=<c:out value="${board.bno }"/>' class="text-info"> 수정 </a>| -->
	            <a data-oper="modify" href="#" class="text-info"> 수정 </a>|
	            <!-- 삭제버튼 누르면 alert창 띄워서 확인하게 만들기 -->
	            <a data-oper="remove" href="#" class="text-danger"> 삭제</a>
	          </p>
	          <p><i class="fas fa-eye"></i> 3 <i class="fas fa-thumbs-up"></i> 1</p>
	        </div>
	      </div>
	      <div class="card-body">
	        <div class="card-text">
	          <p><c:out value="${board.content }" /></p>
	        </div>
	        <div class="like-box">
	          <div class="input-group">
	            <div class="input-group-prepend">
	              <span class="input-group-text"><a href="#">좋아요</a></span>
	            </div>
	            <button type="button" class="btn btn-link"><i class="far fa-thumbs-up"></i></button>
	            <div class="input-group-append">
	              <span class="input-group-text">1</span>
	            </div>
	          </div>
	          <div class="input-group">
	            <div class="input-group-prepend">
	              <span class="input-group-text"><a href="#">싫어요</a></span>
	            </div>
	            <button type="button" class="btn btn-link"><i class="far fa-thumbs-down"></i></button>
	            <div class="input-group-append">
	              <span class="input-group-text">0</span>
	            </div>
	          </div>
	        </div>
	
	        <p class="reply-count">댓글 2</p>
	        <div class="card-footer text-muted">
	          <div class="reply-profile">
	            <div class="btn-group" role="group">
	              <div class="profile">
	                <img
	                  src="//www.gravatar.com/avatar/e2b95f79a5b08dcc676a5cc0f9c645e3?d=identicon&s=40"
	                />
	              </div>
	              <a href="#" class="profile-text">프로필</a>
	            </div>
	            <p>첫번째 댓글입니다.</p>
	            <p class="reply-date">2019.05.16. 21:55</p>
	            <hr />
	          </div>
	
	          <div class="reply-profile">
	            <div class="btn-group" role="group">
	              <div class="profile">
	                <img
	                  src="//www.gravatar.com/avatar/e2b95f79a5b08dcc676a5cc0f9c645e3?d=identicon&s=40"
	                />
	              </div>
	              <a href="#" class="profile-text">프로필</a>
	            </div>
	            <p>두번째 댓글입니다.</p>
	            <p class="reply-date">2019.05.16. 21:55</p>
	            <hr />
	          </div>
	          <form class="reply-form">
	            <textarea name="" id="" cols="30" class="form-control"></textarea>
	            <button type="button" class="btn btn-primary">등록</button>
	          </form>
	        </div>
	      </div>
	    </div>
	    <div class="float-right">
          <a href="/board/register" class="btn btn-outline-info">글쓰기</a>
          <a href="#" data-oper='list' class="btn btn-outline-secondary">글목록</a>
		  <form id='operForm' method="get">
			<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
			<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
		  </form>
			          
        </div>
	  </div>
    </div>
    <script type="text/javascript">
		$(document).ready(function() {
		  
		  var operForm = $("#operForm"); 
		  $('a').on("click", function(e){
			  e.preventDefault();
			  var oper = $(this).data("oper");
			  
			  if(oper === 'remove'){
			      operForm.attr("action", "/board/remove");
		      }else if(oper === 'modify'){
		    	  operForm.attr("action","/board/modify")
		      }else if(oper === 'list'){
		    	  operForm.find("#bno").remove();
				  operForm.attr("action","/board/list");
		      }
			  
			  operForm.submit();	  
		  });
		});
	</script>
  </body>
</html>
