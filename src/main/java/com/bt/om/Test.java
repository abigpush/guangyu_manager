package com.bt.om;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import com.bt.om.util.GsonUtil;
import com.bt.om.util.HttpcomponentsUtil;

public class Test {

	public static void main(String[] args) {
		// List<NameValuePair> nvpList=new ArrayList<>();
		// nvpList.add(new
		// BasicNameValuePair("num_iids","555498592290,563823419762,563308542333"));
		// try {
		// String ret=HttpcomponentsUtil.postReq(nvpList,
		// "http://tae.xmluren.com/tae/shop");
		// List<String> list=GsonUtil.GsonToList(ret, String.class);
		// System.out.println(list.get(0));
		// } catch (Exception e) {
		// e.printStackTrace();
		// }

		// System.out.println(Float.valueOf("0.0"));

		String ptCasinoMsg = "日单量：100 | 实付金额：5000.0 | 订单金额：57000.34 | 优惠金额：9000";
		String[] amounts = extractAmountMsg(ptCasinoMsg);
		String ptliveOrderCount = amounts[0].toString();
		String ptliveVilida = amounts[1].toString();
		String ptliveSum = amounts[2].toString();
		String ptlivePayout = amounts[3].toString();
		System.out.println("日单量：" + ptliveOrderCount + "  实付金额：" + ptliveVilida + "  订单金额：" + ptliveSum + "  优惠金额："
				+ ptlivePayout);
	}

	public static String[] extractAmountMsg(String ptCasinoMsg) {
		String returnAmounts[] = new String[4];
		ptCasinoMsg = ptCasinoMsg.replace(" | ", " ");
		String[] amounts = ptCasinoMsg.split(" ");
		for (int i = 0; i < amounts.length; i++) {
			Pattern p = Pattern.compile("(\\d+\\.\\d+)");
			Matcher m = p.matcher(amounts[i]);
			if (m.find()) {
				returnAmounts[i] = m.group(1);
			} else {
				p = Pattern.compile("(\\d+)");
				m = p.matcher(amounts[i]);
				if (m.find()) {
					returnAmounts[i] = m.group(1);
				}
			}
		}
		return returnAmounts;
	}
}
