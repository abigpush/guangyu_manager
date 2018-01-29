<#assign webTitle="监测管理-活动编辑" in model>
<#assign webHead in model>
</#assign>
<@model.webhead />
    <!-- 头部 -->
    <@model.webMenu current="监测管理" child="活动管理" />

	<!-- 特色内容 -->
<style type="text/css">
    .basic-info .bd .a-title{width:120px;}
    img.demo {width:50px;}
</style>
<div class="main-container" style="height: auto;">
    <div class="clearfix">
        <div class="main-box basic-info">
            <div class="bd">
                <form id="subForm" method="post">
                    <input type="hidden" id="id" value=""/>
                    <table width="100%" cellpadding="0" cellspacing="0" border="0" type="">
                        <tbody>

                        <tr>
                            <td class="a-title"><font class="s-red">*</font>广告活动名称：</td>
                            <td>
                                <input type="text"  id="activityName" name="activityName" value="" autocomplete="off" class="form-control">
                                <span id="activityNameTip"></span>
                                <input type="button" id="btnDemo" class="btn btn-green" value="演示专用"/>
                            </td>
                        </tr>

                        <tr>
                            <td class="a-title"><font class="s-red">*</font>投放时间：</td>
                            <td>
                                <div class="ll inputs-date">
                                    <div class="date">
                                        <input id="dts" class="Wdate" type="text"> -
                                        <input id="dt" class="Wdate" type="text">
                                    </div>
                                </div>
                                <span id="usernameTip"></span>
                            </td>
                        </tr>

                        <tr>
                            <td class="a-title"><font class="s-red">*</font>投放地区：</td>
                            <td>
                                <#--<input type="text" style="width:100px;"  id="province" name="province" value="浙江省" autocomplete="off" class="form-control">-->
                                <#--<a class="addBtn" href="javascript:;" id="resource_sel">选择</a>-->
                                <div class="select-box select-box-100 un-inp-select">
                                    <select name="province" class="select" id="province">
                                        <option value="1">浙江省</option>
                                    </select>
                                </div>
                                    <div class="select-box select-box-100 un-inp-select">
                                    <select name="city" class="select" id="city">
                                        <option value="2">杭州市</option>
                                    </select>
                                </div>
                                    <div class="select-box select-box-100 un-inp-select">
                                    <select name="region" class="select" id="region">
                                        <option value="3">滨江区</option>
                                    </select>
                                </div>
                                    <div class="select-box select-box-100 un-inp-select">
                                    <select name="street" class="select" id="street">
                                        <option value="4">西兴街道</option>
                                    </select>
                                </div>
                                <span id="provinceTip"></span>
                            </td>
                        </tr>

                        <tr>
                            <td class="a-title"><font class="s-red">*</font>媒体选择：</td>
                            <td>
                                <label>
                                    <input type="checkbox" name="media" id="media0" value="1" checked  > 媒体1
                                </label>
                                <label>
                                    <input type="checkbox" name="media" id="media0" value="2" checked > 媒体2
                                </label>
                                <label>
                                    <input type="checkbox" name="media" id="media0" value="3" checked > 媒体3
                                </label>
                                <label>
                                    <input type="checkbox" name="media" id="media0" value="4" checked > 媒体4
                                </label>
                            </td>
                        </tr>

                        <tr>
                            <td class="a-title"><font class="s-red">*</font>广告位监测：</td>
                            <td>
                                <a class="addBtn" href="javascript:;" id="add-adseat">新增</a>
                            </td>
                        </tr>

                        <tr>
                            <td class="a-title">&nbsp;</td>
                            <td>
                                <div class="data-report" style="margin: 0px;">
                                    <div id="as-container" class="bd" style="padding:0px;">
                                        <#--<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tablesorter" id="plan">-->
                                            <#--<thead>-->
                                            <#--<tr>-->
                                                <#--<th>序号</th>-->
                                                <#--<th>广告位</th>-->
                                                <#--<th>媒体</th>-->
                                                <#--<th>投放品牌</th>-->
                                                <#--<th>监测时间段</th>-->
                                                <#--<th>监测次数</th>-->
                                                <#--<th>监测时间</th>-->
                                                <#--<th>样例</th>-->
                                                <#--<th>操作</th>-->
                                            <#--</tr>-->
                                            <#--</thead>-->
                                            <#--<tbody>-->
                                                <#--<tr>-->
                                                    <#--<td width="30">1</td>-->
                                                    <#--<td>新联路1号灯箱</td>-->
                                                    <#--<td>媒体1</td>-->
                                                    <#--<td>可口可乐</td>-->
                                                    <#--<td>2018-01-01至2018-02-01</td>-->
                                                    <#--<td>3</td>-->
                                                    <#--<td>上刊、投放期间、下刊</td>-->
                                                    <#--<td><img src="http://ottstatic2.taiyiplus.com/images/300x250.gif" class="demo"/></td>-->
                                                    <#--<td>-->
                                                        <#--<a href="javascript:;">详情</a>-->
                                                        <#--<a href="javascript:;">删除</a>-->
                                                    <#--</td>-->
                                                <#--</tr>-->
                                            <#--</tbody>-->
                                        <#--</table>-->
                                    </div>
                                </div>

                            </td>
                        </tr>

                        <tr>
                            <td class="a-title">&nbsp;</td>
                            <td>
                                <input type="submit" id="btnSave" class="btn btn-red" value="　保 存　"/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</div>

