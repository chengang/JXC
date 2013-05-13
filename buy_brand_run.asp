<!KDZ Studio Powered at 20070329">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<%response.Expires = 0%>
<!--#include file="inc/conn.asp"-->
<%'机能说明：1、添加品牌商品清单到表里，并显示输入数据
  '更新DB：jxc_buy_brand
  '参照DB：jxc_buy_brand
  '修改履历
  '修改年月日、责任者、内容
  '2008/09/27  cg@kdz  创建
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<HTML>
<HEAD>
<TITLE>进销存系统——品牌进货清单确认</TITLE>
<meta http-equiv="refresh" content="10;url=buy.asp">
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
	brand = trim(request.form("a17brand"))
	money = trim(request.form("a17money"))
	remark = trim(request.form("a17remark"))
	crtuser = username
%>
</HEAD>

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
				'取系统时间为数值
				  dim timestr
					  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
				%>
				<!-- 输入品牌进货清单 Begin-->
				<%
        set rs_buy_brand = server.createobject("adodb.recordset")
        sqltext = "select top 1 * from jxc_buy_brand "
        rs_buy_brand.open sqltext,conn,1,2
        rs_buy_brand.Addnew
        rs_buy_brand("a17brand")=brand
        rs_buy_brand("a17money")=money
        rs_buy_brand("a17remark")=remark
        rs_buy_brand("a17crttime")=int(timestr)
        rs_buy_brand("a17crtuser")=crtuser
        rs_buy_brand.Update
        rs_buy_brand.Close
				%>
				<!-- 输入品牌进货清单 End-->
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%=username%> 你已录入此品牌商品清单
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2">
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						品牌：
						</td>
						<td width="180">
						<%=brand%>
						</td>
					    <td width="50"></td>
					  </tr>
					  
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						金额：
						</td>
						<td width="180">
						<%=money%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						备注：
						</td>
						<td width="180">
						<%=remark%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						录入日期：
						</td>
						<td width="180">
						<%=kdztimeformat(timestr,"1")%>
						</td>
					    <td width="50"></td>
					  </tr>
					   <tr>
						 <td colspan="4" height="60" align="center" class="STYLE1">
						 <a href="buy.asp">10秒后将自动返回录入页面</a>
						 </td>
					   </tr>
				  <%
					  set conn=nothing
				  %>
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
</BODY>
</HTML>
