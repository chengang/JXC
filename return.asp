<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：退货前台页面
  '更新DB：无
  '参照DB：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/08/05  sky@kdz 修改 画面输入去空格的处理
  '2007/11/07  sky@kdz 修改 退货bug修改
  '2007/12/18  sky@kdz 修改 画面输入防止特殊字符的修改
  '2008/01/01  cg@kdz  修改 增加tips功能
  '2008/11/08  sky@kdz 修改 修改退货流程
%>
<HTML>
<HEAD>
<TITLE>进销存系统——退货</TITLE>
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
  form1.a3oid.focus(); 
}
function incheck(inform){
  if (jstrim(inform.a3amount.value) == "")
  {
            alert ("请输入退货数量！");
			inform.a3amount.focus();
			return false;
  }
 if(isNaN(inform.a3amount.value)) 
  { 
            alert("退货数量必须为数字！");
            inform.a3amount.focus(); 
            return false; 
   } 
  if (inform.a3amount.value < 0)
  {
            alert ("数量不能为负值！");
			inform.a3amount.focus();
			return false;
  }
  if (jstrim(inform.a3oid.value) == "")
  {
            alert ("请输入定单号！");
			inform.a3oid.focus();
			return false;
  }
  if( isValidString(inform.a3oid.value) == -1 )
  {
            alert ("输入定单号不能有特殊字符");
	        inform.a3oid.focus();
	        return false;
  }
  if (jstrim(inform.a3code.value) == "")
  {
            alert ("请输入条形码！");
			inform.a3code.focus();
			return false;
  }
  if( isValidString(inform.a3code.value) == -1 )
  {
            alert ("输入条形码不能有特殊字符");
	        inform.a3code.focus();
	        return false;
  }
  var flag = false;
  for(var N=0;N<inform.a3reason.length; N++){
     if (inform.a3reason[N].checked == true ){
	    flag = true;
	 }
  }
  if( flag == false ){
      alert ("请选择退货原因！");
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
				    <form id="form1" name="form1" method="post" onsubmit="return incheck(this)" action="return_code_to_gid.asp">
				    <input name="FromPage" type="hidden" value="return">
					  <tr height="40">
					    <td width="50"></td>
					    <td width="100">
						退货数量
						</td>
						<td width="180">
						<input type="text" name="a3amount" maxlength="20" value="1">
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr height="40">
					    <td width="50"></td>
					    <td width="100">
						定单号
						</td>
						<td width="180">
						<input type="text" name="a3oid" maxlength="20"  value="<%=a3oid%>">
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr height="40">
					    <td width="50"></td>
					    <td width="100">
						条形码
						</td>
						<td width="180">
						<input type="text" name="a3code" maxlength="20" value="<%=a3code%>">
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr height="40">
					    <td width="50"></td>
					    <td width="100">
						退货原因
						</td>
						<td width="180">
						<input type="radio" name="a3reason" value = "换货">换货&nbsp;<input type="radio" name="a3reason" value = "不满意退货">不满意退货
						</td>
					    <td width="50"></td>
					  </tr>
					   <tr height="60">
						 <td colspan="4" align="center"><input type="submit" name="Submit" value="申 请 退 货" class="style_button">
						 </td>
					   </tr>
			        </form>
			        
					   <tr height="60">
						 <td colspan="4" align="center"><input type="button" onclick="javascript:window.open('return_confirm.asp', '_self')"  value="确 认 退 货" class="style_button">
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