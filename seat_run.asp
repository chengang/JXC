<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵�����������ִ��ҳ
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/18  cg@kdz  ����
  '2007/09/04  sky@kdz �޸� ԭ��λ��ȷ����ͬ��λ��ɵ����������޸�
  '2007/12/30  cg@kdz  �޸� ���ӵ����¼��ȫ���� ����conn
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ������λ����</TITLE>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #FFFFFF;
	}
.style1 {font-size:9pt}
.style2 {font-size:10.5pt}
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
</head>
<%
  '��������
dim a10code,a10seat,a10amount,rs_a10seat,rs_a4stock,sqltext,sum_amount
a10gid = request.form("a10gid")
a10seat_temp = request.form("a10seat")
a10amount_temp = request.form("a10amount")

dim timestr
timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

 'response.write a10gid
 'response.write ("<br>")
 'response.write a10seat
 'response.write ("<br>")
 'response.write sum_a10amount

 '�������
 seat = Split(a10seat_temp,",")
 amount = Split(a10amount_temp,",")

 '�ж���Ʒ�����Ƿ�Ϊ��ֵ��
 for i = 0 to UBound(amount)
	if not IsNumeric(amount(i)) then
	response.redirect("messagebox.asp?msg=�����������Ϊ���֣�����������")
	response.end
	end if
 next

 '���ܹ��ı������
 for i = 0 to UBound(amount)
	sum_amount = sum_amount+int(amount(i))
 next

	set rs_a4stock = server.createobject("adodb.recordset")
	sqltext = "select a4gid,a4code,a4stock,a4diff,a4cflag,a4chgtime,a4chguser from stock where a4gid='"&a10gid&"'"
	rs_a4stock.open sqltext,conn,1,2

	'response.write sqltext
	'response.write rs_a4stock("a4cflag")
	'response.write sum_amount
	'response.write ("<br>")
	'response.write rs_a4stock("a4stock")
	'response.write ("<br>")
	'response.write rs_a4stock("a4diff")
	'response.write ("<br>")
	'response.end

	'response.write rs_a4stock("a4cflag")
	'response.write UBound(amount)
  'response.end

	if (rs_a4stock("a4cflag") <> 1 and UBound(amount) = 0) then 
	  response.redirect("messagebox.asp?msg=����Ʒ��λ������ȷ����������")
	  response.end
	end if
	

	if sum_amount <> rs_a4stock("a4stock") then 
	  response.redirect("messagebox.asp?msg=���������ʵ�����������������ȷ�Ϻ���������")
	  response.end
	end if

	'response.write rs_a4stock("a4cflag")

    if rs_a4stock("a4cflag") = 1 then 
	   rs_a4stock("a4diff") = 0
	   rs_a4stock("a4cflag") = 0
	   rs_a4stock("a4stock") = sum_amount
	   rs_a4stock("a4chgtime") = timestr
	   rs_a4stock("a4chguser") = username
	   rs_a4stock.update
	   rs_a4stock.close
	end if

	set rs_a10seat = server.createobject("adodb.recordset")
	sqltext = "select a10name,a10seat,a10code,a10amount,a10chgtime,a10chguser from seat where a10gid='"&a10gid&"' order by a10id"
	rs_a10seat.open sqltext,conn,1,2
	rs_a10seat.movefirst
	i = 0

	while not rs_a10seat.eof
		if rs_a10seat("a10amount") <> amount(i) then
			rs_a10seat("a10amount") = amount(i)
			rs_a10seat("a10chgtime") = timestr
			rs_a10seat("a10chguser") = username
			rs_a10seat.update
		end if
			i = i + 1
		rs_a10seat.movenext
	wend
	    rs_a10seat.movefirst
%>
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
	     <td width="160" valign="top">
		    <!--#include file="inc\left_mini.inc"-->
		 </td>
		 <td width="580" valign="top">
		    <table width="580">
			  <tr>
			    <td align="center">
				 <!--��߿� ��ʼ-->
				 <!--onpropertychange="submit1()"-->
				 <table class="STYLE1" bgcolor="#CCCCCC" width="570">
				   <tr>
				    <td align="left" valign="top">
					   <br>
					  &nbsp;&nbsp;������:<%=rs_a10seat("a10code")%><br><br>
					  &nbsp;&nbsp;��Ʒ����:<%=rs_a10seat("a10name")%><br><br>
					  &nbsp;&nbsp;��ʵ״̬:<%response.write("����")%><br><br>
					  &nbsp;&nbsp;�������:0<br><br><br>
					  &nbsp;&nbsp;���������:<%=rs_a10seat("a10chguser")%><br><br>
					  &nbsp;&nbsp;�������ʱ��:<%=kdztimeformat(rs_a10seat("a10chgtime"),"1")%><br><br><br><br><br>
					</td>
				<!--��߿� ����-->
				    <td width="20"></td>
				<!--�ұ߿� ����-->
					<td valign="top">
					 <fieldset>
					   <table class="STYLE1">
					    <tr>
						 <td align="center" width="150">��λ����</td>
						 <td align="center" width="150">�ִ������</td>
						</tr>
					   </table>
					 </fieldset><br>
					 <fieldset>
					   <table class="STYLE1">
					    <%
						while not rs_a10seat.eof
						%>
					    <tr>
						 <td width="150" align="center"><%=rs_a10seat("a10seat")%></td>
						 <td width="150" align="center"><%=rs_a10seat("a10amount")%></td>
						</tr>
						<%rs_a10seat.movenext
						  wend
						  rs_a10seat.close%>
				<!--�ұ߿� ����-->
					   </table>
					 </fieldset>
					</td>
				   </tr>
				 </table>
				 <!--��߿� ����-->
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
