<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：卖出商品页面2——加入商品
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/12  cg@kdz  新增
  '2007/05/12  sky@kdz 修改 唯一gid的返回
  '2007/06/05  cg@kdz  修改 优惠金额可以为负值
  '2007/06/07  cg@kdz  新增 验证优惠价格不能大于或等于商品总价
  '2007/06/07  cg@kdz  新增 确认提交时显示扣除优惠后的价格小计
  '2007/07/01  sky@kdz 修改 售货时加入邮费的修改
  '2007/08/05  sky@kdz 修改 画面输入去空格的处理
  '2007/12/18  sky@kdz 修改 画面输入防止特殊字符的修改
  '2007/12/30  cg@kdz  修改 增加登入记录安全功能 包括conn
  '2008/12/28  cg@kdz  修改 添加赠品引起js修改 优惠金额可以等于商品总价

  dim pr,gid,goodslist,rs,sqltext,len_goodlist
'======================================================
'修改 唯一gid的返回开始 sky 2007/05/24
'======================================================
  pr = request.queryString("pr")
  'a2code = request.form("a2code")
  'goodslist = request.form("goodslist")
  'goodslist = goodslist&"'"&a2code&"',"
  gid = request.form("a4gid")
  goodslist = request.form("goodslist")
  goodslist = goodslist&",'"&gid&"'," 
  
  len_goodlist = len(goodslist)
  'response.write len_goodlist
  'response.write ("<br>")
  if left(goodslist,1) = "," then
     goodslist = right(goodslist,len_goodlist-1)
  end if

  len_goodlist = len(goodslist)
  'response.write len_goodlist
  'response.write ("<br>")
  if right(goodslist,1) = "," then
     goodslist = left(goodslist,len_goodlist-1)
  end if
  'response.write goodslist
  'response.write ("<br>")
'======================================================
'修改 唯一gid的返回结束 sky 2007/05/24
'======================================================

  set rs=server.createobject("adodb.recordset")
  select case pr
   case 1
    sqltext = "select a4code,a4name,a4gid,a4price_common as a4price"
   case 2
    sqltext = "select a4code,a4name,a4gid,a4price_vip as a4price"
   case 3
    sqltext = "select a4code,a4name,a4gid,a4price_wholesale as a4price"
  end select
  'sqltext = sqltext&" from stock"
'======================================================
'修改 唯一gid的返回开始 sky 2007/05/24
'======================================================
  'sqltext = sqltext&" from stock where a4code in ("&goodslist&") order by a4gid"
  sqltext = sqltext&" from stock where a4gid in ("&goodslist&") order by a4gid"
'======================================================
'修改 唯一gid的返回结束 sky 2007/05/24
'======================================================
  'response.write sqltext
  'response.end
  rs.open sqltext,conn,1,1
