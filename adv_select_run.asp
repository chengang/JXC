<!KDZ Studio Powered at 20070110">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<%response.Expires = 0%>
<!--#include file="inc/conn.asp"-->
<%'����˵������Ʒ��ѯִ��ҳ��
  '         1�����ݴ�adv_select.asp���ܵ�ֵ
  '            ʵ��ģ����ѯ
  '         2��������ܵ���ȫ��Ϊ��������MessageBox.asp
  '����DB����
  '����DB��stock
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/22  sky@kdz ����
  '2007/07/19  sky@kdz �޸� ����ǿ���޸Ŀ����޸�
  '2007/07/22  sky@kdz �޸� ��Ʒ��ѯʱ��λ����ʾ
  '2007/07/27  sky@kdz �޸� ��Ʒ��ѯ���������
  '2007/11/12  sky@kdz �޸� ��Ʒ��ѯ��������м������ٴβ�ѯ
  '2008/01/13  sky@kdz �޸� ��ʾ��Ʒ��ע��Ϣ
%>

<HTML>
<HEAD>
<TITLE>������ϵͳ������Ʒ��ѯ���</TITLE>
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

'��form��ȡֵ
dim name,brand,code

if (request.queryString("a4name") = "" and request.queryString("a4brand") = "" and request.queryString("a4code") = "") then
   name = trim(request.form("a4name"))
   brand = trim(request.form("a4brand"))
   code = trim(request.form("a4code"))
else
   name = request.queryString("a4name")
   brand = request.queryString("a4brand")
   code = request.queryString("a4code")
end if

'response.write name &"<br>"
'response.write brand &"<br>"
'response.write code
'response.end

'��ȡ�����ֶ���
if request.queryString("orderby") = "" then
   index_word = "a4crttime"
else
   index_word = request.queryString("orderby")
end if

'��ȡ����˳��
que = int(request.queryString("que"))
if que="" then
   que = 0
else
   que = que + 1
end if
if que mod 2 = 0 then
  sequence = "desc"
else
  sequence = "asc"
end if

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
		     <form id="form1" name="form1" method="post" action="adv_select_run.asp">
		     <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" valign="bottom">
			   <tr>
			     <td colspan="7" class="STYLE2" align="center"><b>�� �� �� ѯ</b>
				 </td>
			   </tr>
			   <tr>
			     <td>������<input type="text" name="a4code"  style="width:110;">
				 </td>
			     <td>��Ʒ����<input type="text" name="a4name" style="width:110;">
				 </td>
			     <td>Ʒ��<input type="text" name="a4brand"  style="width:110;">
				 </td>
			     <td><input type="submit" name="Submit" value="��ѯ" style="width:60;">
				 </td>
			   </tr>
			 </table>
			 </form>
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
			   <tr height="20"><td colspan="9" class="STYLE2" align="center"><b>�� ѯ �� ��</b></td></tr>
			   <%
				 set rs=server.createobject("adodb.recordset")
                 if (name = "" and brand = "" and code = "") then
				    response.redirect("messagebox.asp?msg=����������һ����ѯ����")
	                response.end
			     else
				    sqltext = "select * from stock "
					sqltext = sqltext&"where a4code like '%"&code&"%' and a4name like '%"&name&"%' and a4brand like '%"&brand&"%' order by "&index_word&" "&sequence
				 end if
                 rs.open sqltext,conn,1,1
				 '�����ѯ����¼,����ʾ��ҳ����
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4code&que=<%=que%>">������</a></td>
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4name&que=<%=que%>">��Ʒ����</a></td>
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4brand&que=<%=que%>">Ʒ ��</a></td>
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4stock&que=<%=que%>">�� ��</a></td>
					   <td>�� λ</td>
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4price_common&que=<%=que%>">��ͨ�۸�</a></td>
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4price_vip&que=<%=que%>">VIP�۸�</a></td>
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4price_wholesale&que=<%=que%>">�����۸�</a></td>
					   <td align="center">����</td>
					</tr>
			   <%   dim a4code,a4name,a4brand,a4stock,a4id
			        dim a4price_common,a4price_vip,a4price_wholesale
					dim a4remark
			        dim i,color_td
					i = 0
					set a4id = rs("a4id")
					set a4code = rs("a4code")
					set a4name = rs("a4name")
					set a4brand = rs("a4brand")
					set a4stock = rs("a4stock")
					set a4price_common = rs("a4price_common")
					set a4price_vip = rs("a4price_vip")
					set a4price_wholesale = rs("a4price_wholesale")
					set a4remark = rs("a4remark")
					do while not rs.eof
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a4code%></td>
					   <td><%=a4name%></td>
					   <td><%=a4brand%></td>
					   <td><%=a4stock%></td>
					   <td>
					      <%
						    dim rs_seat,sqltext_seat
							set rs_seat=server.createobject("adodb.recordset")
							    sqltext_seat = "select * from seat "
					            sqltext_seat = sqltext_seat&"where a10amount <> 0 and a10gid ='"&rs("a4gid")&"'"
							rs_seat.open sqltext_seat,conn,1,1
							
							'response.write sqltext_seat
							'response.end

							if rs_seat.eof then
							   response.write ("��")
							else
							   dim temp_seat
							       temp_seat = ""
							   while not rs_seat.eof
							      temp_seat = temp_seat&"��"&rs_seat("a10seat")
								  rs_seat.movenext
							   wend
							   response.write(mid(temp_seat,2,len(temp_seat)-1))
							end if
							rs_seat.close
						  %>
					   </td>
					   <td><%=a4price_common%></td>
					   <td><%=a4price_vip%></td>
					   <td><%=a4price_wholesale%></td>
					   <td align="center"><A HREF = "stock_modify.asp?a4id=<%=a4id%>">�޸�</A></td>
					<%
					 '��ʾ��Ʒ��ע��Ϣ
					 if not isnull(rs("a4remark")) then
					 response.write ("</tr>")
					 response.write ("<tr height=25 bgcolor="&color_td&">")
					 response.write ("<td colspan=3 class=STYLE1 align=left>&nbsp;</td>")
					 response.write ("<td colspan=6 class=STYLE1 align=left><i>��ע:"&rs("a4remark")&"</i></td>")
					 end if
					%>
					</tr>
			   <%	rs.movenext
					loop
				 else
					response.redirect("messagebox.asp?msg=û��¼��������ѯ��������Ʒ")
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