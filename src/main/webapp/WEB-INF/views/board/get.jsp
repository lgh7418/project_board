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
	            <a href="/member/info/${board.writer }" class="profile-text"><c:out value="${board.writer }" /></a>
	          </div>
	        </div>
	        <div class="article-date">
	          <p>
	            <fmt:formatDate pattern="yyyy.MM.dd. kk:mm" value="${board.regdate }"/> 
		        <c:if test="${userid eq board.writer}">
		            <a data-oper="modify" href="#" class="text-info">| 수정 </a>|
		            <a data-oper="remove" href="#" class="text-danger"> 삭제</a>
	            </c:if>
	          </p>
	          <p><i class="fas fa-eye"></i> <c:out value="${board.viewCnt }" /> </p>
	        </div>
	      </div>
	      <div class="card-body">
	        <div class="card-text">
	          <p><c:out value="${board.content }" /></p>
	        </div>
	
	        <p class="reply-count"></p>
	        <div class="card-footer text-muted">
		      <ul class="chat">
	
			  </ul>
			  <div id="reply-page"></div>
			  <form action="" class="reply-form">
				<c:choose>
			  		<c:when test="${empty userid }">
			  			<textarea name="reply" id="" cols="30" class="form-control" readonly>로그인한 사용자만 댓글을 달 수 있습니다.</textarea>
            			<button type="button" id="replyBtn" class="btn btn-primary" disabled>등록</button>
			  		</c:when>
			  		<c:otherwise>
			  			<input type="hidden" name="replyer" value='<c:out value="${userid }"/>'>
			            <textarea name="reply" id="" cols="30" class="form-control"></textarea>
		            	<button type="button" id="replyBtn" class="btn btn-primary">등록</button>
			  		</c:otherwise>
			  	</c:choose>
	          </form>
	        </div>
	      </div>
	    </div>
	    <div class="float-right">
          <a href="/board/register" class="btn btn-outline-info">글쓰기</a>
          <a href="/board/list" data-oper='list' class="btn btn-outline-secondary">글목록</a>
		  <form id='operForm' method="get">
			<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
			<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
			<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
  			<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>  
		  </form>			          
        </div>
	  </div>
    </div>
    <script type="text/javascript" src="/resources/js/reply.js"></script>
    <script>
    	$(document).ready(function () {
	    	var bnoValue = '<c:out value="${board.bno}"/>';
	    	var replyUL = $(".chat");
 	    	var replyer = '<c:out value="${userid}"/>';
    	  
    	    showList(1);
    	    
			function showList(page){
	    		 console.log("show list " + page);
				 replyService.getList({bno:bnoValue,page: page|| 1 }, function(replyCnt, list) {
					 $(".reply-count").text("댓글 " + replyCnt);
					 console.log("replyCnt: "+ replyCnt );
					 console.log("list: " + list);
					 console.log(list);
					  
					 if(page == -1){
					    pageNum = Math.ceil(replyCnt/10.0);
					    showList(pageNum);
					    return;
					 }
					   
					 var str="";
					   
					 if(list == null || list.length == 0){
					     return;
					  }
					   
				     for (var i = 0, len = list.length || 0; i < len; i++) {
				        str += "<li data-rno='"+list[i].rno+"'>";
				        str += '<div class="reply-profile">';
				      	str += '<div class="btn-group" role="group">';
				      	str += '<div class="profile">';
				      	str += '<img src="//www.gravatar.com/avatar/e2b95f79a5b08dcc676a5cc0f9c645e3?d=identicon&s=40" />';
				      	str += '</div>';
				      	str += '<a href="/member/info/'+list[i].replyer+'" class="profile-text">'+list[i].replyer+'</a>';
				      	str += '</div>';
				      	if(list[i].replyer === replyer){
					      	str += '<div class="reply-btn">';
					      	str += '<a data-oper="cancel" href="#" class="text-info" style="display:none"> 수정취소 </a>'
					      	str += '<a data-oper="modify" href="#" class="text-info"> 수정 </a>|';
					      	str += '<a data-oper="remove" href="#" class="text-danger"> 삭제</a>';
					      	str += '</div>';
				      	}
				      	str += '<p class="reply">'+list[i].reply+'</p>';
				      	str += '<p class="reply-date">'+replyService.displayTime(list[i].replyDate)+'</p>';
				      	str += '<div class="modify-box"></div>'
				      	str += '<hr />';
				      	str += '</div>';
				      	str += '</li>';
				     }
				     replyUL.html(str);
					 showReplyPage(replyCnt);			    	 

				});//end function
			}//end showList	
			
			
			var pageNum = 1;
			// 댓글 페이지 넣을 공간
		    var replyPageFooter = $("#reply-page");
		    
		    function showReplyPage(replyCnt){
		      
		      if(replyCnt <= 10) {
		    	  replyPageFooter.html("");
		    	  return;
		      }
		    	
		      // 1번 페이지의 모든 쪽을 다 사용한다고 가정하고 끝번호를 구함(10)
		      var endNum = Math.ceil(pageNum / 10.0) * 10;
		      // 끝번호를 이용해서 시작 번호를 구함
		      var startNum = endNum - 9; 
		      
		      var prev = startNum != 1;
		      var next = false;
		      
		      // 총 댓글 수가 마지막 쪽 안에 들어간다면
		      if(endNum * 10 >= replyCnt){
		    	// 모든 쪽을 다 사용하지 않으므로 끝 번호를 조정해야 함
		        endNum = Math.ceil(replyCnt/10.0);
		      }
		      
		      // 최종적으로 조정된 endNum으로 이 페이지의 마지막 쪽까지의 댓글 수 보다 총 댓글 수가 많으면 다음 페이지를 생성
		      if(endNum * 10 < replyCnt){
		        next = true;
		      }
		      
		      var str = "<ul class='pagination pull-right'>";
		      
		      // 이전 쪽을 생성
		      if(prev){
		        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
		      }
		      
		      for(var i = startNum ; i <= endNum; i++){
		        
		        var active = pageNum == i? "active":"";
		        
		        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		      }
		      
		      if(next){
		        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
		      }
		      
		      str += "</ul></div>";
		      
		      console.log(str);
		      
		      replyPageFooter.html(str);
		    }
		     
		    replyPageFooter.on("click","li a", function(e){
		       e.preventDefault();
		       console.log("page click");
		       
		       var targetPageNum = $(this).attr("href");
		       
		       console.log("targetPageNum: " + targetPageNum);
		       
		       pageNum = targetPageNum;
		       
		       showList(pageNum);
		     });
		     
			var replyBtn = $("#replyBtn");
	    	var replyForm = $('.reply-form');
	    	var inputReply = replyForm.find('textarea[name="reply"]');
	    	var inputReplyer = replyForm.find('input[name="replyer"]');
		     
		    replyBtn.on("click",function(e){
		    	 var reply = {
    	             reply: inputReply.val(),
    	             replyer: inputReplyer.val(),
    	             bno: bnoValue
    	         };
	    	     replyService.add(reply, function(result){
		    	     alert(result);
		    	     inputReply.val("");
		    	     
		    	     // 댓글의 마지막 페이지로 이동
		    	     showList(-1);
	    	    });
		    }); 
		     
		    
		    
		    $(document).on("click", ".reply-btn a[data-oper='modify']", function(e){
		    	  e.preventDefault();
		    	  var replyProfile = $(this).closest(".reply-profile");
		    	  replyProfile.find("p").hide();
		    	  $(this).hide();
		    	  replyProfile.find("a[data-oper='cancel']").show();
		    	  
		    	  var reply = replyProfile.find(".reply").text();
		    	  var replyer = replyProfile.find(".profile-text").text();
		    	  var modifyBox = replyProfile.find(".modify-box");

		    	  var str="";
		    	  str += '<form action="" class="reply-modify">';
		    	  str += '<input type="hidden" name="replyer" value="'+replyer+'">';
		    	  str += '<textarea name="reply" id="" cols="25" class="form-control">'+reply+'</textarea>';
		    	  str += '<button type="button" id="replyModFormBtn" class="btn btn-info">수정</button>';
		    	  str += '</form>';

		    	  modifyBox.html(str)
		    	  
				  $(document).on("click", "#replyModFormBtn", function(e){
					  var rno = replyProfile.parents("li").data("rno");
					  console.log(rno);
				   	  var reply = {rno: rno, reply: replyProfile.find("textarea").val()};
				   	  
	 			   	  replyService.update(reply, function(result){
				   		  alert(result);
				   		  showList(pageNum);
				   	  });
				  });
		    });
		    
		    $(document).on("click", ".reply-btn a[data-oper='cancel']", function(e){
		    	e.preventDefault();
		    	showList(pageNum);
		    });
		    
		    $(document).on("click", ".reply-btn a[data-oper='remove']", function(e){
		    	e.preventDefault();
		    	var rno = $(this).parents("li").data("rno");
		    	
		    	console.log("RNO: " + rno);
	     	    console.log("REPLYER: " + replyer);
	     	    
	     	    if(!replyer){
	        		  alert("로그인후 삭제가 가능합니다.");
	        		  modal.modal("hide");
	        		  return;
	        	}
	     	    
	     	    var replyProfile = $(this).closest(".reply-profile");
	     	    var originalReplyer = replyProfile.find(".profile-text").val();
	     	    
	     	    if(replyer != originalReplyer){
	        		  alert("자신이 작성한 댓글만 삭제가 가능합니다.");
	        		  return;
        	    }
		    	
		    	replyService.remove(rno, originalReplyer, function(result){
		    		alert(result);
		    		showList(pageNum);
		    	});
		    });
		    
		    

    	});
    </script>
    <script type="text/javascript">
		$(document).ready(function() {
		  
		  var operForm = $("#operForm"); 
		  $('.article-date a').on("click", function(e){
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
