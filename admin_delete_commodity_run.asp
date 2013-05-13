<!KDZ Studio Powered at 20071214">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<%response.Expires = 0%>
<!--#include file="inc/conn.asp"-->
<%'机能说明：删除单件商品后台
  '          1、如果此商品被销售过，则不能删除此商品，
  '             并且跳转到该商品所有订单页面
  '          2、如果此商品没有被销售过
  '             记录被删除商品的信息
  '             删除关联表中此商品的记录
  '更新DB：buy、sold、returned、seat、stock_modify
  '        commodity_modify、seat_transfer、stock、history_delete
  '参照DB：sold
  '修改履历
  '修改年月日、责任者、内容
  '2007/12/14  sky@kdz 新增 删除单件商品功能增加
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<HTML>
<HEAD>
<TITLE>进销存系统——删除单件结果</TITLE>
<meta http-equiv="refresh" content="10;url=admin_delete_commodity.asp">
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
	dim gid,reason
	gid = trim(request.form("gid"))
	reason = trim(request.form("reason"))

	'response.write reason
	'response.end

%>
</HEAD>

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
				'取系统时间为数值
				  dim timestr
					  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
				%>

				<%
				   '判断此商品是否被出售过
					dim rs_sold,sqltext_sold
					set rs_sold = server.createobject("adodb.recordset")
						sqltext_sold = "select * "
						sqltext_sold = sqltext_sold&"from sold "
						sqltext_sold = sqltext_sold&"where a2gid='"&gid&"' and a2mflag = 0 "
						rs_sold.open sqltext_sold,conn,1,1

						'如果被出售过，则跳转到该商品所有订单页面

						if not rs_sold.eof then
						
						   response.write("<script language=javascript> alert('此商品已经被售出过，请先删除订单后，再删除商品');")
						   response.write("window.location ='admin_commodity_orderbook_run.asp?gid="&gid&"';</script>")
						   response.end
						else

                            '-----------记录删除商品的信息到删除历史表中开始---------------

							'获取库存表中商品信息
							dim rs_get_stock,sqltext_get_stock
							set rs_get_stock = server.createobject("adodb.recordset")
								sqltext_get_stock = "select * "
								sqltext_get_stock = sqltext_get_stock&"from stock "
								sqltext_get_stock = sqltext_get_stock&"where a4gid='"&gid&"'"
								rs_get_stock.open sqltext_get_stock,conn,1,1
							    
								'response.write "sqltext_get_stock:"&sqltext_get_stock
								'response.write "<br>"

								dim code,name,brand,amount
								dim a14price_common,a14price_vip,a14price_wholesale
								dim a14stock_money,a14stock_amount
								  code = rs_get_stock("a4code")
								  name = rs_get_stock("a4name")
								  brand = rs_get_stock("a4brand")
									price_common = rs_get_stock("a4price_common")
									price_vip = rs_get_stock("a4price_vip")
									price_wholesale = rs_get_stock("a4price_wholesale")
									stock_money = rs_get_stock("a4total_money")
									stock_amount = rs_get_stock("a4stock")

								rs_get_stock.close

							'获进货表中商品信息
							dim rs_get_buy,sqltext_get_buy
							set rs_get_buy = server.createobject("adodb.recordset")
								sqltext_get_buy = "select sum(IsNull(a1amount,0)) total_buy_amount,sum(IsNull(a1amount,0) * IsNull(a1buy_price,0)) total_buy_money "
								sqltext_get_buy = sqltext_get_buy&"from buy "
								sqltext_get_buy = sqltext_get_buy&"where a1gid='"&gid&"' and a1mflag = 0 "
								rs_get_buy.open sqltext_get_buy,conn,1,1

								'response.write "sqltext_get_buy:"&sqltext_get_buy
								'response.write "<br>"

								dim buy_money,buy_amount
								    buy_amount = rs_get_buy("total_buy_amount")
								    buy_money = rs_get_buy("total_buy_money")

								rs_get_buy.close

							'获强制修改库存表中商品信息
							dim rs_get_stock_modify,sqltext_get_stock_modify
							set rs_get_stock_modify = server.createobject("adodb.recordset")
								sqltext_get_stock_modify = "select sum(IsNull(a11amount_new,0) - IsNull(a11amount_old,0)) total_modify_amount, "
								sqltext_get_stock_modify = sqltext_get_stock_modify&"sum((IsNull(a11amount_new,0) - IsNull(a11amount_old,0))*IsNull(a11price,0)) total_modify_money "
								sqltext_get_stock_modify = sqltext_get_stock_modify&"from stock_modify "
								sqltext_get_stock_modify = sqltext_get_stock_modify&"where a11gid='"&gid&"' "
								rs_get_stock_modify.open sqltext_get_stock_modify,conn,1,1

								'response.write "sqltext_get_stock_modify:"&sqltext_get_stock_modify
								'response.write "<br>"

								dim modify_amount,modify_money
								    modify_amount = rs_get_stock_modify("total_modify_amount")
								    modify_money = rs_get_stock_modify("total_modify_money")

								rs_get_stock_modify.close

							'获仓位表中商品信息
							dim rs_get_seat,sqltext_get_seat
							set rs_get_seat = server.createobject("adodb.recordset")
								sqltext_get_seat = "select a10seat "
								sqltext_get_seat = sqltext_get_seat&"from seat "
								sqltext_get_seat = sqltext_get_seat&"where a10gid='"&gid&"' "
								rs_get_seat.open sqltext_get_seat,conn,1,1

								'response.write "sqltext_get_seat:"&sqltext_get_seat
								'response.write "<br>"

								dim temp_seat
								temp_seat = ""
								do while not rs_get_seat.eof
                   temp_seat = temp_seat&","&rs_get_seat("a10seat")
					         rs_get_seat.movenext
								loop
								temp_seat = right(temp_seat,len(temp_seat)-1)
								'response.write "temp_seat:"&temp_seat

								rs_get_seat.close

							'插入到删除历史表中
							dim rs_history_delete,sqltext_history_delete
							set rs_history_delete = server.createobject("adodb.recordset")
								sqltext_history_delete = "select top 1 * "
								sqltext_history_delete = sqltext_history_delete&"from history_delete "
								rs_history_delete.open sqltext_history_delete,conn,1,2

								rs_history_delete.Addnew
								rs_history_delete("a14gid") = gid
								rs_history_delete("a14code") = code
								rs_history_delete("a14name") = name
								rs_history_delete("a14brand") = brand
								rs_history_delete("a14price_common") = price_common
								rs_history_delete("a14price_vip") = price_vip
								rs_history_delete("a14price_wholesale") = price_wholesale
								rs_history_delete("a14buy_money") = buy_money
								rs_history_delete("a14buy_amount") = buy_amount
								rs_history_delete("a14modify_money") = modify_money
								rs_history_delete("a14modify_amount") = modify_amount
								rs_history_delete("a14seat") = temp_seat
								rs_history_delete("a14stock_money") = stock_money
								rs_history_delete("a14stock_amount") = stock_amount
								rs_history_delete("a14reason") = reason
								rs_history_delete("a14crttime") = int(timestr)
								rs_history_delete("a14crtuser") = username
							  rs_history_delete.Update

								rs_history_delete.close

								'response.end
                '-----------记录删除商品的信息到删除历史表中结束---------------
						    '-----------删除关联表中此商品的记录开始-----------------------
							'删除进货表中记录
							dim rs_buy,sqltext_buy
							set rs_buy = server.createobject("adodb.recordset")
								sqltext_buy = "delete "
								sqltext_buy = sqltext_buy&"from buy "
								sqltext_buy = sqltext_buy&"where a1gid='"&gid&"'"
								rs_buy.open sqltext_buy,conn,1,2

								rs_buy.close

							'删除售货表中数据
							dim rs_sold2,sqltext_sold2
							set rs_sold2 = server.createobject("adodb.recordset")
								sqltext_sold2 = "delete "
								sqltext_sold2 = sqltext_sold2&"from sold "
								sqltext_sold2 = sqltext_sold2&"where a2gid='"&gid&"'"
								rs_sold2.open sqltext_sold2,conn,1,2

								rs_sold2.close
							
							'删除退货表中数据
							dim rs_returned,sqltext_returned
							set rs_returned = server.createobject("adodb.recordset")
								sqltext_returned = "delete "
								sqltext_returned = sqltext_returned&"from returned "
								sqltext_returned = sqltext_returned&"where a3gid='"&gid&"'"
								rs_returned.open sqltext_returned,conn,1,2

								rs_returned.close
							
							'删除仓位表中数据
							dim rs_seat,sqltext_seat
							set rs_seat = server.createobject("adodb.recordset")
								sqltext_seat = "delete "
								sqltext_seat = sqltext_seat&"from seat "
								sqltext_seat = sqltext_seat&"where a10gid='"&gid&"'"
								rs_seat.open sqltext_seat,conn,1,2

								rs_seat.close

							'删除强制修改库存表中数据
							dim rs_stock_modify,sqltext_stock_modify
							set rs_stock_modify = server.createobject("adodb.recordset")
								sqltext_stock_modify = "delete "
								sqltext_stock_modify = sqltext_stock_modify&"from stock_modify "
								sqltext_stock_modify = sqltext_stock_modify&"where a11gid='"&gid&"'"
								rs_stock_modify.open sqltext_stock_modify,conn,1,2

								rs_stock_modify.close

							'删除修改商品属性表中数据
							dim rs_commodity_modify,sqltext_commodity_modify
							set rs_commodity_modify = server.createobject("adodb.recordset")
								sqltext_commodity_modify = "delete "
								sqltext_commodity_modify = sqltext_commodity_modify&"from commodity_modify "
								sqltext_commodity_modify = sqltext_commodity_modify&"where a12gid='"&gid&"'"
								rs_commodity_modify.open sqltext_commodity_modify,conn,1,2

								rs_commodity_modify.close

							'删除仓位迁移表中数据
							dim rs_seat_transfer,sqltext_seat_transfer
							set rs_seat_transfer = server.createobject("adodb.recordset")
								sqltext_seat_transfer = "delete "
								sqltext_seat_transfer = sqltext_seat_transfer&"from seat_transfer "
								sqltext_seat_transfer = sqltext_seat_transfer&"where a13gid='"&gid&"'"
								rs_seat_transfer.open sqltext_seat_transfer,conn,1,2

								rs_seat_transfer.close

							'删除库存表中数据
							dim rs_stock2,sqltext_stock2
							set rs_stock2 = server.createobject("adodb.recordset")
								sqltext_stock2 = "delete "
								sqltext_stock2 = sqltext_stock2&"from stock "
								sqltext_stock2 = sqltext_stock2&"where a4gid='"&gid&"'"
								rs_stock2.open sqltext_stock2,conn,1,2

								rs_stock2.close

						    '-----------删除关联表中此商品的记录开始-----------------------

						end if
						rs_sold.close
				%>
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%=username%> 此商品已经被删除
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2">
					  <tr>
					    <td width="50" height="30"></td>
					    <td width="100">
						条形码：
						</td>
						<td width="180">
						<%=code%>
						</td>
					    <td width="50"></td>
					  </tr>
					  
					  <tr>
					    <td width="50" height="30"></td>
					    <td width="100">
						商品名称：
						</td>
						<td width="180">
						<%=name%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="30"></td>
					    <td width="100">
						品牌：
						</td>
						<td width="180">
						<%=brand%>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="30"></td>
					    <td width="100">
						数量：
						</td>
						<td width="180">
						<%=stock_amount%>
						</td>
					    <td width="50"></td>
					  </tr>

					   <tr>
						 <td colspan="4" height="60" align="center" class="STYLE1">
						 <a href="admin_delete_commodity.asp">10秒后将自动返回删除单件商品页面</a>
						 </td>
					   </tr>
				  <% 
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
