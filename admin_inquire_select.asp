<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：查询页面
  '更新DB：无
  '参照DB：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/06/03  sky@kdz 修改 查询显示字不正确的修改
  '2007/07/02  sky@kdz 修改 高级查询的删除
  '2007/12/30  cg@kdz  修改 增加登入记录安全功能 包括conn
  '2008/01/01  cg@kdz  修改 增加tips功能
%>
<HTML>
<HEAD>
<TITLE>进销存系统——查询</TITLE>
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
<script language="javascript">
function openhere(i)
{
switch (i)
{
case 1:
window.open("admin_buy_select.asp", "_self");
break;
case 2:
window.open("admin_sell_select.asp", "_self") ;
break;
case 3:
window.open("admin_return_select.asp", "_self") ;
break;
case 4:
window.open("admin_postage_select.asp", "_self") ;
break;
/*case 5:
window.open("adv_select.asp", "_self") ;
break;*/
}
}
</script>
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
				    <input name="FromPage" type="hidden" value="inquire">
					   <tr>
						 <td height="60" align="center"><input type="button" name="button1" onclick="openhere(1)" value="全  部  进  货  记  录" class="style_button">
						 </td>
					   </tr>
					</form>
					<form id="form2" name="form2" method="post" action="">
				    <input name="FromPage" type="hidden" value="inquire">
					   <tr>
						 <td height="60" align="center"><input type="button" name="button2" onclick="openhere(2)" value="全  部  售  货  记  录" class="style_button">
						 </td>
					   </tr>
					</form>
					<form id="form3" name="form3" method="post" action="">
				    <input name="FromPage" type="hidden" value="inquire">
					   <tr>
						 <td height="60" align="center"><input type="button" name="button3" onclick="openhere(3)" value="全  部  退  货  记  录" class="style_button">
						 </td>
					   </tr>
					</form>
					<form id="form4" name="form4" method="post" action="">
				    <input name="FromPage" type="hidden" value="inquire">
					   <tr>
						 <td height="60" align="center"><input type="button" name="button4" onclick="openhere(4)" value="全  部  邮  费  记  录" class="style_button">
						 </td>
					   </tr>
					</form>
					<!--<form id="form5" name="form5" method="post" action="">
				    <input name="FromPage" type="hidden" value="inquire">
					   <tr>
						 <td height="60" align="center"><input type="button" name="button5" onclick="openhere(5)" value=" 高    级    查    询 " class="style_button">
						 </td>
					   </tr>
					</form>-->
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