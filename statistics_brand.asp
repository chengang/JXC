<!KDZ Studio Powered at 20070110">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：分品牌统计库存数量、金额
  '更新DB：无
  '参照DB：stock
  '修改履历
  '修改年月日、责任者、内容
  '2008/02/27  CG@kdz 创建 
%>
<HTML>
<HEAD>
<TITLE>进销存系统——品牌库存金额统计</TITLE>
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
		 <td>
			   <%
				'拿取排序字段名
				if request.queryString("orderby") = "" then
				   index_word = "brand"
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

				 '开始查询
				dim rs
				set rs=server.createobject("adodb.recordset")
				sqltext =         "select brand,sum_number,sum_money,total_number,total_money "
				sqltext = sqltext&"from "
				sqltext = sqltext&"( "
				sqltext = sqltext&"select a4brand as brand,sum(a4stock) as sum_number,sum(a4total_money) as sum_money "
				sqltext = sqltext&"from stock  "
				sqltext = sqltext&"group by a4brand  "
				sqltext = sqltext&") as tb1 "
				sqltext = sqltext&"join "
				sqltext = sqltext&"( "
				sqltext = sqltext&"select sum(a4stock) as total_number,sum(a4total_money) as total_money from stock "
				sqltext = sqltext&") as tb2 "
				sqltext = sqltext&"on 1=1 "
				sqltext = sqltext&"order by "& index_word &" "& sequence
					 'response.write sqltext
					 'response.end
					 rs.open sqltext,conn,1,1
				 '如果查询到记录,则显示在页面上
if not rs.eof Then
					dim a4brand,a4sum_number,a4sum_money
					dim i,color_td
					set a4brand = rs("brand")
					set a4sum_number = rs("sum_number")
					set a4sum_money = rs("sum_money")
					set a4total_number = rs("total_number")
					set a4total_money = rs("total_money")
			   %>
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
	           <tr height="50"><td colspan="3"></td></tr>
			   <tr height="20"><td colspan="3" class="STYLE2" align="center"><b>品 牌 库 存 统 计</b></td></tr>
					<tr height="20" bgcolor="#FF6633">
					   <td><a href="statistics_brand.asp?orderby=brand&que=<%=que%>">品牌</a></td>
					   <td><a href="statistics_brand.asp?orderby=sum_number&que=<%=que%>">库存数量</a></td>
					   <td><a href="statistics_brand.asp?orderby=sum_money&que=<%=que%>">库存金额</a></td>
					</tr>
			   <%   
					i = 0
					do while not rs.eof
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><a href="adv_select_run.asp?a4brand=<%=a4brand%>"><%=a4brand%></a></td>
					   <td><%=a4sum_number%>&nbsp;(<%=round((a4sum_number/a4total_number)*100,2)%>%)</td>
					   <td><b>￥<%=round(a4sum_money,2)%>&nbsp;(<%=round((a4sum_money/a4total_money)*100,2)%>%)</b></td>
					</tr>
			   <%	rs.movenext
					loop
				%>
			 </table>
<%
else
	response.redirect("messagebox.asp?msg=库存表中还没有数据，请联系管理员初始化系统")
	response.end
end if
'关闭连接，释放进程
rs.close
conn.close
set conn=nothing
			   %>
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