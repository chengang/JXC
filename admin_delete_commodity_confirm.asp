<!kdz studio powered at 20071214">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<%'机能说明：删除单件商品确认
  '更新DB：无
  '参照DB：stock
  '修改履历
  '修改年月日、责任者、内容
  '2007/12/14  sky@kdz 新增 删除单件商品功能增加
  '2008/01/01  cg@kdz  修改 增加tips功能
%>
<!--#include file="inc/conn.asp"-->
<html>
<head>
<title>进销存系统——删除单件商品确认</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #ffffff;
}
.style1 {font-size:9pt}
.style2 {font-size:10.5pt}
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
function checkform(inform)
{
 if(confirm("确认永久删除此商品？此操作会彻底删除数据！这将是一个不可恢复的操作！！！"))
  {return   true;}
    else 
  {return   false;}  
}
</script>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

'从form中取值
dim gid,code,reason
code = trim(request.form("code"))
reason = trim(request.form("reason"))
gid = trim(request.form("gid"))
'response.write gid
'查询库存表中查询此商品的信息

dim rs_stock,sqltext
set rs_stock=server.createobject("adodb.recordset")
    sqltext = "select * "
    sqltext = sqltext&" from stock where a4gid = '"&gid&"'"
    'response.write sqltext
    rs_stock.open sqltext,conn,1,1

%>
</head>

<body>
<table width="762" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
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
	<table width="760" cellpadding="0" cellspacing="0" style="border-right:#ff0000 6px solid;border-top:#ff0000 6px solid;border-bottom:#ff0000 6px solid;border-left:#ff0000 6px solid;">
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
				    <table class="style2" align="center">
					<form id="form1" name="form1" method="post" onsubmit = "return checkform(this)" action="admin_delete_commodity_run.asp">
					  
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						条形码
						</td>
						<td width="180"><font color="#666666"><%=code%></font>
						<input type="hidden" name="gid" value="<%=gid%>">
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						商品名称
						</td>
						<td width="180"><font color="#666666"><%=rs_stock("a4name")%></font>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						品牌
						</td>
						<td width="180"><font color="#666666"><%=rs_stock("a4brand")%></font>
						</td>
					    <td width="50"></td>
					   </tr>

					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						数量
						</td>
						<td width="180"><font color="#666666"><%=rs_stock("a4stock")%></font>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						删除原因
						</td>
						<td width="180"><font color="#666666"><%=reason%></font>
						<input type="hidden" name="reason" value="<%=reason%>">
						</td>
					    <td width="50"></td>
					  </tr>

					   <tr>
						 <td colspan="4" height="60" align="center"><input type="submit" name="submit" value="确 认 删 除 此 商 品" class="style_button">
						 </td>
					   </tr>
					   <%
	                     rs_stock.close
	                     set conn=nothing
					   %>
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
</body>
</html>