<link rel="stylesheet" href="/static/front/css/table.css">
<@model.webheadsearch />
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
											<input id="mobile_me" maxlength="11" type="text" class="input_enter"
												placeholder="我的您的手机号码" name="mobile_me">
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
											<input id="mobile_friend" maxlength="11" type="text" class="input_enter"
												placeholder="我朋友的手机号码" name="mobile_friend">
										</div>
									</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="content-block">
						<p>
							<a class="button button-big button-fill external"
								data-transition='fade' id="submitlogin" onclick="commit();">提交邀请</a>
						</p>
						<p class='text-center signup'>				        					
								<a href="/search.html"
								class='pull-center external' style="font-size: 0.8rem;">返回</a>								
						</p>
					</div>
			</form>
		</div>

		<div id="result" align="center">
		  <div style="color: red;font-size: 0.7rem;">
             邀请朋友使用逛鱼搜索，并完成一单购买任务后即可得到5元奖励，奖励会在您申请提现时一起发放
		  </div>
		</div>

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
	      var mobile_me = $('#mobile_me').val();
	      var mobile_friend = $('#mobile_friend').val();
	      if(!mobile_me){
	        alert("请输入我的手机号！");
	        return;
	      }else{
	        if(mobile_me.toString().length!=11){
			  alert("我的手机号位数不正确！");
			  return;
			}
	        var myreg=/^[1][3,4,5,7,8][0-9]{9}$/; 
	        if (!myreg.test(mobile_me)) {  
	          alert("我的手机号格式不正确");
              return;  
            } 	        
	      }
	      
	      if(!mobile_friend){
	        alert("请输入朋友的手机号！");
	        return;
	      }else{
	        if(mobile_friend.toString().length!=11){
			  alert("朋友的手机号位数不正确！");
			  return;
			}
	        var myreg=/^[1][3,4,5,7,8][0-9]{9}$/; 
	        if (!myreg.test(mobile_friend)) {  
	          alert("朋友的手机号格式不正确");
              return;  
            } 	        
	      }
	      
	      save(mobile_me,mobile_friend);	      	      	      	      
	    }

		function save(mobile_me,mobile_friend) {
				$
						.ajax({
							type : "post",
							url : "/api/saveinvitation",
							contentType : "application/json",
							dataType : "json",// 返回json格式的数据
							data : JSON.stringify({
								"mobileme" : ""+mobile_me,
								"mobilefriend" : ""+mobile_friend
							}),
							timeout : 30000,
							success : function(data) {
								console.log('请求到的数据为：', data)
								if(JSON.stringify(data) != "{}"){								  		  
                                   if(data.ret.result == "3"){
                                     alert("不能重复邀请好友");
                                   }
                                   if(data.ret.result == "4"){
                                     alert("您的好友已经邀请过您，您不能再次邀请他/她");
                                   }
                                   if(data.ret.result == "5"){
                                     alert("您邀请的好友已经在使用逛鱼搜索了");
                                   }
                                   if(data.ret.result == "0"){
                                     alert("邀请好友成功，请细心教导好友使用逛鱼搜索，当好友通过逛鱼搜索完成购买任务时，您才可以得到奖励哦！");
                                   }
								}				
							},
							error : function(XMLHttpRequest, textStatus,
									errorThrown) {
								console.log('请求失败')
							}
						});
		}
	</script>
<@model.webendsearch />
