<!KDZ Studio Powered at 20070820">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：添加仓位执行页面
  '更新DB：seat
  '参照DB：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/08/20  sky@kdz 新增
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<% 
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

'接受数据
dim new_seat
new_seat = trim(request.form("new_seat"))
'response.write new_seat
'response.write ("<br>")
'response.end

'取系统时间为数值
dim timestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

dim rs_seat
set rs_seat=server.createobject("adodb.recordset")
    sqltext = "select * from seat "
    sqltext = sqltext&"where a10seat = '"&new_seat&"'"
    'response.write sqltext
	'response.end
    rs_seat.open sqltext,conn,1,2

if rs_seat.eof then
	'在仓位表中新增一个仓位
	rs_seat.addnew
	rs_seat("a10seat") = new_seat
	rs_seat("a10amount") = 0
	rs_seat("a10crttime") = int(timestr)
	rs_seat("a10crtuser") = username
	rs_seat("a10chgtime") = int(timestr)
	rs_seat("a10chguser") = username
	rs_seat.update
	rs_seat.close

    '在仓位迁移表中插入新增仓位
    dim rs_seat_transfer
       set rs_seat_transfer=server.createobject("adodb.recordset")
       sqltext_seat_transfer = "select * from seat_transfer "
       response.write sqltext
	     'response.end
       rs_seat_transfer.open sqltext_seat_transfer,conn,1,2

	   rs_seat_transfer.addnew
	   rs_seat_transfer("a13new") = new_seat
	   rs_seat_transfer("a13amount") = 0
	   rs_seat_transfer("a13crttime") = int(timestr)
	   rs_seat_transfer("a13crtuser") = username
	   rs_seat_transfer.update
	   rs_seat_transfer.close

else
    rs_seat.close
    response.redirect("messagebox.asp?msg=此仓位已经存在，请确认后再添加仓位")
    response.end
	set conn = nothing
end if
	response.redirect("seat_view.asp")
%>