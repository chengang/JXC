<!KDZ Studio Powered at 20070329">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<%response.Expires = 0%>
<!--#include file="inc/conn.asp"-->
<%'����˵����1�����Ʒ����Ʒ�嵥���������ʾ��������
  '����DB��jxc_buy_brand
  '����DB��jxc_buy_brand
  '�޸�����
  '�޸������ա������ߡ�����
  '2008/09/27  cg@kdz  ����
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ����Ʒ�ƽ����嵥ȷ��</TITLE>
<meta http-equiv="refresh" content="10;url=buy.asp">
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
-->
</style>
<%
	dim username,power,uid
	username = kdzcookie("tdl_name")
	power = kdzcookie("power")
	uid= kdzcookie("uid")

	'��form��ȡֵ
	brand = trim(request.form("a17brand"))
	money = trim(request.form("a17money"))
	remark = trim(request.form("a17remark"))
	crtuser = username
%>
</HEAD>

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
		 <td width="380" valign="center">
		    <table bgcolor="#CCCCCC">
				<%
				'ȡϵͳʱ��Ϊ��ֵ
				  dim timestr
					  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
				%>
				<!-- ����Ʒ�ƽ����嵥 Begin-->
				<%
        set rs_buy_brand = server.createobject("adodb.recordset")
        sqltext = "select top 1 * from jxc_buy_brand "
        rs_buy_brand.open sqltext,conn,1,2
        rs_buy_brand.Addnew
        rs_buy_brand("a17brand")=brand
        rs_buy_brand("a17money")=money
        rs_buy_brand("a17remark")=remark
        rs_buy_brand("a17crttime")=int(timestr)
        rs_buy_brand("a17crtuser")=crtuser
        rs_buy_brand.Update
        rs_buy_brand.Close
				%>
				<!-- ����Ʒ�ƽ����嵥 End-->
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%=username%> ����¼���Ʒ����Ʒ�嵥
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2">
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						Ʒ�ƣ�
						</td>
						<td width="180">
						<%=brand%>
						</td>
					    <td width="50"></td>
					  </tr>
					  
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						��
						</td>
						<td width="180">
						<%=money%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						��ע��
						</td>
						<td width="180">
						<%=remark%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						¼�����ڣ�
						</td>
						<td width="180">
						<%=kdztimeformat(timestr,"1")%>
						</td>
					    <td width="50"></td>
					  </tr>
					   <tr>
						 <td colspan="4" height="60" align="center" class="STYLE1">
						 <a href="buy.asp">10����Զ�����¼��ҳ��</a>
						 </td>
					   </tr>
				  <%
					  set conn=nothing
				  %>
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
