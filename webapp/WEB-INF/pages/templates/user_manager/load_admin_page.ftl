<!DOCTYPE html>
<html>
<head>
   <#include "../common/commonCss.ftl" />
</head>

<body class="hold-transition skin-blue fixed sidebar-mini">
<div class="wrapper">
 
  <!-- Main Header -->
 	<#include "../header.ftl" />

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        用户管理
      </h1>
      <ol class="breadcrumb">
        <li><a href="${request.contextPath}/admin/user/index"><i class="fa fa-dashboard"></i>首页</a></li>
        <li class="active">用户管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">
      <div class="row">
      
      
        <div class="col-md-12">
          <div class="box">
            <div class="box-header with-border">
              <h3 class="box-title"></h3>
            </div>
            <div class="box-body">
            
              <form id="searchForm" >
              <div class="row">
                <div class="col-md-2">
                <label for="type">用户名：</label>
                  <div class="form-group">
                    <input class="form-control" type="text"  name="adminId" id="adminId" />
                  </div>
                </div>

                <div class="col-md-2">
                <label for="type">姓名：</label>
                  <div class="form-group">
                    <input class="form-control" type="text" name="realName" id="realName" />
                  </div>
                </div><!-- /.col -->


                <div class="col-md-2">
                <label for="type">状态：</label>
                 <select class="form-control select2" id="accountStatus" name="accountStatus">
                   <option selected="selected" value="">请选择</option>
                   <option value="0" textVal="可用">可用</option>
                   <option value="1" textVal="禁用">禁用</option>
                 </select>
                </div>

                <div class="col-md-3" >
                  <button type="submit" class="btn btn-primary">查询</button>
                </div>
                </div>


              </div><!-- /.row -->
            </form> 
            <hr>
             <button type="button" class="btn btn-success" onclick="showAddModal();">
            添加</button>
            <br> <br>
            <div class="table-responsive">
              <table class="table table-striped table-bordered table-hover table-condensed" id="userList">
              </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- /.content -->
  </div>
  <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">管理员</h4>
      </div>
      <div class="modal-body">
         <form id="adminForm">
         <div id="msg" class="alert alert-danger" role="alert" style="display:none"></div>
          <input type="hidden" id="id" name="id">
          
         <div class="row">
         <div class="form-group col-md-6">
   			 <label for="adminId">用户名</label>
    			<input type="text" class="form-control" id="adminId" name="adminId" placeholder="请输入用户名">
  		</div>
         </div>
         <div class="row">
         <div class="form-group col-md-6">
            <label for="realName">真实姓名</label>
            <input type="email" class="form-control" id="realName" name="realName" placeholder="请输入真实姓名">
         </div>
         </div>
         <div class="row ">
  		<div class="form-group col-md-6">
            <label for="dept">部门</label>
            <input type="text" class="form-control" id="dept" name="dept" placeholder="请输入部门">
  		</div>
        </div>

         <div class="row">
           <div class="form-group col-md-6">
             <label for="realName">职务</label>
             <input type="email" class="form-control" id="post" name="post" placeholder="请输入职务">
           </div>
         </div>

         <div class="row">
              <div class="form-group col-md-6">
                 <label for="type">状态：</label>
                 <div class="radio">
                    <label>
                      <input type="radio" name="accountStatus" value="0" checked>可用
                    </label>
                    <label>
                      <input type="radio" name="accountStatus" value="1">不可用
                    </label>
                 </div>
             </div>
         </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" onclick="adminSave()">保存</button>
      </div>
    </div>
  </div>
</div>

	<div class="modal fade" id="roleModal" tabindex="-1" role="dialog" aria-labelledby="roleModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="roleModalLabel"></h4>
                </div>
                <div class="modal-body" style="max-height:500px !important;overflow: scroll;">
                    <form id="roleForm">
                        <input type="hidden" id="adminId" name="adminId">
                        <input type="hidden" id="pers" name="pers">
                    </form>
                    <div class="table-responsive">
                        <table id="r_list" class="table table-striped table-bordered table-hover table-condensed" width="100%">
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="userRoleSave()">保存</button>
                </div>
            </div>

        </div>
    </div>
</div>

	<!-- /.content-wrapper -->

  <!-- Main Footer -->
  <#include "../footer.ftl" />

