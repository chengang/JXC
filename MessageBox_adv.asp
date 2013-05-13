<!kdz studio powered at 20071107">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<%'机能说明：信息提示
  '更新DB：无
  '参照DB：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/11/07  sky@kdz 新增 退货bug修改新增
  '2007/12/14  sky@kdz 修改 删除单件商品功能增加
%>
<html>
<head>
<title>进销存系统——信息提示</title>
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
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim msg,adv
msg = Request.QueryString("msg")
adv = trim(Request.QueryString("adv"))
'response.write msg
'response.write adv
'response.end

select case adv
       case 1
            redirect_address = "buy.asp"
       case 2
            redirect_address = "sell.asp"
       case 3
            redirect_address = "return.asp"
       case 4
            redirect_address = "seat.asp"
       case 5
            redirect_address = "admin_delete_commodity.asp"
end select
%>
</head>
<body>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
    <tr>
	  <td align="center"><img src="image/logo.gif"></td>
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
	  <td>
	    <table width="760" cellpadding="0" cellspacing="0" style="BORDER-RIGHT:#FF0000 6px solid;BORDER-TOP:#FF0000 6px solid;BORDER-BOTTOM:#FF0000 6px solid;BORDER-LEFT:#FF0000 6px solid;">
		   <form id="form1" name="form1" method="post" action="<%=redirect_address%>">
			<tr height="80">
			  <td align="center"><span class="STYLE2"><font color="red"><%=username%>出错了,原因是:</font></span></td>
			</tr>
			<tr height="200">
			  <td valign="center" align="center"><span class="STYLE1"><%=msg%></span></td>
			</tr>
			<tr height="80">
			 <td align="center"><br><input type="submit" class="style_button" value=" 返  回 " name="Submit2"></td>
			</tr>
			</form>
	    </table>
	  </td>
	</tr>
    <tr>
	  <td><img src="image/logo.gif"></td>
	</tr>
</table>
</body>
</html>

