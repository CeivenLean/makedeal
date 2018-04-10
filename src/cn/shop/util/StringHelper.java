package cn.shop.util;

import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

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
	
	public static Map toMap(String param) {
		Map map = new HashMap();
        String str = "";
        String key = "";
        Object value = "";
        char[] charList = param.toCharArray();
        boolean valueBegin = false;
        for (int i = 0; i < charList.length; i++) {
            char c = charList[i];
            if (c == '{') {
                if (valueBegin == true) {
                    value = toMap(param.substring(i, param.length()));
                    i = param.indexOf('}', i) + 1;
                    map.put(key, value);
                }
            } else if (c == '=') {
                valueBegin = true;
                key = str;
                str = "";
            } else if (c == ',') {
                valueBegin = false;
                value = str;
                str = "";
                map.put(key, value);
            } else if (c == '}') {
                if (str != "") {
                    value = str;
                }
                map.put(key, value);
                return map;
            } else if (c != ' ') {
                str += c;
            }
        }
        return map;
	}
	
	public static Map<Integer,Integer> reset(Map<String,String> map) {
		if(map!=null) {
			Map<Integer,Integer> newmap = new HashMap<Integer,Integer>();
			for(Map.Entry<String, String> entry : map.entrySet()) {
				
				newmap.put(Integer.valueOf(entry.getKey()),Integer.valueOf(entry.getValue()));
			}
			return newmap;
		}
		
		return null;
		
	}
	
	public static String[] strToArray(String str) {
		StringTokenizer st = new StringTokenizer(str,",");//把","作为分割标志，然后把分割好的字符赋予StringTokenizer对象。
        String[] strArray = new String[st.countTokens()];//通过StringTokenizer 类的countTokens方法计算在生成异常之前可以调用此 tokenizer 的 nextToken 方法的次数。
        int i=0;
        while(st.hasMoreTokens()){//看看此 tokenizer 的字符串中是否还有更多的可用标记。
            strArray[i++] = st.nextToken();//返回此 string tokenizer 的下一个标记。
        }
        return strArray;
	}

}
