<!KDZ Studio Powered at 20070702">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：普通用户进货查询页面
  '更新DB：无
  '参照DB：buy
  '修改履历
  '修改年月日、责任者、内容
  '2007/07/02  sky@kdz 新增
  '2008/11/16  sky@kdz 修改 显示时间样式修改
%>
<HTML>
<HEAD>
<TITLE>进销存系统——全部进货查询</TITLE>
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
   index_word = "a1crttime"
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
	           <tr height = "50"><td colspan="7"></td></tr>
			   <tr height="20"><td colspan="7" class="STYLE2" align="center"><b>全 部 进 货 记 录 查 询 结 果</b></td></tr>
			   <%
				 dim rs,pagec
				 '在进货表中，查询全部的进货纪录情况
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select "
					 sqltext = sqltext&"a1id,a1code,a1name,a1brand,a1amount,a1seat,a1crttime,a1crtuser " 
					 sqltext = sqltext&"from buy where a1mflag = 0 order by "&index_word&" "&sequence
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
					  <td colspan="7" align="right">
					     <input name="orderby" type="hidden" value="<%=index_word%>">
					     <input name="que" type="hidden" value="<%=que%>">
					     共<%=pagec%>页&nbsp;&nbsp;&nbsp;第
						  <%
							if ipage = "" then
							que = que + 1
							end if
						%>
					     <select name="pagen" style="width:45px;font-size:9pt;" onChange="window.location.href('inquire_buy_select.asp?pagen='+pagen.value+'&orderby='+orderby.value+'&que='+que.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>页
					  </td>
					</tr>
					<tr height="20" bgcolor="#FF6633">
					   <td><a href = "admin_buy_select.asp?orderby=a1code&que=<%=que%>">条形码</a></td>
					   <td><a href = "admin_buy_select.asp?orderby=a1name&que=<%=que%>">商品名称</a></td>
					   <td><a href = "admin_buy_select.asp?orderby=a1brand&que=<%=que%>">品 牌</a></td>
					   <td><a href = "admin_buy_select.asp?orderby=a1amount&que=<%=que%>">数 量</a></td>
					   <td><a href = "admin_buy_select.asp?orderby=a1seat&que=<%=que%>">仓 位</a></td>
					   <td><a href = "admin_buy_select.asp?orderby=a1crttime&que=<%=que%>">录入时间</a></td>
					   <td><a href = "admin_buy_select.asp?orderby=a1crtuser&que=<%=que%>">录入者</a></td>
					   <!--<td align="center">操作</td>-->
					</tr>
			   <%   dim i,color_td
					i = 0
					set a1id = rs("a1id")
					set a1code = rs("a1code")
					set a1name = rs("a1name")
					set a1brand = rs("a1brand")
					set a1amount = rs("a1amount")
					set a1seat = rs("a1seat")
					set a1crttime = rs("a1crttime")
					set a1crtuser = rs("a1crtuser")
					do while ((not rs.eof) and i < rs.pagesize)
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a1code%></td>
					   <td><%=a1name%></td>
					   <td><%=a1brand%></td>
					   <td><%=a1amount%></td>
					   <td><%=a1seat%></td>
					   <td><%=kdztimeformat(a1crttime,"1")%></td>
					   <td><%=a1crtuser%></td>
					   <!--<td align="center"><a href = "buy_modify.asp?a1id=<%=a1id%>&frompage=<%=frompage%>">修改</a></td>-->
					</tr>
			   <%
			        rs.movenext
					loop
				%>
					<tr>
					  <td colspan="7" align="right">共<%=pagec%>页&nbsp;&nbsp;&nbsp;第
					     <select name="pagen2" style="width:45px;font-size:9pt;" onChange="window.location.href('inquire_buy_select.asp?pagen='+pagen2.value+'&orderby='+orderby.value+'&que='+que.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>页
					  </td>
					</tr>
				<%else
					response.redirect("messagebox.asp?msg=目前还没有进货记录")
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