<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵������λ����
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/12  cg@kdz  ����
  '2007/08/05  sky@kdz �޸� ��������ȥ�ո�Ĵ���
  '2007/08/20  sky@kdz �޸� ��λһ����ť������
  '2007/12/18  sky@kdz �޸� ���������ֹ�����ַ����޸�
  '2008/01/01  cg@kdz  �޸� ����tips����
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ������λ����</TITLE>
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
<script language="javascript" src="inc/jstrim.js">
</script>
<script language="javascript">
function bodyf()
{
  form1.a10code.focus(); 
}
function incheck(inform1){
  if (jstrim(inform1.a10code.value) == "")
  {
            alert ("�����������룡");
			inform1.a10code.focus();
			return false;
  }
  if( isValidString(inform1.a10code.value) == -1 )
  {
            alert ("���������벻���������ַ�");
	        inform1.a10code.focus();
	        return false;
  }
}
//function bodyf(){
//document.form1.action="seat_code_to_gid.asp";
//document.form1.submit();
//}
</script>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim a10code,a10gid,a10_flg
a10code = trim(request.form("a10code"))
a10gid = trim(request.form("a10gid"))
a10_flg = trim(request.form("a10_flg"))
%>
</head>

<BODY onload="bodyf()">
<table width="762" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td align="center"><img src="image\logo.gif"></td>
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
	<td align="center">
	<table width="760" cellpadding="0" cellspacing="0" style="BORDER-RIGHT:#FF0000 6px solid;BORDER-TOP:#FF0000 6px solid;BORDER-BOTTOM:#FF0000 6px solid;BORDER-LEFT:#FF0000 6px solid;">
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
				    <table class="STYLE2" align="center">
				    <form id="form1" name="form1" method="post" onsubmit="return incheck(form1)" action="seat_code_to_gid.asp">
					  <tr height="100">
					    <td width="50"></td>
					    <td width="100">
						������
						</td>
						<td width="180">
						<input type="text" name="a10code" maxlength="20" value="<%=a10code%>">
						<input type="hidden" name="a10gid" value="<%=a10gid%>">
						</td>
					    <td width="50"></td>
					  </tr>
					  <% if a10_flg <> "" then 
					     set rs=server.createobject("adodb.recordset")
                             sqltext = "select a4name"
                             sqltext = sqltext&" from stock where a4gid = '"&a10gid&"'"
                             'response.write sqltext
                             rs.open sqltext,conn,1,1
					  %>
					  <tr height="60">
					    <td width="50"></td>
					    <td width="100">
						��Ʒ����
						</td>
						<td width="180">
						<% response.write(rs("a4name")) %>
						</td>
					    <td width="50"></td>
					  </tr>
					  <%rs.close
					    set conn = nothing
					    end if%>
					   <tr>
						 <td colspan="4" height="60" align="center"><input type="Submit" name="Submit" value="�� �� �� �� Ʒ �� �� ��" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td colspan="4" height="60" align="center"><input type="button" onclick ="self.location='seat_view.asp';" value="�� λ �� �� һ ��" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td colspan="4" height="60" align="center"><input type="button" onclick ="self.location='seat_select.asp';" value="�鿴��Ʒ��ռ�õĲ�λ" class="style_button"><br><span class="STYLE1"><font color="red">�˲�ѯ���ܻ��ѽϳ�ʱ��</font></span>
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
</BODY>
</HTML>