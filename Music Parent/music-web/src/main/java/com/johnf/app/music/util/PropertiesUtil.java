package com.johnf.app.music.util;

import java.io.InputStream;
import java.util.Properties;

/**
 * porperties文件操作工具类 
 */
public class PropertiesUtil {
	private static String filePath = "/params.properties";
		
	/**
	 * 根据key读取value
	 * @param key
	 * @return
	 */
	public static String readValue(String key) {
		Properties props = new Properties();
		try {
			InputStream in = Thread.currentThread().getContextClassLoader()
					.getResourceAsStream(filePath);
			props.load(in);
			String value = props.getProperty(key);
			return value;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
}
