<!KDZ Studio Powered at 20070719">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：库存修改后台页面
  '         1、强制修改库存
  '更新DB：stock,stock_modify
  '参照DB：stock
  '修改履历
  '修改年月日、责任者、内容
  '2007/07/19  sky@kdz 新增
  '2007/07/22  sky@kdz 修改时修改原因的增加
  '2007/10/30  sky@kdz 修改 单一订单显示利润引起的修改
  '2008/01/05  sky@kdz 修改 商品添加备注属性
  '2008/10/07  sky@kdz 修改 0件商品强制修改产生null价格的问题
  '2008/11/16  sky@kdz 修改 显示时间样式修改
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>

<HTML>
<HEAD>
<TITLE>进销存系统——库存修改确认</TITLE>
<meta http-equiv="refresh" content="10;url=adv_select.asp">
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
		    <table bgcolor="#CCCCCC">
				<%
				'取系统日期和时间为数值
				  dim datestr,timestr
				  datestr = int(Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)
				  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
				%>

				<!-- 修改库存 Begin-->
				<%
				'从form中取值
				'gid_temp = trim(request.form("a3gid"))
				dim id,stock,reason
				stock = trim(request.form("stock"))
				reason = trim(request.form("reason"))
				id = trim(request.form("id"))
				'查询库存表
				dim rs_stock,sqltext1
				set rs_stock=server.createobject("adodb.recordset")
				sqltext1="select * from stock where a4id = '"&id&"'"
				rs_stock.open sqltext1,conn,1,2

				if rs_stock.eof then 
				   '没有查询到纪录
				    rs_stock.close
					  response.redirect("messagebox.asp?msg=系统错误，请联系管理员1")
	          response.end
				else
				    dim temp_stock,temp_diff,price
				      '===============0件商品强制修改产生null价格的问题开始===============
				      '如果库存表中存货存货总价或者数量为零则采用最近一次进货价格为单价
				      if (rs_stock("a4total_money") = 0 or rs_stock("a4stock") = 0) then
				          dim a4gid
				          a4gid = rs_stock("a4gid")
				          '查询最近一次进货价格
				           dim rs_buy,sqltext_buy
				           set rs_buy=server.createobject("adodb.recordset")
				           sqltext_buy="select top 1 a1buy_price from buy where a1mflag = 0 and a1gid = '"&a4gid&"'order by a1crttime desc "
				           rs_buy.open sqltext_buy,conn,1,1
				           'response.write sqltext_buy & "<br/>"
				           price = rs_buy("a1buy_price")
				           rs_buy.close
				      else
					        price = rs_stock("a4total_money") / rs_stock("a4stock")
					    end if
				      '===============0件商品强制修改产生null价格的问题结束===============
					    temp_stock = rs_stock("a4stock")
						  temp_diff = rs_stock("a4diff") - temp_stock + stock
					
				  dim rs_stock_modify,sqltext2
					set rs_stock_modify=server.createobject("adodb.recordset")
					sqltext2="select top 1 * from stock_modify"
					rs_stock_modify.open sqltext2,conn,1,2
					
          '在强制修改库存表中插入修改的数据
					rs_stock_modify.addnew
					rs_stock_modify("a11gid") = rs_stock("a4gid")
					rs_stock_modify("a11name") = rs_stock("a4name")
					rs_stock_modify("a11code") = rs_stock("a4code")
					rs_stock_modify("a11brand") = rs_stock("a4brand")
					rs_stock_modify("a11reason") = reason
					rs_stock_modify("a11amount_old") = temp_stock
					rs_stock_modify("a11amount_new") = stock
					rs_stock_modify("a11price") = price
					rs_stock_modify("a11crttime") = timestr
					rs_stock_modify("a11crtuser") = username
					rs_stock_modify.update

          '更新库存表
					rs_stock("a4stock") = stock
					rs_stock("a4diff") = temp_diff
					rs_stock("a4total_money") = stock * price
					rs_stock("a4cflag") = 1
					rs_stock("a4chgtime") = timestr
					rs_stock("a4chguser") = username
					rs_stock.update
				end if

        %>
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%username%> 库存已经修改
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2">
					  <tr height="20">
					    <td width="50"></td>
					    <td width="100">
						商品名称
						</td>
						<td width="180"><%=rs_stock("a4name")%></td>
					    <td width="50"></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						条形码
						</td>
						<td><%=rs_stock("a4code")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						品牌
						</td>
						<td><%=rs_stock("a4brand")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						存货数量
						</td>
						<td><%=stock%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						最近买入价格
						</td>
						<td><%=rs_stock("a4buy_price")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						普通会员价格
						</td>
						<td><%=rs_stock("a4price_common")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						VIP价格
						</td>
						<td><%=rs_stock("a4price_vip")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						批销价格
						</td>
						<td><%=rs_stock("a4price_wholesale")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						备注
						</td>
						<td><%if IsNull(rs("a4remark")) then response.write ("无备注") else response.write (rs("a4remark"))%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						修改时间
						</td>
						<td><%=kdztimeformat(rs_stock("a4chgtime"),"1")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						修改人
						</td>
						<td><%=rs_stock("a4chguser")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						修改原因
						</td>
						<td><%=reason%>
						</td>
					    <td></td>
					  </tr>
					   <tr>
						 <td colspan="4" height="60" align="center" class="STYLE1">
						 <a href="adv_select.asp">10秒后将自动返回高级查询页面</a>
						 </td>
					   </tr>
					   <%
					   	  rs_stock_modify.Close
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
	<tr>
	  <td align="center">
	  <img src="image\logo_mini.gif">
	  </td>
	</tr>
</table>
</BODY>
</HTML>