<!KDZ Studio Powered at 20070110">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：退货查询页面
  '更新DB：无
  '参照DB：returned
  '修改履历
  '修改年月日、责任者、内容
  '2007/06/03  sky@kdz 修改 从查询最近10条退货记录
  '                         修改为只查询今天的退货记录
  '2008/11/08  sky@kdz 修改 修改退货流程
  '2008/11/16  sky@kdz 修改 显示时间样式修改
%>
<HTML>
<HEAD>
<TITLE>进销存系统——退货查询</TITLE>
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

'取系统时间为数值
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
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
	           <tr height = "50"><td colspan="9"></td></tr>
			   <tr height="20"><td colspan="10" class="STYLE2" align="center"><b>今 天 退 货 记 录 查 询 结 果</b></td></tr>
			   <%
				 dim rs
				 '在退货表中，查询最近今天退货的纪录情况
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select  "
					 sqltext = sqltext&"a3id,a3code,a3name,a3brand,a3price,a3amount,a3oid,a3crttime,a3crtuser, " 
					 sqltext = sqltext&"a3confirmtime,a3confirmuser,a3reason,a3status " 
					 sqltext = sqltext&"from returned where a3mflag = 0 and left(a3crttime,8) = "&datestr&" order by a3crttime desc"
					 rs.open sqltext,conn,1,1
				 '如果查询到记录,则显示在页面上
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>商品名称<br />/<br />条形码</td>
					   <td>品 牌</td>
					   <td>定单号</td>
					   <td>单 价</td>
					   <td>数 量</td>
					   <td>申请时间<br />/<br />申请者</td>
					   <td>确认时间<br />/<br />确认者</td>
					   <td>退货原因</td>
					   <td>状态</td>
					   <td>操作</td>
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
					set a3confirmtime = rs("a3confirmtime")
					set a3confirmuser = rs("a3confirmuser")
					set a3reason = rs("a3reason")
					set a3status = rs("a3status")
					do while not rs.eof
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a3name%><br />/<br /><%=a3code%></td>
					   <td><%=a3brand%></td>
					   <td><%=a3oid%></td>
					   <td><%=a3price%></td>
					   <td><%=a3amount%></td>
					   <td><%=kdztimeformat(a3crttime,"1")%><br />/<br /><%=a3crtuser%></td>
					   <td><%=kdztimeformat(a3confirmtime,"1")%><br />/<br /><%=a3confirmuser%></td>
					   <td><%=a3reason%></td>
					   <td><%if int(a3status) = 1 then response.write ("申请中") else response.write ("已确认") end if%></td>
					   <td>
					    <%if int(a3status) = 1 then%>
					        <A HREF = "return_modify.asp?a3id=<%=a3id%>"><font color="red">修改</font></A>
					    <%else%>
					        <A HREF = "return_delete_run.asp?a3id=<%=a3id%>" onclick="return confirm('确认删除此退货记录吗?')"><font color="blue">删除</font></A>
					    <%end if%>
					    </td>
					</tr>

			   <%	rs.movenext
					loop
				 else
					response.redirect("messagebox.asp?msg=目前还没有退货记录")
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