</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
 <#include "../common/commonJS.ftl" />
<!-- --------------------------------时间范围选择器 begin---------------------------------------------- -->
<link rel="stylesheet" type="text/css" href="${request.contextPath}/adminLTE/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
<script type="text/javascript" src="${request.contextPath}/adminLTE/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/adminLTE/bower_components/bootstrap-datepicker/dist/locales/bootstrap-datepicker.zh-CN.min.js"></script>
<script type="text/javascript">
   $('#beginDate').datepicker(
	  {  
	    language:  "zh-CN",  
	    autoclose: true,  
	    startView: 0,  
	    format: "yyyy-mm-dd",  
	    clearBtn:true,  
	    todayBtn:false,  
	    endDate:new Date()  
	  }).on('changeDate', function(ev){               
	    if(ev.date){  
	        $("#endDate").datepicker('setStartDate', new Date(ev.date.valueOf()))  
	    }else{  
	        $("#endDate").datepicker('setStartDate',null);  
	    }  
	  }); 
  
      $("#endDate").datepicker(
      {  
        language:  "zh-CN",  
        autoclose: true,  
        startView:0,  
        format: "yyyy-mm-dd",
        clearBtn:true,  
        todayBtn:false,  
        endDate:new Date()  
      }).on('changeDate', function(ev){    
        if(ev.date){  
             $('#beginDate').datepicker('setEndDate', new Date(ev.date.valueOf()))  
        }else{  
             $('#beginDate').datepicker('setEndDate',new Date());  
        }   
  
     });  

