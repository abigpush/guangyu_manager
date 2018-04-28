package com.bt.om.service;

import java.util.List;

import com.bt.om.entity.Invitation;

public interface IInvitationService {
	public void insert(Invitation invitation);
	
	public List<Invitation> findByMobileFriend(Invitation invitation);
}
