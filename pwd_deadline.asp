<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵����1�����뵽��ʱ���޸�����Ĵ���ҳ
  '          2������user�����û�������Ϊ������ֵ����Ŀ����Ϊ���򱨴�
  '             ���м�¼�����Ϊ�µ����롣
  '����DB��user_sql,history_login
  '����DB��user_sql
  '����ҳ����
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/06/02  cg@kdz  ����
  '2007/12/29  cg@kdz  �޸� ���ӵ����¼��ȫ����
  '2008/01/05  sky@kdz �޸� �޸ı�ṹhistory_login(ɾ������������ֶ�)
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ�����������</TITLE>
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
			   font-family: verdana, arial, ����; 
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

'����user�����û���Ϊ������ֵ����Ŀ
set rs_a5user = server.createobject("adodb.recordset")
sqltext = "select * from user_sql where a5uid='"&uid&"'"
rs_a5user.open sqltext,conn,1,2
'��Ϊ���򱨴�
if rs_a5user.eof then
  rs_a5user.close
	response.redirect("messagebox.asp?msg=���������벻��ȷ")
	response.end
else
'���м�¼�����Ϊ�µ�����
  username_temp = rs_a5user("a5name")
  power_temp = rs_a5user("a5power")
  rs_a5user("a5pwd") = a5pwd_new
	rs_a5user("a5chgtime") = timestr
	rs_a5user("a5chguser") = username_temp
	rs_a5user.update
	rs_a5user.close


'--------------------��¼��½��ʷ��ʼ-----------------------
dim loginip,loginsystemver,loginbrowerver

'�õ��û��ĵ���IP
loginip = Request.ServerVariables("REMOTE_ADDR")
'response.write loginip&"<br>"

 agent  = Request.ServerVariables("HTTP_USER_AGENT")

'���������ʷ����
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
'--------------------��¼��½��ʷ��ʼ-----------------------
%>
</head>
<BODY>
<table width="762" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td align="center"><img src="image\logo.gif"></td>
  </tr>
<!--------------------------------------------------------------------------------------->
<!---------------------------070610�¸������Ϸ�����-------------------------------------->
  <tr>
    <td align="right">
     <%if power = "5" then%>
	     <!--#include file="inc/top_admin.inc"-->
	   <%else%>
         <!--#include file="inc/top.inc"-->
	   <%end if%>
	</td>
  </tr>
<!---------------------------070610�¸������Ϸ�����-------------------------------------->
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
					 ����ÿ��һ��ʱ���޸�һ������İ�ȫϰ�ߡ�
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2" align="center" bgcolor="#CCCCCC" width="350">
					<form id="form1" name="form1" method="post" action="">
					   <tr valign="center">
						 <td height="160" align="center">
						 <b>���������޸ĳɹ�</b>
						 </td>
					   </tr>
					   <tr>
						 <td height="120" align="center">
						 <a href="index.asp">10����Զ����ص�½ҳ��</a>
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
