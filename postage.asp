<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：邮费前台页面
  '更新DB：无
  '参照DB：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/08/05  sky@kdz 修改 画面输入去空格的处理
  '2007/12/30  cg@kdz  修改 增加登入记录安全功能 包括conn
  '2008/01/01  cg@kdz  修改 增加tips功能
%>
<%
'取系统日期为数值
  dim datestr,yearmonth
  datestr = int(Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)
  yearmonth = int(Year(now))&right("0"&CStr(Month(now)),2)
%>

<HTML>
<HEAD>
<TITLE>进销存系统——邮费</TITLE>
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
</style><!--画面输入check-->
<script language="javascript" src="inc/jstrim.js">
</script>
<script language="javascript">
function bodyini()
{
  form1.a8postage.focus(); 
}
function incheck(inform){
  if (jstrim(inform.a8postage.value) == "")
  {
            alert ("请输入邮费！");
			inform.a8postage.focus();
			return false;
  }
 if(isNaN(inform.a8postage.value)) 
  { 
            alert("邮费金额必须为数字！");
            inform.a8postage.focus(); 
            return false; 
   } 
  if (inform.a8postage.value < 0)
  {
            alert ("邮费不能为负值！");
			inform.a8postage.focus();
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
					<form id="form1" name="form1" method="post" onsubmit = "return incheck(this)" action="postage_run.asp">
				    <input name="FromPage" type="hidden" value="postage">
					  <tr>
					    <td width="50" height="160"></td>
					    <td width="100">
						日期
						</td>
						<td width="180">
						  <select name="yearstr" style="width:65px">
							<option>2007</option>
							<option>2008</option>
							<option>2009</option>
							<option>2010</option>
							<option>2011</option>
							<option>2012</option>
							<option>2013</option>
							<option>2014</option>
							<option>2015</option>
							<option>2016</option>
						  </select>年
						  <select name="monthstr" style="width:65px">
							<option>01</option>
							<option>02</option>
							<option>03</option>
							<option>04</option>
							<option>05</option>
							<option>06</option>
							<option>07</option>
							<option>08</option>
							<option>09</option>
							<option>10</option>
							<option>11</option>
							<option>12</option>
						  </select>月
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr>
					    <td width="50"></td>
					    <td width="100">
						邮费
						</td>
						<td width="180">
						<input type="text" name="a8postage" maxlength="6">元
						</td>
					    <td width="50"></td>
					  </tr>
					   <tr>
						 <td colspan="4" height="130" align="center"><input type="submit" name="Submit" value="录 入 邮 费" class="style_button">
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