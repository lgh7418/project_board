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
            <th scope="col">추천</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${list }" var="board">
          	<tr>
          		<td><c:out value="${board.bno }"/></td>
          		<td>
          		  <a class='move' href='<c:out value="${board.bno}"/>'>
          		    <c:out value="${board.title}" />
				  </a>
				</td>
          		<td><c:out value="${board.writer}"/></td>
          		<td class="text-center"><fmt:formatDate pattern="yy.MM.dd" value="${board.regdate }"/></td>
          		<td class="text-center">3</td>
            	<td class="text-center">1</td>
          	</tr>
          </c:forEach>
          <tr>
            <td colspan="6">
              <a href="/board/register" class="btn btn-info">글쓰기</a>
            </td>
          </tr>
        </tbody>
      </table>
      </div>
      <nav aria-label="Page navigation">
        <ul class="pagination">
          <li class="page-item ${pageMaker.startPage == 1 ? 'disabled' : ''}">
            <a class="page-link" href='<c:out value="${pageMaker.startPage -1 }"/>' aria-label="Previous">
              <span aria-hidden="true">&laquo;</span>
            </a>
          </li>
          
          <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
	          <li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">
	            <a class="page-link" href="${num }">${num }</a>
	          </li>
          </c:forEach>
          <c:if test="${pageMaker.next }">
	          <li class="page-item">
	            <a class="page-link" href="#" aria-label="Next">
	              <span aria-hidden="true">&raquo;</span>
	            </a>
	          </li>
          </c:if>
        </ul>
      </nav>
      <form id='actionForm' action="/board/list" method='get'>
		<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' >
		<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' >
	  </form>
	  
      <form class="form-inline search">
          <select class="custom-select">
            <option selected>제목+내용</option>
            <option value="1">제목</option>
            <option value="2">내용</option>
            <option value="3">글쓴이</option>
          </select>
        <div class="input-group">
          <input type="text" class="form-control">
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
		
	    //replaceState(): 새로운 히스토리를 하나 생성하는 대신에, 현재의 히스토리 엔트리를 변경
	    // 이전 주소 기록을 지우고 새로운 주소를 넣음 => result를 가졌던 기록을 없앰(경로 변경은 없음 null)
	    // 뒤로가기가 활성화되지 않음
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
	    
	    // 조회 페이지로 이동 처리
		$(".move").on("click", function(e) {
			e.preventDefault();
			actionForm.append(
				"<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>"
			);
			actionForm.attr("action", "/board/get");
			actionForm.submit();

		});
	    
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
	  });
	</script>
  </body>
</html>
