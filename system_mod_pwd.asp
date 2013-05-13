<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：1、修改密码的表单页
  '          2、JS验证 旧密码         非空
  '			           新密码         非空
  '			           确认密码       非空
  '			           确认密码 = 新密码
  '更新DB：无
  '参照DB：无
  '处理页：system_mod_pwd_run.asp
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/17  cg@kdz  新增
  '2007/12/18  sky@kdz 修改 画面输入防止特殊字符的修改
  '2008/01/01  cg@kdz  修改 增加tips功能
%>
<HTML>
<HEAD>
<TITLE>进销存系统——系统</TITLE>
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
<!--画面输入check-->
<script language="javascript" src="inc/jstrim.js">
</script>
<script language="javascript">
function bodyini()
{
  form1.a5pwd_old.focus(); 
}
function incheck(inform){
  if (jstrim(inform.a5pwd_old.value) == "")
  {
            alert ("请输入旧密码！");
			inform.a5pwd_old.focus();
			return false;
  }
  if( isValidString(inform.a5pwd_old.value) == -1 )
  {
            alert ("输入旧密码不能有特殊字符");
	        inform.a5pwd_old.focus();
	        return false;
  }
  if (jstrim(inform.a5pwd_new.value) == "")
  {
            alert ("请输入新密码！");
			inform.a5pwd_new.focus();
			return false;
  }
  if( isValidString(inform.a5pwd_new.value) == -1 )
  {
            alert ("输入新密码不能有特殊字符");
	        inform.a5pwd_new.focus();
	        return false;
  }
  if (jstrim(inform.a5pwd_confirm.value) == "")
  {
            alert ("请输入确认密码！");
			inform.a5pwd_confirm.focus();
			return false;
  }
  if( isValidString(inform.a5pwd_confirm.value) == -1 )
  {
            alert ("输入确认密码不能有特殊字符");
	        inform.a5pwd_confirm.focus();
	        return false;
  }
  if (jstrim(inform.a5pwd_new.value) != jstrim(inform.a5pwd_confirm.value))
  {
            alert ("确认密码应和新密码相同！");
			inform.a5pwd_confirm.focus();
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
					<form id="form1" name="form1" method="post" onsubmit="return incheck(this)" action="system_mod_pwd_run.asp">
					   <tr height="220" valign="center">
						 <td align="center">
						 &nbsp;&nbsp;旧密码&nbsp;<input type="password" name="a5pwd_old" onfocus="this.select();"><br><br>
						 &nbsp;&nbsp;新密码&nbsp;<input type="password" name="a5pwd_new" onfocus="this.select();"><br><br>
						 确认密码&nbsp;<input type="password" name="a5pwd_confirm" onfocus="this.select();"><br><br><br>
						 <input type="submit" name="submit"  value=" 确 认 修 改 " class="style_button">
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