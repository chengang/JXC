<!KDZ Studio Powered at 20070719">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵��������޸ĺ�̨ҳ��
  '         1��ǿ���޸Ŀ��
  '����DB��stock,stock_modify
  '����DB��stock
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/07/19  sky@kdz ����
  '2007/07/22  sky@kdz �޸�ʱ�޸�ԭ�������
  '2007/10/30  sky@kdz �޸� ��һ������ʾ����������޸�
  '2008/01/05  sky@kdz �޸� ��Ʒ��ӱ�ע����
  '2008/10/07  sky@kdz �޸� 0����Ʒǿ���޸Ĳ���null�۸������
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>

<HTML>
<HEAD>
<TITLE>������ϵͳ��������޸�ȷ��</TITLE>
<meta http-equiv="refresh" content="10;url=adv_select.asp">
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

				<!-- �޸Ŀ�� Begin-->
				<%
				'��form��ȡֵ
				'gid_temp = trim(request.form("a3gid"))
				dim id,stock,reason
				stock = trim(request.form("stock"))
				reason = trim(request.form("reason"))
				id = trim(request.form("id"))
				'��ѯ����
				dim rs_stock,sqltext1
				set rs_stock=server.createobject("adodb.recordset")
				sqltext1="select * from stock where a4id = '"&id&"'"
				rs_stock.open sqltext1,conn,1,2

				if rs_stock.eof then 
				   'û�в�ѯ����¼
				    rs_stock.close
					  response.redirect("messagebox.asp?msg=ϵͳ��������ϵ����Ա1")
	          response.end
				else
				    dim temp_stock,temp_diff,price
				      '===============0����Ʒǿ���޸Ĳ���null�۸�����⿪ʼ===============
				      '��������д������ܼۻ�������Ϊ����������һ�ν����۸�Ϊ����
				      if (rs_stock("a4total_money") = 0 or rs_stock("a4stock") = 0) then
				          dim a4gid
				          a4gid = rs_stock("a4gid")
				          '��ѯ���һ�ν����۸�
				           dim rs_buy,sqltext_buy
				           set rs_buy=server.createobject("adodb.recordset")
				           sqltext_buy="select top 1 a1buy_price from buy where a1mflag = 0 and a1gid = '"&a4gid&"'order by a1crttime desc "
				           rs_buy.open sqltext_buy,conn,1,1
				           'response.write sqltext_buy & "<br/>"
				           price = rs_buy("a1buy_price")
				           rs_buy.close
				      else
					        price = rs_stock("a4total_money") / rs_stock("a4stock")
					    end if
				      '===============0����Ʒǿ���޸Ĳ���null�۸���������===============
					    temp_stock = rs_stock("a4stock")
						  temp_diff = rs_stock("a4diff") - temp_stock + stock
					
				  dim rs_stock_modify,sqltext2
					set rs_stock_modify=server.createobject("adodb.recordset")
					sqltext2="select top 1 * from stock_modify"
					rs_stock_modify.open sqltext2,conn,1,2
					
          '��ǿ���޸Ŀ����в����޸ĵ�����
					rs_stock_modify.addnew
					rs_stock_modify("a11gid") = rs_stock("a4gid")
					rs_stock_modify("a11name") = rs_stock("a4name")
					rs_stock_modify("a11code") = rs_stock("a4code")
					rs_stock_modify("a11brand") = rs_stock("a4brand")
					rs_stock_modify("a11reason") = reason
					rs_stock_modify("a11amount_old") = temp_stock
					rs_stock_modify("a11amount_new") = stock
					rs_stock_modify("a11price") = price
					rs_stock_modify("a11crttime") = timestr
					rs_stock_modify("a11crtuser") = username
					rs_stock_modify.update

          '���¿���
					rs_stock("a4stock") = stock
					rs_stock("a4diff") = temp_diff
					rs_stock("a4total_money") = stock * price
					rs_stock("a4cflag") = 1
					rs_stock("a4chgtime") = timestr
					rs_stock("a4chguser") = username
					rs_stock.update
				end if

        %>
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%username%> ����Ѿ��޸�
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2">
					  <tr height="20">
					    <td width="50"></td>
					    <td width="100">
						��Ʒ����
						</td>
						<td width="180"><%=rs_stock("a4name")%></td>
					    <td width="50"></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						������
						</td>
						<td><%=rs_stock("a4code")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						Ʒ��
						</td>
						<td><%=rs_stock("a4brand")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						�������
						</td>
						<td><%=stock%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						�������۸�
						</td>
						<td><%=rs_stock("a4buy_price")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						��ͨ��Ա�۸�
						</td>
						<td><%=rs_stock("a4price_common")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						VIP�۸�
						</td>
						<td><%=rs_stock("a4price_vip")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						�����۸�
						</td>
						<td><%=rs_stock("a4price_wholesale")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						��ע
						</td>
						<td><%if IsNull(rs("a4remark")) then response.write ("�ޱ�ע") else response.write (rs("a4remark"))%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						�޸�ʱ��
						</td>
						<td><%=kdztimeformat(rs_stock("a4chgtime"),"1")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						�޸���
						</td>
						<td><%=rs_stock("a4chguser")%>
						</td>
					    <td></td>
					  </tr>
					  <tr height="20">
					    <td></td>
					    <td>
						�޸�ԭ��
						</td>
						<td><%=reason%>
						</td>
					    <td></td>
					  </tr>
					   <tr>
						 <td colspan="4" height="60" align="center" class="STYLE1">
						 <a href="adv_select.asp">10����Զ����ظ߼���ѯҳ��</a>
						 </td>
					   </tr>
					   <%
					   	  rs_stock_modify.Close
				        rs_stock.Close
				        conn.close
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