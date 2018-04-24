package com.gwm.test.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gwm.test.service.MapService;

@Controller
@RequestMapping(value="/map")
public class MapContorller {
	
	
	/***
	 * 多边形查询
	 * @return
	 */
	@RequestMapping(value="/hello")
	public String hello(){
		System.out.println("spring mvc hello world!");
	
		return "map/map3";
	}
	/***
	 * 多边形查询
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/getPoly",method = RequestMethod.POST)
	public void getPoly(HttpServletRequest request,HttpServletResponse response) throws Exception{
		// 将请求、响应的编码均设置为UTF-8（防止中文乱码）
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");	
		// 调用Api处理服务
		String orgloc="";
		orgloc = MapService.getorgloc();	
		// 响应消息
		PrintWriter out = response.getWriter();
		out.print(orgloc);
		out.close();
		out = null;
	}
	/***
	 * 多边形保存
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/savePoly",method = RequestMethod.POST)
	public void savePoly(HttpServletRequest request,HttpServletResponse response) throws Exception{
		// 将请求、响应的编码均设置为UTF-8（防止中文乱码）
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");	
		// 调用Api处理服务
		String orgloc="";
		orgloc = MapService.saveorgloc(request);	
		// 响应消息
		PrintWriter out = response.getWriter();
		out.print(orgloc);
		out.close();
		out = null;
	}
	
	
	
}
