<!KDZ Studio Powered at 20070525">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：邮费编辑页面
  '更新DB：无
  '参照DB：stock
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/26  sky@kdz 新增
  '2007/08/05  sky@kdz 修改 画面输入去空格的处理
  '2008/11/16  sky@kdz 修改 显示时间样式修改
%>
<HTML>
<HEAD>
<TITLE>进销存系统——邮费查询编辑</TITLE>
<style type="text/css">
<!--
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
            alert ("邮费金额不能为负值！");
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

dim id,frompage
id = trim(request.queryString("a8id"))
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
	           <tr height = "50"><td colspan="6"></td></tr>
			   <tr height="20"><td colspan="6" class="STYLE2" align="center"><b>邮 费 编 辑</b></td></tr>
			   <%
				 dim rs
				 '根据自动编号查询要修改的纪录
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select * " 
					 sqltext = sqltext&"from postage where a8id ="&id
					 'response.write sqltext
					 rs.open sqltext,conn,1,1
				 
			   %> 
			     <form id="form1" name="form1" method="post" onsubmit = "return incheck(this)" action="postage_modify_run.asp">
					<tr height="20" bgcolor="#FF6633">
					   <td>邮费日期</td>
					   <td>邮费金额</td>
					   <td>录入时间</td>
					   <td>录入人</td>
					   <td>修改时间</td>
					   <td>修改人</td>
					</tr>
			   <%   dim a8id,a8date,a8postage,a8crttime
			        dim a8crtuser,a8chgtime,a8chguser
			        set a8id = rs("a8id")
					set a8date = rs("a8date")
					set a8postage = rs("a8postage")
					set a8crttime = rs("a8crttime")
					set a8crtuser = rs("a8crtuser")
					set a8chgtime = rs("a8chgtime")
					set a8chguser = rs("a8chguser")
			   %> 
					<tr height="25">
					   <td><%=a8date%></td>
					   <td><input type="text" name="a8postage" maxlength="6" onfocus="this.select();" value="<%=a8postage%>">
					       <input type="hidden" name="a8id" value="<%=a8id%>">
						   <input type="hidden" name="frompage" value="<%=frompage%>">
					   </td>
					   <td><%=kdztimeformat(a8crttime,"1")%></td>
					   <td><%=a8crtuser%></td>
					   <td><%=kdztimeformat(a8chgtime,"1")%></td>
					   <td><%=a8chguser%></td>
					</tr>
					<tr>
			        <td align="center" colspan="6"><input type="submit" name="submit" class="style_button" value="  提    交  "></td>
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