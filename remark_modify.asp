<!KDZ Studio Powered at 20080106">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：商品备注属性修改前台页面
  '         1、根据从adv_select_run.asp接收的值
  '            查询数据库，显示在页面中
  '更新DB：无
  '参照DB：stock
  '修改履历
  '修改年月日、责任者、内容
  '2008/01/06  sky@kdz 新增 商品添加备注属性
  '2008/01/13  sky@kdz 修改 显示商品备注信息
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>
<HTML>
<HEAD>
<TITLE>进销存系统——商品备注修改</TITLE>
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
  form1.remark.select(); 
}
function incheck(inform)
{
			return true;
}
</script>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim a4id,rs,sqltext
a4id = trim(request.queryString("a4id"))

 set rs=server.createobject("adodb.recordset")
	 sqltext = "select * "
	 sqltext = sqltext&" from stock where a4id = '"&a4id&"'"
	 'response.write sqltext
	 rs.open sqltext,conn,1,1

if rs.eof then
   response.redirect("messagebox.asp?msg=系统错误，请联系管理员")
   response.end
else

%>
</head>

<BODY onload="bodyini()">
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
				    <form id="form1" name="form1" method="post" onsubmit="return incheck(this)" action="remark_modify_run.asp">
					  <tr height="20">
					    <td width="50"></td>
					    <td width="100">
						商品名称
						</td>
						<td width="180"><%=rs("a4name")%><a href="name_modify.asp?a4id=<%=a4id%>"><img src="image\small_modify.gif" border="0"></a>
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						条形码
						</td>
						<td><%=rs("a4code")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						品牌
						</td>
						<td><%=rs("a4brand")%><a href="brand_modify.asp?a4id=<%=a4id%>"><img src="image\small_modify.gif" border="0"></a>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						存货数量
						</td>
						<td><%=rs("a4stock")%><a href="stock_modify.asp?a4id=<%=a4id%>"><img src="image\small_modify.gif" border="0"></a>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						最近买入价格
						</td>
						<td><%=rs("a4buy_price")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						普通会员价格
						</td>
						<td><%=rs("a4price_common")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						VIP价格
						</td>
						<td><%=rs("a4price_vip")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						批销价格
						</td>
						<td><%=rs("a4price_wholesale")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						备注
						</td>
						<td><input type="text" name="remark" maxlength="16" value="<%=rs("a4remark")%>">
						    <input type="hidden" name="id" value="<%=rs("a4id")%>">
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						修改时间
						</td>
						<td><%=kdztimeformat(rs("a4chgtime"),"2")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						修改人
						</td>
						<td><%=rs("a4chguser")%>
						</td>
					    <td></td>
					  </tr>
					   <tr>
						 <td colspan="4" height="30" align="center"><input type="submit" name="Submit" value="确 认 修 改 备 注" class="style_button">
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
<%
  rs.close
  conn.close
  set conn=nothing
end if
%>
</HTML>