%>
<HTML>
<HEAD>
<TITLE>进销存系统——售货</TITLE>
<script language="javascript" src="inc/jstrim.js">
</script>
<script language="javascript"> 
function bodyf()
{
  form1.a2code.focus(); 
}
function submit1()
{
//document.form1.data.value="111";
//document.form1.action="sell_code_to_gid.asp?pr=<%=pr%>";
   document.form1.submit();
}
function checkcode(inform)
{
  if ( isValidString(form1.a2code.value) == -1 )
  {
            alert ("输入条形码不能有特殊字符！");
			form1.a2code.focus();
			return false;
  }
  else
  {
			return true;
  }
}
function checkform(inform)
{
  if (jstrim(inform.a9postage.value) == "")
  {
            alert ("请输入邮费价格！");
			inform.a9postage.focus();
			return false;
  }
  if(isNaN(inform.a9postage.value)) 
  { 
            alert("邮费价格必须为数字！");
            inform.a9postage.focus(); 
            return false; 
   }
  if (inform.a9postage.value < 0)
  {
            alert ("邮费价格不能为负值！");
			inform.a9postage.focus();
			return false;
  }
  if (jstrim(inform.reduce1.value) == "")
  {
            alert ("请输入优惠价格！");
			inform.reduce1.focus();
			return false;
  }
  if(isNaN(inform.reduce1.value)) 
  { 
            alert("优惠价格必须为数字！");
            inform.reduce1.focus(); 
            return false; 
   }
  /*-----------------------------------------------------------------
  ----------------------陈钢070605修改优惠金额可以为负值-------------
  if (inform.reduce1.value < 0)
  {
            alert ("优惠价格不能为负值！");
			inform.reduce1.focus();
			return false;
  }
  ----------------------陈钢070605修改优惠金额可以为负值-------------
  ------------------------------------------------------------------*/
   if (jstrim(inform.oid.value) == "")
  {
            alert ("请输入订单号！");
			inform.oid.focus();
			return false;
  }
  if( isValidString(inform.oid.value) == -1 )
  {
            alert ("输入订单号不能有特殊字符");
			inform.oid.focus();
			return false;
  }

  //-------------------------------------------------------------------------------------------------
  //----------------------陈钢070607增加验证优惠价格不能大于或等于商品总价---------------------------
  //----------------------陈钢070607增加确认提交时显示扣除优惠后的价格小计---------------------------
  var sum_money = 0;
  var soso=inform.a4price.length;
  if (isNaN(soso))
  {soso=1;
   sum_money=inform.a4price.value*inform.amount.value;
  }
  else
  {soso = soso-1
  var i;
    for(i=0;i<=soso;i++){sum_money = sum_money-(-inform.a4price[i].value*inform.amount[i].value);}
  }

  if(sum_money < inform.reduce1.value) 
  { 
            alert("优惠价格不能大于商品总价！");
            inform.reduce1.focus(); 
            return false; 
   }

  var total_money = sum_money - (-inform.a9postage.value) - inform.reduce1.value
  if(confirm('小计金额'+total_money+'元，确认提交订单？')) 
  {return   true;}
    else 
  {return   false;}   
  //----------------------陈钢070607增加确认提交时显示扣除优惠后的价格小计---------------------------
  //----------------------陈钢070607增加验证优惠价格不能大于或等于商品总价---------------------------
  //-------------------------------------------------------------------------------------------------
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
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")
%>
</head>

<BODY onload="bodyf()">
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
	     <td width="160" valign="top">
		    <!--#include file="inc\left_mini.inc"-->
		 </td>
		 <td width="580" valign="top">
		    <br>
		    <table width="580">
			  <tr>
			    <td>
				 <!--左边框 开始-->
				 <!--onpropertychange="submit1()"-->
				 <table class="STYLE1">
				   <tr>
				    <td align="center" valign="top">
					  <form name="form1" id="form1" method="post" onsubmit="return checkcode(this)" action="sell_code_to_gid.asp?pr=<%=pr%>">
					  <input type="hidden" name="goodslist" value="<%=goodslist%>">
					  条形码:&nbsp;&nbsp;&nbsp;<input type="text" name="a2code" style="width:100px" onchange="submit1()"><br><br><br><br><br><br><br><br><br>
					  </form>
					  <form name="form2" method="post" onsubmit="return checkform(this)" action="sell_run.asp">
					  邮费金额:&nbsp;<input type="text" name="a9postage" value="0" maxlength="9" style="width:100px"><br>
					  优惠金额:&nbsp;<input type="text" name="reduce1" value="0" maxlength="9" style="width:100px"><input type="hidden" name="pr" value="<%=pr%>"><br>
					  订单号:&nbsp;&nbsp;&nbsp;<input type="text" name="oid" style="width:100px"><br><br>
					  <input type="submit" name="submit" value="确 认 购 买" class="style_button">
					</td>
				<!--左边框 结束-->
				<!--右边框 结束-->
					<td align="center" valign="top">
					 <fieldset>
					   <table class="STYLE1">
					    <tr>
						 <td align="center" width="200">商品名称</td>
						 <td align="center" width="50">数量</td>
						 <td align="center" width="50">价格</td>
						 <td align="center" width="30">删除</td>
						</tr>
					   </table>
					 </fieldset><br>
					 <fieldset>
					   <table class="STYLE1">
					    <%while not rs.eof%>
					    <tr>
						 <td width="200" align="left"><%=rs("a4name")%></td>
						 <td width="50" align="center"><input name="amount" type="text" value="1" size="3" maxlength="4"><input type="hidden" name="goodslist" value="<%=rs("a4gid")%>"></td>
						 <td width="50" align="center"><%=rs("a4price")%><input type="hidden" name="a4price" value="<%=rs("a4price")%>"></td>
						 <td align="center" width="30"><%response.write("<a href=""sell_confirm_del.asp?No="&rs("a4gid")&"&pr="&pr&"&goodslist="&goodslist&""">删除</a>")%></td>
						</tr>
						<%rs.movenext
						  wend%>
						</form>
				<!--右边框 结束-->
					   </table>
					 </fieldset><br>
					 <fieldset>
					   <table class="STYLE1">
					    <tr>
						 <td width="330" align="right">共计&nbsp<%=rs.recordcount%>&nbsp种商品</td>
						</tr>
					   </table>
					 </fieldset>
					 <%rs.close%>
					</td>
				   </tr>
				 </table>
				 <!--左边框 结束-->
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