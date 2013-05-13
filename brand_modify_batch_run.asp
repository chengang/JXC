<!--KDZ Studio Powered at 20090215">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：批量修改品牌名称后台页面
  '         1、修改商品品牌
  '更新DB：buy,sold,returned,stock,stock_modify,commodity_modify
  '参照DB：stock
  '修改履历
  '修改年月日、责任者、内容
  '2009/02/15  sky@kdz 新增 增加批量修改品牌名称功能
%>

<HTML>
<HEAD>
<TITLE>进销存系统——批量修改品牌名称执行</TITLE>
<meta http-equiv="refresh" content="10;url=brand_modify_batch.asp">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #FFFFFF;
}
.STYLE1 {font-size:9pt}

.STYLE2 {font-size:10.5pt}
-->
</style>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

'从form中取值
dim old_brand,new_brand
old_brand = trim(request.form("old_brand"))
new_brand = trim(request.form("new_brand"))

%>
</head>

<BODY>
<table width="762" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr><td align="center"><img src="image\logo.gif"></td></tr>
  <tr>
    <td align="right"><%if power = "5" then%>
	     <!--#include file="inc/top_admin.inc"-->
	   <%else%>
         <!--#include file="inc/top.inc"-->
	   <%end if%></td></tr>
  <tr>
	<td align="center">
	<table width="760" cellpadding="0" cellspacing="0" style="BORDER-RIGHT:#FF0000 6px solid;BORDER-TOP:#FF0000 6px solid;BORDER-BOTTOM:#FF0000 6px solid;BORDER-LEFT:#FF0000 6px solid;">
	   <tr><td width="380"><!--#include file="inc/left.inc"--></td>
		 <td width="380" valign="center">
		    <table bgcolor="#CCCCCC">
				<%
				'取系统日期和时间为数值
				  dim datestr,timestr
				  datestr = int(Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)
				  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
				%>

				<%
				'查询库存表
				dim rs_stock,sqltext_stock
				set rs_stock=server.createobject("adodb.recordset")
				sqltext_stock="select * from stock where a4brand = '"&old_brand&"'"
				rs_stock.open sqltext_stock,conn,1,1

				if rs_stock.eof then 
				   '没有查询到纪录
				    rs_stock.close
					  response.redirect("messagebox.asp?msg=系统错误，请联系管理员")
	          response.end
				else
				   '更新进货表
				    sql="update buy set a1brand = '"&new_brand&"' where a1brand = '"&old_brand&"'"
            conn.execute(sql)
				   '更新售货表
				    sql="update sold set a2brand = '"&new_brand&"' where a2brand = '"&old_brand&"'"
            conn.execute(sql)
				   '更新退货表
				    sql="update returned set a3brand = '"&new_brand&"' where a3brand = '"&old_brand&"'"
            conn.execute(sql)
				   '更新强制修改库存表
				    sql="update stock_modify set a11brand = '"&new_brand&"' where a11brand = '"&old_brand&"'"
            conn.execute(sql)
				   '更新商品属性表
            sql ="insert into commodity_modify (a12gid,a12code,a12mflag,a12old,a12new,a12reason,a12crttime,a12crtuser) "
            sql =sql&" values('all','all','品牌','"&old_brand&"','"&new_brand&"','批量修改品牌名','"&timestr&"','"&username&"') "
            conn.execute(sql)
					 '更新库存表
            sql ="update stock set a4brand = '"&new_brand&"' where a4brand = '"&old_brand&"'"
            conn.execute(sql)

				end if
        %>
			  <tr>
			    <td><table class="STYLE1" align="center"><tr><td>
					  <%username%> 已成功批量修改商品品牌名称
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2">
					  <tr height="20"><td width="50"></td><td width="100">修改前品牌</td><td width="180"><%=old_brand%></td><td width="50"></td></tr>
					  <tr height="20"><td></td><td>修改后品牌</td><td><%=new_brand%></td><td></td></tr>
					  <tr><td colspan="4" height="60" align="center" class="STYLE1"><a href="brand_modify_batch.asp">10秒后将自动返回批量改品牌页面</a></td></tr>
					   <%
				      rs_stock.Close
				      conn.close
				      set conn=nothing
					   %>
					  </table>
			    </td>
			  </tr>
			</table>
		 </td>
	   </tr>
	</table>
	</td>
  </tr>
	<tr>
	 <td>
	   <%if power = "5" then%>
	     <!--#include file="inc/bottom_admin.inc"-->
	   <%else%>
         <!--#include file="inc/bottom.inc"-->
	   <%end if%>
	 </td>
	</tr>
	<tr><td align="center"><img src="image\logo_mini.gif"></td></tr>
</table>
</BODY>
</HTML>
