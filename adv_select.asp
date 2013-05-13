<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：商品查询输入页面
  '更新DB：无
  '参照DB：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/22  sky@kdz 新增
  '2007/07/22  sky@kdz 修改 文字高级查询改为商品查询
  '2007/12/18  sky@kdz 修改 画面输入防止特殊字符的修改
  '2007/12/30  cg@kdz  修改 增加登入记录安全功能 包括conn
  '2008/01/01  cg@kdz  修改 增加tips功能
%>
<HTML>
<HEAD>
<TITLE>进销存系统——商品查询</TITLE>
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
<!--画面输入check-->
<script language="javascript" src="inc/jstrim.js">
</script>
<script language="javascript">
function bodyini()
{
  form1.a4name.focus(); 
}
function incheck(inform){
  if( isValidString(inform.a4name.value) == -1 )
  {
			alert ("输入商品名称不能有特殊字符");
			inform.a4name.focus();
			return false;
  }
  if( isValidString(inform.a4code.value) == -1 )
  {
			alert ("输入条形码不能有特殊字符");
			inform.a4code.focus();
			return false;
  }
  if( isValidString(inform.a4brand.value) == -1 )
  {
			alert ("输入品牌不能有特殊字符");
			inform.a4brand.focus();
			return false;
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

<BODY onload="bodyini()">
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
				    <table class="STYLE2" align="center">
				    <form id="form1" name="form1" method="post" onsubmit = "return incheck(this)" action="adv_select_run.asp">
					  <tr height="60">
					    <td width="50"></td>
					    <td width="100">
						商品名称
						</td>
						<td width="180">
						<input type="text" name="a4name" maxlength="20">
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr height="60">
					    <td width="50"></td>
					    <td width="100">
						品&nbsp;&nbsp;牌
						</td>
						<td width="180">
						<input type="text" name="a4brand" maxlength="20">
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr height="60">
					    <td width="50"></td>
					    <td width="100">
						条形码
						</td>
						<td width="180">
						<input type="text" name="a4code" maxlength="20">
						</td>
					    <td width="50"></td>
					  </tr>
					   <tr>
						 <td colspan="4" height="130" align="center"><input type="submit" name="Submit" value="商  品  查  询" style="BORDER-RIGHT: #62b0ff 1px solid; PADDING-RIGHT: 1px; BORDER-TOP: #bfdfff 1px solid; PADDING-LEFT: 1px; FONT-SIZE: 12px; PADDING-BOTTOM: 1px; BORDER-LEFT: #bfdfff 1px solid; COLOR: #085878; PADDING-TOP: 1px; BORDER-BOTTOM: #62b0ff 1px solid; FONT-FAMILY: Verdana, Arial, 宋体; HEIGHT: 30px; BACKGROUND-COLOR: #ddeeff">
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