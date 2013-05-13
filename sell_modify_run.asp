<!KDZ Studio Powered at 20070602">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：售货编辑执行页面
  '         1、查询售货表和退货表，判断卖货的数量不能大于退货数量
  '         2、判断卖货数量的差额不能超过库存
  '         2、更新库存表
  '         3、更新售货表
  '         4、更新订单表的售货金额
  '更新DB：sold、stock,oderbook
  '参照DB：return
  '修改履历
  '修改年月日、责任者、内容
  '2007/06/02  sky@kdz 新增
  '2007/06/27  sky@kdz 修改 从不同页面进入
  '                         修改后跳转不同的页面
  '2007/07/01  sky@kdz 修改 售货时加入邮费金额的修改
  '                         修改售货时,订单表同时更新邮费金额
  '2007/07/21  sky@kdz 修改 重复修改售货bug的修改
  '2007/10/29  sky@kdz 修改 单一订单显示利润引起的修改
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim id,amount,frompage
id = trim(request.form("a2id"))
amount = trim(request.form("a2amount"))
frompage = trim(request.form("frompage"))
response.write left(frompage,3)
response.write ("<br>")
response.write frompage
'response.end


'取系统时间为数值
dim timestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

'根据自动编号查询售货表
dim rs_sold,a2id,a2gid,a2name,a2code,a2brand,a2buy_price,a2sold_price,a2amount
dim a2oid,a2flow,a2status,a2mflag,a2crttime,a2crtuser
set rs_sold=server.createobject("adodb.recordset")
    sqltext1 = "select * " 
    sqltext1 = sqltext1&"from sold where a2mflag = 0 and a2id ="&id
    'response.write sqltext1
	  'response.write ("<br>")
	  'response.end
    rs_sold.open sqltext1,conn,1,2

if rs_sold.eof then
   response.redirect("messagebox.asp?msg=请不要用浏览器上的后退按钮反复修改，重新查询后再修改")
   response.end
