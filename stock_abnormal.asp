<!KDZ Studio Powered at 20070722">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：库存异动记录
  '          查询所有库存异动记录
  '更新DB：无
  '参照DB：stock_modify
  '修改履历
  '修改年月日、责任者、内容
  '2007/07/22  sky@kdz 新增
  '2007/07/03  sky@kdz 修改 加入库存增加减少的显示，并加入排序功能
  '2007/12/16  sky@kdz 修改 库存异动记录中添加再次查询功能
  '2008/11/16  sky@kdz 修改 显示时间样式修改
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<HTML>
<HEAD>
<TITLE>进销存系统——库存异动记录</TITLE>
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

if (request.queryString("a11name") = "" and request.queryString("a11brand") = "" and request.queryString("a11code") = "") then
   name = trim(request.form("a11name"))
   brand = trim(request.form("a11brand"))
   code = trim(request.form("a11code"))
else
   name = request.queryString("a11name")
   brand = request.queryString("a11brand")
   code = request.queryString("a11code")
end if

'拿取排序字段名
dim ipage,index_word,que,sequence

'拿取页码
ipage = request.queryString("pagen")

'拿取排序字段名
if request.queryString("orderby") = "" then
   index_word = "a11crttime"
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
		     <form id="form1" name="form1" method="post" action="stock_abnormal.asp">
		     <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" valign="bottom">
			   <tr>
			     <td colspan="7" class="STYLE2" align="center"><b>继 续 查 询</b>
				 </td>
			   </tr>
			   <tr>
			     <td>条形码<input type="text" name="a11code"  style="width:110;">
				 </td>
			     <td>商品名称<input type="text" name="a11name" style="width:110;">
				 </td>
			     <td>品牌<input type="text" name="a11brand"  style="width:110;">
				 </td>
			     <td><input type="submit" name="Submit" value="查询" style="width:60;">
				 </td>
			   </tr>
			 </table>
			 </form>
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
			   <tr height="20"><td colspan="9" class="STYLE2" align="center"><b>库 存 异 动 记 录</b></td></tr>
			   <%
				 dim rs
				 '在强制修改库存中，查询全部纪录
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select a11name,a11code,a11brand,a11amount_old,a11amount_new,"
					 sqltext = sqltext&"a11amount_old - a11amount_new  diff,a11crttime,a11crtuser,a11reason "
					 sqltext = sqltext&"from stock_modify "
					 sqltext = sqltext&"where a11code like '%"&code&"%' and a11name like '%"&name&"%' and a11brand like '%"&brand&"%' "
					 sqltext = sqltext&"order by "&index_word&" "&sequence
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
					  <td colspan="9" align="right">
					     <input name="orderby" type="hidden" value="<%=index_word%>">
					     <input name="que" type="hidden" value="<%=que%>">
					     <input name="code" type="hidden" value="<%=code%>">
					     <input name="a11name" type="hidden" value="<%=name%>">
					     <input name="brand" type="hidden" value="<%=brand%>">
					     共<%=pagec%>页&nbsp;&nbsp;&nbsp;第
						  <%
							if ipage = "" then
							   que = que + 1
							end if
						%>
					     <select name="pagen" style="width:45px;font-size:9pt;" onChange="window.location.href('stock_abnormal.asp?pagen='+pagen.value+'&a11code='+code.value+'&a11name='+a11name.value+'&a11brand='+brand.value+'&orderby='+orderby.value+'&que='+que.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>页
					  </td>
					</tr>
					<tr height="20" bgcolor="#FF6633">
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11name&que=<%=que%>">商品名称</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11code&que=<%=que%>">条形码</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11brand&que=<%=que%>">品牌</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11amount_old&que=<%=que%>">修改前数量</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11amount_new&que=<%=que%>">修改后数量</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=diff&que=<%=que%>">变更趋势</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11crttime&que=<%=que%>">录入时间</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11crtuser&que=<%=que%>">录入人</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11reason&que=<%=que%>">修改原因</a></td>
					</tr>
			   <%   dim i,color_td
					i = 0
					set a11name = rs("a11name")
					set a11code = rs("a11code")
					set a11brand = rs("a11brand")
					set a11amount_old = rs("a11amount_old")
					set a11amount_new = rs("a11amount_new")
					set diff = rs("diff")
					set a11reason = rs("a11reason")
					set a11crttime = rs("a11crttime")
					set a11crtuser = rs("a11crtuser")
					do while ((not rs.eof) and i < rs.pagesize)
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a11name%></td>
					   <td><%=a11code%></td>
					   <td><%=a11brand%></td>
					   <td><%=a11amount_old%></td>
					   <td><%=a11amount_new%></td>
					   <td><%if diff > 0 then
					            response.write ("<font color=red>减少</font>")
							     else if diff < 0 then
							             response.write ("增加")
								        else
								           response.write ("不变")
								        end if
						       end if
							%>
					   </td>
					   <td><%=kdztimeformat(a11crttime,"1")%></td>
					   <td><%=a11crtuser%></td>
					   <td><%=a11reason%></td>
					</tr>
			   <%	rs.movenext
					loop
				%>
					<tr>
					  <td colspan="9" align="right">共<%=pagec%>页&nbsp;&nbsp;&nbsp;第
					     <select name="pagen2" style="width:45px;font-size:9pt;" onChange="window.location.href('stock_abnormal.asp?pagen='+pagen2.value+'&a11code='+code.value+'&a11name='+a11name.value+'&a11brand='+brand.value+'&orderby='+orderby.value+'&que='+que.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>页
					  </td>
					</tr>
				 <%else
					response.redirect("messagebox.asp?msg=目前还没有库存异动记录")
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
