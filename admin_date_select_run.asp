<!KDZ Studio Powered at 20070625">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<%response.Expires = 0%>
<!--#include file="inc/conn.asp"-->
<%'����˵������ʱ���ѯ���
  '����DB����
  '����DB��buy��sell��return
  '�޸�����
  '�޸������ա������ߡ�����
  '2008/06/25  sky@kdz ����
  '2008/11/08  sky@kdz �޸� �޸��˻�����
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ������ʱ���ѯ���</TITLE>
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

dim starttime,endtime,sflag
    starttime = trim(request.form("startyear"))&trim(request.form("startmonth"))&trim(request.form("startday"))&"000000"
    endtime = trim(request.form("endyear"))&trim(request.form("endmonth"))&trim(request.form("endday"))&"250000"
    sflag = trim(request.form("sflag"))
	'response.write starttime & "<br>"
	'response.write endtime & "<br>"
	'response.write sflag
	'response.end

	'�����ѯ���ڼ�����Ϊ2����
	if ( left(trim(endtime),8) - left(trim(starttime),8) ) > 200 then
	    response.redirect("messagebox.asp?msg=��ѯ��������ڼ��Ϊ2�����ڡ�")
		response.end
	end if

	dim rs,sqltext,message_flag,col_no
	set rs=server.createobject("adodb.recordset")
	select case sflag
       case "buy"
	            message_flag = "�� ��"
				col_no = 8
			    sqltext = "select "
				sqltext = sqltext&"a1id,a1code,a1name,a1brand,a1amount,a1seat,a1crttime,a1crtuser " 
				sqltext = sqltext&"from buy where a1mflag = 0 and a1crttime >= "&starttime&" and a1crttime <= "&endtime&" order by a1crttime desc"
				rs.open sqltext,conn,1,1
				set a1id = rs("a1id")
				set a1code = rs("a1code")
				set a1name = rs("a1name")
				set a1brand = rs("a1brand")
				set a1amount = rs("a1amount")
				set a1seat = rs("a1seat")
				set a1crttime = rs("a1crttime")
				set a1crtuser = rs("a1crtuser")
       case "sell"
	            message_flag = "�� ��"
				col_no = 9
			    sqltext = "select "
				sqltext = sqltext&"a2id,a2code,a2name,a2brand,a2oid,a2sold_price,a2amount,a2crttime,a2crtuser " 
				sqltext = sqltext&"from sold where a2mflag = 0  and a2crttime >= "&starttime&" and a2crttime <= "&endtime&" order by a2crttime desc"
				rs.open sqltext,conn,1,1
				set a2id = rs("a2id")
				set a2oid = rs("a2oid")
				set a2code = rs("a2code")
				set a2name = rs("a2name")
				set a2brand = rs("a2brand")
				set a2sold_price = rs("a2sold_price")
				set a2amount = rs("a2amount")
				set a2crttime = rs("a2crttime")
				set a2crtuser = rs("a2crtuser")
       case "return"
	            message_flag = "�� ��"
				col_no = 10
			    sqltext = "select  "
				sqltext = sqltext&"a3id,a3code,a3name,a3brand,a3price,a3amount,a3oid,a3crttime,a3crtuser, " 
				sqltext = sqltext&"a3confirmtime,a3confirmuser,a3reason,a3status " 
				sqltext = sqltext&"from returned where a3mflag = 0 and a3crttime >= "&starttime&" and a3crttime <= "&endtime&" order by a3crttime desc"
				rs.open sqltext,conn,1,1
				set a3id = rs("a3id")
				set a3code = rs("a3code")
				set a3name = rs("a3name")
				set a3brand = rs("a3brand")
				set a3price = rs("a3price")
				set a3amount = rs("a3amount")
				set a3oid = rs("a3oid")
				set a3crttime = rs("a3crttime")
				set a3crtuser = rs("a3crtuser")
				set a3confirmtime = rs("a3confirmtime")
				set a3confirmuser = rs("a3confirmuser")
				set a3reason = rs("a3reason")
				set a3status = rs("a3status")
	end select
	'response.write sqltext
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
	        <tr height = "50"><td colspan="<%=col_no%>"></td></tr>
			    <tr height="20"><td colspan="<%=col_no%>" class="STYLE2" align="center"><b><%=message_flag%>&nbsp;�� ѯ �� ��</b>(��<%response.write(left(starttime,4)&"��"&mid(starttime,5,2)&"��"&mid(starttime,7,2)&"��")%>��<%response.write(left(endtime,4)&"��"&mid(endtime,5,2)&"��"&mid(endtime,7,2)&"��")%>)</td></tr>
			   <%
			     '--------------------��ʾ������ѯ�����ʼ--------------------
				 if sflag = "buy" then
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
			   <%   i = 0
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
				 end if
				 '--------------------��ʾ������ѯ�������--------------------
			   %>
			   <%
			     '--------------------��ʾ�ۻ���ѯ�����ʼ--------------------
				 if sflag = "sell" then
				 '�����ѯ����¼,����ʾ��ҳ����
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>������</td>
					   <td>������</td>
					   <td>��Ʒ����</td>
					   <td>Ʒ ��</td>
					   <td>�� ��</td>
					   <td>�� ��</td>
					   <td>¼��ʱ��</td>
					   <td>¼����</td>
					   <td align="center">����</td>
					</tr>
			   <%   i = 0
					do while not rs.eof
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a2oid%></td>
					   <td><%=a2code%></td>
					   <td><%=a2name%></td>
					   <td><%=a2brand%></td>
					   <td><%=a2sold_price%></td>
					   <td><%=a2amount%></td>
					   <td><%=kdztimeformat(a2crttime,"1")%></td>
					   <td><%=a2crtuser%></td>
					   <td align="center"><A HREF = "sell_modify.asp?a2id=<%=a2id%>">�޸�</A></td>
					</tr>
			   <%	rs.movenext
					loop
				 else
					response.redirect("messagebox.asp?msg=Ŀǰ��û���ۻ���¼")
					response.end
				 end if
				 end if
				 '--------------------��ʾ�ۻ���ѯ�������--------------------
			   %>
			   <%
			     '--------------------��ʾ�˻���ѯ�����ʼ--------------------
				 if sflag = "return" then
				 '�����ѯ����¼,����ʾ��ҳ����
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>��Ʒ����<br />/<br />������</td>
					   <td>Ʒ ��</td>
					   <td>������</td>
					   <td>�� ��</td>
					   <td>�� ��</td>
					   <td>����ʱ��<br />/<br />������</td>
					   <td>ȷ��ʱ��<br />/<br />ȷ����</td>
					   <td>�˻�ԭ��</td>
					   <td>״̬</td>
					   <td>����</td>
					</tr>
			   <%   dim i,color_td
					i = 0
					do while not rs.eof
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a3name%><br />/<br /><%=a3code%></td>
					   <td><%=a3brand%></td>
					   <td><%=a3oid%></td>
					   <td><%=a3price%></td>
					   <td><%=a3amount%></td>
					   <td><%=kdztimeformat(a3crttime,"1")%><br />/<br /><%=a3crtuser%></td>
					   <td><%=kdztimeformat(a3confirmtime,"1")%><br />/<br /><%=a3confirmuser%></td>
					   <td><%=a3reason%></td>
					   <td><%if int(a3status) = 1 then response.write ("������") else response.write ("��ȷ��") end if%></td>
					   <td>
					    <%if int(a3status) = 1 then%>
					        <A HREF = "return_modify.asp?a3id=<%=a3id%>"><font color="red">�޸�</font></A>
					    <%else%>
					        <A HREF = "return_delete_run.asp?a3id=<%=a3id%>" onclick="return confirm('ȷ��ɾ�����˻���¼��?')"><font color="blue">ɾ��</font></A>
					    <%end if%>
					   </td>
					</tr>
			   <%	rs.movenext
					loop
				 else
					response.redirect("messagebox.asp?msg=Ŀǰ��û���˻���¼")
					response.end
				 end if
				 end if
				 '--------------------��ʾ�˻���ѯ�������--------------------
			   %>
			   <%
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