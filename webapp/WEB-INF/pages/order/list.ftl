<#assign webTitle="首页" in model>
<#assign webHead in model>
</#assign>
<@model.webhead />
    <!-- 头部 -->
    <@model.webMenu current="" child="" />
		<div class="main" id="main">
			<div class="side clearfix" style="width:85px;height:60px;float:left;"></div>
			<div class="main-container" style="height: auto;">
				
				<!-- 面包屑导航 -->
				<div class="crumb-nav">
					<a href="/plan/list"></a><span class="crumb-nav-bg">订单管理</span>
				</div>
				
				<!-- 筛选 -->
				<div class="ty-effect bor-box">
					<div class="hd">
						<a href="#" class="btn btn-small btn-primary"></a>
						<div class="select-box plan-select-box">
						</div>
						
						

						<a href="javascript:void(0);" class="btn btn-success" id="queryBtn">查询</a>

					</div>
					
					<!-- 数据报表 -->
					<div class="data-report">
						<div class="bd">
							<table width="100%" cellpadding="0" cellspacing="0" border="0" class="setsorttable" id="plan">
								<thead>
									<tr>
										<th></th>
										<th style="width:30px">编号</th>
										<th >订单号</th>
										<th >客户手机号</th>
										<th >支付宝账号</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
								
								<!-- 翻页 -->
							</table>
						</div>
					</div>
				</div>
				<!--resolve E-->
				<div class="hold-bottom" style="height:30px"></div>
			</div>
		</div>
	</div>
	
	<!-- 日限额 -->
	<div class="edit-price _edit_price">
		<div class="txt">
			<p><input type="text" name="val" class="form-control _val"> <span>元</span><input type="hidden" name="t" value="edit" /><input type="hidden" name="id" value="" /><input type="hidden" name="editType" value="1" /></p>
			<p id="limitationTip" class="s-grey">请输入数字，并保留小数点后两位</p>
		</div>
		<div class="s-btnline">
			<input type="button" class="queding" id="submit1" value="确定">
			<a href="javascript:void(0);" class="quxiao">取消</a>
		</div>
	</div>
	<input type="hidden" name="unitPage" id="unitPage"/>
	<input type="hidden" name="unitPlanId" id="unitPlanId"/>
	<!-- 出价 -->
	<div class="edit-price _edit_bid">
		<div class="txt">
			<p><input type="text" name="val" class="form-control _val"> <span>元</span><input type="hidden" name="t" value="edit" /><input type="hidden" name="id" value="" /><input type="hidden" name="editType" value="2" /></p>
			<p id="advPriceTip" class="s-grey">请输入数字，并保留小数点后两位</p>
		</div>
		<div class="s-btnline">
			<input type="button" class="queding" id="submit2" value="确定">
			<a href="javascript:void(0);" class="quxiao">取消</a>
		</div>
	</div>
	
	<style type="text/css">
		.data-report .bd tbody tr td{ border-right: 1px solid #ddd;}
		.unit-tab{ border:1px solid #bbb; margin-top: -5px;}
		.data-report .bd .unit-tab thead th{ background-color: #fafafa; }
		.data-report .bd .unit-tab tr td:last-child{ border-right: 0;}
		.data-report .bd .unit-tab tfoot td{ padding: 3px 10px;}
		.data-report .bd .unit-tab tfoot td .btn{ color:#fff;padding: 1px 5px;float:left; font-size: 12px;}
		.data-report .bd .unit-tab tfoot td .page a{ border:0; padding:0 5px; background: none;}
	</style>
	
	<script type="text/javascript" src="${model.static_domain}/js/jquery-1.11.3.min.js"></script>

	<!-- 弹出框 -->
	<script type="text/javascript" src="${model.static_domain}/js/layer/layer.js"></script>

	<!-- 下拉 -->
	<link href="${model.static_domain}/js/select/jquery.searchableSelect.css" rel="stylesheet">
	<script src="${model.static_domain}/js/select/jquery.searchableSelect.js"></script>

	<!-- 排序 -->
	<script src="${model.static_domain}/js/table/jquery.dataTables.min.js"></script>

	<!-- 日期 -->
	<link rel="stylesheet" href="${model.static_domain}/js/date/jquery-ui-1.9.2.custom.css" type="text/css">
	<script type="text/javascript" src="${model.static_domain}/js/date/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript" src="${model.static_domain}/js/date/share.js"></script>
	
	<!-- 排序 -->
	<script type="text/javascript">
		
	</script>
	<!-- common.js -->
	<script type="text/javascript" src="${model.static_domain}/js/common.js"></script>
	
	<!-- TIPS -->
	<script type="text/javascript" src="${model.static_domain}/js/jquery.tips.min.js"></script>
	
	<script type="text/javascript">
		var table = $('#plan').DataTable({
			paging:         false,	 //分页
			searching: 		false,	 //每页的条数
			lengthChange: 	false,	 //搜索
			bInfo: 			false,	     //页脚信息
			bSort:           false,     //排序
			"language": {
				"zeroRecords": "没有数据"
			}
		});

	 		//弹出一个层
			$('.unit-state .oper-but a').on('click', function(){
				var dos = $(this).attr('dos');
				var unitId = $(this).attr('unitId');
				var planId = $(this).attr('planId');
				var desc = $(this).attr('desc');
				var page = $(this).attr('page');
				<#--点击修改不需要执行ajax-->
				if(dos == 'editUnit')return;
				
				layer.confirm('请确认是否<b class="s-red">'+desc+'</b>该单元', {
					icon :3,
					btn: ['确定','取消'] //按钮
				}, function(){
					$.ajax({
		                url: "/unit/updateStatus",
		                type: "post",
		                data: {
		                    "dos": dos,
		                    "unitId": unitId
		                },
		                cache: false,
		                dataType: "json",
		                success: function(datas) {
		                    var resultRet = datas.ret;
		                    if(resultRet.code == 501){
			                	layer.confirm("该单元下的创意还在投放，不能删除", {
									icon: 0,
									btn: ['确定'] //按钮
								});
		                    }else if (resultRet.code == 502) {
			                	layer.confirm("该单元日限额不足，不能启用", {
									icon: 0,
									btn: ['确定'] //按钮
								});
		                    }else if (resultRet.code == 101) {
			                	layer.confirm(desc + "失败", {
									icon: 0,
									btn: ['确定'] //按钮
								});
		                    } else {
			                	layer.confirm(desc + "成功", {
									icon: 1,
									btn: ['确定'] //按钮
								}, function(){
									<#--重新加载该计划下的单元-->	
									pagging(page,planId);
									layer.closeAll();
								});
		                    }
		                },
		                error: function(e) {
		                	layer.confirm("操作计划失败", {
								icon: 0,
								btn: ['确定'] //按钮
							});
		                }
		            });
				});
			});
			
			$(window).scroll(function(){
				$('.edit-price').hide();
			});
				
			// 取消
			$('.quxiao').on('click', function(){
				$(this).closest('.edit-price').hide();
			});
			
	
		$(function(){
			$(window).resize();
		});
		
		$(window).resize(function() {
			var h = $(window).outerHeight() + 15;
			$('.main-container').css('min-height', h);
		});
		
		$(function() {
			// 下拉
			$('.plan-select').searchableSelect();
			
			// 查询
			$("#queryBtn").on("click", function() {
				var id = $("select[name=id]").val();
				var status = $("select[name=status]").val();
				var adType = $("select[name=adType]").val();
				
				window.location.href = "/plan/list?id=" + id + "&status=" + status + "&adType=" + adType;
			});
			
			// 状态
			$(".plan-state").mouseenter(function(){
				$(this).find(".plan-state-default").addClass("plan-state-open");
				$(this).find(".oper-but").css("left",$(this).find('.plan-state-default').width() + 20);
				
				$(this).find(".plan-state-open").width($(this).find('.oper-but').width() + $(this).find('.plan-state-default').width()+10);
				return false;
			});
			$(".plan-state").mouseleave(function(){
				$(this).find(".plan-state-default").removeClass("plan-state-open");
				$(this).find(".plan-state-default").width("auto");
			});
			
    		//弹出一个层
			$('.plan-state .oper-but a').on('click', function(){
				var dos = $(this).attr('dos');
				var planId = $(this).attr('entityId');
				var desc = $(this).attr('desc');
				//stopBtn deleteBtn startBtn
				layer.confirm('请确认是否<b class="s-red">'+desc+'</b>该计划', {
					icon :3,
					btn: ['确定','取消'] //按钮
				}, function(){
					$.ajax({
		                url: "/plan/updateStatus",
		                type: "post",
		                data: {
		                    "dos": dos,
		                    "planId": planId
		                },
		                cache: false,
		                dataType: "json",
		                success: function(datas) {
		                    var resultRet = datas.ret;
		                    if (resultRet.code == 501) {
			                	layer.confirm(resultRet.resultDes, {
									icon: 0,
									btn: ['确定'] //按钮
								});
		                    } else if (resultRet.code == 502) {
			                	layer.confirm(resultRet.resultDes, {
									icon: 0,
									btn: ['确定'] //按钮
								});
		                    } else if (resultRet.code == 101) {
			                	layer.confirm(desc + "失败", {
									icon: 0,
									btn: ['确定'] //按钮
								});
		                    } else {
		            			layer.confirm(desc+'成功', {
									icon :1,
									btn: ['确定'] //按钮
								}, function(){
									window.location.reload();
								});
		                    }
		                },
		                error: function(e) {
		                	layer.confirm("操作计划失败", {
								icon: 0,
								btn: ['确定'] //按钮
							});
		                }
		            });
				});
			});
			
		});
		
		// TIPS
		$('label.tab-tips a').tipso({
			background: '#49a8e7'
		});
	</script>
<@model.webend />