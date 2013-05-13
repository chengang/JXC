<!KDZ Studio Powered at 20071214">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<%'机能说明：1、根据条形码返回删除单件商品页面唯一ID
  '             根据条形码查询库存表
  '           (1)如果查询记录条数为零
  '              则跳转MessageBox_adv.asp
  '           (2)如果查询记录条数为一
  '              则返回该商品ID
  '           (3)如果查询记录条数为2个及以上的商品
  '              则显示出所有商品，返回选择商品的ID
  '更新DB：无
  '参照DB：stock
  '修改履历
  '修改年月日、责任者、内容
  '2007/12/14  sky@kdz 新增 删除单件商品功能增加
%>
<%response.Expires = 0%>
<!--#include file="inc/conn.asp"-->
<HTML>
<HEAD>
<TITLE>进销存系统——删除单件商品</TITLE>
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
<%
	dim username,power,uid
	username = kdzcookie("tdl_name")
	power = kdzcookie("power")
	uid= kdzcookie("uid")

	dim code,reason

    code = trim(request.form("code"))
    reason = trim(request.form("reason"))

    set rs=server.createobject("adodb.recordset")
        sqltext = "select a4name,a4gid"
        sqltext = sqltext&" from stock where a4code = '"&code&"'"
        'response.write sqltext
        rs.open sqltext,conn,1,1
%>
</HEAD>

<%	if rs.RecordCount = 0 then
	  rs.close
	  set conn = nothing

      response.redirect("messagebox_adv.asp?msg=该条形码没有对应的商品，请确认后再删除商品&adv=5")
	  response.end
	end if
	gid = rs("a4gid")
	if rs.RecordCount = 1 then
%>
<BODY>
<table>
   <tr>
     <td>
	    <form id="form1" name="form1" method="post">
	    <input type="hidden" name="code" value="<%=code%>">
	    <input type="hidden" name="reason" value="<%=reason%>">
		<input type="hidden" name="gid" value="<%=gid%>">
        </form>
	 </td>
   </tr>
</table>
</BODY>
</HTML>
<script language="javascript"> 
document.form1.action="admin_delete_commodity_confirm.asp";
document.form1.submit();
</script>
<%
    else
%>
<script language="javascript">
function getradio(){
  var temp;
  var out;
  temp = form2.gid.length;
  out = "radio_not_selected";
  for (i=0;i<temp;i++)
  {
   if (form2.gid[i].checked == true)
	{
        out = form2.gid[i].value;
	}
  }
  return out;
}
function incheck(){
  var form2gidvalue;
  form2gidvalue = getradio();
  if (form2gidvalue == "radio_not_selected")
  {
    alert ("请选择您要操作的商品");
    return false;
  }
  else
  {
    return true;
  }

}
</script>
<BODY>
<table align="center">
    <tr>
	  <td><img src="image/logo.gif"></td>
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
	  <td>
	    <table width="760" cellpadding="0" cellspacing="0" style="BORDER-RIGHT:#FF0000 6px solid;BORDER-TOP:#FF0000 6px solid;BORDER-BOTTOM:#FF0000 6px solid;BORDER-LEFT:#FF0000 6px solid;">
			<form id="form2" name="form2" method="post" onsubmit = "return incheck()" action="admin_delete_commodity_confirm.asp">
        	<input type="hidden" name="code" value="<%=code%>">
	        <input type="hidden" name="reason" value="<%=reason%>">
			<tr height="80">
			  <td align="center"><span class="STYLE2"><font color="red">请选择您要操作的商品:</font></span></td>
			</tr>

			<%while not rs.eof
			  gid = rs("a4gid")
			  name = rs("a4name")%>

			<tr>
			  <td valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="gid" type="radio" value="<%=gid%>"><span class="STYLE1"><%=name%></span></td>
			</tr>

			<%rs.movenext
			  wend
			  rs.close%>

			<tr height="80">
			 <td align="center"><br><input type="submit" name="submit" class="style_button" value=" 确 认 "></td>
			</tr>
			</form>
	    </table>
	  </td>
	</tr>
	
    <tr>
	  <td><img src="image/logo.gif"></td>
	</tr>
</table>
</BODY>
</HTML>
<%end if%>