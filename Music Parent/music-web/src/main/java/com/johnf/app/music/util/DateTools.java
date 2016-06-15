package com.johnf.app.music.util;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DateTools {

	public static String getCurrentDate(String pattern){
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		return sdf.format(new Date());
	}

	public static String getCurrentTime(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(new Date());
	}
	
	public static String getCurrentTimeSimple(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(new Date());
	}
	
	public static List<String> calculationYear(){
		List<String> years = new ArrayList<String>();
		for(int i = 0;i<5;i++){
			int yr = 2005+i;
			years.add(String.valueOf(yr));
		}
		Calendar clen = Calendar.getInstance();
		clen.add(Calendar.YEAR, -1);
		String preYear = String.valueOf(clen.get(Calendar.YEAR));
		if(!years.contains(preYear)){
			years.add(preYear);
		}
		clen.add(Calendar.YEAR, 1);
		String currYear = String.valueOf(clen.get(Calendar.YEAR));
		if(!years.contains(currYear)){
			years.add(currYear);
		}
		clen.add(Calendar.YEAR, 1);
		String nextYear = String.valueOf(clen.get(Calendar.YEAR));
		if(!years.contains(nextYear)){
			years.add(nextYear);
		}
		clen.add(Calendar.YEAR, 1);
		String lastYear = String.valueOf(clen.get(Calendar.YEAR));
		if(!years.contains(lastYear)){
			years.add(lastYear);
		}
		return years;
	}
	
	public static String getCurrYear(){
		Calendar clen = Calendar.getInstance();
		int year = clen.get(Calendar.YEAR);
		return String.valueOf(year);
	}
	
	public static String dateToString(Date date){
		if(date == null){
			return "";
		}
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return df.format(date);
	}

	public static String dateToString(java.sql.Date date){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		return sdf.format(date);
	}
	
	public static String dateToString(Date date, String pattern){
		if(date!=null){
			SimpleDateFormat df = new SimpleDateFormat(pattern);
			return df.format(date);
		}
		return "";
	}

	public static boolean checkTimes(String targetTime){
		if(null==targetTime || "".equals(targetTime.trim())){
			return false;
		}else{
			Pattern p = Pattern.compile("^(([0-1][0-9])|([2][0-4])):[0-5][0-9]:[0-5][0-9]$");
			Matcher m = p.matcher(targetTime);
			return m.matches();
		}
	}
	
	public static boolean checkDateTimes(String sourceDate){
		boolean result = true;
		if(StringTools.isEmptyOrNull(sourceDate)){
			result = false;
		}else{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				sdf.parse(sourceDate.trim());
			} catch (ParseException e) {
				result = false;
			}
		}
		return result;
	}

	public static java.sql.Date stringToDate(String source){
		java.sql.Date date = null;
		try{
			date = java.sql.Date.valueOf(source.trim());
		}catch (IllegalArgumentException e) {
			date=null;
		}
		return date;
	}

	public static Date stringToDate(String source, String pattern) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		try {
			return sdf.parse(source);
		} catch (ParseException e) {
			return null;
		}
	}

	public static String formartNumber(double inpara){
		DecimalFormat df = new DecimalFormat("###,##0.00");
		return (df.format(inpara));
	}


	public static String getdateForDayToString(Date date,int day){
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

		// -1表示前一天，+1表示后一天，依次类推
		long myTime = (date.getTime() / 1000) + (day) * 60 * 60 * 24;
		date.setTime(myTime * 1000);
		String strDay = df.format(date);

		return strDay;
	}
}
