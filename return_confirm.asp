<!KDZ Studio Powered at 20081108">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵�����˻�ȷ��ҳ��
  '����DB����
  '����DB��returned
  '�޸�����
  '�޸������ա������ߡ�����
  '2008/11/08  sky@kdz ���� �޸��˻�����
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ�����˻�ȷ��</TITLE>
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
  <tr>
    <td align="right">
       <%if power = "5" then%>
	     <!--#include file="inc/top_admin.inc"-->
	   <%else%>
         <!--#include file="inc/top.inc"-->
	   <%end if%>
	</td>
  </tr>
  <tr>
	<td align="center">
	<table width="760" cellpadding="0" cellspacing="0" style="BORDER-RIGHT:#FF0000 6px solid;BORDER-TOP:#FF0000 6px solid;BORDER-BOTTOM:#FF0000 6px solid;BORDER-LEFT:#FF0000 6px solid;">
	   <tr>
	     <td width="160" valign="top">
		   <!--#include file="inc/left_mini.inc"-->
		 </td>
		 <td width="590" valign="top">
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
	           <tr height = "50"><td colspan="9"></td></tr>
			   <tr height="20"><td colspan="10" class="STYLE2" align="center"><b>�� �� ȷ �� �� ¼ �� ѯ �� ��</b></td></tr>
			   <%
				 dim rs
				 '���˻����У���ѯ��������˻��ļ�¼���
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select  "
					 sqltext = sqltext&"a3id,a3code,a3name,a3brand,a3price,a3amount,a3oid,a3crttime,a3crtuser,a3reason " 
					 sqltext = sqltext&"from returned where a3mflag = 0 and a3status = 1 order by a3crttime desc"
					 rs.open sqltext,conn,1,1
				 '�����ѯ����¼,����ʾ��ҳ����
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>������</td>
					   <td>��Ʒ����</td>
					   <td>Ʒ ��</td>
					   <td>�� ��</td>
					   <td>�� ��</td>
					   <td>������</td>
					   <td>����ʱ��</td>
					   <td>������</td>
					   <td>ԭ��</td>
					   <td align="center">����</td>
					</tr>
			   <%   dim i,color_td
			        dim a3id,a3code,a3name,a3brand,a3price,a3amount,a3oid
					dim a3crttime,a3crtuser
					i = 0
					set a3id = rs("a3id")
					set a3code = rs("a3code")
					set a3name = rs("a3name")
					set a3brand = rs("a3brand")
					set a3price = rs("a3price")
					set a3amount = rs("a3amount")
					set a3oid = rs("a3oid")
					set a3crttime = rs("a3crttime")
					set a3crtuser = rs("a3crtuser")
					set a3reason = rs("a3reason")
					do while not rs.eof
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a3code%></td>
					   <td><%=a3name%></td>
					   <td><%=a3brand%></td>
					   <td><%=a3price%></td>
					   <td><%=a3amount%></td>
					   <td><%=a3oid%></td>
					   <td><%=kdztimeformat(a3crttime,"1")%></td>
					   <td><%=a3crtuser%></td>
					   <td><%=a3reason%></td>
					   <td align="center"><A HREF = "return_confirm_run.asp?a3id=<%=a3id%>" onclick="return confirm('ȷ�ϴ��˻�������?\r\n����ȷʵ�յ��˻���Ʒ��ִ�д˲���')">ȷ��</A></td>
					</tr>
			   <%	rs.movenext
					loop
				 else
					response.redirect("messagebox.asp?msg=Ŀǰ��û���˻���¼")
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