<!KDZ Studio Powered at 20070821">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：仓位一览页面
  '更新DB：
  '参照DB：seat
  '修改履历
  '修改年月日、责任者、内容
  '2007/08/21  cg@kdz 新增
  '2008/04/21  cg@kdz 修改
  '2008/08/21  cg@kdz 再次修改性能
%>
<HTML>
<HEAD>
<TITLE>进销存系统——仓位一览</TITLE>
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
			   font-family: verdana, arial, 宋体; 
			   height: 30px; 
			   background-color: #ddeeff"
			   }
-->
</style>
<script language="javascript"> 
function checkform(inform)
{
  if(confirm('确认要迁移这个仓位内的商品么？')) 
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
			   <tr height="20"><td colspan="3" class="STYLE2" align="center"><b><%=get_seat%> 仓 位 详 细 情 况</b></td></tr>
			   <%
				 dim rs
				 '在仓位表中查询所有的仓位
				 set rs=server.createobject("adodb.recordset")
				 sqltext = "select distinct a10seat from seat order by a10seat"
				 'response.write sqltext
				 'response.end
				 rs.open sqltext,conn,1,1

				 '080421CG修改查询性能
				 '080821CG再次修改查询性能
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
				   <td>商品名称</td>
				   <td>在此仓位中的存货数量</td>
				   <td>迁移至</td>
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
					<input type="submit" value="确 认 仓 位 迁 移" class="style_button">
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