</script>
<!-- --------------------------------时间范围选择器 end---------------------------------------------- -->
 

    <script type="text/javascript">
    //定义查询变量
	var searchData = new Object();
	searchData.pageNum = 1;
	//定义分页相关数据
	var pageUrl ='${request.contextPath}'+"/admin/loadadminlist";
     
     $("#searchForm").submit(function(){
		search();
		return false;
	});
     var rowData=null;
     function showAddModal(){
    	    rowData =null;
    	    $("#adminForm").trigger('reset');
    	    $("#adminForm input[name='id']").val('');
    	    $('#msg').hide();
    	     $('#myModal').modal('show');
    	    }
     function showUpdateModal(id){
    	 $('#msg').hide();
    	  var data = dt.data();
          for(var i = 0;i!=data.length;i++){
            if(data[i].id==id){
            rowData = data[i];
            break;
            }
          }
    	 if(rowData!=null){
    		$("#adminForm input[name='id']").val(rowData.id);
 			$("#adminForm input[name='adminId']").val(rowData.adminId);
 			$("#adminForm input[name='realName']").val(rowData.realName);
 			$("#adminForm input[name='dept']").val(rowData.dept);
 			$("#adminForm input[name='post']").val(rowData.post);
 			$('#myModal').modal('show');
 		}
     }
     var dt=null;
	 $(function() {
		 dt = fangs.initDataTable('userList',{
				ajax:{
		               url:pageUrl,
		               data:function(d){
		            	    d.adminId =$.trim($("#searchForm input[name='adminId']").val());
		            	    d.realName =$.trim($("#searchForm input[name='realName']").val());
		            	    d.accountStatus =$.trim($("#searchForm select[name='accountStatus'] option:selected").val());
		               },
		             },
		         columns: [
		            { title: "用户名",data:"adminId" },
		            { title: "姓名" ,data:"realName"},
		            { title: "部门",data:'dept' },
		            { title: "状态",render:function(d,t,r){
		            	 switch(r.accountStatus){
		            	 	case 0:return '可用';
		            	 	case 1:return '禁用';
		            	 }
		            }},
		            {title:"操作",render:function(d,t,r){
                        var text = "";
                        text+='<div><a href="javascript:void(0)" onclick="showUpdateModal(\''+r.id+'\')" >修改</a> | ';
                        text+='<a href="${request.contextPath}/admin/roleList?userId='+r.id+'" >角色</a> | ';
                        if(r.accountStatus==0){
                            text+='<a href="javascript:void(0)" onclick="updateStatus(\''+r.id+'\',1)" >禁用</a> | ';
                        }else{
                            text+='<a href="javascript:void(0)" onclick="updateStatus(\''+r.id+'\',0)" >启用</a> | ';
                        }
                        text+='<a href="javascript:void(0)" onclick="initPassword(\''+r.id+'\')" >初始化密码</a>';
                     return text+='</div>';
                    }}
		        ]
			});
	   
	 });
	  
	function search(){
		 dt.ajax.reload(null,true);
	}
	
	function updateStatus(id,type){
		var url = '${request.contextPath}/admin/accountstatus';
		var msg = "";
		if(type==1){
			msg="确认禁用该用户?";
		}else{
			msg="是否可用该用户?";
		}
        fangs.confirm({
          text:msg,
          ok:function(){
             fangs.get(url,{id:id, accountStatus:type},function(){
                dt.ajax.reload(null,false);
             });
          }
        });
	}

	function initPassword(id){
        var url = '${request.contextPath}/admin/reset';
        var msg = "是否初始化该用户的密码？";
        fangs.confirm({
          text:msg,
          ok:function(){
             fangs.get(url,{id:id},function(){
                dt.ajax.reload(null,false);
             });
          }
        });
    }
	
	function adminSave(){
        var adminId= $.trim($("#adminForm input[name='adminId']").val());
        var realName= $.trim($("#adminForm input[name='realName']").val());
        var dept= $.trim($("#adminForm input[name='dept']").val());
		var post= $.trim($("#adminForm input[name='post']").val());
		if(adminId.length<=0){
			$('#msg').text("用户名不能为空");
			$('#msg').show();
			return;
		}
		if(adminId.length > 50){
            $('#msg').text("用户名最大不能超过50个字");
            $('#msg').show();
            return;
        }
        if(realName.length<=0){
            $('#msg').text("真实姓名不能为空");
            $('#msg').show();
            return;
        }
        if(realName.length > 50){
            $('#msg').text("姓名最大不能超过50个字");
            $('#msg').show();
            return;
        }
        if(dept.length<=0){
            $('#msg').text("部门不能为空");
            $('#msg').show();
            return;
        }
        if(dept.length > 50){
            $('#msg').text("部门最大不能超过50个字");
            $('#msg').show();
            return;
        }
		fangs.post('${request.contextPath}/admin/save',
				$("#adminForm").serialize(),function(data){
			    dt.ajax.reload(null,false);
			    $('#myModal').modal('toggle');
		});
	}

    var dt1=null;
	var admin = null;
	var rs = {};
	function showUpdateUserRolesModal(adminId, adminName) {
        admin={};
        rs = {};
        $('#roleModalLabel').text("管理员角色设置-"+adminName);
        var data = dt.data();
        for(var i = 0;i!=data.length;i++){
            if(data[i].adminId==adminId){
                $.extend(true,admin,data[i]);
                $.each(admin.roles,function(i,n){
                    rs[n.id] = n;
                });
                break;
            }
        }
        var pageUrl ='${request.contextPath}'+"/admin/role/list";
        if(dt1==null){
            dt1 = fangs.initDataTable('r_list',{
                ajax:{
                    url:pageUrl,
                },
                columns: [
                    { title: "",render:function(data,type,row){
                            var checked = '';
                            $.each(rs,function(i,n){
                                if(i ==row.id){
                                    checked = 'checked="checked"';
                                    return  false;
                                }
                            });
                            return '<input type="checkbox" id="'+row.id+'" '+checked+' onclick="rSelect(this)"/>';
                        } },
                    { title: "名称",data:"name",width:100},
                    { title: "描述",data:'description'}
                ]
            });
        }else{
            dt1.ajax.reload(null,true);
        }
        $('#roleModal').modal('show');
	}


    function rSelect(cb){
        var data = dt1.data();
        $.each(data,function(i,n){
            if(n.id==cb.id){
                n.checked =cb.checked;
                rs[n.id] = n;
                return false;
            }
        });
    }

	function userRoleSave() {
        var adminId= admin.adminId;
        var rids = "";
        $.each($("#r_list").find("input[type=checkbox]"),function(i,n){
            if(n.checked){
                rids = rids+","+n.id;
            }
        });
        if(rids.length == 0) {
            return;
		}
        fangs.post('${request.contextPath}'+"/admin/relateRoles",{
            adminId:adminId,
            rids:rids.substring(1)
        },function(){
            $('#roleModal').modal('hide');
            dt.ajax.reload(null,false);
        });
	}
	</script>
     
</body>
</html>