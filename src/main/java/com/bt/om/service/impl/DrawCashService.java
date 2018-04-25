package com.bt.om.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bt.om.entity.DrawCash;
import com.bt.om.mapper.DrawCashMapper;
import com.bt.om.service.IDrawCashService;

@Service
public class DrawCashService implements IDrawCashService {
	@Autowired
	private DrawCashMapper drawCashMapper;

	@Override
	public void insert(DrawCash drawCash) {
		drawCashMapper.insert(drawCash);
	}
}
