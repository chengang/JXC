<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：品牌统计利润结果后台
  '更新DB：无
  '参照DB：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/12/28  sky@kdz 修改 分离商品利润统计和品牌利润统计
  '2008/01/01  cg@kdz  修改 增加tips功能
%>
<HTML>
<HEAD>
<TITLE>进销存系统——按品牌统计利润结果</TITLE>
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
dim username,power,uid,starttime,endtime,brand,goodname,rs_sold,rs_buy,sqltext,sqltext2
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid = kdzcookie("uid")
starttime = trim(request.form("startyear"))&trim(request.form("startmonth"))&trim(request.form("startday"))&"000000"
endtime = trim(request.form("endyear"))&trim(request.form("endmonth"))&trim(request.form("endday"))&"250000"
brand = trim(request.form("brand"))
goodname = trim(request.form("goodname"))

set rs= server.createobject("adodb.recordset")
sqltext = "select sum(a2amount*a2sold_price) as sales_volume,"
sqltext = sqltext&"sum(a2amount*a2buy_price) as buy_volume "
sqltext = sqltext&"from sold "
sqltext = sqltext&"where a2mflag = 0 and "
sqltext = sqltext&"a2crttime >= '"&starttime&"' and a2crttime <= '"&endtime&"'"
if brand <> "" then
sqltext = sqltext&" and a2brand = '"&brand&"'"
end if
if goodname <> "" then
sqltext = sqltext&" and a2name = '"&goodname&"'"
end if
'response.write sqltext
'response.end
rs.open sqltext,conn,1,1

dim sales_volume,buy_volume
if not IsNumeric(rs("sales_volume")) then
   sales_volume = 0
else
   sales_volume = rs("sales_volume")
end if

if not IsNumeric(rs("buy_volume")) then
   buy_volume = 0
else
   buy_volume = rs("buy_volume")
end if
'response.write sales_volume
'response.write ("<br>")
'response.write buy_volume
'response.write ("<br>")
'response.write 11111
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
		 <td width="380" valign="top">
		    <br>
		    <table align="center">
			  <tr>
			    <td>
				    <table class="style1" align="center" width="330"><tr><td>
					  <!--#include file="inc/marquee_tips.inc"-->
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2" align="center">
					<form id="form1" name="form1" method="post" action="">
					   <tr>
						 <td align="center"><br>
						 <span class="style2">利润统计——商品-品牌利润查询结果</span>
						 <br>
						 <span class="style1">起始时间:<%response.write kdztimeformat(starttime,"2")%></span><br>
						 <span class="style1">截至时间:<%response.write kdztimeformat(endtime,"2")%></span><br>
						 <span class="style1">品牌:<%if brand="" then response.write("所有") else response.write(brand) end if%></span><br>
						 <span class="style1">商品名称:<%if goodname="" then response.write("所有") else response.write(goodname) end if%></span><br><br><br>
						 <span class="style2">销售额:<b><%=sales_volume%></b>元</span><br><br>
						 <span class="style2">毛利润:<b><%=round((sales_volume-buy_volume),2)%></b>元</span><br><br>
						 <span class="style2">利润率:<b><%=round((sales_volume-buy_volume)/sales_volume,4)*100%>%</b></span><br><br>
						 <span class="style2">投资回报率:<b><%=round((sales_volume-buy_volume)/buy_volume,4)*100%>%</b></span><br><br><br>
						 <input type="button" onclick="javascript:window.history.go(-1)" value=" 返 回 " class="style_button">
						 </td>
					   </tr>
					</form>
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