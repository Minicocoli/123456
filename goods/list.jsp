<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html id="nav-order">
  <head>
    <title>商品中心</title>
	<meta charset="UTF-8">
    <%@include file="/views/common/header.jsp" %>
    <%@include file="/views/common/top.jsp" %>
  </head>
  
  <body id="goods">
   	 <session class="session1">
   	 		<div class="cont">
   	 			<!-- <div class="company">
   	 				<label class="checkbtn"><input class="cb" onchange="showcheck()" type="checkbox" name="checkControl"><span class="chboxlabel"></span><img style="vertical-align: initial;" src="https://gw.alicdn.com/bao/uploaded/i2/TB1SGU.KVXXXXXfXXXXXXXXXXXX_!!0-item_pic.jpg_100x100q90s150.jpg_.webp"/></label>
   	 				<div class="content"><a href=""><p>老管家旗舰店</p><span class="glyphicon glyphicon-chevron-right" style="top: 35%;"></span></a></div>
   	 			</div> -->
	   	 		<ul>
	   	 			<c:if test="${list==null}">
	   	 				<li>
	   	 				<div class="text-center" style="padding: 10px">
	   	 				商品尚未上架，请耐心等待...
	   	 				</div></li>
	   	 			</c:if>
	   	 			<c:forEach items="${list}" var="_item">
	   	 				<li>
		   	 				<div class="info">
		   	 					<label class="checkbtn"><input class="listcb"  onchange="showListcheck(this)" name="check" type="radio" value="${_item.id }"><span class="chboxlabel"></span></label>
		   	 					<img class="img" src="${_item.thumbnail }"/>
		   	 					<div class="goodinfo">
		   	 						<a href="${path }/goods/info.do?goodId=${_item.id}" target="_blank"><div class="title">${_item.name }</div></a>
		   	 						<div class="category"><c:if test="${_item.category!=null}">商品分类：${_item.category}</c:if></div>
		   	 						<div class="showmoney">
		   	 							<span class="money">￥<span id="">${_item.rebate_price==null?_item.price:_item.rebate_price }</span></span> 
			   	 						<c:if test="${_item.rebate_price!=null}">
			   	 							<span class="oldmoney">￥${_item.price }<div></div></span>
			   	 						</c:if>
		   	 						</div>
		   	 						<c:if test="${userMap.type==3 && param.from!='deliver' && delivery_mode==2}">
		   	 						<div style="border-top:1px solid #ccc;padding: 5px 0px;margin-top: 5px;color: #aaa "><span>代理最低购买<label>${_item.agent_storage } ${_item.unit }</label></span></div>
									</c:if>
		   	 					</div>
		   	 					<input id="minBuyNum_${_item.id}" type="hidden" value="${_item.agent_storage}"/>
		   	 					<input id="price_${_item.id }" type="hidden" value="${_item.rebate_fee==0?_item.fee/100:_item.rebate_fee/100 }"/>
		   	 					
		   	 				</div>
		   	 			</li>
	   	 			</c:forEach>
	   	 		</ul>
   	 		</div>
   	 </session>
   	 <session class="session5">
		<div class="count">
			<div class="cont">
			<div class="number"><input type="number" name="number" class="spinner" onchange="chnum(this)"/>
			</div>	<div class="countmoney">合计：<label class="money">￥<span id="allprice">0</span></label>
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
   		var goodId = 0;
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
			var minbuy = $("#minBuyNum_"+goodId).val();
			if(minbuy!='' && num<parseInt(minbuy) && '${param.from}'!='deliver' && '${delivery_mode}'==2){
				num = minbuy;
				$("input[name='number']").val(minbuy);
			}
			var price = $("#price_"+goodId).val();
			var allprice = num*price;
			$("#allprice").html(allprice.toFixed(2));
		}
		$('.spinner').spinner({value:1, min:0,maxlength:100000,step:1,callback:chnum});

		function confirm(){
			if($("#allprice").html()=='0'){
				weui.dialog("操作提示","请选择商品后结算");
				return false;
			}
			var num = $("input[name='number']").val();
			window.location.href="${path}/orders/confirm.do?from=${param.from}&goodNum="+num+"&goodId="+goodId;
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
				var minbuy = $("#minBuyNum_"+goodId).val();
				if(minbuy!='' && '${param.from}'!='deliver'  && '${delivery_mode}'==2){
					$("input[name='number']").val(minbuy);
				}
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
  </body>
</html>
