<!--#include file="inc/function.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵������ѯ�������û��������Ƿ���ȷ
  '����DB��history_login
  '����DB��user_sql,history_login
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/15  cg@kdz  ����
  '2007/12/29  cg@kdz  �޸� ���ӵ����¼��ȫ����
  '2008/01/05  sky@kdz �޸� �޸ı�ṹhistory_login(ɾ������������ֶ�)
  '2008/08/02  sky@kdz �޸� SQL��ע��
%>
<%

'ȡϵͳ����,ʱ��Ϊ��ֵ
dim timestr,a5uid,a5pwd,rs_user,sqltext,a5chgtime
timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
timestr2 = left(timestr,4)&"-"&mid(timestr,5,2)&"-"&mid(timestr,7,2)
'��index.htm���û��ύ���û�������
a5uid = trim(request.form("a5uid"))
a5pwd = trim(request.form("a5pwd"))
keeptime = trim(request.form("keeptime"))
a5uid = replace(a5uid,"""" , "")
a5uid = replace(a5uid,"'" , "")
a5uid = replace(a5uid,"," , "")
a5uid = replace(a5uid,"\" , "")
a5uid = replace(a5uid,"/" , "")
a5uid = replace(a5uid,"-" , "")
a5uid = replace(a5uid,"%" , "")
a5uid = replace(a5uid,"?" , "")
a5uid = replace(a5uid,"|" , "")
a5uid = replace(a5uid,"+" , "")
a5uid = replace(a5uid,"=" , "")
a5uid = replace(a5uid,"&" , "")
a5uid = replace(a5uid,"(" , "")
a5uid = replace(a5uid,")" , "")
a5uid = replace(a5uid," " , "")
a5uid = replace(a5uid,"or" , "")
a5uid = replace(a5uid,"and" , "")

a5pwd = replace(a5pwd,"""" , "")
a5pwd = replace(a5pwd,"'" , "")
a5pwd = replace(a5pwd,"," , "")
a5pwd = replace(a5pwd,"\" , "")
a5pwd = replace(a5pwd,"/" , "")
a5pwd = replace(a5pwd,"-" , "")
a5pwd = replace(a5pwd,"%" , "")
a5pwd = replace(a5pwd,"?" , "")
a5pwd = replace(a5pwd,"|" , "")
a5pwd = replace(a5pwd,"+" , "")
a5pwd = replace(a5pwd,"=" , "")
a5pwd = replace(a5pwd,"&" , "")
a5pwd = replace(a5pwd,"(" , "")
a5pwd = replace(a5pwd,")" , "")
a5pwd = replace(a5pwd," " , "")
a5pwd = replace(a5pwd,"or" , "")
a5pwd = replace(a5pwd,"and" , "")

'��use�����ѯ�Ƿ���ȷ
set rs_user = server.createobject("adodb.recordset")
sqltext = "select * from user_sql where a5uid='"&a5uid&"' and a5pwd='"&a5pwd&"'"
rs_user.open sqltext,conn,1,1
a5chgtime = left(rs_user("a5chgtime"),4)&"-"&mid(rs_user("a5chgtime"),5,2)&"-"&mid(rs_user("a5chgtime"),7,2)
'response.write rs_user("a5deadline")
'response.write ("<br>")
'response.write datediff("d",cdate(a5chgtime),cdate(timestr2))
'response.end

'����ȷ�򱨴�
if rs_user.eof then
 rs_user.close
 response.redirect("messagebox.asp?msg=������û���������")
elseif int(datediff("d",cdate(a5chgtime),cdate(timestr2))) > int(rs_user("a5deadline")) then
 response.cookies("uid") = rs_user("a5uid")
 rs_user.close
 response.redirect("index.asp?seediv=1")
 response.end
else
'��ȷ�����3��cookieֵ��ת������ҳ��
 response.cookies("power") = rs_user("a5power")
 response.cookies("tdl_name") = rs_user("a5name")
 response.cookies("uid") = rs_user("a5uid")
 if keeptime <> 0 and keeptime<>"" then
	response.cookies("power").expires = dateadd("d", keeptime, now())
	response.cookies("tdl_name").expires = dateadd("d", keeptime, now())
	response.cookies("uid").expires = dateadd("d", keeptime, now())
 end if
 
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
sqltext_history_login = sqltext_history_login&"where a15uid='"&rs_user("a5uid")&"' order by a15id desc"
rs_history_login.open sqltext_history_login,conn,1,2

'response.write sqltext_history_login&"<br>"
'response.end

if not rs_history_login.eof then
	a15loginnum = rs_history_login("a15loginnum")
    
	rs_history_login.addnew
	rs_history_login("a15uid") = rs_user("a5uid")
	rs_history_login("a15name") = rs_user("a5name")
	rs_history_login("a15power") = rs_user("a5power")
	rs_history_login("a15logintime") = timestr
	rs_history_login("a15loginip") = loginip
	rs_history_login("a15loginsystemver") = agent
	rs_history_login("a15loginnum") = a15loginnum + 1
	rs_history_login("a15work") = 1
	rs_history_login.update
else

	rs_history_login.addnew
	rs_history_login("a15uid") = rs_user("a5uid")
	rs_history_login("a15name") = rs_user("a5name")
	rs_history_login("a15power") = rs_user("a5power")
	rs_history_login("a15logintime") = timestr
	rs_history_login("a15loginip") = loginip
	rs_history_login("a15loginsystemver") = agent
	rs_history_login("a15loginnum") = 1
	rs_history_login("a15work") = 1
	rs_history_login.update
end if
rs_history_login.close
'--------------------��¼��½��ʷ��ʼ-----------------------

 rs_user.close
 response.redirect("sell.asp")
 response.end
 'server.transer ("buy.asp")
end if
%>