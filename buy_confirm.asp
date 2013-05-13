<!kdz studio powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：1、买入模块的前台
  '          2、JS验证 条形码         非空
  '			           商品名称       非空
  '			           品牌           非空
  '			           数量           非空、数字
  '			           仓位           非空
  '			           买入价格       非空、数字
  '			           普通会员价格   非空、数字  
  '			           vip会员价格    非空、数字
  '			           批销价格       非空、数字
  '更新DB：无
  '参照DB：seat,buy
  '处理页：buy_run.asp
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/23  sky@kdz 新增
  '2007/07/21  sky@kdz 修改 取消仓位输入长度的限制
  '2007/08/05  sky@kdz 修改 画面输入去空格的处理
  '2007/08/22  sky@kdz 修改 进货时仓位弄成下来列表
  '2007/12/18  sky@kdz 修改 画面输入防止特殊字符的修改
  '2008/01/01  cg@kdz  修改 增加tips功能
  '2008/12/28  sky@kdz 修改 增加赠品功能
%>
<html>
<head>
<title>进销存系统——进货</title>
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
  form1.a1name.focus(); 
}
function incheck(inform){
  if (jstrim(inform.a1name.value) == "")
  {
            alert ("请输入商品名称！");
			inform.a1name.focus();
			return false;
  }
  if( isValidString(inform.a1name.value) == -1 )
  {
			alert ("输入商品名称不能有特殊字符");
			inform.a1name.focus();
			return false;
  }
  if (jstrim(inform.a1brand.value) == "")
  {
            alert ("请输入商品品牌！");
			inform.a1brand.focus();
			return false;
  }
  if( isValidString(inform.a1brand.value) == -1 )
  {
			alert ("输入输入商品品牌不能有特殊字符");
			inform.a1brand.focus();
			return false;
  }
  if (jstrim(inform.a1amount.value) == "")
  {
            alert ("请输入进货数量！");
			inform.a1amount.focus();
			return false;
  }
 if(isNaN(inform.a1amount.value)) 
  { 
            alert("进货数量必须为数字！");
            inform.a1amount.focus(); 
            return false; 
   } 
  if (inform.a1amount.value < 0)
  {
            alert ("数量不能为负值！");
			inform.a1amount.focus();
			return false;
  }
  if (jstrim(inform.a1seat.value) == "")
  {
            alert ("请输入仓位！");
			inform.a1seat.focus();
			return false;
  }
  if( isValidString(inform.a1seat.value) == -1 )
  {
      alert ("输入仓位不能有特殊字符");
	    inform.a1seat.focus();
	    return false;
  }
  if (jstrim(inform.a1buy_price.value) == "")
  {
      alert ("请输入买入价格！");
			inform.a1buy_price.focus();
			return false;
  }
 if(isNaN(inform.a1buy_price.value)) 
  { 
            alert("价格必须为数字！");
            inform.a1buy_price.focus(); 
            return false; 
   } 
  if (inform.a1buy_price.value < 0)
  {
            alert ("价格不能为负值！");
			inform.a1buy_price.focus();
			return false;
  }
if (inform.gifts.checked == false )
{
  if (jstrim(inform.a1price_common.value) == "")
  {
            alert ("请输入普通会员价格！");
			inform.a1price_common.focus();
			return false;
  }
 if(isNaN(inform.a1price_common.value)) 
  { 
            alert("价格必须为数字！");
            inform.a1price_common.focus(); 
            return false; 
   } 
  if (inform.a1price_common.value < 0)
  {
            alert ("价格不能为负值！");
			inform.a1price_common.focus();
			return false;
  }
  if (jstrim(inform.a1price_vip.value) == "")
  {
            alert ("请输入vip价格！");
			inform.a1price_vip.focus();
			return false;
  }
 if(isNaN(inform.a1price_vip.value)) 
  { 
            alert("价格必须为数字！");
            inform.a1price_vip.focus(); 
            return false; 
   } 
  if (inform.a1price_vip.value < 0)
  {
            alert ("价格不能为负值！");
			inform.a1price_vip.focus();
			return false;
  }
  if (jstrim(inform.a1price_wholesale.value) == "")
  {
            alert ("请输入批销价格！");
			inform.a1price_wholesale.focus();
			return false;
  }
 if(isNaN(inform.a1price_wholesale.value)) 
  { 
            alert("价格必须为数字！");
            inform.a1price_wholesale.focus(); 
            return false; 
   } 
  if (inform.a1price_wholesale.value < 0)
  {
            alert ("价格不能为负值！");
			inform.a1price_wholesale.focus();
			return false;
  }
}
}
</script>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

