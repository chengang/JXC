<!KDZ Studio Powered at 20070821">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵������λһ��ҳ��
  '����DB��
  '����DB��seat
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/08/21  cg@kdz ����
  '2008/04/21  cg@kdz �޸�
  '2008/08/21  cg@kdz �ٴ��޸�����
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
<script language="javascript"> 
function checkform(inform)
{
  if(confirm('ȷ��ҪǨ�������λ�ڵ���Ʒô��')) 
  {return   true;}
    else 
  {return   false;}
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
	           <tr height = "50"><td colspan="3"></td></tr>
			   <%dim get_seat
				 get_seat = trim(request.queryString("a10seat"))%>
			   <tr height="20"><td colspan="3" class="STYLE2" align="center"><b><%=get_seat%> �� λ �� ϸ �� ��</b></td></tr>
			   <%
				 dim rs
				 '�ڲ�λ���в�ѯ���еĲ�λ
				 set rs=server.createobject("adodb.recordset")
				 sqltext = "select distinct a10seat from seat order by a10seat"
				 'response.write sqltext
				 'response.end
				 rs.open sqltext,conn,1,1

				 '080421CG�޸Ĳ�ѯ����
				 '080821CG�ٴ��޸Ĳ�ѯ����
				 allselectstr = "<select name=str_new_seat>"
				 while not rs.eof
							if rs("a10seat") = get_seat then
								allselectstr = allselectstr & "<option value=" & rs("a10seat") & " selected=selected>" & rs("a10seat") & "</option>"
							else
								allselectstr = allselectstr & "<option value=" & rs("a10seat") & ">" & rs("a10seat") & "</option>"
							end if
				 rs.movenext
				 wend
				 allselectstr = allselectstr & "</select>"
				 rs.close

				 set rsa10seat=server.createobject("adodb.recordset")
				 sqltext = "select a10name,a10amount,a10gid "
				 sqltext = sqltext&"from seat where a10seat ='"&get_seat&"' order by a10name"
				 'response.write sqltext
				 'response.end
				 rsa10seat.open sqltext,conn,1,1
				%>
				<tr bgcolor="#FF6633">
				   <td>��Ʒ����</td>
				   <td>�ڴ˲�λ�еĴ������</td>
				   <td>Ǩ����</td>
				</tr>
				<form method="post" action="seat_transfer_run.asp" onsubmit="return checkform(this)">
				<input name="old_seat" type="hidden" value="<%=get_seat%>">
				<%
				    dim seat_total
					    seat_total = 0
					while not rsa10seat.eof
					seat_total = seat_total + rsa10seat("a10amount")
				%>
				<tr>
					<td><%=rsa10seat("a10name")%></td>
					<td><%=rsa10seat("a10amount")%></td>
				    <input name="str_gid" type="hidden" value="<%=rsa10seat("a10gid")%>">
					<td>
				 		<%=allselectstr%>
					</td>
				</tr>
				<%  
				 rsa10seat.movenext
				 wend
				 if seat_total <> 0 then
				%>
				<tr>
					<td colspan="8" align="right">
					<input type="submit" value="ȷ �� �� λ Ǩ ��" class="style_button">
					</td>
				</tr>
				<%
				 end if 
				 rsa10seat.close
				 conn.close
				 set conn=nothing
				 %>
				</form>
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