package cn.shop.service.test;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import cn.shop.entity.Buyer;
import cn.shop.service.BuyerService;

public class GoodServiceTest {

	@Before
	public void init() {
		System.out.println("正在初始化。。");
		System.out.println("初始化完毕！");
	}

	@After
	public void destroy() {
		System.out.println("销毁对象。。。");
		System.out.println("销毁完毕！");
	}

	@Test
	public void test() {
		
		
	}
}
