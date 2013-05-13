<!KDZ Studio Powered at 20070627">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<%response.Expires = 0%>
<!--#include file="inc/conn.asp"-->
<%'机能说明：订单详细页面
  '          根据订单号查询该订单的售货和退货详细
  '更新DB：无
  '参照DB：orderbook,sold,returned
  '修改履历
  '修改年月日、责任者、内容
  '2007/06/27  sky@kdz 新增
  '2007/07/01  sky@kdz 修改 售货时加入邮费的修改
  '2007/07/22  sky@kdz 修改 订单的释放
  '2007/07/27  sky@kdz 修改 退货详细的增加
  '2007/10/30  sky@kdz 修改 单一订单显示利润引起的修改
  '2008/01/02  sky@kdz 修改 退货表中卖出价格字段变更为买入成本
  '2008/11/08  sky@kdz 修改 修改退货流程
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
  '2008/12/28  sky@kdz 修改 售货是赠品的时候，注明为赠品
%>
<HTML>
<HEAD>
<TITLE>进销存系统——订单详细</TITLE>
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
			   height: 28px; 
			   background-color: #ddeeff"
			   }
-->
</style>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim oid,frompage
oid = trim(request.queryString("oid"))

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
	           <tr height = "50"><td colspan="9"></td></tr>
			   <tr height="20"><td colspan="9" class="STYLE2" align="center"><b>订 单 (<%=oid%>) 明 细</b></td></tr>
			   <%
				 dim rs_ob,sqltext_ob,price_reduce
				 '在订单表中，根据开始和结束时间查询
         set rs_ob= server.createobject("adodb.recordset")
             sqltext_ob = "select * from orderbook "
             sqltext_ob = sqltext_ob&"where a9mflag = 0 and a9oid = '"&oid&"'"
             'response.write sqltext
             'response.end
             rs_ob.open sqltext_ob,conn,1,1

						 price_reduce = rs_ob("a9price_reduce")
						 order_price = rs_ob("a9sub_price")+ rs_ob("a9postage") - rs_ob("a9price_reduce")
			   %>
			   <tr height="20"><td colspan="9" class="STYLE2" align="left"><b>基 本 信 息</b></td></tr>
					<tr height="20" bgcolor="#FF6633">
					   <td>订单号</td>
					   <td>流水单号</td>
					   <td>订单金额</td>
					   <td>优惠前金额</td>
					   <td>邮费金额</td>
					   <td>优惠金额</td>
					   <td>录入时间</td>
					   <td>录入人</td>
					   <td align="center">操作</td>
					</tr>
					<tr height="25">
					   <td><%=rs_ob("a9oid")%></td>
					   <td><%=rs_ob("a9flow")%></td>
					   <td><%=(rs_ob("a9sub_price")+ rs_ob("a9postage") - rs_ob("a9price_reduce"))%></td>
					   <td><%=rs_ob("a9sub_price")%></td>
					   <td><%=rs_ob("a9postage")%></td>
					   <td><%=rs_ob("a9price_reduce")%></td>
					   <td><%=kdztimeformat(rs_ob("a9crttime"),"2")%></td>
					   <td><%=rs_ob("a9crtuser")%></td>
					   <td align="center"><A HREF = "orderbook_delete.asp?oid=<%=oid%>&frompage=adv" onclick="return confirm('确认删除此订单?')">删除</A></td>
					</tr>
			   <%'关闭连接，释放进程
				 rs_ob.close
			   %>
			   <tr height="20"><td colspan="9" class="STYLE2" align="left"><b>售 货 明 细</b></td></tr>
			   <%
				 dim rs
				 '在售货表中，根据订单号查询该订单的售货详细
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select "
					 sqltext = sqltext&"a2id,a2code,a2name,a2brand,a2oid,a2buy_price,a2sold_price,a2amount,a2chgtime,a2chguser " 
					 sqltext = sqltext&"from sold where a2mflag = 0  and a2oid = '"&oid&"'"
					 'response.write sqltext
					 'response.end
					 rs.open sqltext,conn,1,1
				 '如果查询到记录,则显示在页面上
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>条形码</td>
					   <td>商品名称</td>
					   <td>品 牌</td>
					   <td>售货价格</td>
					   <td>售货数量</td>
					   <td>修改时间</td>
					   <td>修改人</td>
					   <td colspan="2" align="center">操作</td>
					</tr>
			   <%   dim i,color_td
					i = 0
					set a2id = rs("a2id")
					set a2oid = rs("a2oid")
					set a2code = rs("a2code")
					set a2name = rs("a2name")
					set a2brand = rs("a2brand")
					set a2buy_price = rs("a2buy_price")
					set a2sold_price = rs("a2sold_price")
					set a2amount = rs("a2amount")
					set a2chgtime = rs("a2chgtime")
					set a2chguser = rs("a2chguser")

					dim total_cost,total_gain
						total_cost = 0
						total_gain = 0

					do while not rs.eof
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if

					total_cost = total_cost + (a2buy_price * a2amount)
					total_gain = total_gain + ( (a2sold_price - a2buy_price) * a2amount )

			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a2code%></td>
					   <td><%=a2name%></td>
					   <td><%=a2brand%></td>
					   <td><%if int(a2sold_price)= 0 then response.write "<font color=red>赠品</font>" else response.write a2sold_price end if%></td>
					   <td><%=a2amount%></td>
					   <td><%=kdztimeformat(a2chgtime,"2")%></td>
					   <td><%=a2chguser%></td>
					   <td  colspan="2" align="center"><A HREF = "sell_modify.asp?a2id=<%=a2id%>&frompage=oid=<%=oid%>">修改</A></td>
					</tr>
			   <%	rs.movenext
					loop
				 else
					response.redirect("messagebox.asp?msg=目前还没有售货记录")
					response.end
				 end if
				 '关闭连接，释放进程
				 rs.close
				 %>
			   <tr height="20"><td colspan="9" class="STYLE2" align="left"><b>退 货 明 细</b></td></tr>
			   <%
				 dim rs_return,sqltext_return
				 '在退货表中，根据订单号查询该订单的退货详细
				 set rs_return=server.createobject("adodb.recordset")
					 sqltext_return = "select R.a3code,R.a3name,R.a3brand,R.a3price,R.a3amount,R.a3chgtime,R.a3chguser,R.a3reason,R.a3status,S.a2buy_price "
					 sqltext_return = sqltext_return&"from returned R,sold S "
					 sqltext_return = sqltext_return&"where R.a3gid = S.a2gid "
					 sqltext_return = sqltext_return&"and R.a3mflag = 0  and a3status <> 1 and R.a3oid = '"&oid&"' "
					 sqltext_return = sqltext_return&"and S.a2mflag = 0  and S.a2oid = '"&oid&"' "
					 'response.write sqltext_return
					 'response.end
					 rs_return.open sqltext_return,conn,1,1
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>条形码</td>
					   <td>商品名称</td>
					   <td>品 牌</td>
					   <td>退货价格</td>
					   <td>退货数量</td>
					   <td>退货时间</td>
					   <td>退货人</td>
					   <td>退货原因</td>
					   <td>状态</td>
					   <!--<td align="center">操作</td>-->
					</tr>
			   <%   
				 '如果查询到记录,则显示在页面上
				 if not rs_return.eof Then
				  dim j,color_j
					j = 0
					set a3code = rs_return("a3code")
					set a3name = rs_return("a3name")
					set a3brand = rs_return("a3brand")
					set a3price = rs_return("a3price")
					set a3amount = rs_return("a3amount")
					set a3chgtime = rs_return("a3chgtime")
					set a3chguser = rs_return("a3chguser")
					set a3reason = rs_return("a3reason")
					set a3status = rs_return("a3status")

					set a2buy_price = rs_return("a2buy_price")
					'response.write "<br>"&rs_return("a2buy_price")

					'response.write total_cost&"<br>"
					'response.write total_gain&"<br>"

					do while not rs_return.eof
					j = j + 1
					if j mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if

					total_cost = total_cost - (a2buy_price * a3amount)
					total_gain = total_gain - ( (a3price - a2buy_price) * a3amount )
					'response.write total_cost&"<br>"
					'response.write total_gain&"<br>"

			   %>
					<tr height="20" bgcolor="<%=color_j%>">
					   <td><%=a3code%></td>
					   <td><%=a3name%></td>
					   <td><%=a3brand%></td>
					   <td><%=a3price%></td>
					   <td><%=a3amount%></td>
					   <td><%=kdztimeformat(a3chgtime,"2")%></td>
					   <td><%=a3chguser%></td>
					   <td><%=a3reason%></td>
					   <td><%if int(a3status) = 1 then response.write ("申请中") else response.write ("已确认") end if%></td>
					   <!--<td align="center">修改</td>-->
					</tr>
			   <%	rs_return.movenext
					loop
				 else
				 response.write("<tr><td colspan="& 9 &" align= left>没有退货记录</td></tr>")
				 end if
			   %>
			   <tr height="20"><td colspan="9" class="STYLE2" align="left"><b>利 润 结 算</b></td></tr>
					<tr height="20" bgcolor="#FF6633">
					   <td colspan="2">订单利润</td>
					   <td colspan="7">订单毛利率</td>
					</tr>
					<tr height="20" bgcolor="#FFFFFF">
					   <td colspan="2"><%=round((total_gain-price_reduce)/total_cost,4)*100%>%</td>
					   <td colspan="7"><%=round((total_gain-price_reduce)/order_price,4)*100%>%</td>
					</tr>
			   <%
				 '关闭连接，释放进程
				 rs_return.close
				 %>
			   <%
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
