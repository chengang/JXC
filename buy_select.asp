<!KDZ Studio Powered at 20070110">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵����������ѯҳ��
  '����DB����
  '����DB��buy
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/06/02  sky@kdz �޸� �Ӳ�ѯ���10��������¼
  '                         �޸�Ϊֻ��ѯ����Ľ�����¼
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ����������ѯ</TITLE>
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
-->
</style>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

'ȡϵͳʱ��Ϊ��ֵ
dim timestr,datestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
	datestr = left(timestr,8)
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
	     <td width="160" valign="top">
		   <!--#include file="inc/left_mini.inc"-->
		 </td>
		 <td width="590" valign="top">
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
	           <tr height = "50"><td colspan="8"></td></tr>
			   <tr height="20"><td colspan="8" class="STYLE2" align="center"><b>�� �� �� �� �� ¼ �� ѯ �� ��</b></td></tr>
			   <%
				 dim rs
				 '�ڽ������У���ѯ����Ľ�����¼���
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select "
					 sqltext = sqltext&"a1id,a1code,a1name,a1brand,a1amount,a1seat,a1crttime,a1crtuser " 
					 sqltext = sqltext&"from buy where a1mflag = 0 and left(a1crttime,8) = "&datestr&" order by a1crttime desc"
					 rs.open sqltext,conn,1,1
				 '�����ѯ����¼,����ʾ��ҳ����
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>������</td>
					   <td>��Ʒ����</td>
					   <td>Ʒ ��</td>
					   <td>�� ��</td>
					   <td>�� λ</td>
					   <td>¼��ʱ��</td>
					   <td>¼����</td>
					   <td align="center">����</td>
					</tr>
			   <%   dim i,color_td
					i = 0
					set a1id = rs("a1id")
					set a1code = rs("a1code")
					set a1name = rs("a1name")
					set a1brand = rs("a1brand")
					set a1amount = rs("a1amount")
					set a1seat = rs("a1seat")
					set a1crttime = rs("a1crttime")
					set a1crtuser = rs("a1crtuser")
					do while not rs.eof
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a1code%></td>
					   <td><%=a1name%></td>
					   <td><%=a1brand%></td>
					   <td><%=a1amount%></td>
					   <td><%=a1seat%></td>
					   <td><%=kdztimeformat(a1crttime,"1")%></td>
					   <td><%=a1crtuser%></td>
					   <td align="center"><A HREF = "buy_modify.asp?a1id=<%=a1id%>">�޸�</A></td>
					</tr>
			   <%	rs.movenext
					loop
				 else
					response.redirect("messagebox.asp?msg=Ŀǰ��û�н�����¼")
					response.end
				 end if
				 '�ر����ӣ��ͷŽ���
				 rs.close
				 conn.close
				 set conn=nothing
			   %>
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