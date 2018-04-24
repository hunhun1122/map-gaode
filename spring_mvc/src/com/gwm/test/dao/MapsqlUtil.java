package com.gwm.test.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.gwm.test.pojo.OrgLoaction;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


/**
 * Mysql数据库操作类
 * 
 */
public class MapsqlUtil {
	/**
	 * 获取Mysql数据库连接
	 * 
	 * @return Connection
	 */
	private Connection getConn() {
		String url = SqlUtil.url;
		String username = SqlUtil.username;
		String password = SqlUtil.password;
		Connection conn = null;
		try {
			// 加载MySQL驱动
			Class.forName("com.mysql.jdbc.Driver");
			// 获取数据库连接
			conn = DriverManager.getConnection(url, username, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	/**
	 * 释放JDBC资源
	 * 
	 * @param conn 数据库连接
	 * @param ps
	 * @param rs 记录集
	 */
	private void releaseResources(Connection conn, PreparedStatement ps, ResultSet rs) {
		try {
			if (null != rs)
				rs.close();
			if (null != ps)
				ps.close();
			if (null != conn)
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 根据id查询对应信息
	 * 
	 * @param knowledgeId 问答知识id
	 * @return
	 */
	public static String getPeizhinameSub(String btyenum ,String bytesort,String byteinfo) {
		String infoname = "";
		String sql = "select infoname from peizhiinfo where bytenum=? and bytesort=? and infonum=?";

		MapsqlUtil mysqlUtil = new MapsqlUtil();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = mysqlUtil.getConn();
			ps = conn.prepareStatement(sql);
			ps.setString(1, btyenum);
			ps.setString(2, bytesort);
			ps.setString(3, byteinfo);
			rs = ps.executeQuery();
			if (rs.next()) {
				infoname = rs.getString("infoname");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 释放资源
			mysqlUtil.releaseResources(conn, ps, rs);
		}
		return infoname;
	}

	public static String getorgloc() {		
		JSONArray jarr=new JSONArray();
		List<String> ll=new ArrayList<String>();
		String sql = "select * from orgloaction ";

		MapsqlUtil mysqlUtil = new MapsqlUtil();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = mysqlUtil.getConn();
			ps = conn.prepareStatement(sql);
//			ps.setString(1, btyenum);
//			ps.setString(2, bytesort);
//			ps.setString(3, byteinfo);
			rs = ps.executeQuery();
			while (rs.next()) {				
			String ss="["+rs.getBigDecimal("lng")+","+rs.getBigDecimal("lat")+"]";
			ll.add(ss);
			JSONObject jb=new JSONObject();
			jb.put("lng", rs.getBigDecimal("lng"));
			jb.put("lat", rs.getBigDecimal("lat"));
			jarr.add(jb);
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 释放资源
			mysqlUtil.releaseResources(conn, ps, rs);
		}
		return jarr.toString();
	}

	public static void saveorgloc(OrgLoaction ol) {
		
		String sql = "insert into orgloaction( orgcode, lng, lat, type) values(?, ?, ?, '1')";
		MapsqlUtil mysqlUtil = new MapsqlUtil();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = mysqlUtil.getConn();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ol.getOrgcode());
			ps.setBigDecimal(2, ol.getLng());
			ps.setBigDecimal(3, ol.getLat());			
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 释放资源
			mysqlUtil.releaseResources(conn, ps, rs);
		}
	}


}
