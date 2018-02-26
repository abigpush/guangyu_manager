package com.bt.om.vo.api;

import java.io.Serializable;

import com.bt.om.entity.User;

public class UserVo implements Serializable {
	private static final long serialVersionUID = 1644252664911316576L;
	private String userId;

	public UserVo(User user) {
		this.userId = user.getUserId();
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

}