<script type="text/javascript" src="${model.static_domain}/js/jquery-2.1.4.min.js"></script>
<!-- 下拉 -->
<link href="${model.static_domain}/js/select/jquery.searchableSelect.css" rel="stylesheet">
<script src="${model.static_domain}/js/select/jquery.searchableSelect.js"></script>
<script src="${model.static_domain}/js/ajaxfileupload.js"></script>
<!-- 时期 -->
<link href="${model.static_domain}/js/date/daterangepicker.css" rel="stylesheet">
<script type="text/javascript" src="http://ottstatic2.taiyiplus.com/js/date/moment.min.js"></script>
<script type="text/javascript" src="http://ottstatic2.taiyiplus.com/js/date/jquery.daterangepicker.js"></script>
<script type="text/javascript" src="http://ottstatic2.taiyiplus.com/js/date.js"></script>
<!-- 图片缩放 -->
<script type="text/javascript" src="${model.static_domain}/js/jquery.resize.js"></script>
<!-- formValidator -->
<link type="text/css" rel="stylesheet" href="${model.static_domain}/js/formValidator/style/validator.css"></link>
<script type="text/javascript" src="${model.static_domain}/js/formValidator/formValidator-4.0.1.js"></script>

<script type="text/javascript">

    var mod_activity_seat = null;
    <#if activity?exists>
    var activity = {
        "id":${activity.id},
        "activityName": '${activity.activityName}',
        "dts":"${activity.startTime?string('yyyy-MM-dd')}",
        "dt":"${activity.endTime?string('yyyy-MM-dd')}"
    }
    var activity_seats = [
    <#if (activity.activitySeats?exists && activity.activitySeats?size>0) >
        <#list activity.activitySeats as seat>
            {
                id: ${seat.id},
                mediaId: "${seat.mediaId}",
                mediaName: "${seat.mediaName}",
                seatId: "${seat.adSeatId}",
                seatName: "${seat.adSeatName}",
                startDate: "${seat.monitorStart?string("yyyy-MM-dd")}",
                endDate: "${seat.monitorEnd?string("yyyy-MM-dd")}",
                brand: "${seat.brand}",
                upMonitor: "${seat.upMonitor}",
                downMonitor:  "${seat.downMonitor}",
                durationMonitor:  "${seat.durationMonitor}",
                monitorCount:  "${seat.monitorCount}",
                samplePicUrl:  "${seat.samplePicUrl}"
            }<#if seat_has_next>,</#if>
        </#list>
    </#if>
    ];
    var activity_meias = [
        <#if (activity.activityMedias?exists && activity.activityMedias?size>0) >
            <#list activity.activityMedias as media>
                ${media.mediaId}<#if media_has_next>,</#if>
            </#list>
        </#if>
    ]
    <#else>
    var activity = null;
    var activity_seats = [];
    var activity_meias = [];
    </#if>
    $(function(){
        $(".nav-sidebar>ul>li").on("click",function(){
            $(".nav-sidebar>ul>li").removeClass("on");
            $(this).addClass("on");
        });
    });

    $(function(){
        $(window).resize();
    });

    $(window).resize(function() {
        var h = $(document.body).height() - 115;
        $('.main-container').css('height', h);
    });

    $(function(){

        // 下拉
        $('.select').searchableSelect();

        //日期
        $('.inputs-date').dateRangePicker({
            separator : ' 至 ',
            showShortcuts:false,
            getValue: function()
            {
                if ($('#dts').val() && $('#dt').val() )
                    return $('#dts').val() + ' 至 ' + $('#dt').val();
                else
                    return '';
            },
            setValue: function(s,s1,s2)
            {
                $('#dts').val(s1);
                $('#dt').val(s2);

            }
        });

        $("#add-adseat").click(function(){
            mod_activity_seat=null;
            layer.open({
                type: 2,
                title: '新增广告位监测',
                shade: 0.8,
                area: ['820px', '600px'],
                content: '/customer/activity/adseat/edit' //iframe的url
            });
        });

        //表单处理
        $.formValidator.initConfig({
            validatorGroup:"2",
            submitButtonID: "btnSave",
            debug:true ,
            submitOnce: false,
            errorFocus: false,
            onSuccess: function(){
                var activityName = $("#activityName").val(); //活动名
                var startDate = $("#dts").val(); //投放开始时间
                var endDate = $("#dt").val(); //投放结束时间
                var province = $("#province").val();//省
                var city = $("#city").val();
                var region = $("#region").val();
                var street = $("#street").val();
                var media = [];
                $("input[name='media']:checked").each(function (i,n) {
                    media.push($(n).val());
                });
                $.ajax({
                    url: "/customer/activity/save",
                    type: "post",
                    data: {
                        "id": $("#id").val() ,
                        "activityName": activityName,
                        "startDate": startDate,
                        "endDate": endDate,
                        "area":JSON.stringify([{"province":province,"city":city,"region":region,"street":street}]),
                        "city":city,
                        "region":region,
                        "street":street,
                        "media":media.join(","),
                        "activeSeat":JSON.stringify(activity_seats)
                    },
                    cache: false,
                    dataType: "json",
                    success: function(datas) {
                        var resultRet = datas.ret;
                        if (resultRet.code == 101) {
                            layer.confirm(resultRet.resultDes, {
                                icon: 2,
                                btn: ['确定'] //按钮
                            });
                        } else {
                            var msg = "新增成功";
                            if (id != null && id != "") {
                                msg = "编辑成功";
                            }
                            layer.confirm(msg, {
                                icon: 1,
                                btn: ['确定'] //按钮
                            }, function(){
                                window.location.href="/customer/activity/list";
                            });
                        }
                    },
                    error: function(e) {
                        layer.confirm("服务忙，请稍后再试", {
                            icon: 5,
                            btn: ['确定'] //按钮
                        });
                    }
                });
            },
            submitAfterAjaxPrompt: '有数据正在异步验证，请稍等...'
        });

//        // 公司名称
//        $("#activityName").formValidator({
//            validatorGroup:"2",
//            onShow:"",
//            onFocus:"请输入活动名称",
//            onCorrect:""
//        }).regexValidator({
//            regExp:"^\\S+$",
//            onError:"活动名称不能为空，请输入"
//        });
    });

