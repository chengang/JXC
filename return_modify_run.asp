<!KDZ Studio Powered at 20070602">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵�����˻��༭ִ��ҳ��
  '         1����ѯ�ۻ�����˻����ж��˻����������ܴ�����������
  '         2���ж��˻������Ĳ��ܳ������
  '         2�����¿���
  '         3�������˻���
  '����DB��returned��stock
  '����DB��stock��returned
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/06/03  sky@kdz ����
  '2007/07/21  sky@kdz �޸� �ظ��޸��˻�bug���޸�
  '2007/10/29  sky@kdz �޸� ��һ������ʾ����������޸�
  '2008/01/02  sky@kdz �޸� �˻����������۸��ֶα��Ϊ����ɱ�
  '2008/11/08  sky@kdz �޸� �޸��˻�����
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim id,amount,frompage
id = trim(request.form("a3id"))
amount = trim(request.form("a3amount"))
frompage = trim(request.form("frompage"))
'response.write id
'response.write ("<br>")
'response.write frompage
'response.end

'ȡϵͳʱ��Ϊ��ֵ
dim timestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

'�����Զ���Ų�ѯ�˻���
dim rs_returned1,a3id,a3gid,a3name,a3code,a3brand,a3buy_price
dim a3price,a3amount,a3oid,a3crttime,a3crtuser
set rs_returned1=server.createobject("adodb.recordset")
    sqltext1 = "select * " 
    sqltext1 = sqltext1&"from returned where a3mflag = 0 and a3status = 1 and a3id ="&id
    'response.write sqltext1
	  'response.end
    rs_returned1.open sqltext1,conn,1,2

if rs_returned1.eof then
   response.redirect("messagebox.asp?msg=�벻Ҫ��������ϵĺ��˰�ť�����޸ģ����²�ѯ�����޸�")
   response.end
else

  a3id = rs_returned1("a3id")
	a3gid = rs_returned1("a3gid")
	a3name = rs_returned1("a3name")
	a3code = rs_returned1("a3code")
	a3brand = rs_returned1("a3brand")
	a3buy_price = rs_returned1("a3buy_price")
	a3price = rs_returned1("a3price")
	a3amount = rs_returned1("a3amount")
	a3oid = rs_returned1("a3oid")
	a3crttime = rs_returned1("a3crttime")
	a3crtuser = rs_returned1("a3crtuser")
	a3reason = rs_returned1("a3reason")
	a3status = rs_returned1("a3status")

  '���ݶ����ź�gid��ѯ�ۻ�����˻���
	'�ж��˻������Ƿ�С���ۻ�����
	'��ѯ�ۻ�����
  dim rs_sold,sell_amount,buy_price
  set rs_sold=server.createobject("adodb.recordset")
	sqltext2="select * from sold where  a2mflag = 0 and a2gid='"&a3gid&"' and a2oid ='"&a3oid&"'"
	rs_sold.open sqltext2,conn,1,1

	sell_amount = rs_sold("a2amount")
	buy_price = rs_sold("a2buy_price")

	re_sold.close

	'��ѯ�˻�����
	dim rs_returned2,returned_amount,total_amount
	set rs_returned2=server.createobject("adodb.recordset")
	    sqltext3="select * from returned where a3mflag = 0 and a3gid='"&a3gid&"' and a3oid ='"&a3oid&"'"
	    rs_returned2.open sqltext3,conn,1,2

      '�����˻������ϼ�
		  '�Ѿ��˻������ĺϼ�
		  returned_amount = 0

        if not rs_returned2.eof then
           do while not rs_returned2.eof
			     returned_amount = returned_amount + rs_returned2("a3amount")
			     rs_returned2.movenext
			     loop
	      end if
        
		'�����˻������ϼ�
		total_amount = 0
    total_amount = returned_amount - a3amount + amount

    rs_returnned2.close

    if sell_amount - total_amount < 0 then
       rs_returned1.close
	     set conn = nothing
	     response.redirect("messagebox.asp?msg=�˻����������ۻ�����,��ȷ�Ϻ����˻�")
	     response.end
	  end if

  '�жϿ��������Ƿ�����˻������Ĳ��
	dim rs_stock,stock
	set rs_stock=server.createobject("adodb.recordset")
	sqltext4="select * from stock where a4gid='"&a3gid&"'"
	rs_stock.open sqltext4,conn,1,2

  stock = rs_stock("a4stock")

	if stock - a3amount + amount < 0 then
     rs_returned1.close
	   set conn = nothing
	   response.redirect("messagebox.asp?msg=�����������,��ȷ�Ϻ����˻�")
	   response.end
	end if

  '=====================�˻������޸ĺ�,�ȴ�ȷ�Ϻ��ٸ��¿��=====================
  ''���¿���
	'dim temp_stock,temp_diff
	'temp_stock = rs_stock("a4stock") - a3amount + amount
	'temp_diff = rs_stock("a4diff")  - a3amount + amount
	'
	'rs_stock("a4stock") = temp_stock
	'rs_stock("a4total_money") = rs_stock("a4total_money") + (buy_price * (amount - a3amount))
	'rs_stock("a4diff") = temp_diff
	'rs_stock("a4cflag") = 1
	'rs_stock("a4chgtime") = timestr
	'rs_stock("a4chguser") = username
	'rs_stock.update
  '=====================�˻������޸ĺ�,�ȴ�ȷ�Ϻ��ٸ��¿��=====================
  
  '�����˻���
  '����ɾ�����޸ĵ���������
  rs_returned1("a3mflag") = 1
	rs_returned1("a3chgtime") = timestr
	rs_returned1("a3chguser") = username
  rs_returned1.update

  '����һ���޸ĺ������
	rs_returned1.addnew
	rs_returned1("a3gid") = a3gid
	rs_returned1("a3name") = a3name
	rs_returned1("a3code") = a3code
	rs_returned1("a3brand") = a3brand
	rs_returned1("a3buy_price") = a3buy_price
	'�˻��۸�
	rs_returned1("a3price") = a3price
	rs_returned1("a3amount") = amount
	rs_returned1("a3oid") = a3oid
	rs_returned1("a3mflag") = 0
	rs_returned1("a3relation") = a3id
	rs_returned1("a3crttime") = a3crttime
	rs_returned1("a3crtuser") = a3crtuser
	rs_returned1("a3chgtime") = timestr
	rs_returned1("a3chguser") = username
	rs_returned1("a3reason") = a3reason
	rs_returned1("a3status") = a3status
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
