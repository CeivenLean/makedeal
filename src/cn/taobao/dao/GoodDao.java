package cn.taobao.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import cn.taobao.entity.Good;
import cn.taobao.entity.Seller;
import cn.taobao.util.JdbcHelper;
import cn.taobao.util.PageUtil;

public class GoodDao {
	
	JdbcHelper helper = new JdbcHelper();
	
	String TABLE = " goods_info ";
	
	public long publish(Good g) {
		Date date = new Date();  
		Timestamp timeStamp = new Timestamp(date.getTime());
		String SQL = "INSERT INTO" +TABLE+ "(seller_name,good_title,good_desc,good_price,publish_date,sort1,sort2,sort3) VALUES (?,?,?,?,?,?,?,?)";
		
		int[] i = helper.insert(SQL, g.getSellerName(),g.getGoodTitle(),g.getGoodDesc(),g.getGoodPrice(),timeStamp,g.getSort1(),g.getSort2(),g.getSort3());
		
		return i[0];
	}
	
	public int totalCount(String value) {
		String SQL = "SELECT * FROM " +TABLE+ " WHERE good_title LIKE '%" +value+ "%' OR good_desc LIKE '%" +value+ "%'";
		
		ResultSet rs = helper.query(SQL);
		int n=0;
		try {
			while(rs.next()) {
				n++;
			}
			
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return n;
	}
	public int listSortTotalCount(String sort) {
		String SQL = "SELECT * FROM " +TABLE+ " WHERE sort1 LIKE '%" +sort+ "%' OR sort2 LIKE '%" +sort+ "%' OR sort3 LIKE '%" +sort+ "%' ";
		ResultSet rs = helper.query(SQL);
		int n=0;
		try {
			while(rs.next()) {
				n++;
			}
			
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return n;
	}
	
	public Map<Integer,Good> list(String value,PageUtil pageUtil){
		
		StringBuffer sql = new StringBuffer("SELECT * FROM " +TABLE+ " WHERE good_title LIKE '%" +value+ "%' OR good_desc LIKE '%" +value+ "%' ");
		sql.append(" limit ");
		sql.append((pageUtil.getPageIndex()-1)*pageUtil.getPageSize());
		sql.append(",");
		sql.append(pageUtil.getPageSize());
		ResultSet rs = helper.query(sql.toString());
		
		Map<Integer,Good> map = new HashMap<>();
		
		try {
			while(rs.next()) {
				
				Good g = new Good();
				
				int goodId = (int)rs.getObject(1);
				String sellerName = (String)rs.getObject(2);
				String goodTitle = (String)rs.getObject(3);
				String goodDesc = (String)rs.getObject(4);
				double goodPrice = (double)rs.getObject(5);
				String sort1 = rs.getString("sort1");
				String sort2 = rs.getString("sort2");
				String sort3 = rs.getString("sort3");
				
				g.setGoodId(goodId);
				g.setSellerName(sellerName);
				g.setGoodTitle(goodTitle);
				g.setGoodDesc(goodDesc);
				g.setGoodPrice(goodPrice);
				g.setPublishDate(rs.getTimestamp("publish_date"));
				g.setSort1(sort1);
				g.setSort2(sort2);
				g.setSort3(sort3);
				g.setStatus(rs.getInt("status"));
				
				map.put(goodId, g);
			
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
		
		
	}
	
public Map<Integer,Good> listBySort(String sort,PageUtil pageUtil){
		
		StringBuffer sql = new StringBuffer("SELECT * FROM " +TABLE+ " WHERE sort1 LIKE '%" +sort+ "%' OR sort2 LIKE '%" +sort+ "%' OR sort3 LIKE '%" +sort+ "%' ");
		sql.append(" limit ");
		sql.append((pageUtil.getPageIndex()-1)*pageUtil.getPageSize());
		sql.append(",");
		sql.append(pageUtil.getPageSize());
		ResultSet rs = helper.query(sql.toString());
		
		Map<Integer,Good> map = new HashMap<>();
		
		try {
			while(rs.next()) {
				
				Good g = new Good();
				
				int goodId = (int)rs.getObject(1);
				String sellerName = (String)rs.getObject(2);
				String goodTitle = (String)rs.getObject(3);
				String goodDesc = (String)rs.getObject(4);
				double goodPrice = (double)rs.getObject(5);
				String sort1 = rs.getString("sort1");
				String sort2 = rs.getString("sort2");
				String sort3 = rs.getString("sort3");
				
				g.setGoodId(goodId);
				g.setSellerName(sellerName);
				g.setGoodTitle(goodTitle);
				g.setGoodDesc(goodDesc);
				g.setGoodPrice(goodPrice);
				g.setSort1(sort1);
				g.setSort2(sort2);
				g.setSort3(sort3);
				g.setPublishDate(rs.getTimestamp("publish_date"));
				g.setStatus(rs.getInt("status"));
				map.put(goodId, g);
			
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
		
		
	}
	
	public Good select(Integer key) {
		String SQL = "SELECT * FROM goods_info WHERE good_id=?";
		ResultSet rs = helper.query(SQL, key);
		try {
			while(rs.next()) {
				
				Good g = new Good();
				
				g.setGoodId(rs.getInt("good_id"));
				g.setSellerName(rs.getString("seller_name"));
				g.setGoodTitle(rs.getString("good_title"));
				g.setGoodDesc(rs.getString("good_desc"));
				g.setGoodPrice(rs.getDouble("good_price"));
				g.setSort1(rs.getString("sort1"));
				g.setSort2(rs.getString("sort2"));
				g.setSort3(rs.getString("sort3"));
				g.setPublishDate(rs.getTimestamp("publish_date"));
				g.setStatus(rs.getInt("status"));
				return g;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	public Map listAll() {
		String SQL = "SELECT * FROM goods_info";
		ResultSet rs = helper.query(SQL);
		Map map = new HashMap();
		try {
			while(rs.next()) {
				
				Good g = new Good();
				
				g.setGoodId(rs.getInt("good_id"));
				g.setSellerName(rs.getString("seller_name"));
				g.setGoodTitle(rs.getString("good_title"));
				g.setGoodDesc(rs.getString("good_desc"));
				g.setGoodPrice(rs.getDouble("good_price"));
				g.setSort1(rs.getString("sort1"));
				g.setSort2(rs.getString("sort2"));
				g.setSort3(rs.getString("sort3"));
				g.setPublishDate(rs.getTimestamp("publish_date"));
				g.setStatus(rs.getInt("status"));
				map.put(g.getGoodId(), g);
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Map listBySeller(Seller seller) {
		String SQL = "SELECT * FROM goods_info WHERE seller_name=? ORDER BY publish_date";
		ResultSet rs = helper.query(SQL,seller.getName());
		Map map = new HashMap();
		try {
			while(rs.next()) {
				
				Good g = new Good();
				
				g.setGoodId(rs.getInt("good_id"));
				g.setSellerName(rs.getString("seller_name"));
				g.setGoodTitle(rs.getString("good_title"));
				g.setGoodDesc(rs.getString("good_desc"));
				g.setGoodPrice(rs.getDouble("good_price"));
				g.setSort1(rs.getString("sort1"));
				g.setSort2(rs.getString("sort2"));
				g.setSort3(rs.getString("sort3"));
				g.setPublishDate(rs.getTimestamp("publish_date"));
				g.setStatus(rs.getInt("status"));
				map.put(g.getGoodId(), g);
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Map<Integer,Good> listByPublishDate() {
		String SQL = "SELECT * FROM goods_info ORDER BY publish_date LIMIT 0,8";
		ResultSet rs = helper.query(SQL);
		Map<Integer,Good> map = new LinkedHashMap<Integer,Good>();
		try {
			while(rs.next()) {
				
				Good g = new Good();
				
				g.setGoodId(rs.getInt("good_id"));
				g.setSellerName(rs.getString("seller_name"));
				g.setGoodTitle(rs.getString("good_title"));
				g.setGoodDesc(rs.getString("good_desc"));
				g.setGoodPrice(rs.getDouble("good_price"));
				g.setSort1(rs.getString("sort1"));
				g.setSort2(rs.getString("sort2"));
				g.setSort3(rs.getString("sort3"));
				g.setPublishDate(rs.getTimestamp("publish_date"));
				g.setStatus(rs.getInt("status"));
				map.put(g.getGoodId(), g);
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean save(Map map) {
		
		String SQL = "UPDATE goods_info SET good_title=?,good_desc=?,good_price=? WHERE good_id=?";
		
		int i = helper.update(SQL, map.get("goodTitle").toString(),map.get("goodDesc").toString(),Double.parseDouble(map.get("goodPrice").toString()),Integer.parseInt(map.get("goodId").toString()));
		
		if(i!=0) {
			return true;
		}else {
			return false;
		}
		
	}
	
	public boolean delById(int id) {
		String SQL = "UPDATE goods_info SET status='0' WHERE good_id=?";
		int i = helper.update(SQL, id);
		if(i!=0) {
			return true;
		}else {
			return false;
		}
	}
	
	
	
}
