$.ajaxSetup({
	   dataType:"json",
	    timeout:10000,
		statusCode:{
			401:function(data){
					  location.href="/admin/login";
				  },
			403:function(data){
				  alert("对不起，您的权限不足");
			  }
		}
	}
);

var fangs = {
	    userInfo:{
         getIndustryType:function(type){
			switch(type){
				case 'B1017':return '政府机关国企';
			   case 'B1018':return '制造业';
			   case 'B1019':return '商业贸易';
			   case 'B1020':return '工程类';
			   case 'B1021':return '住宿餐饮';
			   case 'B1022':return '文化科教';
			   case 'B1024':return '网络，计算机，通信服务';
			   case 'B1025':return '金融机构';
			   case 'B1026':return '运输业';
			   case 'B1027':return '养殖种植业';
			   case 'B1028':return '广告娱乐';
			   case 'B1029':return '中介外包';
			   case 'B1030':return '采矿业';
               case "B1031":return '电热燃气水生产';
               case "B1032":return '科学研究技术';
               case "B1033":return '零售业';
               case "B1034":return '水利、环境和公共设施管理业';
               case "B1035":return '卫生和社会工作';
               case "B1036":return '文化、体育和娱乐业';
               case "B1037":return '国际组织';
			}
		 },
		 getPosition:function(type){
			switch(type){
				case 'F12301':return '一般职业';
				case 'F12302':return '农牧业';
				case 'F12303':return '渔业';
				case 'F12304':return '木材、森林业';
				case 'F12305':return '矿业、采石业';
				case 'F12306':return '交通运输业';
				case 'F12307':return '餐旅业';
				case 'F12308':return '建筑工程业(土木工程)';
				case 'F12309':return '制造业';
				case 'F12310':return '新闻、出版、广告业';
				case 'F12311':return '卫生';
				case 'F12312':return '娱乐业';
				case 'F12313':return '文教';
				case 'F12314':return '宗教';
				case "F12315":return '公共事业';
                case "F12316":return '商业';
                case "F12317":return '金融业';
                case "F12318":return '服务业';
                case "F12319":return '家庭管理';
                case "F12320":return '治安人员';
                case "F12321":return '军人';
                case "F12322":return '体育';
                case "F12323":return '资讯';
                case "F12324":return '其它';
			}
		 },
		 getEducation(type){
			switch(type){
				case 'B0301':return '初中及以下';
				case 'B0302':return '中专';
				case 'B0303':return '高中';
				case 'B0304':return '大专';
				case 'B0305':return '本科';
				case 'B0306':return '硕士及以上';
				case 'B0307':return '保密';
			}
		 },
		 getLoanUse:function(type){
			switch(type){
				case 'F11010' :return '住宅装修';
				case 'F11020' :return '旅游';
				case 'F11030' :return '购买原材料';
				case 'F11040' :return '店面装修';
				case 'F11050' :return '进货';
				case 'F11060' :return '开分公司或分店';
				case 'F11070' :return '买车';
				case 'F11080' :return '购买设备';
				case 'F11090' :return '购买家具或家电';
				case 'F11100' :return '结婚';
				case 'F11110' :return '学习';
				case 'F11120' :return '个人或家庭消费';
				case 'F11130' :return '资金周转';
				case 'F11140' :return '租房';
		 }
		 },
		 getMarriage:function(type){
			switch(type){
				case 'B0501' :return '未婚';
				case 'B0502' :return '已婚';
				case 'B0503' :return '丧偶';
				case 'B0504' :return '离异';
				case 'B0505' :return '再婚';
				case 'B0506' :return '未知';
			}
		 },
		 getMonthRec:function(type){
			if(type=='B20201'){
				return "3500以下";
			}else if(type=='B20202'){
			  return "3500-6000";
			}else if(type=='B20203'){
			 return "6000-10000";
			}else if(type=='B20204'){
			 return  "10000-20000";
			}else if(type=='B20205'){
			 return "20000以上";
			}
		 },
		 getIncomeType:function(type){
			if(type=='B20301'){
				return "工资奖金";
			}else if(type=='B20202'){
			  return "经营收入";
			}else if(type=='B20303'){
			  return "投资理财";
			}else if(type=='B20304'){
			 return "房租收入";
			}else if(type=='B20305'){
			 return "其他收入";
			}
		 },
		 getLoanInfo:function(type){
			switch(type){
				case 'F1201' :return '房屋按揭贷款';
				case 'F1202' :return '个人信用贷款';
				case 'F1203' :return '经营贷款';
				case 'F1204' :return '汽车贷款';
				case 'F1205' :return '教育贷款';
				case 'F1206' :return '其他贷款';
			}
			return '无贷款';
		 },
		 getRelation:function(type){
			switch(type){
				case 'F1001' :return '父亲';
				case 'F1002' :return '母亲';
				case 'F1003' :return '配偶';
				case 'F1004' :return '朋友';
				case 'F1005' :return '同事';
				case 'F1006' :return '亲属';
				case 'F1007' :return '共签人';
				case 'F1008' :return '子女';
				case 'F1009' :return '父子';
				case 'F1010' :return '母子';
				case 'F1011' :return '父母';
				case 'F1099' :return '其他';
			}
		 }
		},
	    userStatus:{
          getStatus:function(row){
			if(row.realnameAuthStatus==2){
				return "实名拒绝";
			}
			if((row.teloperatorAuthStatus==0||row.teloperatorAuthStatus==2||row.personalinfoVerifiedStatus=='0'||row.personalinfoVerifiedStatus==2)
			&& row.limitAuditConclusion!=4){
				return '资料未认证';
			} else if (row.limitAuditConclusion==4) {
				return  '审核失败';
			}
			if(row.teloperatorAuthStatus==3&&row.personalinfoVerifiedStatus==3){
				if(row.bindCardStatus==0){
					return '未绑卡';
				}
				if(row.bindCardStatus==2){
					return '绑卡失败';
				}
				if(row.bindCardStatus==3){
					if(row.limitAuditConclusion!=4){
						if(row.maxLoanAmount>0){
							return '已出额';
						}else{
							return '额度被拒';
						}
					}else{
						return '审核失败';
					}
				}
				
			}
		  },
		  getTelStatus:function(row){
			var status = row.teloperatorAuthStatus;
							  if(status ==1){
								  return '审核中';
							  }
							  if(status==2){
								  return '审核失败';
							  }
							  if(status==3){
								  return '已认证';
							  }
							  return '未认证';
		   },
		   getBaseStatus:function(row){
			if(row.personalinfoVerifiedStatus==1){
									 return "审核中";
								 }
								 if(row.personalinfoVerifiedStatus==2){
									 return "审核失败";
								 }
								 if(row.personalinfoVerifiedStatus==3){
									 return "已认证";
								 }
								 return "未认证";
		   }
		},
		exportExcel:function(url,data){
			if(url.indexOf("?")==-1){
				url+="?";
			}
			var form = $("#downLoanFrm");
			form.html("");
			if(data){
				$.each(data,function(i,n){
					form.append('<input type="hidden" name="'+i+'" value="'+n+'"/>');
				});
			}
			form.attr("action",url+new Date().getTime());
			form.trigger('submit');
		},
		formatDate:function(dt, fmt) {
			var o = {
		        "M+": dt.getMonth() + 1, //月份 
		        "d+": dt.getDate(), //日 
		        "h+": dt.getHours(), //小时 
		        "m+": dt.getMinutes(), //分 
		        "s+": dt.getSeconds(), //秒 
		        "q+": Math.floor((dt.getMonth() + 3) / 3), //季度 
		        "S": dt.getMilliseconds() //毫秒 
		    };
		    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (dt.getFullYear() + "").substr(4 - RegExp.$1.length));
		    for (var k in o)
		    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		    return fmt;
		},
		initDataTable:function(id,options){
			$.fn.dataTable.ext.errMode = 'none';
			 var initOptions = {
			            paging: true,
			            lengthChange: true,
			            searching: false,
			            ordering:false,
			            info: true,
			            autoWidth: false,
						processing:true,
						order: [],
			            lengthMenu: [10, 20, 30 ],
			            columnDefs:[
                            {targets:'_all',defaultContent:''}
							],
			            language:{
			               info:"当前显示第 _START_ 至 _END_ 条,共 _TOTAL_ 条",
			               infoEmpty: "",
			               emptyTable:'没有查询到数据',
			               zeroRecords:'没有查询到数据',
			               lengthMenu:"每页显示 _MENU_ 条",
			               paginate: {
			        				first:      "第一页",
			       				 last:      "最后一页",
			        				next:       "下一页",
			        				previous:   "上一页"
			   				 }
			            },
			             serverSide:true
					};
			 var settings = $.extend(true,initOptions,options);
			 settings.ajax.data = function(d){
				delete d["columns"];
				delete d["search"];
				delete d["order"];
				if(options&&options.ajax&&options.ajax.data){
					options.ajax.data(d);
				}
			 }
			 var dt =  $("#"+id).DataTable(settings);
			 dt.on("preXhr.dt",function(e, settings, data ){
				var order = dt.order();
				var orderStr = "";
				$.each(order,function(i,n){
					if(n.length>1&&n[0]&&[1]){
						orderStr = orderStr+","+dt.column(n[0]).dataSrc()+" "+n[1];
					}
				})
				if(orderStr.length>0){
				  orderStr = orderStr.substring(1);
				  data.orderStr = orderStr;
				}
			  });
			 return dt;
		},
		confirm:function(options){
			var initOpt = {
					title:'确认',
					text:'您是否确认?',
					ok:function(){
						
					},
					cancel:function(){
						
					}
			}
			$.extend(initOpt,options);
			$('#confirmModal_btn_cancel').on('click',function(){
				if($.isFunction(initOpt.cancel)){
					initOpt.cancel();
					$("#confirmModal").modal('hide');
				}
			});
			$('#confirmModal_btn_ok').on('click',function(){
				if($.isFunction(initOpt.ok)){
					initOpt.ok();
					$("#confirmModal").modal('hide');	
				}
			});
			$("#confirmModalLabel").html(initOpt.title);
			$("#confirmModalText").html(initOpt.text);
			$("#confirmModal").modal();
		},
		post:function(url,data,success,error,timeout,before,compelete){
			fangs.ajax('POST',url,data,success,error,timeout,before,compelete);
		},
		get:function(url,data,success,error,timeout,before,compelete){
			fangs.ajax('GET',url,data,success,error,timeout,before,compelete);
		},
		ajax:function(type,url,data,success,error,timeout,before,compelete){
			if(!timeout){
				timeout=10000;
			}
			$.ajax({
				timeout:timeout,
                url:url,				
				type:type,
				 data:data,
				dataType:'json',
				success:function(data){
					if(data){
						switch(data.code){
						case 200:
							if($.isFunction(success)){
							success(data);
						}
						break;
						case 400:
							if($.isFunction(error)){
								error(data);
							}else{
								if(data.msg){
									alert(data.msg);
								}
							}
							break;
						default:
							if($.isFunction(error)){
								error(data);
							}else{
								if(data.msg){
									alert(data.msg);
								}
							}
							break;
						}
					}
				},
				error:function(){
					if($.isFunction(error)){
						error();
						return;
					}
				}
			});
		}
}