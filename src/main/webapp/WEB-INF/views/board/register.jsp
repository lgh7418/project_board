<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@include file="../includes/header.jsp" %>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
 	<div class="board register">
      <form action="/board/register" method="post">
     	<input type="hidden" name="writer" value='<c:out value="${board.writer}" default="writer" />' />
        <div class="input-group">
          <div class="input-group-prepend">
            <span class="input-group-text">제목</span>
          </div>
          <input type="text" class="form-control"  name="title"  autofocus />
        </div>
        <div class="uploadDiv clearfix">
	        <input type="file" id="uploadFile" name="uploadFile" style="display:none;" multiple>
	        <button
	          type="button"
	          class="btn btn-link"
	          id="uploadBtn"
	          data-toggle="tooltip"
	          data-placement="bottom"
	          title="사진 추가"
	        >
	          <i class="fas fa-image"></i>
	        </button>
        </div>
        <div class="form-control" contenteditable="true">
        	<img src="/resources/img/attach.png" />
        </div>
        <div class="register-box">
          <input type="submit" class="btn btn-info" value="등록" />
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
    		  location.href='/board/list';
    	  });
    	  
    	  $('#uploadBtn').click(function(e) {
        	  e.preventDefault();
        	  $('#uploadFile').click();
       	  });
    	  
    	  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    	  var maxSize = 5242880; //5MB
    	  
    	  function checkExtension(fileName, fileSize){
    	    
    	    if(fileSize >= maxSize){
    	      alert("파일 사이즈 초과");
    	      return false;
    	    }
    	    
    	    if(regex.test(fileName)){
    	      alert("해당 종류의 파일은 업로드할 수 없습니다.");
    	      return false;
    	    }
    	    return true;
    	  }
    	  
  		  $("#uploadFile").change(function(e) {
			var formData = new FormData();

			var inputFile = $("#uploadFile");
			
			var files = inputFile[0].files;
			
			for (var i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			// 결과 데이터(반환된 정보)를 처리 --dataType // json 타입으로 변경(?)
			$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					console.log(result);
					showUploadResult(result);
			
				}
			}); //$.ajax
		  });
  		  
  		 
  	      function showUploadResult(uploadResultArr){
  	 	    
  	   	    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
  	   	    
  	   	    var str ="";
  	   	    
  	   	    $(uploadResultArr).each(function(i, obj){
  	   	    
  	   			if(obj.image){
  	   				var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
  	   				str += "<div fileName="+fileCallPath+"' class='editImage' ";
  	   				str += "data-file=\'"+fileCallPath+"\' data-type='image'>";
  	   				str += "<img src='/display?fileName="+fileCallPath+"' class='editImage' ";
  	   				str += "</div>";
  	   			}else{
  	   				var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
  	   			    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
  	   				str += "<div class='editImage' data-path='"+obj.uploadPath+"'";
	   				str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
  	 				str += "<img src='/resources/img/attach.png'>";
  	   				str += "</div>";
  	   			}
  	   	    });
  	   	    
  	   	 	$('div.form-control').append(str);
  	   	  }
  	      
  	      $(document).on('keydown', '.editImage', function(e) {
  	    	  console.log(e.keyCode);
  	    	//백스페이스 키의 keyCode 는 8
  	    	if ( e.keyCode === 8 ) {
  	    		console.log($(this));
	  	    	console.log("delete file");
				var targetFile = $(this).data("fileName");
				console.log(targetFile);
				var type = $(this).data("type");
				
 				$.ajax({
				  url: '/deleteFile',
				  data: {fileName: targetFile, type:type},
				  dataType:'text',
				  type: 'POST',
			      success: function(result){
				     alert(result);
				  }
				}); //$.ajax 
				//return false;
  	    		console.log("뒤로가기 키");
	  	    }
  	    	
	   	  });

      });
     
    </script>
  </body>
</html>