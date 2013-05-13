<!KDZ Studio Powered at 20070722">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：订单释放后台
  '          1、判断订单表和售货表中是否有该订单，如果没有则报错
  '          2、判断退货表中是否有该订单的退货，如果有则置废退货表中该订单的纪录
  '          3、置废orderbook表中该订单的纪录
  '          4、置废sold表中该订单的纪录
  '          5、更新stock表
  '更新DB：sold、orderbook、returned、stock
  '参照DB：sold、orderbook
  '修改履历
  '修改年月日、责任者、内容
  '2007/07/22  sky@kdz 新增
  '2007/10/30  sky@kdz 修改 单一订单显示利润引起的修改
  '2008/11/08  sky@kdz 修改 修改退货流程
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<% 
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim oid,frompage
oid = trim(request.queryString("oid"))
frompage = trim(request.queryString("frompage"))
'response.write oid
'response.write ("<br>")
'response.write frompage
'response.write ("<br>")
'response.end

'取系统时间为数值
dim timestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

'根据订单号查询订单表
dim rs_orderbook,sqltext_orderbook
set rs_orderbook=server.createobject("adodb.recordset")
    sqltext_orderbook = "select * " 
    sqltext_orderbook = sqltext_orderbook&"from orderbook where a9mflag = 0 and a9oid ='"&oid&"'"
    'response.write sqltext_orderbook&"<br>"
	  'response.end
    rs_orderbook.open sqltext_orderbook,conn,1,2

if rs_orderbook.eof then
   rs_orderbook.close
   response.redirect("messagebox.asp?msg=没有此订单，请重新查询后再删除")
   response.end
end if

'根据订单号查询售货表
dim rs_sold,sqltext_sold
set rs_sold=server.createobject("adodb.recordset")
    sqltext_sold = "select * " 
    sqltext_sold = sqltext_sold&"from sold where a2mflag = 0 and a2oid ='"&oid&"'"
    'response.write sqltext_sold&"<br>"
	  'response.end
    rs_sold.open sqltext_sold,conn,1,2

if rs_sold.eof then
   rs_sold.close
   response.redirect("messagebox.asp?msg=异常错误，请重新查询后再删除")
   response.end
end if

while not rs_orderbook.eof
'置废订单表中该订单的纪录
   rs_orderbook("a9mflag") = 2
   rs_orderbook("a9chgtime") = timestr
   rs_orderbook("a9chguser") = username
   rs_orderbook.update
   rs_orderbook.movenext
wend
rs_orderbook.close

'response.write "rs_orderbook"&"<br>"
'response.end

while not rs_sold.eof

'根据订单号和商品gid查询退货表
dim rs_returned,sqltext_returned,returned_amount
set rs_returned=server.createobject("adodb.recordset")
    sqltext_returned = "select * " 
    sqltext_returned = sqltext_returned&"from returned where a3mflag = 0 and a3oid ='"&oid&"' and a3gid = '"&rs_sold("a2gid")&"'"
    'response.write sqltext_returned&"<br>"
	  'response.end
    rs_returned.open sqltext_returned,conn,1,2

   returned_amount = 0
   if not rs_returned.eof then
      do while not rs_returned.eof
        '如果已经确认退货，则计算退货数量
        if int(rs_returned("a3status")) = 2 then
	         returned_amount = returned_amount + rs_returned("a3amount")
	      end if
         '置废退货表中该订单的纪录
         rs_returned("a3mflag") = 2
         rs_returned("a3chgtime") = timestr
         rs_returned("a3chguser") = username
         rs_returned.update
         rs_returned.movenext
	  loop
   end if
rs_returned.close
'response.end
'根据商品gid查询库存表
dim rs_stock,sqltext_stock
set rs_stock=server.createobject("adodb.recordset")
    sqltext_stock = "select * " 
    sqltext_stock = sqltext_stock&"from stock where a4gid ='"&rs_sold("a2gid")&"'"
    'response.write sqltext2
    rs_stock.open sqltext_stock,conn,1,2

  '更新库存表
	rs_stock("a4total_money") = rs_stock("a4total_money") + ( rs_sold("a2buy_price") * (rs_sold("a2amount") - returned_amount) )
	rs_stock("a4stock") = rs_stock("a4stock") + (rs_sold("a2amount") - returned_amount)
	rs_stock("a4diff") = rs_stock("a4diff") + (rs_sold("a2amount") - returned_amount)
	rs_stock("a4cflag") = 1
	rs_stock("a4chgtime") = timestr
  rs_stock("a4chguser") = username
	'response.write stock
	'response.write ("<br>")
	'response.write diff
	'response.end
	rs_stock.update
    rs_stock.close

    '置废售货表中该订单的纪录
    rs_sold("a2mflag") = 2
    rs_sold("a2chgtime") = timestr
    rs_sold("a2chguser") = username
	rs_sold.update
	rs_sold.movenext
wend
rs_sold.close

	set conn = nothing
    
	if frompage = "adv" then
     response.redirect("admin_orderbook_select.asp")
	   response.end
	else
	   response.redirect("inquire_orderbook_select.asp")
     response.end
    end if
%>
