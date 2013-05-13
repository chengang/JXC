<!KDZ Studio Powered at 20070702">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：普通用户退货查询页面
  '更新DB：无
  '参照DB：returned
  '修改履历
  '修改年月日、责任者、内容
  '2007/07/02  sky@kdz 新增
  '2008/11/08  sky@kdz 修改 修改退货流程
  '2008/11/16  sky@kdz 修改 显示时间样式修改
%>
<HTML>
<HEAD>
<TITLE>进销存系统——全部退货查询</TITLE>
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
'取系统时间为数值
dim timestr,datestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
	datestr = left(timestr,8)

'拿取排序字段名
dim ipage,index_word,que,sequence

'拿取页码
ipage = request.queryString("pagen")
'拿取排序字段名
if request.queryString("orderby") = "" then
   index_word = "a3crttime"
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
'response.write index_word&" "&que
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
	           <tr height = "50"><td colspan="8"></td></tr>
			   <tr height="20"><td colspan="8" class="STYLE2" align="center"><b>全 部 退 货 记 录 查 询 结 果</b></td></tr>
			   <%
				 dim rs
				 '在退货表中，查询全部退货的纪录情况
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select  "
					 sqltext = sqltext&"a3id,a3code,a3name,a3brand,a3price,a3amount,a3oid,a3crttime,a3crtuser " 
					 sqltext = sqltext&"from returned where a3mflag = 0 and a3status <> 1 order by "&index_word&" "&sequence
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
					  <td colspan="8" align="right">
					     <input name="orderby" type="hidden" value="<%=index_word%>">
					     <input name="que" type="hidden" value="<%=que%>">
					     共<%=pagec%>页&nbsp;&nbsp;&nbsp;第
						 <%
							if ipage = "" then
							que = que + 1
							end if
						%>
					     <select name="pagen" style="width:45px;font-size:9pt;" onChange="window.location.href('inquire_return_select.asp?pagen='+pagen.value+'&orderby='+orderby.value+'&que='+que.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>页
					  </td>
					</tr>
					<tr height="20" bgcolor="#FF6633">
					   <td><a href = "admin_return_select.asp?orderby=a3code&que=<%=que%>">条形码</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3name&que=<%=que%>">商品名称</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3brand&que=<%=que%>">品 牌</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3price&que=<%=que%>">单 价</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3amount&que=<%=que%>">数 量</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3oid&que=<%=que%>">定单号</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3crttime&que=<%=que%>">录入时间</a></td>
					   <td><a href = "admin_return_select.asp?orderby=a3crtuser&que=<%=que%>">录入者</a></td>
					   <!--<td align="center">操作</td>-->
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
					do while ((not rs.eof) and i < rs.pagesize)
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a3code%></td>
					   <td><%=a3name%></td>
					   <td><%=a3brand%></td>
					   <td><%=a3price%></td>
					   <td><%=a3amount%></td>
					   <td><%=a3oid%></td>
					   <td><%=kdztimeformat(a3crttime,"1")%></td>
					   <td><%=a3crtuser%></td>
					   <!--<td align="center"><A HREF = "return_modify.asp?a3id=<%=a3id%>&frompage=<%=frompage%>">修改</A></td>-->
					</tr>
			   <%	rs.movenext
					loop
				%>
					<tr>
					  <td colspan="8" align="right">共<%=pagec%>页&nbsp;&nbsp;&nbsp;第
					     <select name="pagen2" style="width:45px;font-size:9pt;" onChange="window.location.href('inquire_return_select.asp?pagen='+pagen2.value+'&orderby='+orderby.value+'&que='+que.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>页
					  </td>
					</tr>
				<%else
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