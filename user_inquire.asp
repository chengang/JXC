<!KDZ Studio Powered at 20070702">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵������ͨ�û���ѯѡ��ҳ��
  '����DB����
  '����DB����
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/07/02  sky@kdz ����
  '2007/07/22  sky@kdz �޸� ���ָ߼���ѯ��Ϊ��Ʒ��ѯ
  '2007/12/13  sky@kdz �޸� ������Ŀ����
  '2007/12/30  cg@kdz  �޸� ���ӵ����¼��ȫ���� ����conn
  '2008/01/01  cg@kdz  �޸� ����tips����
  '2008/06/25  sky@kdz �޸� ���Ӱ�ʱ���ѯ����
  '2008/09/27  cg@kdz  �޸� ���Ӳ�ѯƷ�ƽ����嵥����
  '2008/12/28  sky@kdz �޸� ������Ʒ��ѯ����
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ������ѯ</TITLE>
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
<script language="javascript">
function openhere(i)
{
switch (i)
{
case 1:
window.open("inquire_today.asp", "_self");
break;
case 2:
window.open("inquire_select.asp", "_self") ;
break;
case 3:
window.open("inquire_orderbook_select.asp", "_self") ;
break;
case 4:
window.open("adv_select.asp", "_self") ;
break;
case 5:
window.open("inquire_date_select.asp", "_self") ;
break;
case 6:
window.open("buy_brand_select.asp", "_self") ;
break;
case 7:
window.open("statistics_commodity.asp", "_self") ;
break;
case 8:
window.open("gifts_select.asp", "_self") ;
break;
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
		   <!--#include file="inc/left.inc"-->
		 </td>
		 <td width="380" valign="top">
		    <br>
		    <table align="center">
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
				    <input name="FromPage" type="hidden" value="inquire">
					   <tr>
						 <td height="35" align="center"><input type="button" name="button1" onclick="openhere(1)" value="��  ��  ��  ѯ" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button2" onclick="openhere(2)" value="ȫ  ��  ��  ѯ" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button3" onclick="openhere(3)" value="��  ��  ��  ѯ" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button4" onclick="openhere(4)" value="��  Ʒ  ��  ѯ" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button5" onclick="openhere(5)" value="�� ʱ �� �� ѯ" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button6" onclick="openhere(6)" value="Ʒ�ƽ����嵥��ѯ" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button7" onclick="openhere(7)" value="�� Ʒ �� �� �� ѯ" class="style_button">
						 </td>
					   </tr>
					   <tr>
						 <td height="35" align="center"><input type="button" name="button8" onclick="openhere(8)" value="��  Ʒ  ��  ѯ" class="style_button">
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