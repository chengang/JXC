<!KDZ Studio Powered at 20070329">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：1、根据商品名称查询进货表是否从前进过此商品
  '             (1)如果进过,查询此商品的gid
  '             (2)如果没有,则查询gid生成表,gid增一作为
  '                该商品的gid,并且更新到商品gid生成表中
  '          2、在进货表中插入进货记录
  '          3、更新库存表，更新仓位表
  '             (1)如果有此商品的库存则更新库存表，和价格
  '             (2)如果没有此商品的库存则插入一条新的记录
  '             (3)根据gid和仓位查询仓位表
  '                如果有记录则更新记录，否则插入记录
  '更新DB：buy、stock
  '参照DB：goods_id_creater
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/11  sky@kdz 修改
  '2007/05/14  sky@kdz 修改 仓位表的修改flag字段的追加修改
  '2007/05/15  sky@kdz 修改 同种商品不同条形码的验证
  '2007/06/02  sky@kdz 修改 buy表修改mflag字段的增加
  '2007/06/07  sky@kdz 修改 进货时把买入价格插入到库存表中
  '2007/10/29  sky@kdz 修改 单一订单显示利润引起的修改
  '2008/11/16  sky@kdz 修改 显示时间样式修改
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
  '2008/12/23  sky@kdz 修改 赠品的时候，不check卖出价格
%>
<HTML>
<HEAD>
<TITLE>进销存系统——进货确认</TITLE>
<meta http-equiv="refresh" content="10;url=buy.asp">
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
	dim code,gid,name,brand,amount,seat,buy_price
	dim price_common,price_vip,price_wholesale,gifts
	dim crtuser,chguser,gid_temp
	gid_temp = trim(request.form("a1gid"))
	code = trim(request.form("a1code"))
	name = trim(request.form("a1name"))
	brand = trim(request.form("a1brand"))
	amount = trim(request.form("a1amount"))
	seat = trim(request.form("a1seat"))
	gifts = trim(request.form("gifts"))
	buy_price = trim(request.form("a1buy_price"))
	price_common = int(trim(request.form("a1price_common")))
	price_vip = int(trim(request.form("a1price_vip")))
	price_wholesale = int(trim(request.form("a1price_wholesale")))
	crtuser = username
	chguser = username
  if gifts <> "1" then
	   if int(buy_price) >  int(price_wholesale) then
        response.redirect("messagebox.asp?msg=买入价格不能大于批销价格")
	      response.end
	   end if
	   if int(price_wholesale) >  int(price_vip) then
        response.redirect("messagebox.asp?msg=批销价格不能大于VIP价格")
	      response.end
	   end if
	   if int(price_vip) >  int(price_common) then
        response.redirect("messagebox.asp?msg=VIP价格不能大于普通会员价格")
	      response.end
	   end if
  else
     price_common = 0
     price_vip = 0
     price_wholesale = 0
	end if
	if gid_temp = "" then
		dim rs_buy_code,sqltext_code,rs_buy_code_name
		set rs_buy_code = server.createobject("adodb.recordset")
		sqltext_code = "select a1name from buy "
		sqltext_code = sqltext_code&"where a1code='"&code&"'"
		'response.write sqltext_code
		'response.end
		rs_buy_code.open sqltext_code,conn,1,1

		while not rs_buy_code.eof
		  if name = rs_buy_code("a1name") then
		   rs_buy_code.close
		   response.redirect("messagebox.asp?msg=此商品名已经存在，请确认后重新输入")
		   response.end
		  end if
		rs_buy_code.movenext
		wend
		rs_buy_code.close
	end if
