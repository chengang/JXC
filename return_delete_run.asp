<!KDZ Studio Powered at 20081109">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：删除退货页面
  '         1、更新库存表
  '         2、删除退货表中记录
  '更新DB：
  '参照DB：stock、returned
  '修改履历
  '修改年月日、责任者、内容
  '2008/11/09  sky@kdz 新增 修改退货流程
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim id,frompage
id = trim(request.queryString("a3id"))
frompage = trim(request.queryString("frompage"))

'取系统时间为数值
dim timestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

'根据自动编号查询退货表
dim rs_returned1,a3gid,a3buy_price,a3amount
set rs_returned1=server.createobject("adodb.recordset")
    sqltext1 = "select * " 
    sqltext1 = sqltext1&"from returned where a3mflag = 0 and a3status <> 1 and a3id ="&id
    rs_returned1.open sqltext1,conn,1,2

if rs_returned1.eof then
   response.redirect("messagebox.asp?msg=请不要用浏览器上的后退按钮反复修改，重新查询后再删除")
   response.end
else

	a3gid = rs_returned1("a3gid")
	a3buy_price = rs_returned1("a3buy_price")
	a3amount = rs_returned1("a3amount")

  '更新库存表
	dim rs_stock,stock
	set rs_stock=server.createobject("adodb.recordset")
	sqltext4="select * from stock where a4gid='"&a3gid&"'"
	rs_stock.open sqltext4,conn,1,2

	dim temp_stock,temp_diff
	temp_stock = rs_stock("a4stock") - a3amount
	temp_diff = rs_stock("a4diff")  - a3amount

	rs_stock("a4stock") = temp_stock
	rs_stock("a4total_money") = rs_stock("a4total_money") - (a3buy_price *  a3amount)
	rs_stock("a4diff") = temp_diff
	rs_stock("a4cflag") = 1
	rs_stock("a4chgtime") = timestr
	rs_stock("a4chguser") = username
	rs_stock.update
	rs_stock.close

   '更新退货表
   '理论删除被修改的那条数据
   rs_returned1("a3mflag") = 2
	 rs_returned1("a3chgtime") = timestr
	 rs_returned1("a3chguser") = username
   rs_returned1.update

	 rs_returned1.close
	 set conn = nothing

	if frompage = "adv" then
       response.redirect("admin_return_select.asp")
	   response.end
	else
       response.redirect("return_select.asp")
       response.end
	end if
end if
%>
