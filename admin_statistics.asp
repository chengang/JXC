<!KDZ Studio Powered at 20070805">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵����ͳ��ѡ��ҳ
  '����DB����
  '����DB����
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/08/05  sky@kdz ����
  '2007/12/13  sky@kdz �޸� ��ӿ�������Ϣ
  '2007/12/14  sky@kdz �޸� ɾ��������Ʒ��������
  '2008/01/01  cg@kdz  �޸� ����tips����
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ����ͳ��ѡ��</TITLE>
<script language="javascript">
function openhere(i)
{
	switch (i)
	{
	case 1:
		window.open("statistics_stock_run.asp", "_self") ;
		break;
	case 2:
		window.open("statistics_profit.asp", "_self");
		break;
	case 3:
		window.open("statistics_flash.asp", "_self");
		break;
	case 4:
		window.open("statistics_brand.asp", "_self");
		break;
	case 5:
		 if(confirm("ȷ������ɾ������Ʒ��ʹ�ô˹���ǰ����ϵ����Ա��"))
		  {window.open("admin_delete_commodity.asp", "_self");
		   break;}
			else 
		  {return   false;
		   break;}
	}
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
	<table width="760" cellpadding="0" cellspacing="0" style="BORDER-RIGHT:#FF0000 6px solid;BORDER-TOP:#FF0000 6px solid;BORDER-BOTTOM:#FF0000 6px solid;BORDER-LEFT:#FF0000 6px solid;">
	   <tr>
	     <td width="380">
		    <!--#include file="inc\left.inc"-->
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
				    <table class="STYLE2" width="360" align="center">
					  <tr>
						 <td height="60" align="center"><input type="button" name="button1" onclick="openhere(1)" value="�� �� �� �� �� Ϣ" class="style_button">
						 </td>
					   </tr>
					  <tr>
						 <td height="60" align="center"><input type="button" name="button2" onclick="openhere(2)" value="�� �� ͳ ��(����)" class="style_button">
						 </td>
					   </tr>
					  <tr>
						 <td height="60" align="center"><input type="button" name="button2" onclick="openhere(3)" value="�� �� ͳ ��(ͼ��)" class="style_button"> <a href="statistics_graph.asp">old</a>
						 </td>
					   </tr>
					  <tr>
						 <td height="60" align="center"><input type="button" name="button2" onclick="openhere(4)" value="Ʒ �� �� �� ͳ ��" class="style_button">
						 </td>
					   </tr>
					  <tr>
						 <td height="60" align="center"><input type="button" name="button3" onclick="openhere(5)" value="ɾ �� �� �� �� Ʒ" class="style_button">
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