package com.bt.om.service;


import java.util.List;

import com.bt.om.entity.UserOrder;

public interface IUserOrderService {   
    public void insert(UserOrder userOrder);
    public List<UserOrder> selectByMobile(String mobile);
    public void updateStatus2(UserOrder userOrder);
    public List<UserOrder> selectUnCheckByMobile(UserOrder userOrder);
    public void updateByPrimaryKey(UserOrder userOrder);
}
