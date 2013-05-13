<!KDZ Studio Powered at 20071214">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：单一商品所有订单页面
  '更新DB：无
  '参照DB：sold
  '修改履历
  '修改年月日、责任者、内容
  '2007/12/14  sky@kdz 新增 删除单件商品功能增加
  '2008/11/16  sky@kdz 修改 显示时间样式修改
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<HTML>
<HEAD>
<TITLE>进销存系统——单件商品所有订单</TITLE>
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
			   font-family: verdana, arial, 宋体; 
			   height: 30px; 
			   background-color: #ddeeff"
			   }
-->
</style>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid = kdzcookie("uid")

dim gid
gid = trim(request.queryString("gid"))
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
	           <tr height = "50"><td colspan="7"></td></tr>
			   <tr height="20"><td colspan="7" class="STYLE2" align="center"><b>单 件 商 品 所 有 订 单</b></td></tr>
			   <%
				 dim rs,sqltext
				 '在售货表中查询商品的所有订单
         set rs= server.createobject("adodb.recordset")
             sqltext = "select * from sold "
             sqltext = sqltext&"where a2gid='"&gid&"' and a2mflag = 0 "
             sqltext = sqltext&"order by a2chgtime desc"
             'response.write sqltext
             'response.end
             rs.open sqltext,conn,1,1

				 '如果查询到记录,则显示在页面上
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>条形码</td>
					   <td>商品名称</td>
					   <td>订单号</td>
					   <td>流水单号</td>
					   <td>录入时间</td>
					   <td>录入者</td>
					   <td align="center">详细</td>
					</tr>
			   <%   dim i,color_td
					i = 0
					set a2code = rs("a2code")
					set a2name = rs("a2name")
					set a2oid = rs("a2oid")
					set a2flow = rs("a2flow")
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
					   <td><%=a2code%></td>
					   <td><%=a2name%></td>
					   <td><%=a2oid%></td>
					   <td><%=a2flow%></td>
					   <td><%=kdztimeformat(a2crttime,"1")%></td>
					   <td><%=a2crtuser%></td>
					   <td align="center"><A HREF = "admin_orderbook_particular.asp?oid=<%=a2oid%>">查看</a></td>
					</tr>
			   <%	rs.movenext
					loop
			   %>
			   <%
			     else
					response.redirect("messagebox.asp?msg=没有此商品的订单")
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
	   <%end if
	     rs_buy.close
	     rs_sold.close
		 set conn = nothing
	   %>
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