else
  a2id = rs_sold("a2id")
	a2gid = rs_sold("a2gid")
	a2name = rs_sold("a2name")
	a2code = rs_sold("a2code")
	a2brand = rs_sold("a2brand")
  '--------------------------------------------------------------------------------------
  '---------------------------070627买入价格的增加---------------------------------------
	a2buy_price = rs_sold("a2buy_price")
  '---------------------------070627买入价格的增加---------------------------------------
  '--------------------------------------------------------------------------------------
	a2sold_price = rs_sold("a2sold_price")
	a2amount = rs_sold("a2amount")
	a2oid = rs_sold("a2oid")
	a2flow = rs_sold("a2flow")
	a2status = rs_sold("a2status")
	a2crttime = rs_sold("a2crttime")
	a2crtuser = rs_sold("a2crtuser")
	'修改卖货数量的差
	diff_amount = amount - a2amount
	diff_monoy = diff_amount * a2sold_price

    'response.write a2amount
    'response.write ("<br>")
    'response.write diff_amount
    'response.write ("<br>")
    'response.write a2sold_price
    'response.write ("<br>")
    'response.write diff_monoy
    'response.write ("<br>")
    'response.end

    '根据售货表的商品gid和定单号查询退货表
	dim rs_return,a3amount,total_amount
	set rs_return=server.createobject("adodb.recordset")
    sqltext2 = "select a3amount " 
    sqltext2 = sqltext2&"from returned where a3gid ='"&a2gid&"' and a3oid ='"&a2oid&"' and a3mflag = 0"
    'response.write sqltext2
    'response.write ("<br>")
	  'response.end
    rs_return.open sqltext2,conn,1,1

	'该商品退货数量合计的算出
	if not rs_return.eof then
	   total_amount = 0
	   do while not rs_return.eof
	   total_amount = total_amount + rs_return("a3amount")
     rs_return.movenext
	   loop

       'response.write "total_amount="&total_amount
       'response.write ("<br>")
       'response.write "amount="&amount
       'response.write ("<br>")
       'response.end

	   '判断卖货数量不能小于退货数量
	   if total_amount - amount > 0 then
	      rs_return.close
	      rs_sold.close
	      set conn = nothing
	      response.redirect("messagebox.asp?msg=卖货数量不能小于退货数量")
	      response.end
     end if
	end if
    re_return.close

    '判断修改卖货数量的差额不能超过库存
    '根据gid查询库存表
    dim rs_stock,stock,diff
    set rs_stock=server.createobject("adodb.recordset")
        sqltext3 = "select * " 
        sqltext3 = sqltext3&"from stock where a4gid ='"&a2gid&"'"
       'response.write sqltext3
       'response.write ("<br>")
	     'response.end
       rs_stock.open sqltext3,conn,1,2

       stock = rs_stock("a4stock")
	     diff = 0
	     diff = rs_stock("a4diff")

	   'response.write stock
	   'response.write ("<br>")
	   'response.write diff
	   'response.write ("<br>")
	   'response.write diff_amount
	   'response.write ("<br>")
	   'response.end

	   '修改后库存数量不能为负值
	   if stock - diff_amount < 0 then
	      rs_sold.close
	      re_return.close
	      rs_stock.close
	      set conn = nothing
	      response.redirect("messagebox.asp?msg=禁止修改！非法操作")
	      response.end
	   end if

    '判断修改后卖出金额不能小于优惠金额
    dim rs_orderbook,fi_sub_price,a9sub_price,a9postage,a9price_reduce
	  dim a9id,a9oid,a9flow,a9status,a9crttime,a9crtuser
	  set rs_orderbook = server.createobject("adodb.recordset")
	  sqltext4 = "select * from orderbook where a9mflag = 0 and a9oid='"&a2oid&"'"
    'response.write sqltext4
    'response.write ("<br>")
	  'response.end
	rs_orderbook.open sqltext4,conn,1,2

    if not rs_orderbook.eof then
	   a9sub_price = rs_orderbook("a9sub_price")
     '--------------------------------------------------------------------------------------
     '---------------------------070701邮费金额的增加---------------------------------------
	   a9postage = rs_orderbook("a9postage")
     '---------------------------070701邮费金额的增加---------------------------------------
     '--------------------------------------------------------------------------------------
	   a9price_reduce = rs_orderbook("a9price_reduce")
	   a9id = rs_orderbook("a9id")
	   a9oid = rs_orderbook("a9oid")
     '--------------------------------------------------------------------------------------
     '---------------------------070627流水单号的增加---------------------------------------
	   a9flow = rs_orderbook("a9flow")
     '---------------------------070627流水单号的增加---------------------------------------
     '--------------------------------------------------------------------------------------
	   a9status = rs_orderbook("a9status")
	   a9crttime = rs_orderbook("a9crttime")
	   a9crtuser = rs_orderbook("a9crtuser")
	   
	   fi_sub_price = a9sub_price + diff_monoy
	   
	   if fi_sub_price - a9price_reduce < 0 then
	      rs_sold.close
	      re_return.close
        rs_stock.close
        rs_orderbook.close
	      set conn = nothing
	      response.redirect("messagebox.asp?msg=优惠金额大于卖货数量,禁止修改！非法操作")
	      response.end
	   end if
	   
	   '更新优惠订单表
	   '理论删除被修改的那条数据
	   rs_orderbook("a9mflag") = 1
	   rs_orderbook("a9chgtime") = timestr
	   rs_orderbook("a9chguser") = username
	   rs_orderbook.update

     '新增一条修改后的数据
     rs_orderbook.addnew
	   rs_orderbook("a9oid") = a9oid
     '--------------------------------------------------------------------------------------
     '---------------------------070627流水单号的增加---------------------------------------
	   rs_orderbook("a9flow") = a9flow
     '---------------------------070627流水单号的增加---------------------------------------
     '--------------------------------------------------------------------------------------
	   rs_orderbook("a9sub_price") = fi_sub_price
     '--------------------------------------------------------------------------------------
     '---------------------------070701邮费金额的增加---------------------------------------
	   rs_orderbook("a9postage") = a9postage
     '---------------------------070701邮费金额的增加---------------------------------------
     '--------------------------------------------------------------------------------------
	   rs_orderbook("a9price_reduce") = a9price_reduce
	   rs_orderbook("a9status") = a9status
	   rs_orderbook("a9mflag") = 0
	   rs_orderbook("a9relation") = a9id
	   rs_orderbook("a9crttime") = a9crttime
	   rs_orderbook("a9crtuser") = a9crtuser
	   rs_orderbook("a9chgtime") = timestr
	   rs_orderbook("a9chguser") = username
	   rs_orderbook.update
   end if
   rs_orderbook.close

	'更新库存表
	rs_stock("a4total_money") = rs_stock("a4total_money") - (a2buy_price * diff_amount)

	rs_stock("a4stock") = stock - diff_amount
	rs_stock("a4diff") = diff - diff_amount
	rs_stock("a4cflag") = 1
	rs_stock("a4chgtime") = timestr
  rs_stock("a4chguser") = username
	'response.write stock
	'response.write ("<br>")
	'response.write diff
	'response.end
	rs_stock.update
	rs_stock.close

	'更新售货表
  '理论删除该修改的那条数据
	rs_sold("a2mflag") = 1
	rs_sold("a2chgtime") = timestr
	rs_sold("a2chguser") = username
	rs_sold.update

	'新增一条修改后的数据
	rs_sold.addnew
	rs_sold("a2gid") = a2gid
	rs_sold("a2name") = a2name
	rs_sold("a2code") = a2code
	rs_sold("a2brand") = a2brand
  '--------------------------------------------------------------------------------------
  '---------------------------070627买入价格的增加---------------------------------------
	rs_sold("a2buy_price") = a2buy_price
  '---------------------------070627买入价格的增加---------------------------------------
  '--------------------------------------------------------------------------------------
	rs_sold("a2sold_price") = a2sold_price
	rs_sold("a2amount") = amount
	rs_sold("a2oid") = a2oid
	rs_sold("a2flow") = a2flow
	rs_sold("a2status") = a2status
	rs_sold("a2mflag") = 0
	rs_sold("a2relation") = a2id
	rs_sold("a2crttime") = a2crttime
	rs_sold("a2crtuser") = a2crtuser
	rs_sold("a2chgtime") = timestr
	rs_sold("a2chguser") = username
	rs_sold.update
	rs_sold.close

	set conn = nothing

	if frompage = "adv" then
       response.redirect("admin_sell_select.asp")
	   response.end
	elseif left(frompage,3) = "oid" then
       response.redirect("admin_orderbook_particular.asp?"&frompage)
	   response.end
	else
       response.redirect("sell_select.asp")
       response.end
	end if
end if
%>