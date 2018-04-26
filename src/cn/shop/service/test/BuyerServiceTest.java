package cn.shop.service.test;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import cn.shop.entity.Buyer;
import cn.shop.service.BuyerService;

public class BuyerServiceTest {

	Buyer b = new Buyer();
	BuyerService bs= new BuyerService();

	@Before
	public void init() {
		System.out.println("测试开始");
	}

	@After
	public void destroy() {
		System.out.println("测试结束");
	}

	@Test
	public void test() {
		
		System.out.println("根据用户名和密码查出该买家，不存在则输出null：");
		b = bs.search("9549", "9549");
		System.out.println(b);
		b = bs.search("9549", "1111");
		System.out.println(b);
		
		System.out.println("根据id查出该买家：");
		b = bs.selectById("421182199509151058");		
		System.out.println(b);
	}
}
