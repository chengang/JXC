<!KDZ Studio Powered at 20081109">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵����ɾ���˻�ҳ��
  '         1�����¿���
  '         2��ɾ���˻����м�¼
  '����DB��
  '����DB��stock��returned
  '�޸�����
  '�޸������ա������ߡ�����
  '2008/11/09  sky@kdz ���� �޸��˻�����
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim id,frompage
id = trim(request.queryString("a3id"))
frompage = trim(request.queryString("frompage"))

'ȡϵͳʱ��Ϊ��ֵ
dim timestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

'�����Զ���Ų�ѯ�˻���
dim rs_returned1,a3gid,a3buy_price,a3amount
set rs_returned1=server.createobject("adodb.recordset")
    sqltext1 = "select * " 
    sqltext1 = sqltext1&"from returned where a3mflag = 0 and a3status <> 1 and a3id ="&id
    rs_returned1.open sqltext1,conn,1,2

if rs_returned1.eof then
   response.redirect("messagebox.asp?msg=�벻Ҫ��������ϵĺ��˰�ť�����޸ģ����²�ѯ����ɾ��")
   response.end
else

	a3gid = rs_returned1("a3gid")
	a3buy_price = rs_returned1("a3buy_price")
	a3amount = rs_returned1("a3amount")

  '���¿���
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

   '�����˻���
   '����ɾ�����޸ĵ���������
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
