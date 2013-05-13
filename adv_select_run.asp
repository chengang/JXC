<!KDZ Studio Powered at 20070110">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<%response.Expires = 0%>
<!--#include file="inc/conn.asp"-->
<%'机能说明：商品查询执行页面
  '         1、根据从adv_select.asp接受的值
  '            实现模糊查询
  '         2、如果接受到的全部为空则跳到MessageBox.asp
  '更新DB：无
  '参照DB：stock
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/22  sky@kdz 新增
  '2007/07/19  sky@kdz 修改 允许强制修改库存的修改
  '2007/07/22  sky@kdz 修改 商品查询时仓位的显示
  '2007/07/27  sky@kdz 修改 商品查询排序的增加
  '2007/11/12  sky@kdz 修改 商品查询结果画面中加入能再次查询
  '2008/01/13  sky@kdz 修改 显示商品备注信息
%>

<HTML>
<HEAD>
<TITLE>进销存系统——商品查询结果</TITLE>
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

'从form中取值
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

'拿取排序字段名
if request.queryString("orderby") = "" then
   index_word = "a4crttime"
else
   index_word = request.queryString("orderby")
end if

'拿取排序顺序
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
<!---------------------------070610陈钢制作上方导航-------------------------------------->
  <tr>
    <td align="right">
       <%if power = "5" then%>
	     <!--#include file="inc/top_admin.inc"-->
	   <%else%>
         <!--#include file="inc/top.inc"-->
	   <%end if%>
	</td>
  </tr>
<!---------------------------070610陈钢制作上方导航-------------------------------------->
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
			     <td colspan="7" class="STYLE2" align="center"><b>继 续 查 询</b>
				 </td>
			   </tr>
			   <tr>
			     <td>条形码<input type="text" name="a4code"  style="width:110;">
				 </td>
			     <td>商品名称<input type="text" name="a4name" style="width:110;">
				 </td>
			     <td>品牌<input type="text" name="a4brand"  style="width:110;">
				 </td>
			     <td><input type="submit" name="Submit" value="查询" style="width:60;">
				 </td>
			   </tr>
			 </table>
			 </form>
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
			   <tr height="20"><td colspan="9" class="STYLE2" align="center"><b>查 询 结 果</b></td></tr>
			   <%
				 set rs=server.createobject("adodb.recordset")
                 if (name = "" and brand = "" and code = "") then
				    response.redirect("messagebox.asp?msg=请至少输入一个查询条件")
	                response.end
			     else
				    sqltext = "select * from stock "
					sqltext = sqltext&"where a4code like '%"&code&"%' and a4name like '%"&name&"%' and a4brand like '%"&brand&"%' order by "&index_word&" "&sequence
				 end if
                 rs.open sqltext,conn,1,1
				 '如果查询到记录,则显示在页面上
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4code&que=<%=que%>">条形码</a></td>
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4name&que=<%=que%>">商品名称</a></td>
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4brand&que=<%=que%>">品 牌</a></td>
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4stock&que=<%=que%>">库 存</a></td>
					   <td>仓 位</td>
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4price_common&que=<%=que%>">普通价格</a></td>
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4price_vip&que=<%=que%>">VIP价格</a></td>
					   <td><a href = "adv_select_run.asp?a4code=<%=code%>&a4name=<%=name%>&a4brand=<%=brand%>&orderby=a4price_wholesale&que=<%=que%>">批销价格</a></td>
					   <td align="center">操作</td>
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
							   response.write ("无")
							else
							   dim temp_seat
							       temp_seat = ""
							   while not rs_seat.eof
							      temp_seat = temp_seat&"、"&rs_seat("a10seat")
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
					   <td align="center"><A HREF = "stock_modify.asp?a4id=<%=a4id%>">修改</A></td>
					<%
					 '显示商品备注信息
					 if not isnull(rs("a4remark")) then
					 response.write ("</tr>")
					 response.write ("<tr height=25 bgcolor="&color_td&">")
					 response.write ("<td colspan=3 class=STYLE1 align=left>&nbsp;</td>")
					 response.write ("<td colspan=6 class=STYLE1 align=left><i>备注:"&rs("a4remark")&"</i></td>")
					 end if
					%>
					</tr>
			   <%	rs.movenext
					loop
				 else
					response.redirect("messagebox.asp?msg=没有录入过满足查询条件的商品")
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
  <tr>
    <td align="center">
	  <img src="image\logo_mini.gif">
    </td>
  </tr>
</table>
</BODY>
</HTML>