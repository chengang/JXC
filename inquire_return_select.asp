<!KDZ Studio Powered at 20070702">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵������ͨ�û��˻���ѯҳ��
  '����DB����
  '����DB��returned
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/07/02  sky@kdz ����
  '2008/11/08  sky@kdz �޸� �޸��˻�����
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ����ȫ���˻���ѯ</TITLE>
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

'ȷ����ʲô����
dim frompage
frompage = "adv"
'ȡϵͳʱ��Ϊ��ֵ
dim timestr,datestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
	datestr = left(timestr,8)

'��ȡ�����ֶ���
dim ipage,index_word,que,sequence

'��ȡҳ��
ipage = request.queryString("pagen")
'��ȡ�����ֶ���
if request.queryString("orderby") = "" then
   index_word = "a3crttime"
else
   index_word = request.queryString("orderby")
end if

'��ȡ����˳��
que = int(request.queryString("que"))
if que="" then
   que = 0
end if
if que mod 2 = 0 then
  sequence = "desc"
else
  sequence = "asc"
end if
'response.write index_word&" "&que
'response.end
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
			   <tr height="20"><td colspan="8" class="STYLE2" align="center"><b>ȫ �� �� �� �� ¼ �� ѯ �� ��</b></td></tr>
			   <%
				 dim rs
				 '���˻����У���ѯȫ���˻��ļ�¼���
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select  "
					 sqltext = sqltext&"a3id,a3code,a3name,a3brand,a3price,a3amount,a3oid,a3crttime,a3crtuser " 
					 sqltext = sqltext&"from returned where a3mflag = 0 and a3status <> 1 order by "&index_word&" "&sequence
					 rs.open sqltext,conn,1,1
					 rs.pagesize = 20
					 pagec = rs.pagecount
					 rs.absolutepage = ipage
					 'dim recordc
					 'recordc = rs.recordcount
					 'response.write recordc
					 'response.write pagec
					 'response.end
				 '�����ѯ����¼,����ʾ��ҳ����
				 if not rs.eof Then
			   %>
					<tr>
					  <td colspan="8" align="right">
					     <input name="orderby" type="hidden" value="<%=index_word%>">
					     <input name="que" type="hidden" value="<%=que%>">
					     ��<%=pagec%>ҳ&nbsp;&nbsp;&nbsp;��
						 <%
							if ipage = "" then
							que = que + 1
							end if
						%>
					     <select name="pagen" style="width:45px;font-size:9pt;" onChange="window.location.href('inquire_return_select.asp?pagen='+pagen.value+'&orderby='+orderby.value+'&que='+que.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>ҳ
					  </td>
					</tr>
					<tr height="20" bgcolor="#FF6633">
					   <td><a href = "admin_return_select.asp?orderby=a3code&que=<%=que%>">������</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3name&que=<%=que%>">��Ʒ����</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3brand&que=<%=que%>">Ʒ ��</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3price&que=<%=que%>">�� ��</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3amount&que=<%=que%>">�� ��</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3oid&que=<%=que%>">������</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3crttime&que=<%=que%>">¼��ʱ��</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3crtuser&que=<%=que%>">¼����</a></td>
					   <!--<td align="center">����</td>-->
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
					do while ((not rs.eof) and i < rs.pagesize)
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
					   <!--<td align="center"><A HREF = "return_modify.asp?a3id=<%=a3id%>&frompage=<%=frompage%>">�޸�</A></td>-->
					</tr>
			   <%	rs.movenext
					loop
				%>
					<tr>
					  <td colspan="8" align="right">��<%=pagec%>ҳ&nbsp;&nbsp;&nbsp;��
					     <select name="pagen2" style="width:45px;font-size:9pt;" onChange="window.location.href('inquire_return_select.asp?pagen='+pagen2.value+'&orderby='+orderby.value+'&que='+que.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>ҳ
					  </td>
					</tr>
				<%else
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