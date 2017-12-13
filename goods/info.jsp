<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html id="nav-order">
  <head>
    <title>${goodInfo.name}</title>
	<meta charset="UTF-8">
    <%@include file="/views/common/header.jsp" %>
    <%@include file="/views/common/top.jsp" %>
    <link rel="stylesheet" href="${sourcePath }css/swipe/info.css">
    <link rel="stylesheet" href="${sourcePath }css/swipe/swiper.min.css">
  </head>
  
  <body id="goods">
   	 <!-- <session class="session1"> -->
   	 	<div class="cont" style="background-color: #FFF;border-bottom: 1px solid #9d9d9d;padding-bottom: 10px">
   	 		<div class="swiper-container">
		        <div class="swiper-wrapper">
		        	<c:forEach items="${mainPic }" var="_pic" varStatus="count">	
		            	<div class="swiper-slide"><img style="width: 100%;" src="<c:out value="${_pic}"/>"/></div>
		        	</c:forEach>
		        </div>
		        <!-- Add Pagination -->
		        <div class="swiper-pagination"></div>
		        <!-- Add Navigation -->
		        <div class="swiper-button-prev"></div>
		        <div class="swiper-button-next"></div>
		    </div>
		    <div style="padding: 0px 10px;">
		    <p style="font-size: 16px;font-weight: bold;padding-top: 15px;margin-bottom: -1.5px"><c:if test="${not empty goodInfo.name}">${goodInfo.name}</c:if></p>
		    <p><font style="font-size: 25px;font-weight: bold;color: red;"><c:if test="${not empty goodInfo.rebate_price}">￥ ${goodInfo.rebate_price}</c:if></font><br/>
		    <font style="font-size: 13px;color: gray;margin-bottom: 15px"><c:if test="${not empty goodInfo.price}">原价：<s>￥ ${goodInfo.price}</s></c:if></font></p>
		    <div style="border-top: 1px solid #efefef;margin-top: 15px;padding-top: 15px" id="content">
		    <c:if test="${not empty goodInfo.content}">
		    	${goodInfo.content }
		    </c:if>
		    </div>
		    </div>
   	 	</div>
   	 <!-- </session> -->
   	 <session class="session5">
		<div class="count">
			<div class="cont">
			<div class="number"><input type="number" name="number" class="spinner" onchange="chnum(this)"/><input id="minBuyNum" type="hidden" value="${goodInfo.agent_storage}"/>
			<input id="price" type="hidden" value="${goodInfo.rebate_fee==0?goodInfo.fee/100:goodInfo.rebate_fee/100 }"/>
			</div>	<div class="countmoney">合计：<label class="money">￥<span id="allprice">${empty goodInfo.rebate_price?0:goodInfo.rebate_price}</span></label>
				</div>
				<div class="pay" onclick="confirm()"><p>结算</p></div>
			</div>
	 	</div>
	</session>
	<%@include file="/views/common/footer.jsp" %>
	<%@include file="/views/common/wxcomponent.jsp" %>
   	 <link rel="stylesheet" href="${sourcePath }/js/plugin/spinner/jquery.spinner.css" />
   	 <style type="text/css">
   	 .spinner{width: 100px}
   	 .spinner .value {height:auto;width: 50px;background:-webkit-gradient(linear, 0 30%, 0 100%, from(#007ED2), to(#0087C0));}
   	 .spinner .value.passive {height:25px;width: 50px;background:-webkit-gradient(linear, 0 0, 0 100%, from(#FCFCFC), to(#E1E1E1));border: 1px solid #BFBFBF}
   	 </style>
   	 <script type="text/javascript" src="${sourcePath }/js/plugin/spinner/jquery.spinner.js"></script>
   	  <script type="text/javascript">
	   		onload=function(){
		   		 var idwidth = $(this).width()-20,  // 容器的宽度和高度
		         idheight = $(this).height();
			     $("#content img").each(function(index,img){
			         var img_w = $(this).width(),
			             img_h = $(this).height();
			         // 如果图片自身宽度大于容器的宽度的话 那么高度等比例缩放
			         if(img_w > idwidth) {
			             var height = img_h * idwidth / img_w;
			             $(this).css({"width":idwidth, "height":height});
			         }
			     });
		   		var div = $("#content div");
		   		div.css("width","100%");
		   		var iframe = $("#content iframe");
		   		iframe.css("width","100%");
   				var iframes = document.getElementsByTagName("iframe");
				for(var j=0;j<iframes.length;j++){
						iframeauto(j);
				}
			}
			    
		    function iframeauto(j){
			    	var sw= document.getElementsByTagName("iframe")[j].width;
					 var sh=document.getElementsByTagName("iframe")[j].height;
					 sh = sh=="NaN"?320:sh;
					 var ow = document.body.clientWidth*0.9;  
			         var oh=sh*ow/sw*0.9;
					 document.getElementsByTagName("iframe")[j].style="";
					 document.getElementsByTagName("iframe")[j].width=ow;
					 document.getElementsByTagName("iframe")[j].height=oh;
					 
		    		var dataLazyload = $(document.getElementsByTagName("iframe")[j]).attr("data-lazyload");
			    	if(dataLazyload!=null){
						 var src = dataLazyload;
						 var aa = src.split('&');
						 var bb = aa;
						 var str = '';
						  for (var i = 0; i < aa.length; i++) {
							  if (aa[i].match(/width/)) {
								  bb[i]=bb[i].split("=")[0]+"="+ow;
							  }
							  if (aa[i].match(/height/)) {
								  bb[i]=bb[i].split("=")[0]+"="+oh;
							  }
							  str += (bb[i] + '&');
						  }
						  $(document.getElementsByTagName("iframe")[j]).attr("data-lazyload",str.substring(0, str.length - 1)); 
				    }
					 var src = document.getElementsByTagName("iframe")[j].src;
					 var aa = src.split('&');
					 var bb = aa;
					 var str = '';
					  for (var i = 0; i < aa.length; i++) {
						  if (aa[i].match(/width/)) {
							  bb[i]=bb[i].split("=")[0]+"="+ow;
						  }
						  if (aa[i].match(/height/)) {
							  bb[i]=bb[i].split("=")[0]+"="+oh;
						  }
						  str += (bb[i] + '&');
					  }
		   			document.getElementsByTagName("iframe")[j].src=str.substring(0, str.length - 1);
			}
			function iFrameHeight() { 
				var ifm= document.getElementById("iframepage"); 
				var subWeb = document.frames ? document.frames["iframepage"].document : ifm.contentDocument; 
				if(ifm != null && subWeb != null) { 
					ifm.height = subWeb.body.scrollHeight; 
				}
			} 
			onload();
			
	   </script>
   	 <script type="text/javascript">
   		var goodId = '${goodInfo.id}';
		var chnum = function(obj){
			if(goodId==0){
				return false;
			}
			var num = 0;
			if(obj==null){
				num = $("input[name='number']").val();
			}else if(obj.value==null){
				num = obj;
			}else{
				num = obj.value;
			}
			//判断当前是否低于最低进货量
			var minbuy = $("#minBuyNum").val();
			if(num<parseInt(minbuy) && '${delivery_mode}'==2){
				num = minbuy;
				$("input[name='number']").val(minbuy);
			}
			var price = $("#price").val();
			var allprice = num*price;
			$("#allprice").html(allprice.toFixed(2));
		}
		$('.spinner').spinner({value:1, min:0,maxlength:100000,step:1,callback:chnum});
		chnum();
		function confirm(){
			var num = $("input[name='number']").val();
			window.location.href="${path}/orders/confirm.do?goodNum="+num+"&goodId=${goodInfo.id}";
		}
		
		function showcheck(){
			var elements = document.getElementsByName("check");
			for (var i = 0; i < elements.length; i ++) {
				 elements[i].checked=false;
				 var obj = elements[i].nextSibling;
				 removeClass(obj,'check');
			}
		}
		showcheck();
		function showListcheck(obj){
			var check = obj.checked;
			/*if(!check){
				 var control = document.getElementsByName("checkControl");
				 control[0].checked=false;
				 var hobj = control[0].nextSibling;
				 removeClass(hobj,'check');
				 var o =  obj.nextSibling;
				 removeClass(o,'check');
			}else{*/
				var elements = document.getElementsByName("check");
				for (var i = 0; i < elements.length; i ++) {
					if(!elements[i].checked){
						var elementsImg = elements[i].nextSibling;
						removeClass(elementsImg,'check');
						//return false;
					}
				}
				var o = obj.nextSibling;
				addClass(o,'check');
				goodId = obj.value;
				chnum();
				//var control = document.getElementsByName("checkControl");
				//control[0].checked=true;
				//var controlImg = control[0].nextSibling;
				//addClass(controlImg,'check');
				/*}*/
		}

		function hasClass(obj, cls) {  
		    return obj.className.match(new RegExp('(\\s|^)' + cls + '(\\s|$)'));  
		}  
		  
		function addClass(obj, cls) {  
		    if (!this.hasClass(obj, cls)) obj.className += " " + cls;  
		}  
		  
		function removeClass(obj, cls) {  
		    if (hasClass(obj, cls)) {  
		        var reg = new RegExp('(\\s|^)' + cls + '(\\s|$)');  
		        obj.className = obj.className.replace(reg, ' ');  
		    }  
		}  
   	 </script>
    <script type="text/javascript" src="${sourcePath }css/swipe/swiper.min.js"></script>
    <script type="text/javascript">
    var swiper = new Swiper('.swiper-container', {
        autoplay: 2000,
		autoplayDisableOnInteraction:false,
		loop: true,
		pagination: '.swiper-pagination',
        paginationClickable: true,
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        // Enable debugger
        debugger: true
    });
    </script>
  </body>
</html>
