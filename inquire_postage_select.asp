<!KDZ Studio Powered at 20070702">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：邮费查询页面
  '更新DB：无
  '参照DB：postage
  '修改履历
  '修改年月日、责任者、内容
  '2007/07/02  sky@kdz 新增
  '2008/11/16  sky@kdz 修改 显示时间样式修改
%>
<HTML>
<HEAD>
<TITLE>进销存系统——全部邮费查询</TITLE>
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

'确定是什么操作
dim frompage
frompage = "adv"
'拿取排序字段名
dim ipage,index_word,que,sequence

'拿取页码
ipage = request.queryString("pagen")

'拿取排序字段名
if request.queryString("orderby") = "" then
   index_word = "a8crttime"
else
   index_word = request.queryString("orderby")
end if

'拿取排序顺序
que = int(request.queryString("que"))
if que="" then
   que = 0
end if
if que mod 2 = 0 then
  sequence = "desc"
else
  sequence = "asc"
end if
'response.write "index_word"&" "&index_word
'response.end
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
	           <tr height = "50"><td colspan="6"></td></tr>
			   <tr height="20"><td colspan="6" class="STYLE2" align="center"><b>全 部 邮 费 记 录 查 询 结 果</b></td></tr>
			   <%
				 dim rs
				 '在邮费表中，查询全部邮费的纪录情况
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select * "
					 sqltext = sqltext&"from postage where a8mflag = 0 order by "&index_word&" "&sequence
					 'response.write sqltext
					 'response.end
					 rs.open sqltext,conn,1,1
					 rs.pagesize = 20
					 pagec = rs.pagecount
					 rs.absolutepage = ipage
					 'dim recordc
					 'recordc = rs.recordcount
					 'response.write recordc
					 'response.write pagec
					 'response.end
				 '如果查询到记录,则显示在页面上
				 if not rs.eof Then
			   %>
					<tr>
					  <td colspan="6" align="right">
					     <input name="orderby" type="hidden" value="<%=index_word%>">
					     <input name="que" type="hidden" value="<%=que%>">
					     共<%=pagec%>页&nbsp;&nbsp;&nbsp;第
						 <%
							if ipage = "" then
							que = que + 1
							end if
						%>
					     <select name="pagen" style="width:45px;font-size:9pt;" onChange="window.location.href('inquire_postage_select.asp?pagen='+pagen.value+'&orderby='+orderby.value+'&que='+que.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>页
					  </td>
					</tr>
					<tr height="20" bgcolor="#FF6633">
					   <td><a href = "admin_postage_select.asp?orderby=a8date&que=<%=que%>">邮费日期</a></td>
					   <td><a href = "admin_postage_select.asp?orderby=a8postage&que=<%=que%>">邮费金额</a></td>
					   <td><a href = "admin_postage_select.asp?orderby=a8crttime&que=<%=que%>">录入时间</a></td>
					   <td><a href = "admin_postage_select.asp?orderby=a8crtuser&que=<%=que%>">录入人</a></td>
					   <td><a href = "admin_postage_select.asp?orderby=a8chgtime&que=<%=que%>">修改时间</a></td>
					   <td><a href = "admin_postage_select.asp?orderby=a8chguser&que=<%=que%>">修改人</a></td>
					   <!--<td align="center">操作</td>-->
					</tr>
			   <%   dim i,color_td
					i = 0
					dim a8id,a8date,a8postage,a8crttime
			        dim a8crtuser,a8chgtime,a8chguser

					set a8id = rs("a8id")
					set a8date = rs("a8date")
					set a8postage = rs("a8postage")
					set a8crttime = rs("a8crttime")
					set a8crtuser = rs("a8crtuser")
					set a8chgtime = rs("a8chgtime")
					set a8chguser = rs("a8chguser")

					do while ((not rs.eof) and i < rs.pagesize)
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a8date%></td>
					   <td><%=a8postage%></td>
					   <td><%=kdztimeformat(a8crttime,"1")%></td>
					   <td><%=a8crtuser%></td>
					   <td><%=kdztimeformat(a8chgtime,"1")%></td>
					   <td><%=a8chguser%></td>
					   <!--<td align="center"><A HREF = "postage_modify.asp?a8id=<%=a8id%>&frompage=<%=frompage%>">修改</A></td>-->
					</tr>
			   <%	rs.movenext
					loop
			   %>
					<tr>
					  <td colspan="6" align="right">共<%=pagec%>页&nbsp;&nbsp;&nbsp;第
					     <select name="pagen2" style="width:45px;font-size:9pt;" onChange="window.location.href('inquire_postage_select.asp?pagen='+pagen2.value+'&orderby='+orderby.value+'&que='+que.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>页
					  </td>
					</tr>
				<%else
					response.redirect("messagebox.asp?msg=目前还没有邮费记录")
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