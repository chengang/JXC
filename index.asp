<!kdz studio powered at 20070518">
<!--#include file="inc/function.asp"-->
<%'����˵������ҳ����½���
  '����DB����
  '����DB����
  '����ҳ��logon.asp
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/12  cg@kdz  ����
%>
<html>
<head>
<%
seediv = request.queryString("seediv")
if seediv = "" then
%>
<META http-equiv="Page-Enter" CONTENT="RevealTrans(Duration=3,Transition=6)"> 
<%end if%>
<title>������ϵͳ������½</title>
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
<script language="javascript">
function incheck(inform){
  if (inform.a5pwd_new.value == "")
  {
            alert ("�����������룡");
			inform.a5pwd_new.focus();
			return false;
  }
  if (inform.a5pwd_confirm.value == "")
  {
            alert ("������ȷ�����룡");
			inform.a5pwd_confirm.focus();
			return false;
  }
  if (inform.a5pwd_new.value != inform.a5pwd_confirm.value)
  {
            alert ("ȷ������Ӧ����������ͬ��");
			inform.a5pwd_confirm.focus();
			return false;
  }
}
</script>
</head>
<%if seediv = 1 then%>
<body onload="document.all.Layer1.style.visibility='visible'">
<%else%>
<body onload="document.all.Layer1.style.visibility='hidden'">
<%end if%>
<div id="Layer1" style="position:absolute;filter:alpha(opacity=80);background:#999999;width:762;height:590;visibility:hidden">
   <table width="762" border="0" align="center" cellpadding="0" cellspacing="0">
     <tr height="500" valign="center">
	   <td align="center">
	     <form method="post" action="pwd_deadline.asp" onsubmit="return incheck(this)">
		   <span class="style2"><b>���������Ѿ����ڣ�������µ����룺</b></span><br><br>
		   <span class="style1">
		   ������&nbsp;&nbsp;&nbsp;<input type="password" name="a5pwd_new"><br>
		   ȷ������&nbsp;<input type="password" name="a5pwd_confirm"><br><br>
		   </span>
		   <input type="submit" class="style_button" value=" ȷ �� �� �� "><br>
		 </form>
	   </td>
	 </tr>
   </table>
</div>
<table width="762" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
  <tr>
    <td colspan="2" align="center"><img src="image\logo.gif"></td>
  </tr>
  <tr><td>
  <table width="760" cellpadding="0" cellspacing="0" style="BORDER-RIGHT:#FF0000 6px solid;BORDER-TOP:#FF0000 6px solid;BORDER-BOTTOM:#FF0000 6px solid;BORDER-LEFT:#FF0000 6px solid;font-size:10.5pt;">
  <tr>
	<td width="380" align="center"><img src="image\1_index.gif"></td>
	<td width="380" align="center">
	  <form name="form1" method="post" action="logon.asp">
	    <br><br><br>
	    �û���&nbsp;<input name="a5uid" type="text" value="******" onfocus="this.select();">
		<br><br><br>
		&nbsp;����&nbsp;<input name="a5pwd" type="password" value="******" onfocus="this.select();">
		<br><br><br>
		��¼��Ч��&nbsp;&nbsp;<input name="keeptime" type="radio" value="0">��ʱ&nbsp;<input name="keeptime" type="radio" value="7">һ��&nbsp;<input name="keeptime" type="radio" value="30" checked="checked">һ��
		<br><br><br><br><br>
		<input name="submit" type="<%if seediv = 1 then response.write ("button") else response.write ("submit") end if%>" class="style_button" value="  ��      ¼  ">
	  </form>
	</td>
  </tr>
  </table>
  </td></tr>
  <tr>
	<td align="center"><img src="image\logo_mini.gif"></td>
  </tr>
</table>
</body>
</html>