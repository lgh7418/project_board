<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

    <%@include file="../includes/header.jsp" %>
    
    <div class="board list">
     <p><c:out value="${pageMaker.cri.keyword }"/>님이 쓴 게시글</p>
      <div>
      <table class="table">
        <thead>
          <tr>
            <th scope="col"></th>
            <th scope="col" class="w-50">제목</th>
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
          		<td class="text-center"><fmt:formatDate pattern="yy.MM.dd" value="${board.regdate }"/></td>
          		<td class="text-center"><c:out value="${board.viewCnt }"/></td>
          	</tr>
          </c:forEach>
          <tr>
            <td colspan="4">
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
      <form id='actionForm' action="/board/mypage" method='get'>
		<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' >
		<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' >
		<!-- 다른 페이지로 이동해도 검색 결과를 유지하도록 처리 -->
		<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>
	  </form>
    </div>
    <script>
	  $(document).ready(function() {
	    // 조회 페이지로 이동 처리
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
