<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">   
<title>逛鱼搜索</title> 
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
									<div class="item-inner">
										<div class="item-input">
											<input type="text" class="input_enter"
												placeholder="请输入要查询的商品链接地址" name="product_url">
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="item-content">
									<div class="item-media">
										<i class="icon icon-form-name"></i>
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
								data-transition='fade' id="submitlogin" onclick="fetch();">查返利</a>
						</p>
						<p class='text-center signup'>                               
								<a href="/order.html"
								class='pull-right external' style="font-size: 0.8rem;">订单录入</a>
								
						</p>
					</div>
			</form>
		</div>

		<div id="result" align="center"></div>

	</div>

	<script type='text/javascript' src='/static/front/js/jquery.min.js' charset='utf-8'></script>
	<script type='text/javascript' src='/static/front/js/light7.js' charset='utf-8'></script>
	<script>
		function drump(link) {
			//location.href=link;
			window.open(link);
		}
		
		function vcodevalid() {
			var vcode = $('#vcode').val();

			if (!vcode) {
				alert("请输入验证码！");
				return -1;
			}
			if(vcode.toString().length!=5){
			  alert("验证码输入不正确！");
			  return -2;
			}
			 
			var dt=0;

				$
						.ajax({
							type : "post",
							url : "https://plug.guangfish.com/api/vcodevaild",
							contentType : "application/json",
							dataType : "json",// 返回json格式的数据
							async:false,
							data : JSON.stringify({
								"vcode" : vcode
							}),
							timeout : 30000,
							success : function(data) {
								console.log('请求到的数据为：', data)
								if(data.ret.result=="0"){
								  dt=0;
								}else{
								  dt=1;
								}					
							},
							error : function(XMLHttpRequest, textStatus,
									errorThrown) {
								console.log('请求失败')
							}
						});
						return dt;
		}

		function fetch() {
		    	
			$('#e-c').remove();
			var producturl = $('.input_enter').val();
			var reg = /http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
			if (!reg.test(producturl)) {
				alert("请输入有效的地址！");
				return;
			}else{
			  var adt=vcodevalid();
			  if(adt==-1 || adt==-2){
			    return;
			  }			  
			  if(!(adt==0)){
		        alert("验证码验证失败");
		        return;
		      }else{		        
		        document.getElementById('num').src='/getCode?'+(new Date()).getTime();
		      }
			}

			//加载中
			$('#result')
					.html(
							"<div id='waiting'><img src='/static/front/timg.gif'></div>");
			if (producturl) {
				$
						.ajax({
							type : "post",
							url : "https://plug.guangfish.com/api/productInfo",
							contentType : "application/json",
							dataType : "json",// 返回json格式的数据
							data : JSON.stringify({
								"user_id" : "",
								"product_url" : producturl
							}),
							timeout : 30000,
							success : function(data) {
								console.log('请求到的数据为：', data)
								$('#waiting').remove();
								if (JSON.stringify(data) == "{}") {
									$('#result')
											.html(
													"<div id='e-c' align=center><div style='font-size:12px;width:330px;top:10%;left:38%;background:#fff;border-radius:10px;box-shadow:5px 5px 10px #888;'><h2 style='padding:5px;font-size:18px;'>该商品无佣金</h2></div></div>");
								} else {
									$('#result').html(data.ret.result.msg);
								}
								$(".input_enter").val("");
								$("#vcode").val("");
							},
							error : function(XMLHttpRequest, textStatus,
									errorThrown) {
								console.log('请求失败')
							}
						});
			} else {
				alert("请输入商品地址后再查询");
			}
		}
	</script>
</body>
</html>
