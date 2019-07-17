<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri="/priveliege"  prefix="privilege" %>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>实时车流量监控</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/cac-all.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/historyTrajectoryQuery.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main1680.css" />
</head>
<style type="text/css">
		body, html{width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";background-image:linear-gradient(#000c17,#042543);margin:0px; padding:0px;}
		#baseMsg{width: 330px;height: 95%;float:left;margin:0px; padding:0px;}
		.baseMsgFont{background: url("${pageContext.request.contextPath}/images/index/p.png") no-repeat;background-position:1px 1px;color:#1BD9FF;font-size:18px;font-family:"微软雅黑";font-weight:bold;margin:0px; padding:0px;margin-left:27px; margin-top:17px;padding-left:30px}
        .vehicleOwner{line-height:30px;background-color:#082942;width:300px;height:30px;margin-left:27px;margin-top:10px;font-size:16px;color:#1BD9FF;float-left;font-weight:Regular}
        .carNum{line-height:30px;background-color:#082942;width:300px;height:30px;margin-left:27px;margin-top:2px;font-size:16px;color:#1BD9FF;float-left;font-weight:Regular}
        #guiji{width: 1020px;height: 100%;float:right;margin:0px; padding:0px;}
</style>
<body>
	
<script type="text/javascript">
	
$(document).ready(function(){
	setInterval("loadguiji()",1000);
	
		
	}); 
function loadguiji()
{
	
	
	
	
	var cphm = window.sessionStorage.getItem('cphm');
	var bufferList = JSON.parse( window.sessionStorage.getItem("bufferList") );
	
	var dmId=1;
	for(var i=0;i<bufferList.length;i++)
		{
		
			if(bufferList[i].cphm==cphm)
				{
				$("#vehicleOwner").text("车"+" "+"主：");
				$("#carNum").text("车牌号：");
				$("#vehicleOwner").text($("#vehicleOwner").text()+bufferList[i].cz);
				$("#carNum").text("车牌号："+cphm);
				if(dmId<bufferList[i].dmId)
					{
					dmId=bufferList[i].dmId;
					}
				if(bufferList[i].dmId==1)
					{
					//$(".right").hide();
					//   $("#right1").show();
					$("#ry").text("入"+" "+"园：");
					if($(".right1 li").text()!=null&&$(".right1 li").text()!="")
						{
						 $(".right").hide();
						}
					$("#ry").text($("#ry").text()+formatUnixtimestamp(bufferList[i].txsj));								
					}
				if(bufferList[i].dmId==7)
					{
					$("#cy").text("出"+" "+"园：");
					$("#cy").text($("#cy").text()+formatUnixtimestamp(bufferList[i].txsj));
					}
				$("#singleLiCountMiddle"+bufferList[i].dmId).text(formatUnixtimestamp(bufferList[i].txsj));
				
				 
				}
			$("#right"+dmId).show();
			$("#img").attr("src","${pageContext.request.contextPath}/images/guijiImage/"+dmId+".gif");
			
		}
	
		  
		
}
function formatUnixtimestamp (unixtimestamp){
    var unixtimestamp = new Date(unixtimestamp);
    var year = 1900 + unixtimestamp.getYear();
    var month = "0" + (unixtimestamp.getMonth() + 1);
    var date = "0" + unixtimestamp.getDate();
    var hour = "0" + unixtimestamp.getHours();
    var minute = "0" + unixtimestamp.getMinutes();
    var second = "0" + unixtimestamp.getSeconds();
    return year + "-" + month.substring(month.length-2, month.length)  + "-" + date.substring(date.length-2, date.length)
        + " " + hour.substring(hour.length-2, hour.length) + ":"
        + minute.substring(minute.length-2, minute.length) + ":"
        + second.substring(second.length-2, second.length);
}
	


	
			
</script>


       
		<div id="baseMsg">
		<div class="baseMsgFont">车辆信息</div>
			<div class="vehicleOwner" id="vehicleOwner">
				车     主：
			</div>
			<div class="carNum" id="carNum">
				车牌号：
			</div>
		<div class="baseMsgFont" style="margin-top:34px;">轨迹信息</div>
			<div class="vehicleOwner" id="ry">
				入    园：
			</div>
			<div class="carNum" id="cy">
				出    园：
			</div>
			<div class="carNum">
				轨    迹：如黄线
			</div>	
		</div>
		<div id="guiji">
		 <img id="img" style="width:100%;height:100%;" src="" /> 
		
		</div>
		<div id="right1" class="right" style="position:absolute;width:70px;height:44px;margin-left:963px;margin-top:417px;z-index:999;display:none;">
				<ul   class="singlePointUlCommon right1">	
					<li  class='singlePointLiCommon' id='singleLiCountMiddle1' ></li>
				</ul>
			</div>
		<div id="right2" class="right" style="position:absolute;width:70px;height:44px;margin-left:1090px;margin-top:367px;z-index:999;display:none">
				<ul   class="singlePointUlCommon">	
					<li  class='singlePointLiCommon' id='singleLiCountMiddle2' ></li>
				</ul>
		</div>	
		<div id="right3" class="right" style="position:absolute;width:70px;height:44px;margin-left:778px;margin-top:121px;z-index:999;display:none">
				<ul   class="singlePointUlCommon">	
					<li  class='singlePointLiCommon' id='singleLiCountMiddle3' ></li>
				</ul>
		</div>
		<div id="right4" class="right" style="position:absolute;width:70px;height:44px;margin-left:377px;margin-top:252px;z-index:999;display:none">
				<ul   class="singlePointUlCommon">	
					<li  class='singlePointLiCommon' id='singleLiCountMiddle4' ></li>
				</ul>
		</div>
		<div id="right5" class="right" style="position:absolute;width:70px;height:44px;margin-left:498px;margin-top:490px;z-index:999;display:none">
				<ul   class="singlePointUlCommon">	
					<li  class='singlePointLiCommon' id='singleLiCountMiddle5' ></li>
				</ul>
		</div>
		<div id="right6" class="right" style="position:absolute;width:70px;height:44px;margin-left:684px;margin-top:386px;z-index:999;display:none">
				<ul   class="singlePointUlCommon">	
					<li  class='singlePointLiCommon' id='singleLiCountMiddle6' ></li>
				</ul>
		</div>
		<div id="right7" class="right" style="position:absolute;width:70px;height:44px;margin-left:675px;margin-top:482px;z-index:999;display:none">
				<ul   class="singlePointUlCommon">	
					<li  class='singlePointLiCommon' id='singleLiCountMiddle7' ></li>
				</ul>
		</div>

</body>
</html>