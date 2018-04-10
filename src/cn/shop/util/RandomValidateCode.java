package cn.shop.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 随机验证码 类
 * @author Ceiven
 *
 */
public class RandomValidateCode {
	
	//定义放到 Session 空间中的 key
	public static final String RANDOMCODEKEY = "RANDOMVALIDATECODEKEY";
	
	private Random random = new Random();
	
	//设定验证码字符来源 为：0~9、A~Z
	private String strSource = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	
	private int width = 80;		//验证码图片的宽
	private int height = 40;	//验证码图片的高
	private int lineSize = 15;	//验证码干扰线的数量
	private int stringNum = 4;	//验证码中字符个数
	
	
	/**
	 * 随机获得一个char字符
	 * 	并转换为String类型
	 * @param index
	 * @return 
	 */
	public String getRandomString(int index) {
		return String.valueOf(strSource.charAt(index));
	}
	
	
	/**
	 * 设置字体
	 * @return
	 */
	private Font getFont() {
		return new Font("Times New Roman",Font.ROMAN_BASELINE,18);
	}
	
	/**
	 * 设置字符颜色
	 * @return Color(r,g,b)
	 */
	private Color getRandomColor() {
		int r = random.nextInt(256);
		int g = random.nextInt(256);
		int b = random.nextInt(256);
		return new Color(r,g,b);
	}
	
	
	/**
	 * 绘制一条干扰线
	 * 	起点坐标为 ( x , y )
	 * 	终点坐标为 ( x+xl , y+yl )
	 * @param g
	 */
	private void drawAline(Graphics g) {
		//每画一条线就换个颜色
		//g.setColor(new Color(random.nextInt(101),random.nextInt(111),random.nextInt(121)));
		
		int x = random.nextInt(width);
		int y = random.nextInt(height);
		int xl = random.nextInt(20);
		int yl = random.nextInt(20);
		g.drawLine(x, y, x+xl, y+yl);
	}
	
	
	/**
	 * 将字符串 randomString 进行绘制
	 * @param g
	 * @param randomString
	 * @param i
	 * @return
	 */
	private String drawString(Graphics g, String randomString, int i) {
		
		g.setFont(getFont());
		
		g.setColor(new Color(random.nextInt(101),random.nextInt(111),random.nextInt(121)));
		
		g.translate(random.nextInt(3), random.nextInt(3));
		
		String rand = String.valueOf(getRandomString(random.nextInt(strSource.length())));
		
		//将字符 连接到验证码字符串中
		randomString += rand;
		
		//绘制这个字符
		g.drawString(rand, 12*i, 20);
		
		//返回完整的验证码字符串
		return randomString;
		
	}
	
	
	/**
	 * 生成最终随机数图片
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void getRandomCode(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		//获取请求中的 Session 对象
		HttpSession session = request.getSession();
		
		//创建一张指定宽、高、背景色的图像， 随机数将绘制在这副图像上
		BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		
		//获取 image 对象的 Graphics 对象g
		Graphics g = image.getGraphics();
		
		g.fillRect(0, 0, width, height);
		
		g.setColor(getRandomColor());
		
		for(int i=0; i<=lineSize; i++) {
			drawAline(g);
		}
		
		String randomString = "";
		
		for(int i=1; i<=stringNum; i++) {
			randomString = drawString(g,randomString,i);
		}
		
		session.removeAttribute(RANDOMCODEKEY);
		session.setAttribute(RANDOMCODEKEY, randomString);
		
		g.dispose();
		
		ImageIO.write(image, "JPEG", response.getOutputStream());
		
	}
	
	
	
	
	

}
