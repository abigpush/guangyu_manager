package com.bt.om.vo.api;

import java.io.Serializable;

public class UserOrderVo implements Serializable {
	private static final long serialVersionUID = 354883746982564301L;
	private String msg;
	private String status;

	public UserOrderVo(String msg, String status) {
		this.msg = msg;
		this.status = status;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
