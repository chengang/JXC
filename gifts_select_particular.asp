<!--KDZ Studio Powered at 20081228">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：赠品详细查询页面
  '更新DB：无
  '参照DB：sold
  '修改履历
  '修改年月日、责任者、内容
  '2008/12/28  sky@kdz 新增 赠品详细查询
%>
<HTML>
<HEAD>
<TITLE>进销存系统——赠品详细</TITLE>
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
dim username,power,uid,crtdate
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")
crtdate = trim(request.queryString("crtdate"))

%>
</head>

<BODY>
<table width="762" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr><td align="center"><img src="image\logo.gif"></td></tr>
  <tr>
    <td align="right">
     <%if power = "5" then%>
	     <!--#include file="inc/top_admin.inc"-->
	   <%else%>
         <!--#include file="inc/top.inc"-->
	   <%end if%></td>
  </tr>
  <tr>
	<td align="center">
	<table width="760" cellpadding="0" cellspacing="0" style="BORDER-RIGHT:#FF0000 6px solid;BORDER-TOP:#FF0000 6px solid;BORDER-BOTTOM:#FF0000 6px solid;BORDER-LEFT:#FF0000 6px solid;">
	   <tr>
	     <td width="160" valign="top"><!--#include file="inc/left_mini.inc"--></td>
		   <td width="590" valign="top">
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
	       <tr height = "50"><td colspan="9"></td></tr>
			   <tr height="20"><td colspan="9" class="STYLE2" align="center"><b>赠 品 明 细 查 询 结 果</b></td></tr>
			   <%
				 dim rs
				 '在售货表中，查询赠品纪录
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select "
					 sqltext = sqltext&"a2id,a2oid,a2code,a2name,a2brand,a2buy_price,a2amount,a2crttime,a2crtuser "
					 sqltext = sqltext&"from sold where a2mflag = 0 and a2sold_price = 0 and left(a2crttime,8) = '"&crtdate&"'"
					 rs.open sqltext,conn,1,1
				 '如果查询到记录,则显示在页面上
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>定单号</td>
					   <td>条形码</td>
					   <td>商品名称</td>
					   <td>品 牌</td>
					   <td>成 本</td>
					   <td>数 量</td>
					   <td>录入时间</td>
					   <td>录入者</td>
					   <td>详细</td>
					</tr>
			   <%   dim i,color_td
					set a2oid = rs("a2oid")
					set a2code = rs("a2code")
					set a2name = rs("a2name")
					set a2brand = rs("a2brand")
					set a2buy_price = rs("a2buy_price")
					set a2amount = rs("a2amount")
					set a2crttime = rs("a2crttime")
					set a2crtuser = rs("a2crtuser")
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
					   <td><%=a2oid%></td>
					   <td><%=a2code%></td>
					   <td><%=a2name%></td>
					   <td><%=a2brand%></td>
					   <td><%=a2buy_price%></td>
					   <td><%=a2amount%></td>
					   <td><%=kdztimeformat(a2crttime,"1")%></td>
					   <td><%=a2crtuser%></td>
					   <td align="center"><A HREF = "admin_orderbook_particular.asp?oid=<%=a2oid%>">查看</A></td>
					</tr>
			   <%	rs.movenext
					loop
				 else
					response.redirect("messagebox.asp?msg=出错了，请联系管理员")
					response.end
				 end if
				 '关闭连接，释放进程
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
  <tr><td align="center"><img src="image\logo_mini.gif"></td>
  </tr>
</table>
</BODY>
</HTML>
