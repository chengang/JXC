<!KDZ Studio Powered at 20071214">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<%'����˵����1�����������뷵��ɾ��������Ʒҳ��ΨһID
  '             �����������ѯ����
  '           (1)�����ѯ��¼����Ϊ��
  '              ����תMessageBox_adv.asp
  '           (2)�����ѯ��¼����Ϊһ
  '              �򷵻ظ���ƷID
  '           (3)�����ѯ��¼����Ϊ2�������ϵ���Ʒ
  '              ����ʾ��������Ʒ������ѡ����Ʒ��ID
  '����DB����
  '����DB��stock
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/12/14  sky@kdz ���� ɾ��������Ʒ��������
%>
<%response.Expires = 0%>
<!--#include file="inc/conn.asp"-->
<HTML>
<HEAD>
<TITLE>������ϵͳ����ɾ��������Ʒ</TITLE>
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

      response.redirect("messagebox_adv.asp?msg=��������û�ж�Ӧ����Ʒ����ȷ�Ϻ���ɾ����Ʒ&adv=5")
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
			  <td align="center"><span class="STYLE2"><font color="red">��ѡ����Ҫ��������Ʒ:</font></span></td>
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