<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<%@ taglib prefix ="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>


<div class="container text-start">
  
  <!-- 상품 등록 -->
  <div class="row pt-4">
    <div class="col">
      <h2 class="fs-3 fw-semibold">상품 등록</h2>
    </div>
  </div>
  
  <hr style="border:solid 1px black">
  
  <!-- 상품이미지 -->
  <div class="row flex-column">
    <div class="col">
      <h3 class="fs-5 fw-semibold">상품 이미지</h3>
      <form>
      	<input type="hidden" id="imageInput">
      	<div id="imageDiv" class="invalid-feedback text-start fs-6">
		  적어도 하나 이상의 상품 이미지 등록이 필요합니다
	    </div>
      </form>
    </div>
    
    <div class="col">
      <!-- 이미지 행 -->
      <div class="row pt-4" id="View_area">
      	<div class='col-lg-3 col-md-3 col-sm-6'>
      		<label for="img_upload">
                <img src="<%=request.getContextPath() %>/image/add_img.png" class='img-thumbnail' style='cursor: pointer; height:100px; width:100px;'>
            </label>
      		<input class="form-control" type="file" accept="image/*" id="img_upload" name="img_upload" onchange="previewImage(this,'View_area')"
		   multiple="multiple" style="display: none;">
      	</div>
      	<!-- 이미지 썸네일 추가되는 자리-->
      </div>
       <!-- 이미지 행 end -->
    </div>
    
  </div>
  
  <hr style="border:solid 1px black">
  
  <form id="addForm" class="needs-validation" novalidate>
   <!-- 제목 -->
  <div class="row align-items-center">
    <div class="col-lg-2">
      <h3 class="fs-5 fw-semibold mb-2">제목</h3>
    </div>
    <div class="col-lg-5">
    	<div class="form-floating">
	      <input class="form-control form-control-sm mb-2" type="text" placeholder="상품 제목을 입력해주세요" aria-label="상품 제목" id="GOODS_TITLE" name="GOODS_TITLE" maxlength="30" style="width:450px; height:40px;"required>
	      <label for="GOODS_TITLE" style="font-size:13px;">상품 제목을 적어주세요.&nbsp;&nbsp;&nbsp;<span class="textCount2">0자</span><span class="textTotal2">/30자</span></label>
	      <div class="invalid-feedback text-start">
			  상품 제목을 입력해주세요
		  </div>
		</div>
    </div>
  </div>
  
  <hr style="border:solid 1px black">
  
   <!-- 카테고리 -->
  <div class="row align-items-center">
    <div class="col-lg-2">
      <h3 class="fs-5 fw-semibold mb-2">카테고리</h3>
    </div>
    <div class="col-lg-4">
      <select class="form-select form-select-sm mb-2" aria-label="카테고리" name="GOODS_CATEGORY" required>
		  <option value="" selected>카테고리 선택</option>
		  <option value="상의">상의</option>
		  <option value="하의">하의</option>
		  <option value="신발">신발</option>
		  <option value="악세사리">악세사리</option>
	  </select>
	  <div class="invalid-feedback text-start">
		  카테고리를 선택해주세요
	  </div>
    </div>
  </div>
  
  <hr style="border:solid 1px black">
  
  <!-- 상태 -->
  <div class="row align-items-center">
    <div class="col-lg-2">
      <h3 class="fs-5 fw-semibold mb-2">상태</h3>
    </div>
    <div class="col-lg-4">
      <select class="form-select form-select-sm mb-2" aria-label="상태" name="GOODS_STATUS" required>
		  <option value="" selected>상태 선택</option>
		  <option value="A">A</option>
		  <option value="B">B</option>
		  <option value="C">C</option>
	  </select>
	  <div class="invalid-feedback text-start">
		  상품 상태를 선택해주세요
	  </div>
    </div>
  </div>
  
  <hr style="border:solid 1px black">
  
  <!-- 가격 -->
  <div class="row align-items-center">
    <div class="col-lg-2">
      <h3 class="fs-5 fw-semibold mb-2">가격</h3>
    </div>
    <div class="col-lg-4">
      <div class="input-group mb-2">
          <span class="input-group-text" style="width:40px; height:30px;"><i class="fa-solid fa-won-sign"></i></span>
          <input type="text" class="form-control" maxlength="20" aria-label="Amount (to the nearest dollar)" id="GOODS_PRICE" name="GOODS_PRICE" onkeyup="inputNumberFormat(this);" style="width:50px; height:30px;" required>
          <span class="input-group-text" style="width:40px; height:30px;">원</span>
          <div class="invalid-feedback text-start mt-2">
		  	상품 가격을 입력해주세요
	  	  </div>
        </div>
    </div>
  </div>
  
  <hr style="border:solid 1px black">
  
  <!-- 설명 -->
  <div class="row align-items-center">
    <div class="col-lg-2">
      <h3 class="fs-5 fw-semibold mb-2">설명</h3>
    </div>
    <div class="col-lg-10">
      <div class="form-floating mb-2">
		  <textarea class="form-control" placeholder="상품 설명을 적어주세요" id="GOODS_CONTENT" name="GOODS_CONTENT" style="height: 200px" required></textarea>
		  <label for="GOODS_CONTENT">상품 설명을 적어주세요.&nbsp;&nbsp;&nbsp;<span class="textCount">0자</span><span class="textTotal">/666자</span></label>
		  <div class="invalid-feedback text-start">
		  	상품 설명을 입력해주세요
	  	  </div>
	  </div>
    </div>
  </div>
  
  <!-- 등록버튼 -->
  <div class="row pt-4 pb-4 align-items-center">
  	<div class="col text-lg-end text-md-end text-sm-end">
  		<button type="button" class="btn btn-secondary" name="goodsWrite">상품등록</button>
  	</div>
  </div>
  
  <input type="hidden" name="GOODS_DCOST" value="3000">
  </form>
