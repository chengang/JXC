<!KDZ Studio Powered at 20080106">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵��������޸ĺ�̨ҳ��
  '         1��ǿ���޸Ŀ��
  '����DB��stock
  '����DB��stock
  '�޸�����
  '�޸������ա������ߡ�����
  '2008/01/06  sky@kdz ���� ��Ʒ��ӱ�ע����
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>

<HTML>
<HEAD>
<TITLE>������ϵͳ������Ʒ��ע�޸�ȷ��</TITLE>
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

				<!-- �޸ı�ע Begin-->
				<%
				'��form��ȡֵ
				dim id,remark,reason
				remark = trim(request.form("remark"))
				id = trim(request.form("id"))
				'��ѯ����
				dim rs_stock,sqltext1
				set rs_stock=server.createobject("adodb.recordset")
				sqltext1="select * from stock where a4id = '"&id&"'"
				rs_stock.open sqltext1,conn,1,1

                'response.write "sqltext1:"&sqltext1&"<br>"
                'response.write "id:"&id&"<br>"
                'response.write "stock:"&stock
                'response.end

				if rs_stock.eof then 
				  'û�в�ѯ����¼
				  rs_stock.close
					response.redirect("messagebox.asp?msg=ϵͳ��������ϵ����Ա1")
	                response.end
				else
          '���¿���
          if remark ="" then
            sql = "UPDATE stock SET a4remark = NULL where a4id = '"&id&"'"
          else
            sql = "UPDATE stock SET a4remark = '"&remark&"' where a4id = '"&id&"'"
          end if
					conn.execute(sql)
					rs_stock.close
				end if

                %>
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%username%> ��Ʒ��ע�Ѿ��޸�
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
						<td><%=rs_stock("a4stock")%>
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
						<td><%=remark%>
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
