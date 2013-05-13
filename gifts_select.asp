<!--KDZ Studio Powered at 20081228">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：赠品查询页面
  '更新DB：无
  '参照DB：sold
  '修改履历
  '修改年月日、责任者、内容
  '2008/12/28  sky@kdz 新增 赠品查询
%>
<HTML>
<HEAD>
<TITLE>进销存系统——赠品查询</TITLE>
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

'拿取排序字段名
dim ipage

'拿取页码
ipage = request.queryString("pagen")
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
	       <tr height = "50"><td colspan="4"></td></tr>
			   <tr height="20"><td colspan="4" class="STYLE2" align="center"><b>赠 品 查 询 结 果</b></td></tr>
			   <%
				 dim rs
				 '在售货表中，查询赠品纪录
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select left(a2crttime,8) crtdate,sum(a2amount) total_amount,sum(a2buy_price*a2amount) total_money " 
					 sqltext = sqltext&"from sold where a2mflag = 0 and a2sold_price = 0 group by left(a2crttime,8) order by crtdate desc "
					 rs.open sqltext,conn,1,1
                     rs.pagesize = 20
                     pagec = rs.pagecount
                     rs.absolutepage = ipage
				 '如果查询到记录,则显示在页面上
				 if not rs.eof Then
			   %>
	               <tr>
					  <td colspan="4" align="right">
					     共<%=pagec%>页&nbsp;&nbsp;&nbsp;第
						   <%if ipage = "" then que = que + 1 end if%>
					     <select name="pagen" style="width:45px;font-size:9pt;" onChange="window.location.href('gifts_select.asp?pagen='+pagen.value)" >
						   <%for i = 1 to pagec%>
							 <option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						   <%next%>
						   </select>页
					  </td>
					</tr>
					<tr height="20" bgcolor="#FF6633">
					   <td>日期</td>
					   <td>赠品数量</td>
					   <td>赠品成本</td>
					   <td align="center">查看详细</td>
					</tr>
			   <%   dim i,color_td
					i = 0
					set crtdate = rs("crtdate")
					set total_amount = rs("total_amount")
					set total_money = rs("total_money")
					do while ( ( not rs.eof )  and i < rs.pagesize )
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=crtdate%></td>
					   <td><%=total_amount%></td>
					   <td><%=round(total_money,2)%></td>
					   <td align="center"><A HREF = "gifts_select_particular.asp?crtdate=<%=crtdate%>">查看</A></td>
					</tr>
			   <%
                    rs.movenext
					loop
         %>
					<tr>
					  <td colspan="4" align="right">共<%=pagec%>页&nbsp;&nbsp;&nbsp;第
					   <select name="pagen2" style="width:45px;font-size:9pt;" onChange="window.location.href('gifts_select.asp?pagen='+pagen2.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>页
					  </td>
					</tr>
         <%
				 else
					response.redirect("messagebox.asp?msg=目前还没有送礼记录")
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
