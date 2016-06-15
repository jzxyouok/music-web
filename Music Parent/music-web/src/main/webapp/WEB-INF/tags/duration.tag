<%@ tag language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ attribute name="duration" required="true" type="java.lang.Short" description="歌曲时长，单位:秒" %>

<%
	int minute = duration / 60;
	int second = duration % 60;
	String minuteStr = minute >= 10 ? minute+"" : "0" + minute;
	String secondStr = second >= 10 ? second+"" : "0" + second;
	String timeStr = minuteStr + ":" + secondStr;
%>
<%=timeStr %>