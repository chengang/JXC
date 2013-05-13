<!KDZ Studio Powered at 20070329">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：1、根据条形码返回卖货页面商品唯一ID
  '           (1)如果没有此商品或者只有唯一的商品ID
  '              则直接跳转回卖货确认页面
  '           (2)如果有2个及以上的商品ID，显示出所有
  '              商品，选择商品后，返回该商品ID
  '           (3)如果有2个及以上的商品ID，显示出所有
  '              商品，不选择商品，按确认后，返回空
  '更新DB：无
  '参照DB：stock
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/23  sky@kdz 修改
  '2007/12/16  sky@kdz 修改 code_to_gid增加js验证
%>
<HTML>
<HEAD>
<TITLE>进销存系统——商品确认</TITLE>
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

	dim pr,code,name,gid,goodslist

    pr = request.queryString("pr")
    code = request.form("a2code")
	goodslist = request.form("goodslist")

    set rs=server.createobject("adodb.recordset")
        sqltext = "select a4name,a4gid"
        sqltext = sqltext&" from stock where a4code = '"&code&"'"
        'response.write sqltext
        rs.open sqltext,conn,1,1
%>
</HEAD>

<%	if ( rs.RecordCount = 0 or rs.RecordCount = 1 ) then
	  gid = rs("a4gid")
	  rs.close
	  set conn = nothing
%>
<BODY>
<table>
   <tr>
     <td>
	    <form id="form1" name="form1" method="post">
	    <input type="hidden" name="a4gid" value="<%=gid%>">
		<input type="hidden" name="goodslist" value="<%=goodslist%>">
        </form>
	 </td>
   </tr>
</table>
</BODY>
</HTML>
<script language="javascript"> 
document.form1.action="sell_confirm.asp?pr=<%=pr%>";
document.form1.submit();
</script>
<%
    else
%>
<script language="javascript">
function getradio(){
  var temp;
  var out;
  temp = form2.a4gid.length;
  out = "radio_not_selected";
  for (i=0;i<temp;i++)
  {
   if (form2.a4gid[i].checked == true)
	{
        out = form2.a4gid[i].value;
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
	  <td>
	    <table width="760" cellpadding="0" cellspacing="0" style="BORDER-RIGHT:#FF0000 6px solid;BORDER-TOP:#FF0000 6px solid;BORDER-BOTTOM:#FF0000 6px solid;BORDER-LEFT:#FF0000 6px solid;">
			<form id="form2" name="form2" method="post" onsubmit = "return incheck()" action="sell_confirm.asp?pr=<%=pr%>">
			<tr height="80">
			  <td align="center"><span class="STYLE2"><font color="red">此条形码有两种以上商品，请选择您要操作的商品:</font></span></td>
			</tr>
			<input type="hidden" name="goodslist" value="<%=goodslist%>">

			<%while not rs.eof
			  gid = rs("a4gid")
			  name = rs("a4name")%>

			<tr>
			  <td valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="a4gid" type="radio" value="<%=gid%>"><span class="STYLE1"><%=name%></span></td>
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