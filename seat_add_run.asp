<!KDZ Studio Powered at 20070820">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵������Ӳ�λִ��ҳ��
  '����DB��seat
  '����DB����
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/08/20  sky@kdz ����
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>
<% 
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

'��������
dim new_seat
new_seat = trim(request.form("new_seat"))
'response.write new_seat
'response.write ("<br>")
'response.end

'ȡϵͳʱ��Ϊ��ֵ
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
	'�ڲ�λ��������һ����λ
	rs_seat.addnew
	rs_seat("a10seat") = new_seat
	rs_seat("a10amount") = 0
	rs_seat("a10crttime") = int(timestr)
	rs_seat("a10crtuser") = username
	rs_seat("a10chgtime") = int(timestr)
	rs_seat("a10chguser") = username
	rs_seat.update
	rs_seat.close

    '�ڲ�λǨ�Ʊ��в���������λ
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
    response.redirect("messagebox.asp?msg=�˲�λ�Ѿ����ڣ���ȷ�Ϻ�����Ӳ�λ")
    response.end
	set conn = nothing
end if
	response.redirect("seat_view.asp")
%>