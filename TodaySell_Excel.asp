<%@ CODEPAGE=936 %>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：售货查询页面
  '更新DB：无
  '参照DB：sold
  '修改履历
  '修改年月日、责任者、内容
  '2007/06/02  sky@kdz 修改 从查询最近10条进货记录
  '                         修改为只查询今天的进货记录
  '2008/11/16  sky@kdz 修改 显示时间样式修改
  '2009/03/06  sky@kdz 修改 导出错误bug修改
%>
<%
response.ContentType ="application/vnd.ms-excel;"
if ( kdzcookie("power") <> "1"  and kdzcookie("power")<>"5" ) then
   response.redirect ("index.asp")
end if

dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

'取系统时间为数值
dim timestr,datestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
	datestr = left(timestr,8)
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
			 <table width="100%" border="1" cellpadding="5" cellspacing="0">
			   <tr height="20"><td colspan="8" align="center"><b>今 天 售 货 记 录 查 询 结 果</b></td></tr>
			   <%
				 dim rs
				 '在售货表中，查询今天的售货纪录情况
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select "
					 sqltext = sqltext&"a2id,a2code,a2name,a2brand,a2oid,a2sold_price,a2amount,a2crttime,a2crtuser " 
					 sqltext = sqltext&"from sold where a2mflag = 0  and left(a2crttime,8) = "&datestr&" order by a2crttime desc"
					 rs.open sqltext,conn,1,1
				 '如果查询到记录,则显示在页面上
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>定单号</td>
					   <td>条形码</td>
					   <td>商品名称</td>
					   <td>品 牌</td>
					   <td>价 格</td>
					   <td>数 量</td>
					   <td>录入时间</td>
					   <td>录入者</td>
					</tr>
			   <%   dim i,color_td
					i = 0
					set a2id = rs("a2id")
					set a2oid = rs("a2oid")
					set a2code = rs("a2code")
					set a2name = rs("a2name")
					set a2brand = rs("a2brand")
					set a2sold_price = rs("a2sold_price")
					set a2amount = rs("a2amount")
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
					   <td><%=a2oid%></td>
					   <td><%=a2code%></td>
					   <td><%=a2name%></td>
					   <td><%=a2brand%></td>
					   <td><%=a2sold_price%></td>
					   <td><%=a2amount%></td>
					   <td><%=kdztimeformat(a2crttime,"1")%></td>
					   <td><%=a2crtuser%></td>
					</tr>
			   <%	rs.movenext
					loop
				 else
					response.redirect("messagebox.asp?msg=目前还没有售货记录")
					response.end
				 end if
				 '关闭连接，释放进程
				 rs.close
				 conn.close
				 set conn=nothing
			   %>
</table>