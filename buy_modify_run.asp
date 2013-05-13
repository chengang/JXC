<!KDZ Studio Powered at 20070602">
<%response.Expires = 0%>
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：进货编辑执行页面
  '更新DB：buy、stock
  '参照DB：stock
  '修改履历
  '修改年月日、责任者、内容
  '2007/06/02  sky@kdz 新增
  '2007/07/21  sky@kdz 修改 重复修改进货bug的修改
  '2007/10/29  sky@kdz 修改 单一订单显示利润引起的修改
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<% 
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim id,amount,frompage
id = trim(request.form("a1id"))
amount = trim(request.form("a1amount"))
frompage = trim(request.form("frompage"))
'response.write frompage
'response.write ("<br>")
'response.write frompage
'response.end

'取系统时间为数值
dim timestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

'根据自动编号查询进货表
dim rs_buy,a1gid,a1name,a1code,a1brand,a1seat,a1amount,temp_amount
dim a1buy_price,a1price_common,a1price_vip,a1price_wholesale
dim a1crttime,a1crtuser
set rs_buy=server.createobject("adodb.recordset")
    sqltext1 = "select * " 
    sqltext1 = sqltext1&"from buy where a1mflag = 0 and a1id ="&id
    'response.write sqltext1
	  'response.end
    rs_buy.open sqltext1,conn,1,2

if rs_buy.eof then
   response.redirect("messagebox.asp?msg=请不要用浏览器上的后退按钮反复修改，重新查询后再修改")
   response.end
else
  a1gid = rs_buy("a1gid")
	a1name = rs_buy("a1name")
	a1code = rs_buy("a1code")
	a1brand = rs_buy("a1brand")
	a1seat = rs_buy("a1seat")
	a1amount = rs_buy("a1amount")
	a1buy_price = rs_buy("a1buy_price")
	a1price_common = rs_buy("a1price_common")
	a1price_vip = rs_buy("a1price_vip")
	a1price_wholesale = rs_buy("a1price_wholesale")
	a1crttime = rs_buy("a1crttime")
	a1crtuser = rs_buy("a1crtuser")
	'进货数量的修改的差
	temp_amount = 0
	temp_amount = a1amount - amount
	'response.write ("<br>")
	'response.write a1amount
	'response.write ("<br>")
	'response.write temp_amount
	'response.end

'根据gid查询库存表
dim rs_stock,stock,diff,total_money
set rs_stock=server.createobject("adodb.recordset")
    sqltext2 = "select * " 
    sqltext2 = sqltext2&"from stock where a4gid ='"&a1gid&"'"
    'response.write sqltext2
    rs_stock.open sqltext2,conn,1,2

    stock = rs_stock("a4stock")
	  diff = 0
	  diff = rs_stock("a4diff")
	  'response.write stock
	  'response.write ("<br>")
	  'response.write diff
	  'response.end

    total_money = rs_stock("a4total_money")

	'修改后库存数量不能为负值
	if stock < temp_amount then
	   rs_stock.close
	   rs_buy.close
	   set conn = nothing
	   response.redirect("messagebox.asp?msg=禁止修改！非法操作")
	   response.end
	end if

  '更新库存表
	rs_stock("a4stock") = stock - temp_amount
	rs_stock("a4total_money") = total_money - a1buy_price * temp_amount
	rs_stock("a4diff") = diff - temp_amount
	rs_stock("a4cflag") = 1
	rs_stock("a4chgtime") = timestr
  rs_stock("a4chguser") = username
	'response.write stock
	'response.write ("<br>")
	'response.write diff
	'response.end
	rs_stock.update

  '更新进货表
  '理论删除该修改的那条数据
	rs_buy("a1mflag") = 1
	rs_buy("a1chgtime") = timestr
  rs_buy("a1chguser") = username
	rs_buy.update

	'新增一条修改后的数据
	rs_buy.addnew
	rs_buy("a1gid") = a1gid
	rs_buy("a1name") = a1name
	rs_buy("a1code") = a1code
	rs_buy("a1brand") = a1brand
	rs_buy("a1seat") = a1seat
	rs_buy("a1buy_price") = a1buy_price
	rs_buy("a1amount") = amount
	rs_buy("a1price_common") = a1price_common
	rs_buy("a1price_vip") = a1price_vip
	rs_buy("a1price_wholesale") = a1price_wholesale
	rs_buy("a1mflag") = 0
	rs_buy("a1relation") = id
	rs_buy("a1crttime") = a1crttime
	rs_buy("a1crtuser") = a1crtuser
	rs_buy("a1chgtime") = timestr
	rs_buy("a1chguser") = username
	rs_buy.update
	rs_buy.close
	set conn = nothing
    
	if frompage = "adv" then
       response.redirect("admin_buy_select.asp")
	   response.end
	else
	    response.redirect("buy_select.asp")
        response.end
    end if
end if
%>
