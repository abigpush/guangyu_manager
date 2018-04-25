package com.bt.om.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bt.om.entity.UserOrder;
import com.bt.om.mapper.UserOrderMapper;
import com.bt.om.service.IUserOrderService;

@Service
public class UserOrderService implements IUserOrderService {
	@Autowired
	private UserOrderMapper userOrderMapper;

	@Override
	public void insert(UserOrder userOrder) {
		userOrderMapper.insert(userOrder);
	}

	@Override
	public List<UserOrder> selectByMobile(String mobile) {
		return userOrderMapper.selectByMobile(mobile);
	}
	
	@Override
	public void updateStatus2(UserOrder userOrder) {
		userOrderMapper.updateStatus2(userOrder);
	}
	
	@Override
	public List<UserOrder> selectUnCheckByMobile(UserOrder userOrder) {
		return userOrderMapper.selectUnCheckByMobile(userOrder);
	}
	
	@Override
	public void updateByPrimaryKey(UserOrder userOrder) {
		userOrderMapper.updateByPrimaryKey(userOrder);
	}
}
