<!kdz studio powered at 20071214">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵����
  '          1��ɾ��������Ʒǰ̨
  '          2��JS��֤������Ϊ�ǿ�
  '����DB����
  '����DB����
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/12/14  cg@kdz  ���� ɾ��������Ʒ��������
  '2007/12/18  sky@kdz �޸� ���������ֹ�����ַ����޸�
  '2007/12/30  cg@kdz  �޸� ���ӵ����¼��ȫ���� ����conn
  '2008/01/01  cg@kdz  �޸� ����tips����
%>
<html>
<head>
<title>������ϵͳ����ɾ��������Ʒ</title>
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
			   font-family: verdana, arial, ����; 
			   height: 30px; 
			   background-color: #ddeeff"
			   }
-->
</style>
<!--��������check-->
<script language="javascript" src="inc/jstrim.js">
</script>
<script language="javascript">
function bodyf()
{
  form1.code.focus(); 
}
function incheck(inform){
  if (jstrim(inform.code.value) == "")
  {
            alert ("�����������룡");
			inform.code.focus();
			return false;
  }
  if( isValidString(inform.code.value) == -1 )
  {
			alert ("���������벻���������ַ�");
			inform.code.focus();
			return false;
  }
  if (jstrim(inform.reason.value) == "")
  {
            alert ("������ɾ����Ʒԭ��");
			inform.reason.focus();
			return false;
  }
  if( isValidString(inform.reason.value) == -1 )
  {
			alert ("����ɾ����Ʒԭ�����������ַ�");
			inform.reason.focus();
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

<body onload="bodyf()">
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
					<form id="form1" name="form1" method="post" onsubmit = "return incheck(this)" action="admin_delete_commodity_code_to_gid.asp">
					  
					  <tr height="80">
					    <td width="50"></td>
					    <td width="100" align="center">
						������
						</td>
						<td width="180">
						<input type="text" name="code" maxlength="20">
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr height="80">
					    <td width="50"></td>
					    <td width="100" align="center">
						ɾ��ԭ��
						</td>
						<td width="180">
						<input type="text" name="reason" maxlength="20">
						</td>
					    <td width="50"></td>
					  </tr>

					   <tr>
						 <td colspan="4" height="130" align="center"><input type="submit" name="submit" value="ȷ         ��" class="style_button">
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