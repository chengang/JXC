<!KDZ Studio Powered at 20070329">
<%@ language="vbscript"%>
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="conn.asp"-->
<%response.Expires = 0%>

<%
'确定是什么操作
  dim FromPage
  FromPage = request.form("FromPage")
'取系统日期为数值
  dim datestr
  datestr = int(Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)
%>

<%if FromPage = "statistics" then%>
<!-- 毛利计算 Begin-->
<%
'今日毛利计算
    '取要计算毛利的日期范围
	set rs2=server.createobject("adodb.recordset")
	sqltext2="select * from sold where a2date = datestr "
	rs2.open sqltext2,conn,1,1
	gross_today = 0
		'毛利计算公式
		while not rs2.eof
		set rs1=server.createobject("adodb.recordset")
		sqltext1="select * from stock where a1code='" & rs2("a2code") & "'"
		rs1.open sqltext1,conn,1,1
		gross_today_once = (rs2("a2price") - rs1("a1price")) * rs2("a2amount")
		gross_today = gross_today + gross_today_once
		rs1.close
		rs2.movenext
		wend
	rs2.close

'昨日毛利计算
    '取要计算毛利的日期范围
	set rs2=server.createobject("adodb.recordset")
	sqltext2="select * from sold where a2date = datestr - 1 "
	rs2.open sqltext2,conn,1,1
	gross_yesterday = 0
		'毛利计算公式
		while not rs2.eof
		set rs1=server.createobject("adodb.recordset")
		sqltext1="select * from stock where a1code='" & rs2("a2code") & "'"
		rs1.open sqltext1,conn,1,1
		gross_yesterday_once = (rs2("a2price") - rs1("a1price")) * rs2("a2amount")
		gross_yesterday = gross_yesterday + gross_yesterday_once
		rs1.close
		rs2.movenext
		wend
	rs2.close

'上个月毛利计算
    '取要计算毛利的日期范围
	set rs2=server.createobject("adodb.recordset")
	sqltext2="select * from sold where a2date < int(datestr/100)*100 and a2date > (int(datestr/100)*100)-100 "
	rs2.open sqltext2,conn,1,1
	gross_month = 0
		'毛利计算公式
		while not rs2.eof
		set rs1=server.createobject("adodb.recordset")
		sqltext1="select * from stock where a1code='" & rs2("a2code") & "'"
		rs1.open sqltext1,conn,1,1
		gross_month_once = (rs2("a2price") - rs1("a1price")) * rs2("a2amount")
		gross_month = gross_month + gross_month_once
		rs1.close
		rs2.movenext
		wend
	rs2.close

'本年度毛利计算
    '取要计算毛利的日期范围
	set rs2=server.createobject("adodb.recordset")
	sqltext2="select * from sold where a2date < int(datestr/10000)*10000+10000 and a2date > (int(datestr/10000)*10000) "
	rs2.open sqltext2,conn,1,1
	gross_year = 0
		'毛利计算公式
		while not rs2.eof
		set rs1=server.createobject("adodb.recordset")
		sqltext1="select * from stock where a1code='" & rs2("a2code") & "'"
		rs1.open sqltext1,conn,1,1
		gross_year_once = (rs2("a2price") - rs1("a1price")) * rs2("a2amount")
		gross_year = gross_year + gross_year_once
		rs1.close
		rs2.movenext
		wend
	rs2.close

conn.close
set conn=nothing
'Response.Redirect ""
%>

<!-- 毛利计算 End-->
<%end if %>

<HTML>
<HEAD>
<TITLE>进销存系统——毛利统计</TITLE>
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
%>
</head>

<BODY>
<table width="762" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td align="center"><img src="image\logo.gif"></td>
  </tr>
<!--------------------------------------------------------------------------------------->
<!---------------------------070610陈钢制作上方导航-------------------------------------->
  <tr>
    <td align="right">
       <%if power = "5" then%>
	     <!--#include file="inc/top_admin.inc"-->
	   <%else%>
         <!--#include file="inc/top.inc"-->
	   <%end if%>
	</td>
  </tr>
<!---------------------------070610陈钢制作上方导航-------------------------------------->
<!--------------------------------------------------------------------------------------->
  <tr>
	<td align="center">
	<table width="760" cellpadding="0" cellspacing="0" style="BORDER-RIGHT:#FF0000 6px solid;BORDER-TOP:#FF0000 6px solid;BORDER-BOTTOM:#FF0000 6px solid;BORDER-LEFT:#FF0000 6px solid;">
	   <tr>
	     <td width="380">
		    <!--#include file="left.asp"-->
		 </td>
		 <td width="380" valign="center">
		    <table bgcolor="#FFFFFF">
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  t% 你好，以下是毛利统计信息
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2">
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						今日毛利：
						</td>
						<td width="180">
						<%=gross_today%>
						</td>
					    <td width="50"></td>
					  </tr>
					  
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						昨日毛利：
						</td>
						<td width="180">
						<%=gross_yesterday%>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						上月毛利：
						</td>
						<td width="180">
						<%=gross_month%>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						本年度毛利：
						</td>
						<td width="180">
						<%=gross_year%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
						 <td colspan="4" height="60" align="center" class="STYLE1">
						 <a href="statistics.asp">点这里返回统计菜单页</a>
						 </td>
					   </tr>
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
	   <!--#include file="bottom.asp"-->
	 </td>
	</tr>
	<tr>
	  <td align="center">
	  <img src="image\logo_mini.gif">
	  </td>
	</tr>
</table>
</BODY>
</HTML>