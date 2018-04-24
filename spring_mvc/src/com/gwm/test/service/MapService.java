package com.gwm.test.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.gwm.test.dao.MapsqlUtil;
import com.gwm.test.pojo.OrgLoaction;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/***
 * map
 * @author gw00089267
 *
 */

public class MapService {

	public static String getorgloc() {
		String orgloc="";
		orgloc=MapsqlUtil.getorgloc();	
		
		return orgloc;
	}

	public static String saveorgloc(HttpServletRequest request) {
	
		String org = request.getParameter("org");
		
		String polydatas = request.getParameter("polydatas");
		String[] polydatasArray = polydatas.split(";");
		for(String po:polydatasArray){
			String[] pos = po.split(",");
			OrgLoaction ol=new OrgLoaction();
			ol.setLng(new BigDecimal(pos[0]));
			ol.setLat(new BigDecimal(pos[1]));
			ol.setOrgcode(Integer.parseInt(org));
			MapsqlUtil.saveorgloc(ol);	
		}
		
		
		System.out.println(polydatas);
		return null;
	}

}
