<!KDZ Studio Powered at 20070821">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵������Ӳ�λִ��ҳ��
  '����DB��seat,seat_transfer
  '����DB����
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/08/21  cg@kdz ����
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>
<% 
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

'ȡϵͳʱ��Ϊ��ֵ
dim timestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

'��������
dim str_gid,str_new_seat,old_seat
str_gid = trim(request.form("str_gid"))
str_new_seat = trim(request.form("str_new_seat"))
old_seat = trim(request.form("old_seat"))

'response.write str_gid&"<br>"
'response.write str_new_seat&"<br>"
'response.write old_seat&"<br>"

'�������
dim temp_gid,temp_new_seat
temp_gid = Split(str_gid,",")
temp_new_seat = Split(str_new_seat,",")


'for i = 0 to UBound(temp_gid)
'   response.write temp_gid(i)&"<br>"
'   response.write temp_new_seat(i)&"<br>"
'next
'response.write old_seat

'response.end

dim rs_seat_transfer,sqltext_seat_transfer
set rs_seat_transfer=server.createobject("adodb.recordset")
    sqltext_seat_transfer = "select top 1 * from seat_transfer "
    'response.write sqltext_seat_transfer &"<br>"
	  'response.end
    rs_seat_transfer.open sqltext_seat_transfer,conn,1,2

dim rs_seat1,sqltext1
dim rs_seat2,sqltext2

for i = 0 to UBound(temp_gid)
  if trim(temp_gid(i)) <> "" then
	set rs_seat1=server.createobject("adodb.recordset")
        sqltext1 = "select * from seat "
        sqltext1 = sqltext1&"where a10gid = '"&trim(temp_gid(i))&"' and a10seat = '"&old_seat&"'"
        'response.write sqltext1 &"<br>"
	      'response.end
        rs_seat1.open sqltext1,conn,1,2

    if rs_seat1.eof then
	   rs_seat_transfer.close
	   rs_seat1.close
     response.redirect("messagebox.asp?msg=�˲�λ���Ѿ���Ǩ�ƹ��ˣ���ȷ�Ϻ��ڲ���")
     response.end
	  end if

	if trim(temp_new_seat(i)) <> old_seat then
      
	  '���²�λǨ�Ʊ�
      rs_seat_transfer.Addnew
      rs_seat_transfer("a13gid") = trim(temp_gid(i))
      rs_seat_transfer("a13code") = rs_seat1("a10code")
      rs_seat_transfer("a13name") = rs_seat1("a10name")
      rs_seat_transfer("a13old") = old_seat
      rs_seat_transfer("a13new") = trim(temp_new_seat(i))
      rs_seat_transfer("a13amount") = rs_seat1("a10amount")
      rs_seat_transfer("a13crttime") = int(timestr)
      rs_seat_transfer("a13crtuser") = username
	    rs_seat_transfer.update

      set rs_seat2=server.createobject("adodb.recordset")
          sqltext2 = "select * from seat "
          sqltext2 = sqltext2&"where a10gid = '"&trim(temp_gid(i))&"' and a10seat = '"&trim(temp_new_seat(i))&"'"
          'response.write sqltext2 &"<br>"
	        'response.end
          rs_seat2.open sqltext2,conn,1,2
      if not rs_seat2.eof then
	     rs_seat2("a10amount") = rs_seat2("a10amount") + rs_seat1("a10amount")
	     rs_seat2("a10chgtime") = int(timestr)
	     rs_seat2("a10chguser") = username
	     rs_seat2.update
		   rs_seat1.delete
       'response.write "ɾ��ԭ��λ"&"<br>"
	    else
	     rs_seat1("a10seat") = trim(temp_new_seat(i))
	     rs_seat1("a10chgtime") = int(timestr)
	     rs_seat1("a10chguser") = username
	     rs_seat1.update
       'response.write "ԭ��λ���³��²�λ"&"<br>"
	    end if
	  rs_seat2.close
   end if
   rs_seat1.close
 end if
next

	rs_seat_transfer.close

    'response.end
	response.redirect("seat_view.asp")
%>
