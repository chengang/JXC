<!KDZ Studio Powered at 20070729">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：商品品牌修改后台页面
  '         1、修改商品品牌
  '更新DB：buy,sold,returned,stock,stock_modify,commodity_modify
  '参照DB：stock
  '修改履历
  '修改年月日、责任者、内容
  '2007/07/29  sky@kdz 新增
  '2008/01/05  sky@kdz 修改 商品添加备注属性
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>

<HTML>
<HEAD>
<TITLE>进销存系统——商品品牌修改确认</TITLE>
<meta http-equiv="refresh" content="10;url=return.asp">
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

				<%
				'从form中取值
				dim id,brand,reason
				brand = trim(request.form("brand"))
				reason = trim(request.form("reason"))
				id = trim(request.form("id"))

        'response.write "name_temp"&name_temp&"<br>"
        'response.write "reason"&reason&"<br>"
        'response.write "id"&id&"<br>"
        'response.end

				'更具id查询库存表
				dim rs_stock,sqltext_stock
				set rs_stock=server.createobject("adodb.recordset")
				sqltext_stock="select * from stock where a4id = '"&id&"'"
				rs_stock.open sqltext_stock,conn,1,2

        'response.write "sqltext_stock"&sqltext_stock&"<br>"
        'response.end

				if rs_stock.eof then 
				   '没有查询到纪录
				    rs_stock.close
					  response.redirect("messagebox.asp?msg=系统错误，请联系管理员1")
	          response.end
				else
				    dim temp_gid,old_brand,code
					  temp_gid = rs_stock("a4gid")
						old_brand = rs_stock("a4brand")
						code = rs_stock("a4code")
					
					'更新库存表
					rs_stock("a4brand") = brand
					rs_stock.update

				   '更新进货表
				    dim rs_buy,sqltext_buy
				    set rs_buy=server.createobject("adodb.recordset")
				        sqltext_buy="select * from buy where a1gid = '"&temp_gid&"'"
				        rs_buy.open sqltext_buy,conn,1,2

                'response.write "sqltext_buy"&sqltext_buy&"<br>"
                'response.end

					    while not rs_buy.eof
               rs_buy("a1brand") = brand
						   rs_buy.update
						   rs_buy.movenext
						wend
						rs_buy.close

				   '更新售货表
				    dim rs_sold,sqltext_sold
				    set rs_sold=server.createobject("adodb.recordset")
				        sqltext_sold="select * from sold where a2gid = '"&temp_gid&"'"
				        rs_sold.open sqltext_sold,conn,1,2

              'response.write "sqltext_sold"&sqltext_sold&"<br>"
              'response.end

					    while not rs_sold.eof
               rs_sold("a2brand") = brand
						   rs_sold.update
						   rs_sold.movenext
						wend
						rs_sold.close

				   '更新退货表
				    dim rs_returned,sqltext_returned
				    set rs_returned=server.createobject("adodb.recordset")
				        sqltext_returned="select * from returned where a3gid = '"&temp_gid&"'"
				        rs_returned.open sqltext_returned,conn,1,2

              'response.write "sqltext_returned"&sqltext_returned&"<br>"
              'response.end

					    while not rs_returned.eof
               rs_returned("a3brand") = brand
						   rs_returned.update
						   rs_returned.movenext
						wend
						rs_returned.close

				   '更新强制修改库存表
				    dim rs_stock_modify,sqltext_stock_modify
				    set rs_stock_modify=server.createobject("adodb.recordset")
				        sqltext_stock_modify="select * from stock_modify where a11gid = '"&temp_gid&"'"
				        rs_stock_modify.open sqltext_stock_modify,conn,1,2

              'response.write "sqltext_stock_modify"&sqltext_stock_modify&"<br>"
              'response.end

					    while not rs_stock_modify.eof
               rs_stock_modify("a11brand") = brand
						   rs_stock_modify.update
						   rs_stock_modify.movenext
						wend
						rs_stock_modify.close

				   '更新商品属性表
				    dim rs_commodity_modify,sqltext_commodity_modify
				    set rs_commodity_modify=server.createobject("adodb.recordset")
				        sqltext_commodity_modify="select top 1 * from commodity_modify"
				        rs_commodity_modify.open sqltext_commodity_modify,conn,1,2

              'response.write "sqltext_commodity_modify"&sqltext_commodity_modify&"<br>"
              'response.end

					    rs_commodity_modify.addnew
					    rs_commodity_modify("a12gid") = temp_gid
					    rs_commodity_modify("a12code") = code
					    rs_commodity_modify("a12mflag") = "品牌"
					    rs_commodity_modify("a12old") = old_brand
					    rs_commodity_modify("a12new") = brand
					    rs_commodity_modify("a12reason") = reason
					    rs_commodity_modify("a12crttime") = timestr
					    rs_commodity_modify("a12crtuser") = username
						  rs_commodity_modify.update
						  rs_commodity_modify.close

				end if
        %>
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%username%> 商品品牌已经修改
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
						<td><%=brand%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						存货数量
						</td>
						<td><%=rs_stock("a4stock")%>
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
						<td><%if IsNull(rs_stock("a4remark")) then response.write ("无备注") else response.write (rs_stock("a4remark"))%>
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
