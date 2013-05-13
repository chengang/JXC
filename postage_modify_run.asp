<!KDZ Studio Powered at 20070525">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：邮费编辑执行页面
  '更新DB：无
  '参照DB：stock
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/26  sky@kdz 新增
  '2007/07/21  sky@kdz 修改 重复修改邮费bug的修改
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim id,postage,frompage
id = trim(request.form("a8id"))
postage = trim(request.form("a8postage"))
frompage = trim(request.form("frompage"))

'response.write frompage
'response.end

'取系统时间为数值
dim timestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

dim rs,a8date,a8crttime,a8crtuser
set rs=server.createobject("adodb.recordset")
    sqltext = "select * " 
    sqltext = sqltext&"from postage where a8mflag = 0 and a8id ="&id
    'response.write sqltext
    rs.open sqltext,conn,1,2

if rs.eof then
   response.redirect("messagebox.asp?msg=请不要用浏览器上的后退按钮反复修改，重新查询后再修改")
   response.end
else
  a8date = rs("a8date")
	a8crttime = rs("a8crttime")
	a8crtuser = rs("a8crtuser")

	rs("a8mflag") = 1
	rs("a8chgtime") = timestr
  rs("a8chguser") = username
	rs.update

	rs.addnew
	rs("a8date") = a8date
	rs("a8postage") = postage
	rs("a8mflag") = 0
	rs("a8relation") = id
	rs("a8crttime") = a8crttime
	rs("a8crtuser") = a8crtuser
	rs("a8chgtime") = timestr
	rs("a8chguser") = username
	rs.update
	rs.close
	set conn = nothing

	if frompage = "adv" then
     response.redirect("admin_postage_select.asp")
	   response.end
	else
     response.redirect("postage_select.asp")
     response.end
	end if
end if
%>