</script>

<script type="text/javascript">
    $("#date_val").click(function(){
        if($(".dsp-select").hasClass("hover")){
            $(".dsp-select").removeClass("hover")
            $(".time-conditions").hide();
        }else{
            $(".dsp-select").addClass("hover")
            $(".time-conditions").show();
        }
    });


    //以下演示数据

    $(function(){
        $("input:checkbox").change(function(){
            checked_media = [];
            $("input:checkbox:checked").each(function(i,n){
                var _id = n.value*1;
                $.each(media_seats,function(i,m){
                    //console.log(_id+":"+m.id)
                    if(_id == m.id) checked_media.push(m)
                });
            });
        });

        $("#btnDemo").click(function(){
            var demo_data = {
                "activityName" : "可口可乐2018新年投放"+Math.ceil(Math.random()*100),
                "dts":"2018-02-01",
                "dt":"2018-03-01"
            }
            $.each(demo_data,function(key,value){
                $("#"+key).val(value);
            })
        });
        if(activity){
            $("#btnDemo").hide();
            $.each(activity,function(key,value){
                $("#"+key).val(value);
            })
            checked_media=[];
            $.each(media_seats,function (i,n) {
                if(activity_meias.includes(n.id)){
                    checked_media.push(n);
                }else{
                    $("input:checkbox[name='media'][value='"+n.id+"']").removeAttr("checked");
                }
            });
            renderASTable();
        }
    });

    //媒体广告位
    var checked_media = media_seats = [
        {
            id : 1,
            name : '媒体1',
            seats: [
                {
                    id: 1,
                    name:'新联路1号灯箱'
                },
                {
                    id: 2,
                    name:'新联路2号灯箱'
                },
                {
                    id: 3,
                    name:'新联路3号灯箱'
                }
            ]
        },
        {
            id : 2,
            name : '媒体2',
            seats: [
                {
                    id: 4,
                    name:'西兴路1号灯箱'
                },
                {
                    id: 5,
                    name:'西兴路2号灯箱'
                },
                {
                    id: 6,
                    name:'西兴路3号灯箱'
                }
            ]
        },
        {
            id : 3,
            name : '媒体3',
            seats: [
                {
                    id: 7,
                    name:'月明路1号灯箱'
                },
                {
                    id: 8,
                    name:'月明路2号灯箱'
                },
                {
                    id: 9,
                    name:'月明路3号灯箱'
                }
            ]
        },
        {
            id : 4,
            name : '媒体4',
            seats: [
                {
                    id: 10,
                    name:'阡陌路1号灯箱'
                },
                {
                    id: 11,
                    name:'阡陌路2号灯箱'
                },
                {
                    id: 12,
                    name:'阡陌路3号灯箱'
                }
            ]
        }
    ];

    renderASTable=function(){
        $("#as-container").html("");
        if(activity_seats.length>0){
            var tab = $('<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tablesorter" id="plan"> <thead> <tr> <th>序号</th> <th>广告位</th> <th>媒体</th> <th>投放品牌</th> <th>监测时间段</th> <th>监测次数</th> <th>监测时间</th> <th>样例</th> <th>操作</th> </tr> </thead> <tbody></tbody></table>');
            $.each(activity_seats,function(i,as){
                tab.find("tbody").append("<tr> <td width='30'>"+(i+1)+"</td> <td>"+as.seatName+"</td> <td>"+as.mediaName+"</td> <td>"+as.brand+"</td> <td>"+as.startDate+"至"+as.endDate+"</td> <td>"+as.monitorCount+"</td> <td>"+(as.upMonitor==1?"上刊":"")+"&nbsp;"+(as.durationMonitor==1?"投放期间":"")+"&nbsp;"+(as.downMonitor==1?"下刊":"")+"&nbsp;"+"</td> <td><img src='"+as.samplePicUrl+"' class='demo'/></td> <td> <a href='javascript:modAS("+i+");'>详情</a> <a href='javascript:dealAS("+i+");'>删除</a> </td> </tr>");
            });
            $("#as-container").append(tab);
        }
    }

    dealAS=function (i) {
        activity_seats.splice(i,1);
        renderASTable();
    }

    modAS=function (i) {
        mod_activity_seat=activity_seats[i];
        layer.open({
            type: 2,
            title: '新修改告位监测',
            shade: 0.8,
            area: ['820px', '600px'],
            content: '/customer/activity/adseat/edit' //iframe的url
        });
    }

</script>
    <!-- 特色内容 -->

<@model.webend />