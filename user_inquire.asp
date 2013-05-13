<!KDZ Studio Powered at 20070702">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：普通用户查询选择页面
  '更新DB：无
  '参照DB：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/07/02  sky@kdz 新增
  '2007/07/22  sky@kdz 修改 文字高级查询改为商品查询
  '2007/12/13  sky@kdz 修改 调整栏目分类
  '2007/12/30  cg@kdz  修改 增加登入记录安全功能 包括conn
  '2008/01/01  cg@kdz  修改 增加tips功能
  '2008/06/25  sky@kdz 修改 增加按时间查询功能
  '2008/09/27  cg@kdz  修改 增加查询品牌进货清单功能
  '2008/12/28  sky@kdz 修改 增加赠品查询功能
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
window.open("inquire_today.asp", "_self");
break;
case 2:
window.open("inquire_select.asp", "_self") ;
break;
case 3:
window.open("inquire_orderbook_select.asp", "_self") ;
break;
case 4:
window.open("adv_select.asp", "_self") ;
break;
case 5:
window.open("inquire_date_select.asp", "_self") ;
break;
case 6:
window.open("buy_brand_select.asp", "_self") ;
break;
case 7:
window.open("statistics_commodity.asp", "_self") ;
break;
case 8:
window.open("gifts_select.asp", "_self") ;
break;
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
				    <input name="FromPage" type="hidden" value="inquire">
					   <tr>
						 <td height="35" align="center"><input type="button" name="button1" onclick="openhere(1)" value="今  日  查  询" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button2" onclick="openhere(2)" value="全  部  查  询" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button3" onclick="openhere(3)" value="订  单  查  询" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button4" onclick="openhere(4)" value="商  品  查  询" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button5" onclick="openhere(5)" value="按 时 间 查 询" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button6" onclick="openhere(6)" value="品牌进货清单查询" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button7" onclick="openhere(7)" value="商 品 流 量 查 询" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button8" onclick="openhere(8)" value="赠  品  查  询" class="style_button">
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
</BODY>
</HTML>