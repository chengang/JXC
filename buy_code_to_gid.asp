<!KDZ Studio Powered at 20070329">
<%'����˵����1�����������뷵�ؽ���ҳ����ƷΨһID
  '           (1)���û�д���Ʒ����ֻ��Ψһ����ƷID
  '              ��ֱ����ת�ؽ���ȷ��ҳ��
  '           (2)�����2�������ϵ���ƷID����ʾ������
  '              ��Ʒ��ѡ����Ʒ�󣬷��ظ���ƷID
  '           (3)�����2�������ϵ���ƷID����ʾ������
  '              ��Ʒ����ѡ����Ʒ����ȷ�Ϻ󣬷��ؿ�
  '����DB����
  '����DB��stock
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/06/03  sky@kdz ����
  '2007/12/16  sky@kdz �޸� code_to_gid����js��֤
%>
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<%response.Expires = 0%>
<!--#include file="inc/conn.asp"-->
<HTML>
<HEAD>
<TITLE>������ϵͳ������Ʒȷ��</TITLE>
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
			   font-family: verdana, arial, ����; 
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

	dim code

    code = request.form("a1code")

    set rs=server.createobject("adodb.recordset")
        sqltext = "select a4name,a4gid"
        sqltext = sqltext&" from stock where a4code = '"&code&"'"
        'response.write sqltext
        rs.open sqltext,conn,1,1
%>
</HEAD>

<%	if rs.RecordCount = 0 then
	  gid = rs("a4gid")
	  rs.close
	  set conn = nothing
%>
<BODY>
<table>
   <tr>
     <td>
	    <form id="form1" name="form1" method="post">
	    <input type="hidden" name="a1code" value="<%=code%>">
		<input type="hidden" name="a4gid" value="<%=gid%>">
        </form>
	 </td>
   </tr>
</table>
</BODY>
</HTML>
<script language="javascript"> 
document.form1.action="buy_confirm.asp";
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
    alert ("��ѡ����Ҫ��������Ʒ");
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
<!---------------------------070610�¸������Ϸ�����-------------------------------------->
  <tr>
    <td align="right">
       <%if power = "5" then%>
	     <!--#include file="inc/top_admin.inc"-->
	   <%else%>
         <!--#include file="inc/top.inc"-->
	   <%end if%>
	</td>
  </tr>
<!---------------------------070610�¸������Ϸ�����-------------------------------------->
<!--------------------------------------------------------------------------------------->
	<tr>
	  <td>
	    <table width="760" cellpadding="0" cellspacing="0" style="BORDER-RIGHT:#FF0000 6px solid;BORDER-TOP:#FF0000 6px solid;BORDER-BOTTOM:#FF0000 6px solid;BORDER-LEFT:#FF0000 6px solid;">
			<form id="form2" name="form2" method="post" onsubmit = "return incheck()" action="buy_confirm.asp">
        	<input type="hidden" name="a1code" value="<%=code%>">
			<tr height="80">
			  <td align="center"><span class="STYLE2"><font color="red">��ѡ����Ҫ��������Ʒ:</font></span></td>
			</tr>

			<%while not rs.eof
			  gid = rs("a4gid")
			  name = rs("a4name")%>

			<tr>
			  <td valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="a4gid" type="radio" value="<%=gid%>"><span class="STYLE1"><%=name%></span></td>
			</tr>

			<%rs.movenext
			  wend
			  rs.close%>
			<tr>
			  <td valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="a4gid" type="radio" value=""><span class="STYLE1">������Ʒ</span></td>
			</tr>

			<tr height="80">
			 <td align="center"><br><input type="submit" name="submit" class="style_button" value=" ȷ �� "></td>
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