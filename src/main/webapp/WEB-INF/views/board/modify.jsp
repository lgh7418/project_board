<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
  
    <%@include file="../includes/header.jsp" %>
    
 	<div class="board register">
      <form action="/board/modify" method="post">
        <div class="input-group">
          <div class="input-group-prepend">
            <span class="input-group-text">제목</span>
          </div>
          <input type="text" class="form-control" name="title" value='<c:out value="${board.title }" />' />
        </div>
        <div class="input-group">
          <div class="input-group-prepend">
            <span class="input-group-text">작성자</span>
          </div>
          <input type="text" class="form-control"  name="writer" value='<c:out value="${userid }"/>' readonly />
        </div>
        <textarea class="form-control" name="content" rows="15"><c:out value="${board.content }" /></textarea>
        <div class="register-box d-flex justify-content-center">
          <input type="submit" class="btn btn-info" value="수정" />
          <input type="button" class="btn btn-outline-info" id="cancel" value="취소" />
        </div>
      </form>
    </div>
    <script>
      $(function() {
        $('[data-toggle="tooltip"]').tooltip();
      });
      
      $(document).ready(function() {
    	  $('#cancel').on("click", function(e){
    		  location.href='/board/get?bno=<c:out value="${board.bno }"/>';
    	  });
      });
    </script>
  </body>
</html>