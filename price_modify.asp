<!kdz studio powered at 20070619">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：1、批量修改品牌价格的前台
  '          2、JS验证 非空 数字 非负 大于0小于1
  '更新DB：无
  '参照DB：stock
  '处理页：price_modify.asp
  '修改履历
  '修改年月日、责任者、内容
  '2007/06/19  sky@kdz 新增 批量修改品牌价格的增加
  '2007/08/05  sky@kdz 修改 画面输入去空格的处理
  '2008/01/01  cg@kdz  修改 增加tips功能
%>
<html>
<head>
<title>进销存系统——批量修改品牌价格</title>
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
<!--画面输入check-->
<script language="javascript" src="inc/jstrim.js">
</script>
<script language="javascript">
function bodyini()
{
  form1.a4buy_price_rate.focus(); 
}
function incheck(inform){
  if (jstrim(inform.a4buy_price_rate.value) == "")
  {
            alert ("请输入进货价和市场价的比率！");
			inform.a4buy_price_rate.focus();
			return false;
  }
 if(isNaN(inform.a4buy_price_rate.value)) 
  { 
            alert("进货比率必须为的数字！");
            inform.a4buy_price_rate.focus(); 
            return false; 
   } 
  if ((inform.a4buy_price_rate.value <= 0) || (inform.a4buy_price_rate.value > 1))
  {
            alert ("进货比率必须为大于0小于1的数字！");
			inform.a4buy_price_rate.focus();
			return false;
  }
  if (jstrim(inform.a4price_common_rate.value) == "")
  {
            alert ("请输入普通价和市场价的比率！");
			inform.a4price_common_rate.focus();
			return false;
  }
 if(isNaN(inform.a4price_common_rate.value)) 
  { 
            alert("普通价比率必须为数字！");
            inform.a4price_common_rate.focus(); 
            return false; 
   } 
  if ((inform.a4price_common_rate.value <= 0) || (inform.a4price_common_rate.value > 1))
  {
            alert ("普通价比率必须为大于0小于1的数字");
			inform.a4price_common_rate.focus();
			return false;
  }
  if (jstrim(inform.a4price_vip_rate.value) == "")
  {
            alert ("请输入VIP价和市场价的比率！");
			inform.a4price_vip_rate.focus();
			return false;
  }
 if(isNaN(inform.a4price_vip_rate.value)) 
  { 
            alert("VIP价比率必须数字！");
            inform.a4price_vip_rate.focus(); 
            return false; 
   } 
  if ((inform.a4price_vip_rate.value <= 0) || (inform.a4price_vip_rate.value > 1))
  {
            alert ("VIP价比率为大于0小于1的数字！");
			inform.a4price_vip_rate.focus();
			return false;
  }
  if (jstrim(inform.a4price_wholesale_rate.value) == "")
  {
            alert ("请输入批销价和市场价的比率！");
			inform.a4price_wholesale_rate.focus();
			return false;
  }
 if(isNaN(inform.a4price_wholesale_rate.value)) 
  { 
            alert("批销价比率必须为数字！");
            inform.a4price_wholesale_rate.focus(); 
            return false; 
   } 
  if ((inform.a4price_wholesale_rate.value <= 0) || (inform.a4price_wholesale_rate.value > 1))
  {
            alert ("批销价比率大于0小于1的数字！");
			inform.a4price_wholesale_rate.focus();
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

<body onload="bodyini()">
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
					<form id="form1" name="form1" method="post" onsubmit = "return incheck(this)" action="price_modify_run.asp">
					  
					  <tr  height="40">
					    <td width="50"></td>
					    <td width="100">
						品牌
						</td>
						<td width="180">
						<%dim rs,recordcount
				       '在进货表中，查询全部的进货纪录情况
				          set rs=server.createobject("adodb.recordset")
					          sqltext = "select a4brand "
					          sqltext = sqltext&"from stock group by a4brand order by a4brand desc"
					          rs.open sqltext,conn,1,1
                              recordcount = rs.recordcount
					          
							  'response.write recordcount
					          'response.end
					    %>
						<select name="brand" style="width:150px;font-size:9pt;"  >
						 <%for i = 1 to recordcount%>
							<option><%=rs("a4brand")%></option>
						 <% rs.movenext
							next
						 %>
						  </select>
						  <%rs.close
						    set conn = nothing
						  %>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr  height="15">
					    <td width="50"></td>
					    <td width="100">
						</td>
						<td width="180">
						进货价和市场价的比率
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr  height="30">
					    <td width="50"></td>
					    <td width="100">
						进货价格
						</td>
						<td width="180">
						<input type="text" name="a4buy_price_rate" maxlength="20">
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr  height="15">
					    <td width="50"></td>
					    <td width="100">
						</td>
						<td width="180">
						普通价和市场价的比率
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr  height="30">
					    <td width="50"></td>
					    <td width="100">
						普通价格
						</td>
						<td width="180">
						<input type="text" name="a4price_common_rate" maxlength="20">
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr  height="15">
					    <td width="50"></td>
					    <td width="100">
						</td>
						<td width="180">
						VIP价和市场价的比率
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr  height="30">
					    <td width="50"></td>
					    <td width="100">
						VIP价格
						</td>
						<td width="180">
						<input type="text" name="a4price_vip_rate" maxlength="20">
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr  height="15">
					    <td width="50"></td>
					    <td width="100">
						</td>
						<td width="180">
						批销价和市场价的比率
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr  height="30">
					    <td width="50"></td>
					    <td width="100">
						批销价格
						</td>
						<td width="180">
						<input type="text" name="a4price_wholesale_rate" maxlength="20">
						</td>
					    <td width="50"></td>
					  </tr>
					   <tr>
						 <td colspan="4" height="50" align="center"><input type="submit" name="submit" value="修         改" class="style_button">
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
</body>
</html>