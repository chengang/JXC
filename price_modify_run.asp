<!KDZ Studio Powered at 20070719">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：1、批量修改品牌价格的后台
  '更新DB：stock
  '参照DB：无
  '处理页：price_modify_run.asp
  '修改履历
  '修改年月日、责任者、内容
  '2007/06/19  sky@kdz 新增 批量修改品牌价格的增加
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<html>
<head>
<title>进销存系统——批量修改品牌价格</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #ffffff;
}
.style1 {font-size:9pt}
.style2 {font-size:10.5pt}
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
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

'取系统时间为数值
dim timestr
 timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

'从form中取值
dim brand,a4buy_price_rate,a4price_common_rat,a4price_vip_rat,a4price_wholesale_rat
	brand = trim(request.form("brand"))
	a4buy_price_rate = trim(request.form("a4buy_price_rate"))
	a4price_common_rate = trim(request.form("a4price_common_rate"))
	a4price_vip_rate = trim(request.form("a4price_vip_rate"))
	a4price_wholesale_rate = trim(request.form("a4price_wholesale_rate"))
	chguser = username

  'response.write brand
	'response.write("<br>")
  'response.write a4buy_price_rate
	'response.write("<br>")
  'response.write a4price_common_rate
	'response.write("<br>")
  'response.write a4price_vip_rate
	'response.write("<br>")
  'response.write a4price_wholesale_rate
	'response.write("<br>")
	'response.end

	if int(a4buy_price_rate) >  int(a4price_wholesale_rate) then
     response.redirect("messagebox.asp?msg=买入价格不能大于批销价格")
	   response.end
	end if
	if int(a4price_wholesale_rate) >  int(a4price_vip_rate) then
     response.redirect("messagebox.asp?msg=批销价格不能大于VIP价格")
	   response.end
	end if
	if int(a4price_vip_rate) >  int(a4price_common_rate) then
     response.redirect("messagebox.asp?msg=VIP价格不能大于普通会员价格")
	   response.end
	end if
  'response.write 1111
	'response.write("<br>")
	'response.end

   dim rs
   '在库存表中，根据品牌查询
   set rs=server.createobject("adodb.recordset")
     sqltext = "select * "
	   sqltext = sqltext&"from stock where a4brand = '"&brand&"'"
	   'response.write sqltext
	   'response.end
	   rs.open sqltext,conn,1,2
	   rs.movefirst
	   '如果查询到记录,则显示在页面上
	   while not rs.eof
	      rs("a4price_common")=round(rs("a4buy_price")*a4price_common_rate/a4buy_price_rate,0)
	      rs("a4price_vip")=round(rs("a4buy_price")*a4price_vip_rate/a4buy_price_rate,0)
	      rs("a4price_wholesale")=round(rs("a4buy_price")*a4price_wholesale_rate/a4buy_price_rate,0)
		  rs("a4chgtime") = timestr
		  rs("a4chguser") = chguser
      rs.update
		  rs.movenext
	   wend
     rs.close
	   set conn = nothing
%>
</head>

<body>
<table width="762" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
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
	<table width="760" cellpadding="0" cellspacing="0" style="border-right:#ff0000 6px solid;border-top:#ff0000 6px solid;border-bottom:#ff0000 6px solid;border-left:#ff0000 6px solid;">
	   <tr>
	     <td width="380">
		   <!--#include file="inc/left.inc"-->
		 </td>
		 <td width="380" valign="top">
		    <br>
		    <table bgcolor="#CCCCCC">
			  <tr>
			    <td>
				    <table class="style1" align="center"><tr><td>
					   <%=username%> 价格已经修改成功
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="style2">
					  
					  <tr  height="40">
					    <td width="50"></td>
					    <td width="100">
						品牌
						</td>
						<td width="180">
						<%response.write(brand)%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr  height="15">
					    <td width="50"></td>
					    <td width="100">
						</td>
						<td width="180">
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr  height="30">
					    <td width="50"></td>
					    <td width="100">
						进货价格
						</td>
						<td width="180">
						<%response.write(a4buy_price_rate)%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr  height="15">
					    <td width="50"></td>
					    <td width="100">
						</td>
						<td width="180">
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr  height="30">
					    <td width="50"></td>
					    <td width="100">
						普通价格
						</td>
						<td width="180">
						<%response.write(a4price_common_rate)%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr  height="15">
					    <td width="50"></td>
					    <td width="100">
						</td>
						<td width="180">
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr  height="30">
					    <td width="50"></td>
					    <td width="100">
						VIP价格
						</td>
						<td width="180">
						<%response.write(a4price_vip_rate)%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr  height="15">
					    <td width="50"></td>
					    <td width="100">
						</td>
						<td width="180">
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr  height="30">
					    <td width="50"></td>
					    <td width="100">
						批销价格
						</td>
						<td width="180">
						<%response.write(a4price_wholesale_rate)%>
						</td>
					    <td width="50"></td>
					  </tr><tr>
						 <td colspan="4" height="60" align="center" class="STYLE1">
						 <a href="price_modify.asp">点击这里返回批量修改品牌价格页面</a>
						 </td>
					   </tr>
					</table>
			    </td>
			  </tr>
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
</body>
</html>
