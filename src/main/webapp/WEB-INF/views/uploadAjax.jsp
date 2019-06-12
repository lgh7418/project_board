<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Upload with Ajax</h1>



	<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}
</style>

<style>
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
}

.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}
</style>

<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>

	<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple>
	</div>

	<div class='uploadResult'>
		<ul>

		</ul>
	</div>


	<button id='uploadBtn'>Upload</button>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>

	<script>

	// 썸네일 클릭 시 이미지 보여주기
	function showImage(fileCallPath){
	  
	  // 화면 가운데 배치(flex)
   	  $(".bigPictureWrapper").css("display","flex").show();
	  
	  // <img> 태그를 추가하고, jQuery의 animate()를 이요해서 지정된 시간 동안 화면에서 열리는 효과 처리
	  $(".bigPicture")
	  	.html("<img src='/display?fileName="+fileCallPath+"'>")
	  	.animate({width:'100%', height: '100%'}, 1000);

	}
	
	// 원본 이미지가 보여지는 <div>를 클릭하면 사라지도록 이벤트 처리
 	$(".bigPictureWrapper").on("click", function(e){
	  $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
	  // arrow function은 IE 11에서 동작X
	  // setTimeout(() => {
      setTimeout(function(){
	    $(this).hide();
	  }, 1000);
	});

	$(".uploadResult").on("click","span", function(e){
	   
	  var targetFile = $(this).data("file");
	  var type = $(this).data("type");
	  console.log(targetFile);
	  
	  $.ajax({
	    url: '/deleteFile',
	    data: {fileName: targetFile, type:type},
	    dataType:'text',
	    type: 'POST',
	      success: function(result){
	         alert(result);
	       }
	  }); //$.ajax
	  
	});


		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB

		function checkExtension(fileName, fileSize) {

			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}

			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		// <input type="file">은 readonly라 안쪽의 내용을 수정할 수 없기 때문에 별도의 초기화 방법이 필요
		// 첨부파일을 업로드하기 전에 아무 내용도 없는 <input type="file">이 포함된 객체를 복사(clone)
		// ajax 처리할 때 첨부파일 부분 초기화($(".uploadDiv").html(cloneObj.html());)
		var cloneObj = $(".uploadDiv").clone();
		
		$("#uploadBtn").on("click", function(e) {
			// 첨부파일 데이터는 
			var formData = new FormData();

			var formData = new FormData();

			var inputFile = $("input[name='uploadFile']");

			var files = inputFile[0].files;

			//console.log(files);

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

					showUploadedFile(result);

					$(".uploadDiv").html(cloneObj.html());

				}
			}); //$.ajax

		});

		// 첨부파일 이름을 목록으로 처리
		var uploadResult = $(".uploadResult ul");
 		//json 데이터를 받아서 해당 파일의 이름을 추가(ajax에서 showUploadedFile(result);)
	    function showUploadedFile(uploadResultArr){
	 
		   var str = "";
		   
		   $(uploadResultArr).each(function(i, obj){
		     
			 // 이미지 파일이 아닌 경우 '/resources/img/attatch.png' 아이콘을 보여줌
		     if(!obj.image){
		       
		       var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
		       
		       var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
		       
		       str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+
		           "<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"+
		           "<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span>"+
		           "<div></li>"
		           
		     }else{
		       
		       // 브라우저에서 GET 방식으로 첨부파일의 이름을 사용할 때, 파일 이름에 포함된 공백 문자나 한글 이름 등이 문제 될 수 있음
		       // encodeURIComponent()를 이용해서 URI 호출에 적합한 문자열로 인코딩 처리
		       var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
		       
		       var originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName;
		       // 문자열이 '\'기호 때문에 일반 문자열과 다르게 처리되므로 '/'로 변환
		       originPath = originPath.replace(new RegExp(/\\/g),"/");
		       
		       str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
		              "<img src='display?fileName="+fileCallPath+"'></a>"+
		              "<span data-file=\'"+fileCallPath+"\' data-type='image'> x </span>"+
		              "<li>";
		     }
		   });
		   
		   uploadResult.append(str);
	    }
	
	</script>


</body>
</html>
