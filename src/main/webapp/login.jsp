<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" 
src="${pageContext.request.contextPath}/js/cac-all.js"></script>
<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/style/alogin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/main.css">
<title>用户登录</title>

<script type="text/javascript">  
	// 使登陆页保持为最大窗口
    if (window != top)   
    top.location.href = location.href;   
	// 清除按钮
	function resetInput(){
		document.getElementById('userName').value = "";
		document.getElementById('password').value = "";
	}
</script>
</head>
<body style="overflow:hidden; background:url(${pageContext.request.contextPath}/images/login/login_background.jpg) center no-repeat">
	<div style="width:100%;height:100%;background-position: center; background-attachment: fixed;background-size:100% 100%;">
		<div style="position: absolute;width:510px;height:225px;left:62%;top:50%; margin-left:-580px;margin-top:-130px;border:0px solid #00F;">
			<form id="form1" name="form1" action="${pageContext.request.contextPath}/cacInto/login" method="post">
				<div class="MAIN">
					<ul>
						<li class="topD"> 
							<ul class="login">
								<li>
									<span style="">
										<input id="userName" name="userName" type="text" class="txt" value="${userName}" /> 
									</span>
								</li>
								<li style="marigin-top:50px;">
									<span style="">
										<input id="password" name="password" type="password" class="txt" value="${password}" onkeydown= "if(event.keyCode==13) form1.submit()"/>
									</span>
								</li>
							</ul>
						</li>
						<li class="middle_C">
							<span class="btn"> 
								<input type="submit" id="submit" value="登录" />
							</span>
						</li>
					</ul>
				</div>	
				<span style="">
					<font id="errorInfo" color="red">${error}</font>
				</span>
			</form>
			<input onclick="resetInput()" type="button"  id="reset"  value="清除" />
		</div>
	</div>
</body>
</html>