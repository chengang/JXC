<!--KDZ Studio Powered at 20071011 -->
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：库存情况历史记录
  '更新DB：无
  '参照DB：buy、sold、returned、stock_modify、stock
  '修改履历
  '修改年月日、责任者、内容
  '2008/10/11  sky@kdz 创建 
  '2008/11/08  sky@kdz 修改 修改退货流程
%>
<HTML>
<HEAD>
<TITLE>进销存系统——库存情况历史记录</TITLE>
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
		 <td>
			   <%

				'查询进货表中最早记录日期
				dim rs,sql,early_day
				set rs=server.createobject("adodb.recordset")
				sql = "select min(left(a1crttime,8)) early_day from buy "
				rs.open sql,conn,1,1
				early_day = rs("early_day")
				rs.close
				'日期格式转化
				early_day = mid(early_day,1,4)&"-"&mid(early_day,5,2)&"-01"
				'计算系统已经运行几个月
				dim num_month
				num_month = datediff("m",early_day,date())
				'把月份保存为数组
				dim run_month()
				redim run_month(num_month+1)
				run_month(0) = year(early_day)&right("0"&CStr(month(early_day)),2)
				for i=1 to num_month
				    run_month(i) = year(dateadd("m",i,early_day))&right("0"&CStr(month(dateadd("m",i,early_day))),2)
				    'response.write run_month(i) & "<br />"
			  next

				'查询进货详细
				dim rs_buy,sql_buy
				set rs_buy=server.createobject("adodb.recordset")
				sql_buy =         "select B.buy_month buy_month,sum(A.buy_money) buy_money,sum(A.buy_amount) buy_amount "
				sql_buy = sql_buy&"from "
				sql_buy = sql_buy&"( select left(a1crttime,6) buy_month,sum(a1buy_price*a1amount) buy_money,sum(a1amount) buy_amount "
				sql_buy = sql_buy&"from buy where a1mflag = 0 group by left(a1crttime,6) ) A, "
				sql_buy = sql_buy&"( select left(a1crttime,6) buy_month from buy  group by left(a1crttime,6) ) B "
				sql_buy = sql_buy&"where A.buy_month <= B.buy_month "
				sql_buy = sql_buy&"group by B.buy_month order by B.buy_month "
				'response.write sql_buy & "<br />"
				rs_buy.open sql_buy,conn,1,1
				'把进货数量和进货总价保存为数组
				dim run_buy_money(),run_buy_amount(),flag
				redim run_buy_money(num_month+1),run_buy_amount(num_month+1)
				flag = 0
				for i = 0 to num_month
				     while ( not rs_buy.eof and flag = 0 )
				        if run_month(i) = rs_buy("buy_month") then
				           run_buy_money(i) = rs_buy("buy_money")
				           run_buy_amount(i) = rs_buy("buy_amount")
				           flag = 1
				        end if
				     rs_buy.movenext
				     wend
				     'response.write rs_buy("buy_month") & "<br />"
				     'response.write run_month(i) & "<br />"
				     'response.write run_buy_money(i) & "<br />"
				     'response.write run_buy_amount(i) & "<br />"
				     'response.end
				     '如果没有该月的值，则赋给上月的值
				     if flag = 0 then
				        if i = 0 then
				           run_buy_money(i) = 0
				           run_buy_amount(i) = 0
				        else
				           run_buy_money(i) = run_buy_money(i-1)
				           run_buy_amount(i) = run_buy_amount(i-1)
				        end if
				     else
				        flag = 0
				     end if
				     rs_buy.movefirst
				'response.write run_month(i) & " " & run_buy_money(i) & " " & run_buy_amount(i) & "<br />"
				next
				rs_buy.close

				'查询售货详细
				dim rs_sold,sql_sold
				set rs_sold=server.createobject("adodb.recordset")
				sql_sold =         "select B.sold_month,sum(A.sold_money) sold_money,sum(A.sold_amount) sold_amount "
				sql_sold = sql_sold&"from "
				sql_sold = sql_sold&"( select left(a2crttime,6) sold_month,sum(a2amount*a2buy_price) sold_money,sum(a2amount) sold_amount "
				sql_sold = sql_sold&"from sold where a2mflag = 0 group by left(a2crttime,6)  ) A, "
				sql_sold = sql_sold&"( select left(a2crttime,6) sold_month from sold  group by left(a2crttime,6) ) B "
				sql_sold = sql_sold&"where A.sold_month <= B.sold_month "
				sql_sold = sql_sold&"group by B.sold_month order by B.sold_month "
				'response.write sql_sold & "<br />"
				'response.end
				rs_sold.open sql_sold,conn,1,1
				'把售货数量和售货总价保存为数组
				dim run_sold_money(),run_sold_amount()
				redim run_sold_money(num_month+1),run_sold_amount(num_month+1)
				flag = 0
				for i = 0 to num_month
				     while ( not rs_sold.eof and flag = 0 )
				        if run_month(i) = rs_sold("sold_month") then
				           run_sold_money(i) = rs_sold("sold_money")
				           run_sold_amount(i) = rs_sold("sold_amount")
				           flag = 1
				        end if
				     rs_sold.movenext
				     wend
				     'response.write rs_sold("sold_month") & "<br />"
				     'response.write run_month(i) & "<br />"
				     'response.write run_sold_money(i) & "<br />"
				     'response.write run_sold_amount(i) & "<br />"
				     'response.end
				     '如果没有该月的值，则赋给上月的值
				     if flag = 0 then
				        if i = 0 then
				           run_sold_money(i) = 0
				           run_sold_amount(i) = 0
				        else
				           run_sold_money(i) = run_sold_money(i-1)
				           run_sold_amount(i) = run_sold_amount(i-1)
				        end if
				     else
				        flag = 0
				     end if
				     rs_sold.movefirst
				'response.write run_month(i) & " " & run_sold_money(i) & " " & run_sold_amount(i) & "<br />"
				next
				rs_sold.close

				'查询退货详细
				dim rs_returned,sql_returned
				set rs_returned=server.createobject("adodb.recordset")
				sql_returned =              "select B.return_month,sum(A.return_money) return_money,sum(A.return_amount) return_amount "
				sql_returned = sql_returned&"from "
				sql_returned = sql_returned&"( select left(a3crttime,6) return_month,sum(a3amount*a3buy_price) return_money,sum(a3amount) return_amount "
				sql_returned = sql_returned&"from returned where a3mflag = 0 and a3status <> 1 group by left(a3crttime,6)   ) A, "
				sql_returned = sql_returned&"( select left(a3crttime,6) return_month from returned  group by left(a3crttime,6) ) B "
				sql_returned = sql_returned&"where A.return_month <= B.return_month "
				sql_returned = sql_returned&"group by B.return_month order by B.return_month "
				'response.write sql_returned & "<br />"
				'response.end
				rs_returned.open sql_returned,conn,1,1
				'把退货数量和退货总价保存为数组
				dim run_return_money(),run_return_amount()
				redim run_return_money(num_month+1),run_return_amount(num_month+1)
				flag = 0
				for i = 0 to num_month
				     while ( not rs_returned.eof and flag = 0 )
				        if run_month(i) = rs_returned("return_month") then
				           run_return_money(i) = rs_returned("return_money")
				           run_return_amount(i) = rs_returned("return_amount")
				           flag = 1
				        end if
				     rs_returned.movenext
				     wend
				     'response.write rs_returned("return_month") & "<br />"
				     'response.write run_month(i) & "<br />"
				     'response.write run_return_money(i) & "<br />"
				     'response.write run_return_amount(i) & "<br />"
				     'response.end
				     '如果没有该月的值，则赋给上月的值
				     if flag = 0 then
				        if i = 0 then
				           run_return_money(i) = 0
				           run_return_amount(i) = 0
				        else
				           run_return_money(i) = run_return_money(i-1)
				           run_return_amount(i) = run_return_amount(i-1)
				        end if
				     else
				        flag = 0
				     end if
				     rs_returned.movefirst
				'response.write run_month(i) & " " & run_return_money(i) & " " & run_return_amount(i) & "<br />"
				next
				rs_returned.close

				'查询强制修改详细
				dim rs_stock_modify,sql_stock_modify
				set rs_stock_modify=server.createobject("adodb.recordset")
				sql_stock_modify =                  "select B.stock_modify_month,sum(A.stock_modify_money) stock_modify_money,sum(A.stock_modify_amount) stock_modify_amount "
				sql_stock_modify = sql_stock_modify&"from "
				sql_stock_modify = sql_stock_modify&"( select left(a11crttime,6) stock_modify_month, sum((a11amount_new - a11amount_old)*isnull(a11price,0)) stock_modify_money, "
				sql_stock_modify = sql_stock_modify&"sum(a11amount_new - a11amount_old) stock_modify_amount "
				sql_stock_modify = sql_stock_modify&"from stock_modify group by left(a11crttime,6)    ) A, "
				sql_stock_modify = sql_stock_modify&"( select left(a11crttime,6) stock_modify_month from stock_modify  group by left(a11crttime,6) ) B "
				sql_stock_modify = sql_stock_modify&"where A.stock_modify_month <= B.stock_modify_month "
				sql_stock_modify = sql_stock_modify&"group by B.stock_modify_month order by B.stock_modify_month "
				'response.write sql_stock_modify & "<br />"
				'response.end
				rs_stock_modify.open sql_stock_modify,conn,1,1
				'把强制修改数量和强制修改总价保存为数组
				dim run_modify_money(),run_modify_amount()
				redim run_modify_money(num_month+1),run_modify_amount(num_month+1)
				flag = 0
				for i = 0 to num_month
				     while ( not rs_stock_modify.eof and flag = 0 )
				        if run_month(i) = rs_stock_modify("stock_modify_month") then
				           run_modify_money(i) = rs_stock_modify("stock_modify_money")
				           run_modify_amount(i) = rs_stock_modify("stock_modify_amount")
				           flag = 1
				        end if
				     rs_stock_modify.movenext
				     wend
				     'response.write run_month(i) & "<br />"
				     'response.write run_modify_money(i) & "<br />"
				     'response.write run_modify_amount(i) & "<br />"
				     'response.end
				     '如果没有该月的值，则赋给上月的值
				     if flag = 0 then
				        if i = 0 then
				           run_modify_money(i) = 0
				           run_modify_amount(i) = 0
				        else
				           run_modify_money(i) = run_modify_money(i-1)
				           run_modify_amount(i) = run_modify_amount(i-1)
				        end if
				     else
				        flag = 0
				     end if
				     rs_stock_modify.movefirst
				'response.write run_month(i) & " " & run_modify_money(i) & " " & run_modify_amount(i) & "<br />"
				next
				rs_stock_modify.close

				'查询种类详细
				dim rs_stock,sql_stock
				set rs_stock=server.createobject("adodb.recordset")
				sql_stock =          "select B.stock_month,count(A.a4gid) count_sort "
				sql_stock = sql_stock&"from "
				sql_stock = sql_stock&"( select a4crttime,a4gid from stock ) A, "
				sql_stock = sql_stock&"( select left(a4crttime,6) stock_month from stock group by left(a4crttime,6) ) B "
				sql_stock = sql_stock&"where left(A.a4crttime,6) <= B.stock_month "
				sql_stock = sql_stock&"group by B.stock_month order by B.stock_month "
				'response.write sql_stock & "<br />"
				'response.end
				rs_stock.open sql_stock,conn,1,1
				'把商品种类数量保存为数组
				dim run_count_sort()
				redim run_count_sort(num_month+1)
				flag = 0
				for i = 0 to num_month
				     while ( not rs_stock.eof and flag = 0 )
				        if run_month(i) = rs_stock("stock_month") then
				           run_count_sort(i) = rs_stock("count_sort")
				           flag = 1
				        end if
				     rs_stock.movenext
				     wend
				     '如果没有该月的值，则赋给上月的值
				     if flag = 0 then
				        if i = 0 then
				           run_count_sort(i) = 0
				        else
				           run_count_sort(i) = run_count_sort(i-1)
				        end if
				     else
				        flag = 0
				     end if
				     'response.write rs_stock("stock_month") & "<br />"
				     'response.write run_month(i) & "<br />"
				     'response.write run_count_sort(i) & "<br />"
				     'response.end
				     rs_stock.movefirst
				'response.write run_month(i) & " " & run_count_sort(i)  & "<br />"
				next
				rs_stock.close
				
				'求库存总价值，库存总计数量
				dim run_total_money(),run_total_amount()
				redim run_total_money(num_month+1),run_total_amount(num_month+1)
				for i = 0 to num_month
				    run_total_money(i) = run_buy_money(i) - run_sold_money(i) + run_return_money(i) + run_modify_money(i) + 1907.72
				    run_total_amount(i) = run_buy_amount(i) - run_sold_amount(i) + run_return_amount(i) + run_modify_amount(i)
			  next
				'response.end
			   %>
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
	           <tr height="50"><td colspan="4"></td></tr>
			   <tr height="20"><td colspan="4" class="STYLE2" align="center"><b>库 存 情 况 历 史 记 录</b></td></tr>
					<tr height="20" bgcolor="#FF6633">
					   <td>月份 </td>
					   <td>商品种类 </td>
					   <td>商品数量 </td>
					   <td>库存总价值 </td>
					</tr>
			   <%   
			   %>
				  <%
				    for i = 0 to num_month
				       if i mod 2 = 0 then
				          color_td = "#CCFFFF"
				       else
				          color_td = "#FFFFFF"
				       end if
				  %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=left(run_month(i),4)%>-<%=right(run_month(i),2)%></td>
					   <td><%=run_count_sort(i)%></td>
					   <td><%=run_total_amount(i)%></td>
					   <td><img src="image/change30015.jpg" border="0" height="10" width="<%=run_total_money(i) * 0.0001%>">&nbsp;<%=round(run_total_money(i),2)%></td>
					</tr>
					<%next%>
			 </table>
<%
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
