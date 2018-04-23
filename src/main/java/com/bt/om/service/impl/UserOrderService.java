package com.bt.om.service.impl;

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
}