'从form中取值
dim gid,a1code
code = trim(request.form("a1code"))
gid = trim(request.form("a4gid"))
'response.write gid
'查询进货表中是否有该商品的进货记录
dim rs_buy
set rs_buy = server.createobject("adodb.recordset")
	sqltext = "select top 1 * "
	sqltext = sqltext&"from buy "
	sqltext = sqltext&"where a1gid='"&gid&"' "
	sqltext = sqltext&"order by a1crttime desc"
	rs_buy.open sqltext,conn,1,1
    
	dim name,brand,seat,buy_price
	dim price_common,price_vip,price_wholesale
	if not rs_buy.eof then
	   name = rs_buy("a1name")
       brand = rs_buy("a1brand")
       seat = rs_buy("a1seat")
       buy_price = rs_buy("a1buy_price")
       price_common = rs_buy("a1price_common")
       price_vip = rs_buy("a1price_vip")
       price_wholesale = rs_buy("a1price_wholesale")
  end if

'在仓位表中查询所有的仓位
dim rs_seat,sqltext_seat
set rs_seat=server.createobject("adodb.recordset")
    sqltext_seat = "select distinct a10seat,sum(a10amount) as seat_amount "
	  sqltext_seat = sqltext_seat&"from seat "
	  sqltext_seat = sqltext_seat&"group by a10seat order by a10seat"
	  'response.write sqltext_seat
	  'response.end
	  rs_seat.open sqltext_seat,conn,1,1

%>
</head>

<body onload="bodyini()">
<table width="762" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
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
					<form id="form1" name="form1" method="post" onsubmit = "return incheck(this)" action="buy_run.asp">
				    <input name="frompage" type="hidden" value="add">
					  
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">条形码</td>
						  <td width="180"><font color="#666666"><% response.write(code) %></font>
						  <input type="hidden" name="a1code" value="<%=code%>"></td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">商品名称</td>
						  <td width="180">
						  <%if gid="" then%><input type="text" name="a1name" maxlength="20">
						  <%else response.write name%>
						  <input type="hidden" name="a1name" value="<%=name%>">
						  <input type="hidden" name="a1gid" value="<%=gid%>">
						  <%end if%></td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">品牌</td>
						  <td width="180">
						  <%if gid="" then%><input type="text" name="a1brand" maxlength="10">
						  <%else response.write brand%>
						  <input type="hidden" name="a1brand" value="<%=brand%>">
						  <%end if%></td>
					    <td width="50"></td>
					   </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">数量</td>
						  <td width="180"><input type="text" name="a1amount" maxlength="6"></td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">仓位</td>
						  <td width="180">
						  <select name="a1seat" style="width:150px;font-size:9pt;">
					    <%
						   rs_seat.movefirst
						   while not rs_seat.eof
						   if rs_seat("a10seat")=seat then%>
							 <option value="<%=rs_seat("a10seat")%>" selected="selected"><%=rs_seat("a10seat")%></option>
						   <%else%>
							 <option value="<%=rs_seat("a10seat")%>"><%=rs_seat("a10seat")%></option>
						   <%end if%>
						  <%
						   rs_seat.movenext
						   wend%>
					    </select></td>
					    <td width="50"></td>
					   </tr>
					 
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">买入价格</td>
						  <td width="180"><input type="text" name="a1buy_price" maxlength="10" value="<%=buy_price%>"></td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">普通会员价格</td>
						  <td width="180"><input type="text" name="a1price_common" maxlength="10" value="<%=price_common%>"></td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">vip会员价格</td>
						  <td width="180"><input type="text" name="a1price_vip" maxlength="10" value="<%=price_vip%>"></td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">批销价格</td>
						  <td width="180"><input type="text" name="a1price_wholesale" maxlength="10" value="<%=price_wholesale%>"></td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">赠品</td>
						  <td width="180"><input type="checkbox" name="gifts" value="1" <% if gid<>"" and int(price_common) = 0 then response.write "checked" end if %> ></td>
					    <td width="50"></td>
					  </tr>

					   <tr>
						 <td colspan="4" height="60" align="center"><input type="submit" name="submit" value="录 入 新 商 品" class="style_button">
						 </td>
					   </tr>
					   <%
	             rs_buy.close
	             rs_seat.close
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