<#assign webTitle="首页" in model>
<#assign webHead in model>
</#assign>
<@model.webhead />
    <!-- 头部 -->
    <@model.webMenu current="order" child="orderSearch" />
			<div class="main-container" style="height: auto;">
				
				<!-- 筛选 -->
				<div class="ty-effect bor-box">
				<form id="searchForm" action="post">
					<div class="hd">
						<div class="select-box plan-select-box">
							<label>订单状态：</label>
							<select class="form-control" style="height:37px;width:95px;">
								<option>全部</option>
								<option value="1">未审核</option>
								<option value="2">已审核</option>
								<option value="3">无效订单</option>
							</select>
						</div>
						
						<div class="select-box plan-select-box">
							<label>提现状态：</label>
							<select class="form-control" style="height:37px;width:95px;">
								<option value="">全部</option>
								<option value="1">未提现</option>
								<option value="2">提现申请中</option>
								<option value="3">已提现</option>
							</select>
						</div>
						
						<div class="select-box plan-select-box">
							<label>支付状态：</label>
							<select class="form-control" style="height:37px;width:95px;">
								<option value="">全部</option>
								<option value="1">未支付</option>
								<option value="2">已支付</option>
							</select>
						</div>

						<a href="javascript:void(0);" class="btn btn-success" id="queryBtn">查询</a>
                    </form>
					</div>
					
					<!-- 数据报表 -->
					<div class="data-report">
						<div class="bd">
							<table width="100%" cellpadding="0" cellspacing="0" border="0" class="setsorttable" id="plan">
								<thead>
									<tr>
										<th style="width:30px">编号</th>
										<th >订单号</th>
										<th >手机号</th>
										<th >创建时间</th>
										<th >更新时间</th>
										<th >商品名称</th>
										<th >商品价格</th>
										<th >返现比例</th>
										<th >真实佣金</th>
										<th >客户佣金</th>
										<th >订单状态</th>
										<th >提现状态</th>
										<th >是否已支付</th>
										<th >操作</th>
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
    
    <script type ="text/javascript" scr="${model.static_domain}/js/jquery-2.1.4.min.js"></script>

	<script type="text/javascript">
$("#datetimepicker").datetimepicker();
		$(function(){
		  console.log("1243")
		});
	</script>
<@model.webend />