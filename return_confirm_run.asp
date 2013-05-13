<!KDZ Studio Powered at 20081108">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：实现退货确认功能
  '          (1)更新库存表的数据
  '更新DB：returned,stock
  '参照DB：sold
  '修改履历
  '修改年月日、责任者、内容
  '2008/11/08  sky@kdz 新增 修改退货流程
  '2008/11/16  sky@kdz 修改 显示时间样式修改
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>

<HTML>
<HEAD>
<TITLE>进销存系统——退货确认</TITLE>
<meta http-equiv="refresh" content="10;url=return.asp">
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
	     <td width="380">
		    <!--#include file="inc/left.inc"-->
		 </td>
		 <td width="380" valign="center">
		    <table bgcolor="#CCCCCC">
				<%
				'取系统日期和时间为数值
				  dim datestr,timestr
				  datestr = int(Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)
				  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
				%>

				<!-- 退货 Begin-->
				<%
				  a3id = trim(request.querystring("a3id"))

			    dim rs_returned,returned_amount
					set rs_returned=server.createobject("adodb.recordset")
					sqltext1="select * from returned where a3mflag = 0 and a3status = 1 and a3id =" &a3id
					rs_returned.open sqltext1,conn,1,2
					
					if not rs_returned.eof then
					   amount = rs_returned("a3amount")
					   gid = rs_returned("a3gid")
					   buy_price = rs_returned("a3buy_price")
					   code = rs_returned("a3code")
					   name = rs_returned("a3name")
					   price = rs_returned("a3price")
						 chgtime = timestr
						 chguser = username
					else
					   response.redirect("messagebox_adv.asp?msg=操作有误，请确认后再操作&adv=3")
	           response.end
					end if

						'更新退货表
						rs_returned("a3chgtime") = chgtime
						rs_returned("a3chguser") = chguser
						rs_returned("a3confirmtime") = chgtime
						rs_returned("a3confirmuser") = chguser
						rs_returned("a3status") = 2
						rs_returned.update

						'更新库存表
						dim stock,diff
						set rs_stock=server.createobject("adodb.recordset")
						sqltext2="select * from stock where a4gid='"&gid&"'"
						rs_stock.open sqltext2,conn,1,2
                        
						stock = rs_stock("a4stock") + amount
						diff = rs_stock("a4diff") + amount

						rs_stock("a4stock") = stock
						rs_stock("a4total_money") = rs_stock("a4total_money") + (buy_price * amount)
						rs_stock("a4diff") = diff
						rs_stock("a4cflag") = 1
						rs_stock("a4chgtime") = chgtime
						rs_stock("a4chguser") = chguser
						rs_stock.update

                %>
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%username%> 你已退回此商品
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2">
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						条形码：
						</td>
						<td width="180">
						<%=code%>
						</td>
					    <td width="50"></td>
					  </tr>
					  
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						商品名称：
						</td>
						<td width="180">
						<%=name%>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						数量：
						</td>
						<td width="180">
						<%=amount%>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						价格：
						</td>
						<td width="180">
						<%=price%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						确认日期：
						</td>
						<td width="180">
						<%=kdztimeformat(timestr,"1")%>
						</td>
					    <td width="50"></td>
					  </tr>
					   <tr>
						 <td colspan="4" height="60" align="center" class="STYLE1">
						 <a href="return.asp">10秒后将自动返回退货页面</a>
						 </td>
					   </tr>
					</table>
			    </td>
			  </tr>
				<%
				    rs_returned.Close
				    rs_stock.Close
				conn.close
				set conn=nothing
				%>
				<!-- 售货 End-->
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
