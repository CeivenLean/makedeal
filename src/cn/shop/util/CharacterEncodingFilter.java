package cn.shop.util;

import java.io.IOException;
import java.nio.charset.Charset;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class CharacterEncodingFilter implements Filter {
	
	private String encoding ;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// 从 FilterConfig 对象中获取指定名称对应的初始化参数，并赋值给 encoding 字段(属性)
		this.encoding = filterConfig.getInitParameter( "encoding" );
		// 检查 encoding 是否为 null 或 空串，如果是就选择使用 默认编码 ( UTF-8 )
		this.encoding = ( this.encoding == null || this.encoding.trim().isEmpty() )? "UTF-8" : this.encoding;
		// 剔除 encoding 对应的字符串的 首、尾 空白
		this.encoding = this.encoding.trim();
		// 判断 指定的编码 是否是 JVM 所支持的有效字符编码
		this.encoding = Charset.isSupported( this.encoding)  ? this.encoding : "UTF-8" ; 
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// 设置请求 和 响应 的字符编码
		request.setCharacterEncoding( encoding );
		response.setCharacterEncoding( encoding );
		// 通过 过滤器链 向后传递 请求 和 响应 对象
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
	}

}
