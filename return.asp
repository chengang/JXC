<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵�����˻�ǰ̨ҳ��
  '����DB����
  '����DB����
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/08/05  sky@kdz �޸� ��������ȥ�ո�Ĵ���
  '2007/11/07  sky@kdz �޸� �˻�bug�޸�
  '2007/12/18  sky@kdz �޸� ���������ֹ�����ַ����޸�
  '2008/01/01  cg@kdz  �޸� ����tips����
  '2008/11/08  sky@kdz �޸� �޸��˻�����
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ�����˻�</TITLE>
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
<!--��������check-->
<script language="javascript" src="inc/jstrim.js">
</script>
<script language="javascript">
function bodyini()
{
  form1.a3oid.focus(); 
}
function incheck(inform){
  if (jstrim(inform.a3amount.value) == "")
  {
            alert ("�������˻�������");
			inform.a3amount.focus();
			return false;
  }
 if(isNaN(inform.a3amount.value)) 
  { 
            alert("�˻���������Ϊ���֣�");
            inform.a3amount.focus(); 
            return false; 
   } 
  if (inform.a3amount.value < 0)
  {
            alert ("��������Ϊ��ֵ��");
			inform.a3amount.focus();
			return false;
  }
  if (jstrim(inform.a3oid.value) == "")
  {
            alert ("�����붨���ţ�");
			inform.a3oid.focus();
			return false;
  }
  if( isValidString(inform.a3oid.value) == -1 )
  {
            alert ("���붨���Ų����������ַ�");
	        inform.a3oid.focus();
	        return false;
  }
  if (jstrim(inform.a3code.value) == "")
  {
            alert ("�����������룡");
			inform.a3code.focus();
			return false;
  }
  if( isValidString(inform.a3code.value) == -1 )
  {
            alert ("���������벻���������ַ�");
	        inform.a3code.focus();
	        return false;
  }
  var flag = false;
  for(var N=0;N<inform.a3reason.length; N++){
     if (inform.a3reason[N].checked == true ){
	    flag = true;
	 }
  }
  if( flag == false ){
      alert ("��ѡ���˻�ԭ��");
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

<BODY onload="bodyini()">
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
				    <form id="form1" name="form1" method="post" onsubmit="return incheck(this)" action="return_code_to_gid.asp">
				    <input name="FromPage" type="hidden" value="return">
					  <tr height="40">
					    <td width="50"></td>
					    <td width="100">
						�˻�����
						</td>
						<td width="180">
						<input type="text" name="a3amount" maxlength="20" value="1">
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr height="40">
					    <td width="50"></td>
					    <td width="100">
						������
						</td>
						<td width="180">
						<input type="text" name="a3oid" maxlength="20"  value="<%=a3oid%>">
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr height="40">
					    <td width="50"></td>
					    <td width="100">
						������
						</td>
						<td width="180">
						<input type="text" name="a3code" maxlength="20" value="<%=a3code%>">
						</td>
					    <td width="50"></td>
					  </tr>
					  <tr height="40">
					    <td width="50"></td>
					    <td width="100">
						�˻�ԭ��
						</td>
						<td width="180">
						<input type="radio" name="a3reason" value = "����">����&nbsp;<input type="radio" name="a3reason" value = "�������˻�">�������˻�
						</td>
					    <td width="50"></td>
					  </tr>
					   <tr height="60">
						 <td colspan="4" align="center"><input type="submit" name="Submit" value="�� �� �� ��" class="style_button">
						 </td>
					   </tr>
			        </form>
			        
					   <tr height="60">
						 <td colspan="4" align="center"><input type="button" onclick="javascript:window.open('return_confirm.asp', '_self')"  value="ȷ �� �� ��" class="style_button">
						 </td>
					   </tr>
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