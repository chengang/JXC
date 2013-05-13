<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：1、密码到期时，修改密码的处理页
  '          2、检索user表中用户名密码为传来的值的条目，若为空则报错
  '             若有记录则更新为新的密码。
  '更新DB：user_sql,history_login
  '参照DB：user_sql
  '处理页：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/06/02  cg@kdz  新增
  '2007/12/29  cg@kdz  修改 增加登入记录安全功能
  '2008/01/05  sky@kdz 修改 修改表结构history_login(删除等入浏览器字段)
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<HTML>
<HEAD>
<TITLE>进销存系统——密码过期</TITLE>
<meta http-equiv="refresh" content="10;url=index.asp">
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

.style_button {border-right: #62b0ff 1px solid; 
               padding-right: 1px; 
			   border-top: #bfdfff 1px solid; 
			   padding-left: 1px; 
			   font-size: 12px; 
			   padding-bottom: 1px; 
			   border-left: #bfdfff 1px solid; 
			   color: #085878; 
			   padding-top: 1px; 
			   border-bottom: #62b0ff 1px solid; 
			   font-family: verdana, arial, 宋体; 
			   height: 30px; 
			   background-color: #ddeeff"
			   }
-->
</style>
<%
dim username,power,uid,a5pwd_new,timestr
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")
a5pwd_new = trim(request.form("a5pwd_new"))
timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

'response.write uid
'response.write ("<br>")
'response.write a5pwd_old
'response.end

'检索user表中用户名为传来的值的条目
set rs_a5user = server.createobject("adodb.recordset")
sqltext = "select * from user_sql where a5uid='"&uid&"'"
rs_a5user.open sqltext,conn,1,2
'若为空则报错
if rs_a5user.eof then
  rs_a5user.close
	response.redirect("messagebox.asp?msg=旧密码输入不正确")
	response.end
else
'若有记录则更新为新的密码
  username_temp = rs_a5user("a5name")
  power_temp = rs_a5user("a5power")
  rs_a5user("a5pwd") = a5pwd_new
	rs_a5user("a5chgtime") = timestr
	rs_a5user("a5chguser") = username_temp
	rs_a5user.update
	rs_a5user.close


'--------------------记录登陆历史开始-----------------------
dim loginip,loginsystemver,loginbrowerver

'得到用户的登入IP
loginip = Request.ServerVariables("REMOTE_ADDR")
'response.write loginip&"<br>"

 agent  = Request.ServerVariables("HTTP_USER_AGENT")

'插入登入历史表中
dim rs_history_login,sqltext_history_login
dim a15logintime,a15loginip,a15loginnum
set rs_history_login = server.createobject("adodb.recordset")
sqltext_history_login = "select top 1 * "
sqltext_history_login = sqltext_history_login&"from history_login "
sqltext_history_login = sqltext_history_login&"where a15uid='"&uid&"' order by a15id desc"
rs_history_login.open sqltext_history_login,conn,1,2

'response.write sqltext_history_login&"<br>"

if not rs_history_login.eof then
	a15loginnum = rs_history_login("a15loginnum")
    
	rs_history_login.addnew
	rs_history_login("a15uid") = uid
	rs_history_login("a15name") = username_temp
	rs_history_login("a15power") = power_temp
	rs_history_login("a15logintime") = timestr
	rs_history_login("a15loginip") = loginip
	rs_history_login("a15loginsystemver") = agent
	rs_history_login("a15loginnum") = a15loginnum + 1
	rs_history_login("a15work") = 2
	rs_history_login.update
else

	rs_history_login.addnew
	rs_history_login("a15uid") = uid
	rs_history_login("a15name") = username_temp
	rs_history_login("a15power") = power_temp
	rs_history_login("a15logintime") = timestr
	rs_history_login("a15loginip") = loginip
	rs_history_login("a15loginsystemver") = agent
	rs_history_login("a15loginnum") = 1
	rs_history_login("a15work") = 2
	rs_history_login.update
end if
rs_history_login.close
'--------------------记录登陆历史开始-----------------------
%>
</head>
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
		 <td width="380" valign="top">
		    <br>
		    <table align="center">
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					 保持每隔一段时间修改一下密码的安全习惯。
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2" align="center" bgcolor="#CCCCCC" width="350">
					<form id="form1" name="form1" method="post" action="">
					   <tr valign="center">
						 <td height="160" align="center">
						 <b>您的密码修改成功</b>
						 </td>
					   </tr>
					   <tr>
						 <td height="120" align="center">
						 <a href="index.asp">10秒后将自动返回登陆页面</a>
						 </td>
					   </tr>
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
<%end if%>
