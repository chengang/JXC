<!KDZ Studio Powered at 20071105">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：统计库存基本信息
  '更新DB：
  '参照DB：buy,stock_modify,sold,returned,stock
  '修改履历
  '修改年月日、责任者、内容
  '2007/11/05  sky@kdz 新增
  '2007/12/12  sky@kdz 修改 日月均出货金额的增加
  '2008/01/01  cg@kdz  修改 增加tips功能
  '2008/10/11  sky@kdz 修改 库存情况历史记录
  '2008/11/08  sky@kdz 修改 修改退货流程
%>

<HTML>
<HEAD>
<TITLE>进销存系统——库存基本信息</TITLE>
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
.style_button {border-right: #62b0ff 1px solid; 
               padding-right: 1px; 
			   border-top: #bfdfff 1px solid; 
			   padding-left: 1px; 
			   font-size: 12px; 
			   padding-bottom: 1px; 
			   border-left: #bfdfff 1px solid; 
			   color: #085878; 
			   padding-top: 1px; 
			   border-bottom: #62b0ff 1px solid; 
			   font-family: verdana, arial, 宋体; 
			   height: 30px; 
			   background-color: #ddeeff"
			   }
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
  <tr>
    <td align="right">
       <%if power = "5" then%>
	     <!--#include file="inc/top_admin.inc"-->
	   <%else%>
         <!--#include file="inc/top.inc"-->
	   <%end if%>
	</td>
  </tr>
  <tr>
	<td align="center">
	<table width="760" cellpadding="0" cellspacing="0" style="BORDER-RIGHT:#FF0000 6px solid;BORDER-TOP:#FF0000 6px solid;BORDER-BOTTOM:#FF0000 6px solid;BORDER-LEFT:#FF0000 6px solid;">
	   <tr>
	     <td width="380">
		    <!--#include file="inc/left.inc"-->
		 </td>
		 <td width="380" valign="center">
		    <table>
				<%
				'取系统日期和时间为数值
				  dim datestr,timestr
				  datestr = int(Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)
				  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
				%>

				<%
				'查询库存表
				dim rs_stock
				    set rs_stock=server.createobject("adodb.recordset")
						sqltext_stock =        "select min(a4crttime)     set_up_time, "
						sqltext_stock = sqltext_stock&"sum(a4total_money) total_stock_money, "
						sqltext_stock = sqltext_stock&"count(*)           total_stock_sort, "
						sqltext_stock = sqltext_stock&"sum(a4stock)       total_stock_amount "
						sqltext_stock = sqltext_stock&"from stock"
						rs_stock.open sqltext_stock,conn,1,1

						set_up_time_temp = mid(rs_stock("set_up_time"),1,4)&"-"&mid(rs_stock("set_up_time"),5,2)&"-"&mid(rs_stock("set_up_time"),7,2)
						'response.write set_up_time_temp
					'response.write sqltext_stock&"<br>"

				dim rs_other
				    set rs_other=server.createobject("adodb.recordset")
						sqltext_other =        "select sum(VW1.buy_amount)           buy_amount, "
						sqltext_other = sqltext_other&"sum(VW1.modify_amount)        modify_amount, "
						sqltext_other = sqltext_other&"sum(VW1.sold_amount)          sold_amount, "
						sqltext_other = sqltext_other&"sum(VW1.sold_money)           sold_money, "
						sqltext_other = sqltext_other&"sum(VW1.returned_amount)      returned_amount "
						sqltext_other = sqltext_other&"from "
						sqltext_other = sqltext_other&"( "
						sqltext_other = sqltext_other&" (select sum(T1.a1amount)      buy_amount, "
						sqltext_other = sqltext_other&"         0                     modify_amount, "
						sqltext_other = sqltext_other&"         0                     sold_amount, "
						sqltext_other = sqltext_other&"         0                     sold_money, "
						sqltext_other = sqltext_other&"         0                     returned_amount "
						sqltext_other = sqltext_other&"  from buy T1 "
						sqltext_other = sqltext_other&"  where T1.a1mflag = 0) "
						sqltext_other = sqltext_other&"union all "
						sqltext_other = sqltext_other&" (select 0                     buy_amount, "
						sqltext_other = sqltext_other&"         sum(T2.a11amount_new - T2.a11amount_old)  modify_amount, "
						sqltext_other = sqltext_other&"         0                     sold_amount, "
						sqltext_other = sqltext_other&"         0                     sold_money, "
						sqltext_other = sqltext_other&"         0                     returned_amount "
						sqltext_other = sqltext_other&"  from stock_modify T2) "
						sqltext_other = sqltext_other&"union all "
						sqltext_other = sqltext_other&" (select 0                     buy_amount, "
						sqltext_other = sqltext_other&"         0                     modify_amount, "
						sqltext_other = sqltext_other&"         sum(T3.a2amount)      sold_amount, "
						sqltext_other = sqltext_other&"         sum(T3.a2amount*T3.a2sold_price)      sold_money, "
						sqltext_other = sqltext_other&"         0                     returned_amount "
						sqltext_other = sqltext_other&"  from sold T3 "
						sqltext_other = sqltext_other&"  where T3.a2mflag = 0) "
						sqltext_other = sqltext_other&"union all "
						sqltext_other = sqltext_other&" (select 0                     buy_amount, "
						sqltext_other = sqltext_other&"         0                     modify_amount, "
						sqltext_other = sqltext_other&"         0                     sold_amount, "
						sqltext_other = sqltext_other&"         0                     sold_money, "
						sqltext_other = sqltext_other&"         sum(T4.a3amount)      returned_amount "
						sqltext_other = sqltext_other&"  from returned T4 "
						sqltext_other = sqltext_other&"  where T4.a3mflag = 0  and a3status <> 1 ) "
						sqltext_other = sqltext_other&" )VW1 "
						rs_other.open sqltext_other,conn,1,1

					    'response.write sqltext_other&"<br>"
                %>
			  <tr height="50">
			    <td>
				    <table class="style1" align="center" width="330"><tr><td>
					  <!--#include file="inc/marquee_tips.inc"-->
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2" align="center">
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="150">
						系统运行时间：
						</td>
						<td width="180">
						<b><%=datediff("D",set_up_time_temp,date())%></b>&nbsp天
						</td>
					  </tr>
					  
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						库存总价值：
						</td>
						<td width="180">
						<b><%=round(rs_stock("total_stock_money"),2)%></b>&nbsp元
						</td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						商品总计种类：
						</td>
						<td width="180">
						<b><%=rs_stock("total_stock_sort")%></b>&nbsp种
						</td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						商品总计数量：
						</td>
						<td width="180">
						<b><%=rs_stock("total_stock_amount")%></b>&nbsp件
						</td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100"></td>
						<td width="180"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						日均出货件数：
						</td>
						<td width="180">
						<b><%=round(rs_other("sold_amount")/datediff("D",set_up_time_temp,date()),0)%></b>&nbsp件(<span class="STYLE1">￥</span><%=round(rs_other("sold_money")/datediff("D",set_up_time_temp,date()),2)%>)
						</td>
					  </tr>
					  
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						月均出货件数：
						</td>
						<td width="180">
						<b><%=round(rs_other("sold_amount")/datediff("M",set_up_time_temp,date()),0)%></b>&nbsp件(<span class="STYLE1">￥</span><%=round(rs_other("sold_money")/datediff("M",set_up_time_temp,date()),0)%>)
						</td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100"></td>
						<td width="180"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						总计入货数量：
						</td>
						<td width="180">
						<b><%=(rs_other("buy_amount") +  rs_other("modify_amount"))%></b>&nbsp件
						</td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						总计出货数量：
						</td>
						<td width="180">
						<b><%=rs_other("sold_amount")%></b>&nbsp件
						</td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						总计退货数量：
						</td>
						<td width="180">
						<b><%=rs_other("returned_amount")%></b>&nbsp件
						</td>
					  </tr>

					   <tr>
						 <td colspan="3" height="50" align="center" class="STYLE1">
						 <input type="button" onclick="javascript:window.open('statistics_stock_history_run.asp', '_self')" value=" 查 看 历 史 记 录 " class="style_button">
						 </td>
					   </tr>
					</table>
			    </td>
			  </tr>
				<%
				    rs_stock.Close
				    rs_other.Close
				conn.close
				set conn=nothing
				%>
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
	<tr>
	  <td align="center">
	  <img src="image\logo_mini.gif">
	  </td>
	</tr>
</table>
</BODY>
</HTML>