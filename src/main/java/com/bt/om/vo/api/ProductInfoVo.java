package com.bt.om.vo.api;

import java.io.Serializable;

public class ProductInfoVo implements Serializable {

	private static final long serialVersionUID = 5774873558751018950L;
	private String shortLinkUrl="";
	private String couponName="";
	private String couponLink="";

	public ProductInfoVo(String shortLinkUrl,String couponName,String couponLink) {
		this.shortLinkUrl = shortLinkUrl;
		this.couponName=couponName;
		this.couponLink=couponLink;
	}

	public String getShortLinkUrl() {
		return shortLinkUrl;
	}

	public void setShortLinkUrl(String shortLinkUrl) {
		this.shortLinkUrl = shortLinkUrl;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public String getCouponLink() {
		return couponLink;
	}

	public void setCouponLink(String couponLink) {
		this.couponLink = couponLink;
	}

}
