<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

    <%@include file="../includes/header.jsp" %>
    <div class="board list">
      <div>
      <table class="table">
        <thead>
          <tr>
            <th scope="col"></th>
            <th scope="col" class="w-50">제목</th>
            <th scope="col">작성자</th>
            <th scope="col">작성일</th>
            <th scope="col">조회</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${list }" var="board">
          	<tr>
          		<td><c:out value="${board.bno }"/></td>
          		<td>
          		  <a class='move' href='<c:out value="${board.bno}"/>'>
          		    <c:out value="${board.title}" />
				  </a>&nbsp;
				  <c:if test="${board.replyCnt != 0}"> 
				  	<a class="text-black-50">[<c:out value="${board.replyCnt }"/>]</a>
				  </c:if>
				</td>
          		<td><c:out value="${board.writer}"/></td>
          		<td class="text-center"><fmt:formatDate pattern="yy.MM.dd" value="${board.regdate }"/></td>
          		<td class="text-center"><c:out value="${board.viewCnt }"/></td>
          	</tr>
          </c:forEach>
          <tr>
            <td colspan="5">
              <a href="/board/register" class="btn btn-info">글쓰기</a>
            </td>
          </tr>
        </tbody>
      </table>
      </div>
      <nav aria-label="Page navigation">
        <ul class="pagination d-flex justify-content-center">
          <c:if test="${pageMaker.prev}">
            <li class="page-item">
              <a class="page-link" href='<c:out value="${pageMaker.startPage -1 }"/>' aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
              </a>
            </li>
          </c:if>
          <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
	          <li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">
	            <a class="page-link" href="${num }">${num }</a>
	          </li>
          </c:forEach>
          <c:if test="${pageMaker.next }">
	          <li class="page-item">
	            <a class="page-link" href="${pageMaker.endPage +1 }" aria-label="Next">
	              <span aria-hidden="true">&raquo;</span>
	            </a>
	          </li>
          </c:if>
        </ul>
      </nav>
      <form id='actionForm' action="/board/list" method='get'>
		<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' >
		<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' >
		<!-- 다른 페이지로 이동해도 검색 결과를 유지하도록 처리 -->
		<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>
	  </form>
	  
      <form class="form-inline search" id="searchForm" action="/board/list" method="get">
          <select class="custom-select" name="type">
            <option value="TC" selected>제목+내용</option>
            <option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
            <option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
            <option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>글쓴이</option>
          </select>
        <div class="input-group">
          <input type="text" class="form-control" name="keyword"
          	value='<c:out value="${pageMaker.cri.keyword}"/>'>
          <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
          <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
          <div class="input-group-append">
            <button class="btn" type="button"><i class="fas fa-search"></i></button>
          </div>
        </div>
        </form>
    </div>

	<!-- Modal  추가 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Success</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          				<span aria-hidden="true">&times;</span>
       				</button>
				</div>
				<div class="modal-body">처리가 완료되었습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	
	<script>
	  $(document).ready(function() {
	    var result = '<c:out value="${result}"/>';

	    checkModal(result);
		
	    history.replaceState({}, null, null);

	    function checkModal(result) {
	      if (result === "" || history.state) {
	        return;
	      }

	      if (parseInt(result) > 0) {
	        $(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
	      }else if (result === "success") {
	    	  $(".modal-body").html("수정되었습니다.");
	      }

	      $("#myModal").modal("show");
	    }
	    
	    var actionForm = $("#actionForm");
		$(".move").on("click", function(e) {
			e.preventDefault();
			actionForm.append(
				"<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>"
			);
			actionForm.attr("action", "/board/get");
			actionForm.submit();

		});
	    
	    
	 });
	  
	  

	  
	</script>
  </body>
</html>
