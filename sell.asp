<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵����������Ʒҳ��1�����۸�ѡ��
  '          ��ͨ��Ա��VIP��Ա������
  '          �ֱ���pr=1��2��3ȥҳ��sell_confirm.asp
  '����ҳ��sell_confirm.asp
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/12  cg@kdz  ����
  '2007/12/30  cg@kdz  �޸� ���ӵ����¼��ȫ���� ����conn
  '2008/01/01  cg@kdz  �޸� ����tips����
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ�����ۻ�</TITLE>
<script language="javascript"> 
function openhere(i)
{
window.open("sell_confirm.asp?pr="+i, "_self") 
//window.location.href="jumped.asp"; 
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
%>
</head>

<BODY>
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
		    <!--#include file="inc\left.inc"-->
		 </td>
		 <td width="380" valign="top">
		    <br>
		    <table>
			  <tr height="40">
			    <td>
				    <table class="style1" align="center" width="330"><tr><td>
					  <!--#include file="inc/marquee_tips.inc"-->
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2" width="360">
					  <tr>
						 <td height="80" align="center"><input type="button" name="button1" onclick="openhere(1)" value="�� ͨ �� Ա �� ��" class="style_button">
						 </td>
					   </tr>
					  <tr>
						 <td height="80" align="center"><input type="button" name="button2" onclick="openhere(2)" value="V I P �� Ա �� ��" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="80" align="center"><input type="button" name="button3" onclick="openhere(3)" value="   ��     ��     " class="style_button">
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