<!KDZ Studio Powered at 20070713">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：品牌仓位信息查询
  '更新DB：无
  '参照DB：seat，sell
  '修改履历
  '修改年月日、责任者、内容
  '2007/07/13  sky@kdz 新增 查询所有的仓位信息
%>
<HTML>
<HEAD>
<TITLE>进销存系统——品牌仓位信息查询</TITLE>
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
	           <tr height = "50"><td colspan="2"></td></tr>
			   <tr height="20"><td colspan="3" class="STYLE2" align="center"><b>仓 位 记 录 查 询 结 果</b></td></tr>
			   <%
				 dim rs,i
				 '在库存表中查询商品品牌，在仓位表中查询该品牌的所有仓位
				 set rs=server.createobject("adodb.recordset")
				 sqltext = "select "
				 sqltext = sqltext&"A.a4brand brand,A.a4gid gid,B.a10seat seat " 
				 sqltext = sqltext&"from stock A, "
				 sqltext = sqltext&"seat B "
				 sqltext = sqltext&"where A.a4gid = B.a10gid order by A.a4brand,B.a10seat desc"
				 rs.open sqltext,conn,1,1
					while not rs.eof
						rs.moveprevious
							temp_brand = rs("brand")
							temp_seat = rs("seat")
						rs.movenext
						if Ucase(trim(temp_brand)) <> Ucase(trim(rs("brand"))) then
							i = i + 1
							ouput_seat = ""
						 set rs2=server.createobject("adodb.recordset")
						 sqltext2 = "select distinct a10seat from seat join stock on stock.a4brand='"&rs("brand")&"' and a4gid = a10gid"
						 rs2.open sqltext2,conn,1,1
							while not rs2.eof
								dim ouput_seat
								ouput_seat = ouput_seat &"."&rs2("a10seat")
							rs2.movenext
							wend
							rs2.close
				%>
				<tr>
					<td><%=i%></td>
					<td><%=Ucase(rs("brand"))%></td>
					<td><%=ouput_seat%>
					</td>
				</tr>
				<%	
					end if
					rs.movenext
					wend
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