%>
</HEAD>

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
		    <!--#include file="inc/left.inc"-->
		 </td>
		 <td width="380" valign="center">
		    <table bgcolor="#CCCCCC">
				<%
				'确定是什么操作
				  dim FromPage
					  FromPage = request.form("FromPage")
				'取系统时间为数值
				  dim timestr
					  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
				%>

				<%if FromPage = "add" then%>
				<!-- 进货 Begin-->
				<%
				   dim rs_goods_id_creater
				   set rs_goods_id_creater = server.createobject("adodb.recordset")
					   sqltext2 = "select * from goods_id_creater where a7reason = 'gid_creater'"
					   rs_goods_id_creater.open sqltext2,conn,1,2

					   dim goods_id_creater
					   if rs_goods_id_creater.eof then
						  '没有查询到记录
						  response.redirect("messagebox.asp?msg=请联系管理员，初始化数据库")
						  rs_goods_id_creater.Close
						  response.end
					   else

							'查询进货表是否从前进过此商品
							dim rs_buy
							set rs_buy = server.createobject("adodb.recordset")
								sqltext1 = "select * "
								sqltext1 = sqltext1&"from buy "
								sqltext1 = sqltext1&"where a1name='"&name&"' and a1gid <>'' "
								sqltext1 = sqltext1&"order by a1crttime"
								rs_buy.open sqltext1,conn,1,2

								if not rs_buy.eof Then
								   '----------------------------------------------------------------------------------------------------
								   '------------------------------------------070605陈钢修改and gid_temp = ""---------------------------
								   '判断同种商品是否拥有不同的条形码
								   if rs_buy("a1code") <> code and gid_temp = "" then
								    'response.write("DB"&rs("a1code"))
									  'response.write("<br>")
									  'response.write("page"&code)
								    response.redirect("messagebox.asp?msg=同一种商品不能有不同的条形码，请确认后再输入")
									  'response.end
								   end if
								   '------------------------------------------070605陈钢修改and gid_temp = ""---------------------------
								   '----------------------------------------------------------------------------------------------------


								   '进过此货,查询此商品的gid，并把进货记录插入到进货表中
								   'response.write ("在进货表中有该商品")
								   'response.write("<br>")
								   gid = rs_buy("a1gid")
								   'response.write ("a1gid:")
								   'response.write (gid)
								   'response.write ("<br>")
								   
								else
								   '没进过此商品，查询商品生成ID表，生成商品ID，把记录插到进货表中
								   'response.write ("在进货表中没有查询到该商品")
								   'response.write("<br>")
									 '商品生成ID增1更新到表中
									  goods_id_creater = clng(rs_goods_id_creater("a7id")) + 1
									  rs_goods_id_creater("a7id") = goods_id_creater
									  rs_goods_id_creater.Update
									  'response.write("生成新的商品ID，更新到表中")
									  'response.write ("<br>")
								    rs_goods_id_creater.Close
								    gid="g"&goods_id_creater
								   'response.write gid
								   'response.write ("<br>")
								   'response.end
								end if

								 '把进货记录插入到进货表中
								 rs_buy.addnew
								 rs_buy("a1code")=code
								 rs_buy("a1gid")=gid
								 rs_buy("a1name")=name
								 rs_buy("a1brand")=brand
								 rs_buy("a1amount")=amount
								 rs_buy("a1seat")=seat
								 rs_buy("a1buy_price")=buy_price
								 rs_buy("a1price_common")=price_common
								 rs_buy("a1price_vip")=price_vip
								 rs_buy("a1price_wholesale")=price_wholesale
								 rs_buy("a1mflag")=0
								 rs_buy("a1crttime")=int(timestr)
								 rs_buy("a1crtuser")=crtuser
								 rs_buy("a1chgtime")=int(timestr)
								 rs_buy("a1chguser")=chguser
								 'response.write ("db_code:")
								 'response.write (rs_buy("a1code"))
								 'response.write ("<br>")
								 rs_buy.update
								 rs_buy.close
								 'response.write("进货记录已插入到进货表中")

							'把进货记录更新到存货表中
							'查询库存表中是否有该商品的库存
							dim rs_stock,stock,total_money
							set rs_stock = server.createobject("adodb.recordset")
								sqltext3 = "select top 1 * "
								sqltext3 = sqltext3&"from stock "
								sqltext3 = sqltext3&"where a4gid='"&gid&"'"
								sqltext3 = sqltext3&"order by a4crttime"
								rs_stock.open sqltext3,conn,1,2
								if not rs_stock.eof then
								  '查询到记录，更新库存
								  stock = int(rs_stock("a4stock")) + amount
								  total_money = int(rs_stock("a4total_money")) + amount * buy_price
								  'response.write ("更新前库存:")
								  'response.write (rs_stock("a4stock"))
								  'response.write ("<br>")
								  'response.write ("更新后库存:")
								  'response.write stock
								  'response.write ("<br>")
								  'response.end
								  rs_stock("a4stock") = stock
								  rs_stock("a4buy_price")=buy_price
								  rs_stock("a4price_common")=price_common
								  rs_stock("a4price_vip")=price_vip
								  rs_stock("a4price_wholesale")=price_wholesale
								  rs_stock("a4total_money")=total_money
								  rs_stock("a4chgtime")=int(timestr)
								  rs_stock("a4chguser")=chguser
								  'response.write("库存已更新")
								else
								  '没有查询到记录，在表中插入一条记录
								  rs_stock.Addnew
								  rs_stock("a4gid")=gid
								  rs_stock("a4code")=code
								  rs_stock("a4name")=name
								  rs_stock("a4brand")=brand
								  rs_stock("a4stock")=amount
								  rs_stock("a4buy_price")=buy_price
								  rs_stock("a4price_common")=price_common
								  rs_stock("a4price_vip")=price_vip
								  rs_stock("a4price_wholesale")=price_wholesale
								  rs_stock("a4total_money")=amount * buy_price
								  rs_stock("a4cflag")=0
								  rs_stock("a4crttime")=int(timestr)
								  rs_stock("a4crtuser")=crtuser
								  rs_stock("a4chgtime")=int(timestr)
								  rs_stock("a4chguser")=chguser
								 'response.write ("db_code:")
								 'response.write (rs_buy("a1code"))
								 'response.write ("<br>")
								 'response.write("进货记录已插入库存")
								end if
							  rs_stock.Update
								rs_stock.Close

							'查询仓位表
							'如果有记录则更新，否则为插入
							dim rs_seat,total_amount
							set rs_seat = server.createobject("adodb.recordset")
								sqltext4 = "select top 1 * "
								sqltext4 = sqltext4&"from seat "
								sqltext4 = sqltext4&"where a10gid='"&gid&"' and a10seat = '"&seat&"'"
								sqltext4 = sqltext4&"order by a10crttime"
								rs_seat.open sqltext4,conn,1,2
								if not rs_seat.eof then
								  '查询到记录，更新库存
								  total_amount = int(rs_seat("a10amount")) + amount
								  'response.write ("更新前仓位库存:")
								  'response.write (rs_seat("a10amount"))
								  'response.write ("<br>")
								  'response.write ("更新后仓位库存:")
								  'response.write total_amount
								  'response.write ("<br>")
								  'response.end
								  rs_seat("a10amount") = total_amount
								  rs_seat("a10chgtime")=int(timestr)
								  rs_seat("a10chguser")=chguser
								  'response.write("库存已更新")
								else
								  '没有查询到记录，在表中插入一条记录
								  rs_seat.Addnew
								  rs_seat("a10gid")=gid
								  rs_seat("a10name")=name
								  rs_seat("a10code")=code
								  rs_seat("a10seat")=seat
								  rs_seat("a10amount")=amount
								  rs_seat("a10crttime")=int(timestr)
								  rs_seat("a10crtuser")=crtuser
								  rs_seat("a10chgtime")=int(timestr)
								  rs_seat("a10chguser")=chguser
								 'response.write ("db_code:")
								 'response.write (rs_buy("a1code"))
								 'response.write ("<br>")
								 'response.write("进货记录已插入仓位表")
								end if
							  rs_seat.Update
								rs_seat.Close
				%>
				<!-- 进货 End-->
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%=username%> 你已录入此商品
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2">
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						条形码：
						</td>
						<td width="180">
						<%=code%>
						</td>
					    <td width="50"></td>
					  </tr>
					  
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						商品名称：
						</td>
						<td width="180">
						<%=name%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						品牌：
						</td>
						<td width="180">
						<%=brand%>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						数量：
						</td>
						<td width="180">
						<%=amount%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						仓位：
						</td>
						<td width="180">
						<%=seat%>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						买入价格：
						</td>
						<td width="180">
						<%=buy_price%>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						普通价格：
						</td>
						<td width="180">
						<%=price_common%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						vip价格：
						</td>
						<td width="180">
						<%=price_vip%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						批销价格：
						</td>
						<td width="180">
						<%=price_wholesale%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						录入日期：
						</td>
						<td width="180">
						<%=kdztimeformat(timestr,"1")%>
						</td>
					    <td width="50"></td>
					  </tr>
					   <tr>
						 <td colspan="4" height="60" align="center" class="STYLE1">
						 <a href="buy.asp">10秒后将自动返回录入页面</a>
						 </td>
					   </tr>
				  <%  end if
					  set conn=nothing
			      end if
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
