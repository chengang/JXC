<!KDZ Studio Powered at 20070110">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵�����ʷѲ�ѯҳ��
  '����DB��postage
  '����DB����
  '�޸�����
  '�޸������ա������ߡ�����
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ�����ʷѲ�ѯ</TITLE>
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
	           <tr height = "50"><td colspan="7"></td></tr>
			   <tr height="20"><td colspan="7" class="STYLE2" align="center"><b>�� �� ʮ �� �� �� �� ¼ �� ѯ �� ��</b></td></tr>
			   <%
				 dim rs
				 '���ʷѱ��У���ѯ���10���ʷѵļ�¼���
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select top 10 * "
					 sqltext = sqltext&"from postage where a8mflag = 0 order by a8crttime desc"
					 'response.write sqltext
					 'response.end
					 rs.open sqltext,conn,1,1
				 '�����ѯ����¼,����ʾ��ҳ����
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>�ʷ�����</td>
					   <td>�ʷѽ��</td>
					   <td>¼��ʱ��</td>
					   <td>¼����</td>
					   <td>�޸�ʱ��</td>
					   <td>�޸���</td>
					   <td align="center">����</td>
					</tr>
			   <%   dim i,color_td
					i = 0
					dim a8id,a8date,a8postage,a8crttime
			        dim a8crtuser,a8chgtime,a8chguser

					set a8id = rs("a8id")
					set a8date = rs("a8date")
					set a8postage = rs("a8postage")
					set a8crttime = rs("a8crttime")
					set a8crtuser = rs("a8crtuser")
					set a8chgtime = rs("a8chgtime")
					set a8chguser = rs("a8chguser")

					do while not (rs.eof or i = 10)
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a8date%></td>
					   <td><%=a8postage%></td>
					   <td><%=kdztimeformat(a8crttime,"1")%></td>
					   <td><%=a8crtuser%></td>
					   <td><%=kdztimeformat(a8chgtime,"1")%></td>
					   <td><%=a8chguser%></td>
					   <td align="center"><A HREF = "postage_modify.asp?a8id=<%=a8id%>">�޸�</A></td>
					</tr>
			   <%	rs.movenext
					loop
				 else
					response.redirect("messagebox.asp?msg=Ŀǰ��û���ʷѼ�¼")
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