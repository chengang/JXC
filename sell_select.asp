<!KDZ Studio Powered at 20070110">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵�����ۻ���ѯҳ��
  '����DB����
  '����DB��sold
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/06/02  sky@kdz �޸� �Ӳ�ѯ���10��������¼
  '                         �޸�Ϊֻ��ѯ����Ľ�����¼
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ�����ۻ���ѯ</TITLE>
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
			   height: 28px; 
			   background-color: #ddeeff"
			   }
-->
</style>
<script language="javascript">
function openhere()
{
window.open("TodaySell_Excel.asp", "_self");
}
</script>

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
	           <tr height = "50"><td colspan="9"></td></tr>
			   <tr height="20"><td colspan="9" class="STYLE2" align="right"><b>�� �� �� �� �� ¼ �� ѯ �� ��</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="button1" class="style_button" onclick="openhere()" value="����EXCEL" class="style_button"></td></tr>
			   <%
				 dim rs
				 '���ۻ����У���ѯ������ۻ���¼���
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select "
					 sqltext = sqltext&"a2id,a2code,a2name,a2brand,a2oid,a2sold_price,a2amount,a2crttime,a2crtuser " 
					 sqltext = sqltext&"from sold where a2mflag = 0  and left(a2crttime,8) = "&datestr&" order by a2crttime desc"
					 rs.open sqltext,conn,1,1
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
			   <%   dim i,color_td
					i = 0
					set a2id = rs("a2id")
					set a2oid = rs("a2oid")
					set a2code = rs("a2code")
					set a2name = rs("a2name")
					set a2brand = rs("a2brand")
					set a2sold_price = rs("a2sold_price")
					set a2amount = rs("a2amount")
					set a2crttime = rs("a2crttime")
					set a2crtuser = rs("a2crtuser")
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