</div>

<script>
	var fileArr;
	var fileInfoArr=[];
	var num = 0;

	//썸네일 클릭시 삭제.
	function fileRemove(index) {
	    console.log("index: "+index);
	    fileInfoArr.splice(index,1,null);
	 
	    var imgId="#img_id_"+index;
	    $(imgId).remove();
	    
	    console.log(fileInfoArr);
	}
	
	//썸네일 미리보기.
	function previewImage(targetObj, View_area) {
	    var files=targetObj.files;
	    fileArr=Array.prototype.slice.call(files);
	    
	    var preview = document.getElementById(View_area); //div id
	 
	    var files = targetObj.files;
	    for ( var i = 0; i < files.length; i++) {
	        var file = files[i];
	        fileInfoArr.push(file);
	 
	        var imageType = /image.*/; //이미지 파일일경우만.. 뿌려준다.
	        if (!file.type.match(imageType))
	            continue;
	        // var prevImg = document.getElementById("prev_" + View_area); //이전에 미리보기가 있다면 삭제
	        // if (prevImg) {
	        //     preview.removeChild(prevImg);
	        // }
	 
	        var div=document.createElement('div');
	        div.id="img_id_" +num;
	        div.className="col-lg-3 col-md-3 col-sm-6";
	        preview.appendChild(div);
	 
	        var img = document.createElement("img");
	        img.className="addImg";
	        img.classList.add("obj");
	        img.classList.add("img-thumbnail");
	        img.file = file;
	        img.style.cursor='pointer';
	        const idx=num;
	        img.onclick=()=>fileRemove(idx);
	        div.appendChild(img);
	 
	        var reader = new FileReader();
	        reader.onloadend = (function(aImg) {
	            return function(e) {
	                aImg.src = e.target.result;
	            };                                               
	        })(img);                                             
	        reader.readAsDataURL(file);
	        num = num + 1;
	    }
	    console.log(fileInfoArr);
	    $("#imageDiv").hide();
	}
	
	//천단위 콤마
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }

    function uncomma(str) {
        str = String(str);
        return str.replace(/[^\d]+/g, '');
    } 
    
    function inputNumberFormat(obj) {
        obj.value = comma(uncomma(obj.value));
    }
    
    function inputOnlyNumberFormat(obj) {
        obj.value = onlynumber(uncomma(obj.value));
    }
	
	//form데이터 전송
	function dataSubmit() {
	 
	    var data=new FormData($("#addForm")[0]);
	    for(var i=0; i<fileInfoArr.length; i++) {
	    	data.append('file-'+i, fileInfoArr[i]);
	    }
	 
	    $.ajax({
	        url: "/ns/shop/goodsWrite",
	        data: data,
	        processData:false,
	        contentType:false,
	        enctype:'multipart/form-data',
	        type:"POST",
	    }).done(function (fragment) {
	    	if (fragment.code == "OK"){ //응답결과
                alert("상품이 정상적으로 등록되었습니다.");
                fn_goodsDetail(fragment.GOODS_NUM);
            } else {
                alert("파일 등록에 실패하였습니다.");
            }
	    });
	}

	function fn_goodsDetail(num) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/goodsDetail");
		comSubmit.addParam("GOODS_NUM", num);
		comSubmit.submit();
	};
	
	$('#GOODS_TITLE').keyup(function (e) {
		let content = $(this).val();
	    
	    // 글자수 세기
	    if (content.length == 0 || content == '') {
	    	$('.textCount2').text('0자');
	    } else {
	    	$('.textCount2').text(content.length + '자');
	    }
	    
	    // 글자수 제한
	    if (content.length > 30) {
	    	// 200자 부터는 타이핑 되지 않도록
	        $(this).val($(this).val().substring(0, 30));
	        // 200자 넘으면 알림창 뜨도록
	        alert('글자수는 30자까지 입력 가능합니다.');
	    };
	});
	
	$('#GOODS_CONTENT').keyup(function (e) {
		let content = $(this).val();
	    
	    // 글자수 세기
	    if (content.length == 0 || content == '') {
	    	$('.textCount').text('0자');
	    } else {
	    	$('.textCount').text(content.length + '자');
	    }
	    
	    // 글자수 제한
	    if (content.length > 666) {
	    	// 200자 부터는 타이핑 되지 않도록
	        $(this).val($(this).val().substring(0, 666));
	        // 200자 넘으면 알림창 뜨도록
	        alert('글자수는 666자까지 입력 가능합니다.');
	    };
	});
	
	(() => {
		  'use strict'

		  // Fetch all the forms we want to apply custom Bootstrap validation styles to
		  const form = document.querySelector('.needs-validation');
		 

		  // Loop over them and prevent submission
		  $("button[name='goodsWrite']").on("click", function(e) { 
			e.preventDefault();
			form.classList.add('was-validated')
			
			let isNull = true;
			
			if(fileInfoArr.length != 0) {
				for(var i=0; i<fileInfoArr.length; i++) {
					if(fileInfoArr[i] != null) {
						isNull = false;
						break;
					}
				}
			}
			
			if(fileInfoArr.length == 0 || isNull) {
				$("#imageInput").addClass("is-invalid");
				$("#imageDiv").show();
				event.preventDefault();
		        event.stopPropagation();
		        return false;
			}
			$("#imageDiv").hide();
			
			if (!form.checkValidity()) {
		        event.preventDefault();
		        event.stopPropagation();
		        return false;
		    }
			
			dataSubmit();
			});
		  
		  

		})()
  </script>

</body>
</html>