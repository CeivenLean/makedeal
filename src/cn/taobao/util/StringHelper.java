package cn.taobao.util;

public class StringHelper {
	
	//判断字符串 s 是否为 null
	public static boolean isNull( String s ) {
		return s==null;
	}
	
	//判断字符串 s 是否不为 null
	public static boolean notNull( String s ) {
		return s!=null;
	}
	
	//判断字符串 s 是否为 空串或空白
	public static boolean isEmpty( String s ) {
		return notNull(s)&&s.trim().isEmpty();
	}
	
	//判断字符串 s 是否不为空
	public static boolean notEmpty( String s ) {
		return notNull(s)&&s.trim().length()>0;
	}

}
