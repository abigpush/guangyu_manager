package com.bt.om.vo.api;

import com.bt.om.entity.vo.AdMonitorTaskMobileVo;
import com.bt.om.enums.MonitorTaskType;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by caiting on 2018/1/24.
 */
public class MonitorTaskWaitToExecutedVo extends BasicVo{
    private Integer task_id;
    private Integer task_type;
    private String task_type_text;
    private String monitor_start;
    private String monitor_end;
    private String ad_activity_name;
    private String ad_name;
    private String ad_location;
    private Integer ad_status;
    private List<String> img_url_list;

    public MonitorTaskWaitToExecutedVo(AdMonitorTaskMobileVo task) {
        this.task_id = task.getId();
        this.task_type = task.getTaskType();
        this.task_type_text = MonitorTaskType.getText(task.getTaskType());
        this.monitor_start = sdf.format(task.getMonitorStart());
        this.monitor_end = sdf.format(task.getMonitorEnd());
        this.ad_activity_name = task.getActivityName();
        this.ad_name = task.getAdSeatName();
        this.ad_location = task.getAdSeatName();
        this.ad_status = task.getStatus();
        this.img_url_list = new ArrayList<>();
        this.img_url_list.add(task.getSamplePicUrl());
    }

    public String getMonitor_start() {
        return monitor_start;
    }

    public void setMonitor_start(String monitor_start) {
        this.monitor_start = monitor_start;
    }

    public String getMonitor_end() {
        return monitor_end;
    }

    public void setMonitor_end(String monitor_end) {
        this.monitor_end = monitor_end;
    }

    public Integer getTask_type() {
        return task_type;
    }

    public void setTask_type(Integer task_type) {
        this.task_type = task_type;
    }

    public String getTask_type_text() {
        return task_type_text;
    }

    public void setTask_type_text(String task_type_text) {
        this.task_type_text = task_type_text;
    }

    public Integer getTask_id() {
        return task_id;
    }

    public void setTask_id(Integer task_id) {
        this.task_id = task_id;
    }

    public String getAd_activity_name() {
        return ad_activity_name;
    }

    public void setAd_activity_name(String ad_activity_name) {
        this.ad_activity_name = ad_activity_name;
    }

    public String getAd_name() {
        return ad_name;
    }

    public void setAd_name(String ad_name) {
        this.ad_name = ad_name;
    }

    public String getAd_location() {
        return ad_location;
    }

    public void setAd_location(String ad_location) {
        this.ad_location = ad_location;
    }

    public Integer getAd_status() {
        return ad_status;
    }

    public void setAd_status(Integer ad_status) {
        this.ad_status = ad_status;
    }

    public List<String> getImg_url_list() {
        return img_url_list;
    }

    public void setImg_url_list(List<String> img_url_list) {
        this.img_url_list = img_url_list;
    }
}