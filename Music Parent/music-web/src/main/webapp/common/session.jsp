<%@ page language="java" pageEncoding="UTF-8"%>
<% String path = request.getContextPath();%>

  <script language="javascript">
  	alert("登录已超时，请重新登录!");
    window.parent.location.href="<%=path%>/login.jsp";
  </script>
