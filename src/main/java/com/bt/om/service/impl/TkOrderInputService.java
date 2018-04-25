package com.bt.om.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bt.om.entity.TkOrderInput;
import com.bt.om.mapper.TkOrderInputMapper;
import com.bt.om.service.ITkOrderInputService;

@Service
public class TkOrderInputService implements ITkOrderInputService {
	@Autowired
	private TkOrderInputMapper tkOrderInputMapper;

	@Override
	public TkOrderInput selectByOrderId(String sign) {
		return tkOrderInputMapper.selectByOrderId(sign);
	}
}
