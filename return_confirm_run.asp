<!KDZ Studio Powered at 20081108">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵����ʵ���˻�ȷ�Ϲ���
  '          (1)���¿��������
  '����DB��returned,stock
  '����DB��sold
  '�޸�����
  '�޸������ա������ߡ�����
  '2008/11/08  sky@kdz ���� �޸��˻�����
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>

<HTML>
<HEAD>
<TITLE>������ϵͳ�����˻�ȷ��</TITLE>
<meta http-equiv="refresh" content="10;url=return.asp">
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
		 <td width="380" valign="center">
		    <table bgcolor="#CCCCCC">
				<%
				'ȡϵͳ���ں�ʱ��Ϊ��ֵ
				  dim datestr,timestr
				  datestr = int(Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)
				  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
				%>

				<!-- �˻� Begin-->
				<%
				  a3id = trim(request.querystring("a3id"))

			    dim rs_returned,returned_amount
					set rs_returned=server.createobject("adodb.recordset")
					sqltext1="select * from returned where a3mflag = 0 and a3status = 1 and a3id =" &a3id
					rs_returned.open sqltext1,conn,1,2
					
					if not rs_returned.eof then
					   amount = rs_returned("a3amount")
					   gid = rs_returned("a3gid")
					   buy_price = rs_returned("a3buy_price")
					   code = rs_returned("a3code")
					   name = rs_returned("a3name")
					   price = rs_returned("a3price")
						 chgtime = timestr
						 chguser = username
					else
					   response.redirect("messagebox_adv.asp?msg=����������ȷ�Ϻ��ٲ���&adv=3")
	           response.end
					end if

						'�����˻���
						rs_returned("a3chgtime") = chgtime
						rs_returned("a3chguser") = chguser
						rs_returned("a3confirmtime") = chgtime
						rs_returned("a3confirmuser") = chguser
						rs_returned("a3status") = 2
						rs_returned.update

						'���¿���
						dim stock,diff
						set rs_stock=server.createobject("adodb.recordset")
						sqltext2="select * from stock where a4gid='"&gid&"'"
						rs_stock.open sqltext2,conn,1,2
                        
						stock = rs_stock("a4stock") + amount
						diff = rs_stock("a4diff") + amount

						rs_stock("a4stock") = stock
						rs_stock("a4total_money") = rs_stock("a4total_money") + (buy_price * amount)
						rs_stock("a4diff") = diff
						rs_stock("a4cflag") = 1
						rs_stock("a4chgtime") = chgtime
						rs_stock("a4chguser") = chguser
						rs_stock.update

                %>
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%username%> �����˻ش���Ʒ
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2">
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						�����룺
						</td>
						<td width="180">
						<%=code%>
						</td>
					    <td width="50"></td>
					  </tr>
					  
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						��Ʒ���ƣ�
						</td>
						<td width="180">
						<%=name%>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						������
						</td>
						<td width="180">
						<%=amount%>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						�۸�
						</td>
						<td width="180">
						<%=price%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						ȷ�����ڣ�
						</td>
						<td width="180">
						<%=kdztimeformat(timestr,"1")%>
						</td>
					    <td width="50"></td>
					  </tr>
					   <tr>
						 <td colspan="4" height="60" align="center" class="STYLE1">
						 <a href="return.asp">10����Զ������˻�ҳ��</a>
						 </td>
					   </tr>
					</table>
			    </td>
			  </tr>
				<%
				    rs_returned.Close
				    rs_stock.Close
				conn.close
				set conn=nothing
				%>
				<!-- �ۻ� End-->
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
