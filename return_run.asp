<!KDZ Studio Powered at 20070329">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵����ʵ���˻����빦��
  '          (1)��ѯ������ֻ����������Ʒ�������˻�
  '          (2)��ѯ�������˻���ֻ�д���Ʒ�������������˻������������˻�
  '          (3)���˻���¼���뵽�˻�����
  '����DB��returned
  '����DB��sold,returned
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/13  sky@kdz �޸�
  '2007/05/19  sky@kdz �޸� cflag��־Ϊ��1,�����������
  '2007/05/25  sky@kdz �޸� ��Ϊ��gid������
  '2007/06/03  sky@kdz �޸� �˻����޸�flag������
  '2007/10/29  sky@kdz �޸� ��һ������ʾ����������޸�
  '2007/11/07  sky@kdz �޸� �˻�bug�޸�
  '2008/01/02  sky@kdz �޸� �˻����������۸��ֶα��Ϊ����ɱ�
  '2008/11/08  sky@kdz �޸� �޸��˻�����
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>

<HTML>
<HEAD>
<TITLE>������ϵͳ�����˻�����</TITLE>
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
				'ȷ����ʲô����
				  dim FromPage
				  FromPage = request.form("FromPage")
				'ȡϵͳ���ں�ʱ��Ϊ��ֵ
				  dim datestr,timestr
				  datestr = int(Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)
				  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
				%>

				<%if FromPage = "return" then%>
				<!-- �˻� Begin-->
				<%
				'��form��ȡֵ
				'gid_temp = trim(request.form("a3gid"))
				dim gid,amount,oid
				get_gid = trim(request.form("a3gid"))
				amount = trim(request.form("a3amount"))
				oid = trim(request.form("a3oid"))
				a3reason = trim(request.form("a3reason"))
				
				'��ѯ������ֻ����������Ʒ�������˻�
				dim rs_sold
				set rs_sold=server.createobject("adodb.recordset")
				sqltext1="select * from sold where a2mflag = 0 and a2gid='"&get_gid&"' and a2oid ='"&oid&"'"
				rs_sold.open sqltext1,conn,1,1

				if rs_sold.eof then 
				   'û����������Ʒ
				    rs_sold.close
					  response.redirect("messagebox_adv.asp?msg=��û���������Ʒ�������˻�&adv=3")
	          response.end
				else
				  dim rs_returned,returned_amount,total_amount
					set rs_returned=server.createobject("adodb.recordset")
					sqltext2="select * from returned where a3mflag = 0 and a3gid='"&get_gid&"' and a3oid ='"&oid&"'"
					rs_returned.open sqltext2,conn,1,2
					'����Ѿ��ܵ��˻�����
					returned_amount = 0
					total_amount = 0
					
					if not rs_returned.eof then
             do while not rs_returned.eof
					   returned_amount = returned_amount + rs_returned("a3amount")
					   rs_returned.movenext
					   loop
					end if

          total_amount = returned_amount + amount
					if rs_sold("a2amount") < total_amount then
					'ֻ�д���Ʒ�������������˻������������˻�
				     rs_sold.close
					   response.redirect("messagebox_adv.asp?msg=���˻�������������������������˻�&adv=3")
	           response.end
					else
						dim code,name,brand,price
						dim crttime,crtuser,chgtime,chguser
						code = rs_sold("a2code")
						gid = rs_sold("a2gid")
						name = rs_sold("a2name")
						brand = rs_sold("a2brand")
						buy_price = rs_sold("a2buy_price")
						price = rs_sold("a2sold_price")
						crttime = timestr
						crtuser = username
						chgtime = timestr
						chguser = username

						'�����˻���
						rs_returned.addnew
						rs_returned("a3gid") = gid
						rs_returned("a3name") = name
						rs_returned("a3code") = code
						rs_returned("a3brand") = brand
						rs_returned("a3buy_price") = buy_price
						'�˻��۸�
						rs_returned("a3price") = price
						rs_returned("a3amount") = amount
						rs_returned("a3oid") = oid
						rs_returned("a3mflag") = 0
						rs_returned("a3crttime") = crttime
						rs_returned("a3crtuser") = crtuser
						rs_returned("a3chgtime") = chgtime
						rs_returned("a3chguser") = chguser
						rs_returned("a3reason") = a3reason
						rs_returned("a3status") = 1
						rs_returned.update

            '=====================�˻������,�ȴ�ȷ�Ϻ��ٸ��¿��=====================
						'���¿���
						'dim stock,diff
						'set rs_stock=server.createobject("adodb.recordset")
						'sqltext3="select * from stock where a4gid='"&gid&"'"
						'rs_stock.open sqltext3,conn,1,2
            '
						''response.write(rs_stock("a4gid"))
						''response.write(sqltext3)
            ''response.write("<br>")
            '            
						'stock = rs_stock("a4stock") + amount
						'diff = rs_stock("a4diff") + amount
						'
						''response.write("stock:")
						''response.write stock
            ''response.write("<br>")
						''response.write("diff:")
						''response.write diff
            ''response.write("<br>")
						''response.end
            '
						'rs_stock("a4stock") = stock
						'rs_stock("a4total_money") = rs_stock("a4total_money") + (buy_price * amount)
						'rs_stock("a4diff") = diff
						'rs_stock("a4cflag") = 1
						'rs_stock("a4chgtime") = chgtime
						'rs_stock("a4chguser") = chguser
						'rs_stock.update
            '=====================�˻������,�ȴ�ȷ�Ϻ��ٸ��¿��=====================

                %>
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%username%> ���������˻ش���Ʒ
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
						ԭ��
						</td>
						<td width="180">
						<%=a3reason%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="40"></td>
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
						 <a href="return.asp">10����Զ������˻�ҳ��</a>
						 </td>
					   </tr>
					</table>
			    </td>
			  </tr>
				<%
				    end if
				    rs_returned.Close
				    'rs_stock.Close
				end if
				rs_sold.Close
				conn.close
				set conn=nothing
				%>
				<!-- �˻� End-->
				<%end if %>
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
