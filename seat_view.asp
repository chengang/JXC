<!KDZ Studio Powered at 20070820">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵������λһ��ҳ��
  '����DB����
  '����DB��seat
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/08/20  sky@kdz ����
  '2008/12/03  sky@kdz �޸� �������
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ������λһ��</TITLE>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #ffffff;
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
<!--��������check-->
<script language="javascript" src="inc/jstrim.js">
</script>
<script language="javascript">
	function incheck(inform){
	if (jstrim(inform.new_seat.value) == "")
	  {
				alert ("�������²�λ�����ƣ�");
				inform.new_seat.focus();
				return false;
	  }
	}
</script>
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
	           <tr height = "50"><td colspan="8"></td></tr>
			   <tr height="20"><td colspan="8" class="STYLE2" align="center"><b>�� λ �� �� һ ��</b></td></tr>
			   <%
				 dim rs,i,j
				 '�ڲ�λ���в�ѯ���еĲ�λ
				 set rs=server.createobject("adodb.recordset")
				 sqltext = "select distinct a10seat,sum(a10amount) as seat_amount,count(a10amount) as count_amount "
				 sqltext = sqltext&"from seat "
				 sqltext = sqltext&"group by a10seat order by a10seat"
				 'response.write sqltext
				 'response.end
				 rs.open sqltext,conn,1,1
				%>
				<tr bgcolor="#FF6633">
				   <td>��λ</td>
				   <td>����/����</td>
				   <td>��λ</td>
				   <td>����/����</td>
				   <td>��λ</td>
				   <td>����/����</td>
				   <td>��λ</td>
				   <td>����/����</td>
				</tr>
				<% while not rs.eof
				    i = 0
				%>
				<tr>
				<%
					while (not rs.eof and i < 4)
				%>
					<td bgcolor="#CCFFFF"><a href="seat_transfer.asp?a10seat=<%=rs("a10seat")%>"><%=rs("a10seat")%></a></td>
					<td><%=rs("seat_amount")%>/<%=rs("count_amount")%></td>
				<%
					rs.movenext
					i = i + 1
					wend
				%>
				</tr>
				<%  wend
				 rs.close
				 conn.close
				 set conn=nothing
				%>
				<tr>
					<td colspan="8" align="right">
				<div id="Layer1">
					<input type="button" value="�� �� �� λ" class="style_button" onclick="document.all.Layer1.style.visibility='hidden';document.all.Layer2.style.visibility='visible'">
				</div>
				<div id="Layer2" style="visibility:hidden;">
					<form id="form1" name="form1" method="post"  onsubmit = "return incheck(this)" action="seat_add_run.asp">
					<span class="style1">�²�λ������</span>&nbsp<input type="text" name="new_seat">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="submit" value="ȷ �� �� �� �� �� �� �� λ"  class="style_button">
					</form>
				</div></td>
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