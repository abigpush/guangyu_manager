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
      <ol class="breadcrumb">
        <li><a href="${request.contextPath}/admin/user/index"><i class="fa fa-dashboard"></i>首页</a></li>
        <li class="active">权限管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">
      <div class="row">
        <div class="col-md-12">
          <div class="box">
            <div class="box-header with-border">
              <h3 class="box-title">管理员</h3>
            </div>
            <div class="box-body">

              <form id="searchForm" action="" method="post">
              <div id="msg" class="alert alert-danger" role="alert" style="display:none"></div>
              <div class="row">
               <div class="col-md-2">
               <div class="form-group">
                 <label>权限类型：</label>
                 <select class="form-control select2" name="permissionTpye">
                   <option selected="selected" value="">全部</option>
                   <option value="0">菜单</option>
                   <option value="1">按钮</option>
                 </select>
               </div>
               </div>

               <div class="col-md-2">
               <div class="form-group">
                 <label>权限级别：</label>
                 <select class="form-control select2" name="permissionLevel">
                   <option selected="selected" value="">全部</option>
                   <option value="0">1级</option>
                   <option value="1">2级</option>
                 </select>
               </div>
               </div>

                <div class="col-md-2">
                  <div class="form-group">
                    <label>父级权限：</label>
                    <input class="form-control" type="text"  name="parentName" id=""/>
                  </div>
                </div><!-- /.col -->
                <div class="col-md-2">
                <label>权限名称：</label>
                  <div class="form-group">
                    <input class="form-control" type="text"  name="name" id=""/>
                  </div>
                </div><!-- /.col -->
                <div class="col-md-2">
                   <div class="form-group">
                     <label>状态：</label>
                     <select class="form-control select2" name="permissionStatus">
                       <option selected="selected" value="">全部</option>
                       <option value="0">可用</option>
                       <option value="1">不可用</option>
                     </select>
                   </div>
                 </div>
                <div class="row">
                <div class="col-md-2">
                   <button type="submit" id="searchList" class="btn btn-info pull-right">查询</button>

                   <button type="button" class="btn btn-info pull-right" onclick="showAddModal();">新增</button>
                </div>
              </div><!-- /.row -->
            </form>
            <br> <br>
            <div class="table-responsive">
              <table class="table table-striped table-bordered table-hover table-condensed" id="permissionList">

              </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- /.content -->
  </div>
  <div class="modal fade" id="addPmsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
         <form id="addForm">
         <div id="msg" class="alert alert-danger" role="alert" style="display:none"></div>

         <input type="hidden" id="id" name="id">
         <div class="row">
            <div class="form-group col-md-6">
     			<label for="type">权限类型：</label>
     			<div class="radio">
                  <label>
                    <input type="radio" name="type" id="optionsRadios1" textVal="菜单" value="0"/>菜单
                  </label>
                  <label>
                    <input type="radio" name="type" id="optionsRadios2" textVal="按钮" value="1"/>按钮
                  </label>
                </div>
      		</div>
         </div>

         <div class="row">
            <div class="form-group col-md-6">
             <label for="type">权限级别：</label>
             <select class="form-control select2" id="permissionLevel" name="value" onchange="filterParentPms()">
               <option selected="selected" value="">请选择</option>
               <option value="0" textVal="1级">1级</option>
               <option value="1" textVal="2级">2级</option>
             </select>
            </div>
         </div>

         <div class="row">
            <div class="form-group col-md-6">
             <label for="type">父级权限：</label>
             <select class="form-control select2" id="parentPms" name="parentId">
               <option selected="selected" value="">请选择</option>
             </select>
            </div>
         </div>
         <div class="row">
         <div class="form-group col-md-6">
            <label for="idCardNo">权限名称：</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="请输入权限名称">
         </div>
         </div>
         <div class="row">
         <div class="form-group col-md-6">
            <label for="idCardNo">排序值：</label>
            <input type="text" class="form-control" id="orderBy" name="orderBy" placeholder="请输入排序值">
         </div>
         </div>
         <div class="row">
         <div class="form-group col-md-6">
            <label for="idCardNo">URL：</label>
            <input type="text" class="form-control" id="url" name="url" placeholder="请输入URL">
         </div>
         </div>
         <div class="row">
             <div class="form-group col-md-6">
                <label for="type">状态：</label>
                <div class="radio">
                   <label>
                     <input type="radio" name="status" value="0">可用
                   </label>
                   <label>
                     <input type="radio" name="status" value="1">不可用
                   </label>
                </div>
            </div>
         </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" onclick="permissionSave()">保存</button>
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
<script type="text/javascript">

    //定义查询变量
    var searchData = new Object();
    searchData.pageNum = 1;
    //定义分页相关数据
    var pageUrl ='${request.contextPath}'+"/userpermission/loadpermissionlist";

     $("#searchForm").submit(function(){
        search();
        return false;
    });
     var rowData=null;

     var dt=null;
     $(function() {
         dt = fangs.initDataTable('permissionList',{
                ajax:{
                       url:pageUrl,
                       data:function(d){
                            d.permissionType =$.trim($("#searchForm select[name='permissionTpye'] option:selected").val());
                            d.permissionLevel =$.trim($("#searchForm select[name='permissionLevel'] option:selected").val());
                            d.parentName =$.trim($("#searchForm input[name='parentName']").val());
                            d.name =$.trim($("#searchForm input[name='name']").val());
                            d.permissionStatus =$.trim($("#searchForm select[name='permissionStatus'] option:selected").val());
                       },
                     },
                 columns: [
                    { title: "权限ID",data:"id" },
                    { title: "权限类型" ,data:"permission_type"},
                    { title: "权限级别",data:'permission_level' },
                    { title: "父级权限",data:'parent_name' },
                    { title: "权限名称",data:'name' },
                    { title: "状态",render:function(d,t,r){
                         switch(r.status){
                            case 0:return '可用';
                            case 1:return '不可用';
                         }
                    }},
                    {title:"",render:function(d,t,r){
                        var text = "";
                        text+='<div><ul><li><a href="javascript:void(0)" onclick="showUpdateModal(\''+r.id+'\')" >修改</a> | ';
                        if(r.status==0){
                            text+='<a href="javascript:void(0)" onclick="updateStatus(\''+r.id+'\',1)" >禁用</a></li>';
                        }else{
                            text+='<a href="javascript:void(0)" onclick="updateStatus(\''+r.id+'\',0)" >启用</a></li>';
                        }
                     return text+='</ul></div>';
                    }},
                ]
            });

     });

    function search(){
         dt.ajax.reload(null,true);
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
          console.log("ssss",id, rowData.status);

    	  if(rowData!=null){
    	    $("#addForm input[name='type']").attr("disabled",true);
 			$("#addForm input[name='type'][textVal=" +rowData.permission_type +"]").attr("checked",true);
            $("#addForm select[name='value']").find("option[textVal='" +rowData.permission_level + "']").attr("selected",true);
 			if (rowData.parent_id != 0) {
              //$("#addForm select[name='parentId'] option").remove();
              filterParentPms();
              $("#addForm select[name='parentId']").find("option[textVal='" +rowData.parent_name + "']").attr("selected",true);
 			}
 			if(rowData.parent_id == 0) {
              $("#addForm select[name='parentId']").attr("disabled",true);
 			}
 			$("#addForm input[name='id']").val(rowData.id);
 			$("#addForm input[name='name']").val(rowData.name);
 			$("#addForm input[name='orderBy']").val(rowData.order_by);
 			$("#addForm input[name='url']").val(rowData.url);
 			$("#addForm input[name='status'][value=" +rowData.status +"]").attr("checked",true);
 			$('#addPmsModal').modal('show');
 		  }
    }

    function showAddModal(){
        rowData =null;
        $("#addForm").trigger('reset');
        $("#addForm input[name='id']").val('');
        $('#msg').hide();
        $('#addPmsModal').modal('show');
    }

    function filterParentPms() {
        $("#parentPms").attr("disabled",false);
        $("option[name='parentOpt']").remove();
        var permissionLevel = $("select[name='value'] option:selected").val();
        if (permissionLevel == "") {
          return;
        }
        console.log(permissionLevel);
        if (permissionLevel == 0) {
          $("#parentPms").attr("disabled","disabled");
        } else {
          $.ajax({
              url: "${request.contextPath}/userpermission/parentpmslist",
              type: "get",
              async:false,
              data: {
                  "value": permissionLevel
              },
              cache: false,
              dataType: "json",
              success: function(result) {
                console.log(result);
                var html = "";
                  if (result.length > 0) {
                    for (var i = 0; i < result.length; i ++) {
                      html = html + '<option name="parentOpt" value="' + result[i].id +  '" textVal="' + result[i].name + '">' + result[i].name + '</option>'
                    }
                    $("option[name='parentOpt']").remove();
                    $("#parentPms").append(html);
                  }
              },
              error: function(e) {

              }
          });
        }
    }

    function permissionSave() {
      var form = new FormData($("#addForm").get(0));
      $.ajax({
        url: "${request.contextPath}/userpermission/hold",
        type: "POST",
        data: form,
        processData: false,
        contentType: false,
        success : function(result) {
          console.log(result);
          if(result.code == 200) {
            $('#addPmsModal').modal('hide');
            window.location.reload();
          } else if (result.code == 400) {
            $('#addPmsModal').modal('hide');
          }
        }
      });
    }

    function updateStatus(id, status) {
        $.ajax({
            url: "${request.contextPath}/userpermission/modification",
            type: "get",
            data: {
                "id": id,
                "status": status
            },
            cache: false,
            dataType: "json",
            success: function(result) {
              window.location.reload();
            },
            error: function(e) {

            }
        });
    }
</script>
</body>
</html>