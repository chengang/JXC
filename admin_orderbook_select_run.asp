<!KDZ Studio Powered at 20070626">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：订单查询结果页面
  '更新DB：无
  '参照DB：orderbook
  '修改履历
  '修改年月日、责任者、内容
  '2007/06/26  sky@kdz 新增 订单查询结果页面
  '2007/07/01  sky@kdz 修改 订单表中加入油费金额字段的修改
  '2007/07/03  sky@kdz 修改 根据订单号查询的增加
  '2008/07/03  sky@kdz 修改 没有起始、截至时间查询的修改
  '2008/11/16  sky@kdz 修改 显示时间样式修改
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<HTML>
<HEAD>
<TITLE>进销存系统——订单查询结果</TITLE>
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
'response.wrtie 11111
dim username,power,uid,starttime,endtime,oid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid = kdzcookie("uid")
if request.form("startyear") <> "" then
   starttime = trim(request.form("startyear"))&trim(request.form("startmonth"))&trim(request.form("startday"))&"000000"
   endtime = trim(request.form("endyear"))&trim(request.form("endmonth"))&trim(request.form("endday"))&"250000"
else
   starttime = request.queryString("starttime")
   endtime = request.queryString("endtime")
end if

if request.form("oid") <> "" then
   oid = trim(request.form("oid"))
else
   oid = request.queryString("oid")
end if

'拿取排序字段名
dim ipage,index_word,que,sequence

'拿取页码
ipage = request.queryString("pagen")
'拿取排序字段名
if request.queryString("orderby") = "" then
   index_word = "a9crttime"
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
			   <tr height="20"><td colspan="6" class="STYLE2" align="center"><b>订 单 查 询 结 果</b></td></tr>
			   <%
				 dim rs,sqltext
				 '在订单表中，根据开始和结束时间查询
         set rs= server.createobject("adodb.recordset")
             sqltext = "select * from orderbook "
             sqltext = sqltext&"where a9mflag = 0 "
					     if ( starttime <> "" and endtime <> "" ) then
					        sqltext = sqltext&"and a9crttime >= '"&starttime&"' and a9crttime <= '"&endtime&"'  "
					     end if
               sqltext = sqltext&"and a9oid like '%"&oid&"%' order by "&index_word&" "&sequence
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
					     <input name="starttime" type="hidden" value="<%=starttime%>">
					     <input name="endtime" type="hidden" value="<%=endtime%>">
					     <input name="oid" type="hidden" value="<%=oid%>">
					     共<%=pagec%>页&nbsp;&nbsp;&nbsp;第
						 <%
							if ipage = "" then
							que = que + 1
							end if
						%>
					     <select name="pagen" style="width:45px;font-size:9pt;" onChange="window.location.href('admin_orderbook_select_run.asp?pagen='+pagen.value+'&orderby='+orderby.value+'&que='+que.value+'&starttime='+starttime.value+'&endtime='+endtime.value+'&oid='+oid.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>页
					  </td>
					</tr>
					<tr height="20" bgcolor="#FF6633">
					   <td><a href = "admin_orderbook_select_run.asp?orderby=a9oid&que=<%=que%>&starttime=<%=starttime%>&endtime=<%=endtime%>&oid=<%=oid%>">订单号</a></td>
					   <td><a href = "admin_orderbook_select_run.asp?orderby=a9flow&que=<%=que%>&starttime=<%=starttime%>&endtime=<%=endtime%>&oid=<%=oid%>">流水单号</a></td>
					   <td><a href = "admin_orderbook_select_run.asp?orderby=a9sub_price&que=<%=que%>&starttime=<%=starttime%>&endtime=<%=endtime%>&oid=<%=oid%>">订单<!--优惠前-->金额</a></td>
					   <!--<td><a href = "admin_orderbook_select_run.asp?orderby=a9price_reduce&que=<%=que%>&starttime=<%=starttime%>&endtime=<%=endtime%>&oid=<%=oid%>">优惠金额</a></td>-->
					   <td><a href = "admin_orderbook_select_run.asp?orderby=a9crttime&que=<%=que%>&starttime=<%=starttime%>&endtime=<%=endtime%>&oid=<%=oid%>">录入时间</a></td>
					   <td><a href = "admin_orderbook_select_run.asp?orderby=a9crtuser&que=<%=que%>&starttime=<%=starttime%>&endtime=<%=endtime%>&oid=<%=oid%>">录入人</a></td>
					   <td align="center">详细</td>
					</tr>
			   <%   dim i,color_td,fi_money
					i = 0
					set a9oid = rs("a9oid")
					set a9flow = rs("a9flow")
					set a9sub_price = rs("a9sub_price")
					set a9postage = rs("a9postage")
					set a9price_reduce = rs("a9price_reduce")
					set a9crttime = rs("a9crttime")
					set a9crtuser = rs("a9crtuser")
					do while ((not rs.eof) and i < rs.pagesize)
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if

					fi_money = a9sub_price + a9postage - a9price_reduce
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a9oid%></td>
					   <td><%=a9flow%></td>
					   <td><%=fi_money%></td>
					   <td><%=kdztimeformat(a9crttime,"1")%></td>
					   <td><%=a9crtuser%></td>
					   <td align="center"><A HREF = "admin_orderbook_particular.asp?oid=<%=a9oid%>">查看</a></td>
					</tr>
			   <%	rs.movenext
					loop
			   %>
					<tr>
					  <td colspan="6" align="right">共<%=pagec%>页&nbsp;&nbsp;&nbsp;第
					     <select name="pagen2" style="width:45px;font-size:9pt;" onChange="window.location.href('admin_orderbook_select_run.asp?pagen='+pagen2.value+'&orderby='+orderby.value+'&que='+que.value+'&starttime='+starttime.value+'&endtime='+endtime.value+'&oid='+oid.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>页
					  </td>
					</tr>
			   <%
			     else
					response.redirect("messagebox.asp?msg=没有查询到订单")
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
