<!KDZ Studio Powered at 20070805">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：统计选择页
  '更新DB：无
  '参照DB：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/08/05  sky@kdz 新增
  '2007/12/13  sky@kdz 修改 添加库存基本信息
  '2007/12/14  sky@kdz 修改 删除单件商品功能增加
  '2008/01/01  cg@kdz  修改 增加tips功能
%>
<HTML>
<HEAD>
<TITLE>进销存系统——统计选择</TITLE>
<script language="javascript">
function openhere(i)
{
	switch (i)
	{
	case 1:
		window.open("statistics_stock_run.asp", "_self") ;
		break;
	case 2:
		window.open("statistics_profit.asp", "_self");
		break;
	case 3:
		window.open("statistics_flash.asp", "_self");
		break;
	case 4:
		window.open("statistics_brand.asp", "_self");
		break;
	case 5:
		 if(confirm("确认永久删除此商品？使用此功能前请联系管理员！"))
		  {window.open("admin_delete_commodity.asp", "_self");
		   break;}
			else 
		  {return   false;
		   break;}
	}
}
</script>
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
	     <td width="380">
		    <!--#include file="inc\left.inc"-->
		 </td>
		 <td width="380" valign="top">
		    <br>
		    <table>
			  <tr>
			    <td>
				    <table class="style1" align="center" width="330"><tr><td>
					  <!--#include file="inc/marquee_tips.inc"-->
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2" width="360" align="center">
					  <tr>
						 <td height="60" align="center"><input type="button" name="button1" onclick="openhere(1)" value="库 存 基 本 信 息" class="style_button">
						 </td>
					   </tr>
					  <tr>
						 <td height="60" align="center"><input type="button" name="button2" onclick="openhere(2)" value="利 润 统 计(文字)" class="style_button">
						 </td>
					   </tr>
					  <tr>
						 <td height="60" align="center"><input type="button" name="button2" onclick="openhere(3)" value="利 润 统 计(图形)" class="style_button"> <a href="statistics_graph.asp">old</a>
						 </td>
					   </tr>
					  <tr>
						 <td height="60" align="center"><input type="button" name="button2" onclick="openhere(4)" value="品 牌 库 存 统 计" class="style_button">
						 </td>
					   </tr>
					  <tr>
						 <td height="60" align="center"><input type="button" name="button3" onclick="openhere(5)" value="删 除 单 件 商 品" class="style_button">
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