<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">   
<title>逛鱼订单录入</title> 
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, minimal-ui">
<link rel="shortcut icon" href="/static/front/favicon.ico">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta content="yes" name="apple-touch-fullscreen">
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<link rel="stylesheet" href="/static/front/css/light7.css">
<link rel="stylesheet" href="/static/front/css/app.css">

</head>
<body style="position: static; width: 300px; height: 600px;">
	<div class="page">
		<div class="content">
			<form id="formdata">
				<div class="page-login" style="margin-top: 2rem">
					<div class="list-block inset text-center">
						<ul>
							<li>
								<div class="item-content">
								    <div class="item-media">
										<i class="icon icon-form-name"></i>
									</div>
									<div class="item-inner">
										<div class="item-input">
											<input id="orderid" maxlength="18" type="text" class="input_enter"
												placeholder="请输入订单号" name="order_id">
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="item-content">
								    <div class="item-media">
										<i class="icon icon-form-name"></i>
									</div>
									<div class="item-inner">
										<div class="item-input">
											<input id="mobile" maxlength="11" type="text" class="input_enter"
												placeholder="请输入手机号码" name="mobile">
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="item-content">
									<div class="item-media">
										<i class="icon icon-form-email"></i>
									</div>
									<div class="item-inner" style="padding:0">
										<div class="item-input">
											<input id="vcode" maxlength="5" class="input_enter" type="text" placeholder="输入验证码"
												name="codeimage">
										</div>
										<div class="item-title label" style="width:100px;height:35px;">
											 <img id="num" height="35" src="/getCode?%27+(new%20Date()).getTime()" onclick="document.getElementById('num').src='/getCode?'+(new Date()).getTime()"  alt="换一换" title="换一换" class="codeimage">
										</div>
										
									</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="content-block">
						<p>
							<a class="button button-big button-fill external"
								data-transition='fade' id="submitlogin" onclick="commit();">确认提交</a>
						</p>
						<p class='text-center signup'>                               
								<a href="/search.html"
								class='pull-right external' style="font-size: 0.8rem;">查返利</a>
								
						</p>
					</div>
			</form>
		</div>

		<div id="result" align="center"></div>

	</div>

	<script type='text/javascript' src='/static/front/js/jquery.min.js' charset='utf-8'></script>
	<script type='text/javascript' src='/static/front/js/light7.js' charset='utf-8'></script>
	<script>	
	    function isPoneAvailable(mobile) {  
          var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;  
          if (!myreg.test(mobile)) {  
              return false;  
          } else {  
              return true;  
          }  
      }
	    
	    function commit(){
	      var orderid = $('#orderid').val();
	      var mobile = $('#mobile').val();
	      var vcode = $('#vcode').val();
	      if (!orderid) {
	        alert("请输入18位订单号！");
	        return;
	      }else{
	        if(orderid.toString().length!=18){
			  alert("订单号位数不正确！");
			  return;
			}
	      }
	      if(!mobile){
	        alert("请输入手机号！");
	        return;
	      }else{
	        if(mobile.toString().length!=11){
			  alert("手机号位数不正确！");
			  return;
			}
	        var myreg=/^[1][3,4,5,7,8][0-9]{9}$/; 
	        if (!myreg.test(mobile)) {  
	          alert("请输入正确的手机号码");
              return;  
            } 	        
	      }    
	      if(!vcode){
	        alert("请输入验证码！");
	        return;
	      }else{
	        if(vcode.toString().length!=5){
			  alert("验证码输入不正确！");
			  return;
			}
	      }
	      
	      save(orderid,mobile,vcode);	      	      	      	      
	    }

		function save(orderid,mobile,vcode) {
				$
						.ajax({
							type : "post",
							url : "https://plug.guangfish.com/api/ordersave",
							contentType : "application/json",
							dataType : "json",// 返回json格式的数据
							data : JSON.stringify({
								"orderid" : ""+orderid,
								"mobile" : ""+mobile,
								"vcode" : ""+vcode
							}),
							timeout : 30000,
							success : function(data) {
								console.log('请求到的数据为：', data)
								if(JSON.stringify(data) != "{}"){
								  if(data.ret.result=="0"){
								    alert("提交成功");
								    $("#orderid").val("");
								    $("#mobile").val("");
								    $("#vcode").val("");								    
								  }
								  
								  if(data.ret.result=="-1"){
								    alert("该订单号已存在，请勿重复提交!");
								    $("#orderid").val("");
								    $("#vcode").val("");
								  }
								  
								  if(data.ret.result=="4"){
								    $('#result').html("验证码错误");
								    $("#vcode").val("");								    
								  }
								}
								document.getElementById('num').src='/getCode?'+(new Date()).getTime();							
							},
							error : function(XMLHttpRequest, textStatus,
									errorThrown) {
								console.log('请求失败')
							}
						});
		}
	</script>
</body>
</html>
