package com.bt.om.vo.api;

import java.io.Serializable;

public class GetSmsCodeVo implements Serializable {

	private static final long serialVersionUID = 5774873558751018950L;
	private String vcode;

	public GetSmsCodeVo(String vcode) {
		this.vcode = vcode;
	}

	public String getVcode() {
		return vcode;
	}

	public void setVcode(String vcode) {
		this.vcode = vcode;
	}

}
