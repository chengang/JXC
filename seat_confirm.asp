<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵���������������ҳ
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/18  cg@kdz  ����
  '2007/09/04  sky@kdz �޸� �����λ��ѯ���
  '2007/12/30  cg@kdz  �޸� ���ӵ����¼��ȫ���� ����conn
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�

  dim a10gid,rs_a10seat,rs_a4stock,sqltext
  a10gid = request.form("a10gid")
  set rs_a10seat=server.createobject("adodb.recordset")
  sqltext = "select a10gid,a10name,a10code,a10seat,a10amount,a10crttime,a10crtuser,a10chgtime,a10chguser"
  sqltext = sqltext&" from seat where a10gid='"&a10gid&"' order by a10id"
  'response.write sqltext
  rs_a10seat.open sqltext,conn,1,1
  if rs_a10seat.eof then
   response.redirect("messagebox.asp?msg=�����������Ʒ��δ�������¼")
  else
	set rs_a4stock=server.createobject("adodb.recordset")
	sqltext = "select a4diff,a4cflag"
	sqltext = sqltext&" from stock where a4gid='"&a10gid&"'"
	rs_a4stock.open sqltext,conn,1,1
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
	     <td width="160" valign="top">
		    <!--#include file="inc\left_mini.inc"-->
		 </td>
		 <td width="580" valign="top">
		    <br>
		    <table width="580">
			  <tr>
			    <td>
				 <!--��߿� ��ʼ-->
				 <!--onpropertychange="submit1()"-->
				 <table class="STYLE1">
				   <tr>
				    <td align="center" valign="top">
					  <form name="form1" method="post" action="seat_run.asp">
					  ������:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="a10code_temp" style="width:105px" value="<%=rs_a10seat("a10code")%>" disabled><input type="hidden" name="a10gid" value="<%=rs_a10seat("a10gid")%>"><br><br>
					  ��Ʒ����:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="a10name" style="width:105px" value="<%=rs_a10seat("a10name")%>" disabled><br><br>
					  ��ʵ״̬:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="a4cflag" style="width:105px" value="<%if rs_a4stock("a4cflag")=1 then response.write("��ʵ") else if  rs_a4stock("a4cflag")=0 then response.write("����") end if%>" disabled><br><br>
					  �������:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="a4diff" style="width:105px" value="<%=rs_a4stock("a4diff")%>" disabled><br><br><br>
					  ���������:&nbsp;&nbsp;&nbsp;<input type="text" name="a10chguser" style="width:105px" value="<%=rs_a10seat("a10chguser")%>" disabled><br><br>
					  �������ʱ��:&nbsp;<input type="text" name="a10chgtime" style="width:105px" value="<%=kdztimeformat(rs_a10seat("a10chgtime"),"1")%>" disabled><br><br><br><br><br>
					  <input type="submit" name="submit" value="ȷ �� �� ��" class="style_button">
					</td>
				<!--��߿� ����-->
				    <td width="20"></td>
				<!--�ұ߿� ����-->
					<td valign="top">
					 <fieldset>
					   <table class="STYLE1">
					    <tr>
						 <td align="center" width="150">��λ����</td>
						 <td align="center" width="150">�ִ������</td>
						</tr>
					   </table>
					 </fieldset><br>
					 <fieldset>
					   <table class="STYLE1">
					    <%
						dim a10seat,a10amount
						set a10seat=rs_a10seat("a10seat")
						set a10amount=rs_a10seat("a10amount")
						while not rs_a10seat.eof%>
					    <tr>
						 <td width="150" align="center"><%=a10seat%><input type="hidden" name="a10seat" value="<%=a10seat%>"></td>
						 <td width="150" align="center"><input type="text" name="a10amount" onfocus="this.select();" style="width:30px" value="<%=a10amount%>"></td>
						</tr>
						<%rs_a10seat.movenext
						  wend
						  rs_a10seat.close
						  rs_a4stock.close%>
						</form>
				<!--�ұ߿� ����-->
					   </table>
					 </fieldset>
					</td>
				   </tr>
				 </table>
				 <!--��߿� ����-->
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
<%end if%>