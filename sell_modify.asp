<!KDZ Studio Powered at 20070110">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：售货编辑页面
  '更新DB：无
  '参照DB：sold
  '修改履历
  '修改年月日、责任者、内容
  '2007/06/02  sky@kdz 新增
  '2007/08/05  sky@kdz 修改 画面输入去空格的处理
  '2008/11/16  sky@kdz 修改 显示时间样式修改
%>
<HTML>
<HEAD>
<TITLE>进销存系统——售货查询编辑</TITLE>
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
<!--画面输入check-->
<script language="javascript" src="inc/jstrim.js">
</script>
<script language="javascript">
function incheck(inform){
  if (jstrim(inform.a2amount.value) == "")
  {
            alert ("请输入售货数量！");
			inform.a2amount.focus();
			return false;
  }
 if(isNaN(inform.a2amount.value)) 
  { 
            alert("售货数量必须为数字！");
            inform.a2amount.focus(); 
            return false; 
   } 
 if(inform.a2amount.value < 0) 
  { 
            alert("售货数量不能为负值！");
            inform.a2amount.focus(); 
            return false; 
   } 
}
</script>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim id,frompage
id = trim(request.queryString("a2id"))
frompage = trim(request.queryString("frompage"))

'response.write frompage
'response.end
%>
</head>

<BODY>
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
		   <!--#include file="inc/left_mini.inc"-->
		 </td>
		 <td width="590" valign="top">
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
	           <tr height = "50"><td colspan="7"></td></tr>
			   <tr height="20"><td colspan="7" class="STYLE2" align="center"><b>售 货 编 辑</b></td></tr>
			   <%
				 dim rs
				 '根据自动编号查询要修改的纪录
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select * " 
					 sqltext = sqltext&"from sold where a2id ="&id
					 'response.write sqltext
					 'response.end
					 rs.open sqltext,conn,1,1
			   %> 
			      <form id="form1" name="form1" method="post" onsubmit = "return incheck(this)" action="sell_modify_run.asp">
					<tr height="20" bgcolor="#FF6633">
					   <td>条形码</td>
					   <td>商品名称</td>
					   <td>品 牌</td>
					   <td>价 格</td>
					   <td>数 量</td>
					   <td>录入时间</td>
					   <td>录入者</td>
					</tr>
			   <%   dim a2id,a2code,a2name,a2brand,a2sold_price
			        dim a2amount,a2crttime,a2crtuser
					set a2id = rs("a2id")
					set a2code = rs("a2code")
					set a2name = rs("a2name")
					set a2brand = rs("a2brand")
					set a2sold_price = rs("a2sold_price")
					set a2amount = rs("a2amount")
					set a2crttime = rs("a2crttime")
					set a2crtuser = rs("a2crtuser")
			   %>
					<tr height="25">
					   <td><%=a2code%></td>
					   <td><%=a2name%></td>
					   <td><%=a2brand%></td>
					   <td><%=a2sold_price%></td>
					   <td><input type="text" name="a2amount" maxlength="6" onfocus="this.select();" style="width:60px" value="<%=a2amount%>">
					       <input type="hidden" name="a2id" value="<%=a2id%>">
						   <input type="hidden" name="frompage" value="<%=frompage%>"></td>
					   <td><%=kdztimeformat(a2crttime,"1")%></td>
					   <td><%=a2crtuser%></td>
					</tr>
					<tr>
			        <td align="center" colspan="7"><input type="submit" name="submit" class="style_button" value="  提    交  "></td>
			        </tr>
			   <%
				 '关闭连接，释放进程
				 rs.close
				 conn.close
				 set conn=nothing
			   %>
			   </form>
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