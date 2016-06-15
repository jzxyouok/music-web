package com.johnf.app.music.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串辅助类
 */
public class StringTools {
	/**
	 * 把一个Object转化成字符串
	 * @param obj
	 * @return
	 */
	public static String objectToString(Object obj) {
		if (null == obj) {
			return "";
		} else {
			return String.valueOf(obj).trim();
		}
	}

	/**
	 * 忽略字符串前导空白和尾部空白
	 * @param obj
	 * @return
	 */
	public static String trimString(String obj) {
		if (isEmptyOrNull(obj)) {
			return "";
		} else {
			return obj.trim();
		}
	}

	/**
	 * 验证字符串是否全是数字
	 * 
	 * @author
	 * @version 2009-12-23
	 * @param source
	 * @return
	 */
	public static boolean regexNumber(String source) {
		Pattern p = Pattern.compile("\\d+");
		Matcher m = p.matcher(source);
		return m.matches();
	}

	/**
	 * 去掉字符串中的html标记
	 * 
	 * @author
	 * @version 2009-12-31
	 * @param source
	 * @return
	 */
	public static String removeHtmlFlag(String source) {
		if (null == source || "".equals(source.trim())) {
			return "";
		} else {
			return source.replaceAll("</?[^>]+>", "");
		}
	}

	/**
	 * 判断字符串是否为null或者""
	 * 
	 * @param source 要判断的字符串
	 * @return
	 */
	public static boolean isEmpty(String source) {
		return source == null || "".equals(source);
	}

	/**
	 * 判断字符串是否为null或者""或者"null"
	 * 
	 * @param source
	 * @return
	 */
	public static boolean isEmptyOrNull(String source) {
		return isEmpty(source) || ("null".equalsIgnoreCase(source));
	}

	/**
	 * 验证是否为整数或者小数
	 * 
	 * @param source
	 * @return
	 */
	public static boolean regexDec(String source) {
		if (null == source || "".equals(source.trim())) {
			return false;
		} else {
			String regex = "^[0-9]+([.]{1}[0-9]+?)?$";
			Pattern p = Pattern.compile(regex);
			Matcher m = p.matcher(source);
			return m.matches();
		}
	}
	
	/**
	 * 处理富文本,如'<'->'&lt;'
	 * @param source
	 * @return
	 */
	public static String encodeHtml(String source) {
        if (source == null) {
            return "";
        }
        String html = "";
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < source.length(); i++) {
            char c = source.charAt(i);
            switch (c) {
            case '<':
                buffer.append("&lt;");
                break;
            case '>':
                buffer.append("&gt;");
                break;
            case '&':
                buffer.append("&amp;");
                break;
            case '"':
                buffer.append("&quot;");
                break;
            case 10:
            case 13:
                break;
            default:
                buffer.append(c);
            }
        }
        html = buffer.toString();
        return html;
    }

}