<!KDZ Studio Powered at 20070627">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<%response.Expires = 0%>
<!--#include file="inc/conn.asp"-->
<%'����˵����������ϸҳ��
  '          ���ݶ����Ų�ѯ�ö������ۻ����˻���ϸ
  '����DB����
  '����DB��orderbook,sold,returned
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/06/27  sky@kdz ����
  '2007/07/01  sky@kdz �޸� �ۻ�ʱ�����ʷѵ��޸�
  '2007/07/22  sky@kdz �޸� �������ͷ�
  '2007/07/27  sky@kdz �޸� �˻���ϸ������
  '2007/10/30  sky@kdz �޸� ��һ������ʾ����������޸�
  '2008/01/02  sky@kdz �޸� �˻����������۸��ֶα��Ϊ����ɱ�
  '2008/11/08  sky@kdz �޸� �޸��˻�����
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
  '2008/12/28  sky@kdz �޸� �ۻ�����Ʒ��ʱ��ע��Ϊ��Ʒ
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ����������ϸ</TITLE>
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
			   height: 28px; 
			   background-color: #ddeeff"
			   }
-->
</style>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim oid,frompage
oid = trim(request.queryString("oid"))

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
	     <td width="160" valign="top">
		   <!--#include file="inc/left_mini.inc"-->
		 </td>
		 <td width="590" valign="top">
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
	           <tr height = "50"><td colspan="9"></td></tr>
			   <tr height="20"><td colspan="9" class="STYLE2" align="center"><b>�� �� (<%=oid%>) �� ϸ</b></td></tr>
			   <%
				 dim rs_ob,sqltext_ob,price_reduce
				 '�ڶ������У����ݿ�ʼ�ͽ���ʱ���ѯ
         set rs_ob= server.createobject("adodb.recordset")
             sqltext_ob = "select * from orderbook "
             sqltext_ob = sqltext_ob&"where a9mflag = 0 and a9oid = '"&oid&"'"
             'response.write sqltext
             'response.end
             rs_ob.open sqltext_ob,conn,1,1

						 price_reduce = rs_ob("a9price_reduce")
						 order_price = rs_ob("a9sub_price")+ rs_ob("a9postage") - rs_ob("a9price_reduce")
			   %>
			   <tr height="20"><td colspan="9" class="STYLE2" align="left"><b>�� �� �� Ϣ</b></td></tr>
					<tr height="20" bgcolor="#FF6633">
					   <td>������</td>
					   <td>��ˮ����</td>
					   <td>�������</td>
					   <td>�Ż�ǰ���</td>
					   <td>�ʷѽ��</td>
					   <td>�Żݽ��</td>
					   <td>¼��ʱ��</td>
					   <td>¼����</td>
					   <td align="center">����</td>
					</tr>
					<tr height="25">
					   <td><%=rs_ob("a9oid")%></td>
					   <td><%=rs_ob("a9flow")%></td>
					   <td><%=(rs_ob("a9sub_price")+ rs_ob("a9postage") - rs_ob("a9price_reduce"))%></td>
					   <td><%=rs_ob("a9sub_price")%></td>
					   <td><%=rs_ob("a9postage")%></td>
					   <td><%=rs_ob("a9price_reduce")%></td>
					   <td><%=kdztimeformat(rs_ob("a9crttime"),"2")%></td>
					   <td><%=rs_ob("a9crtuser")%></td>
					   <td align="center"><A HREF = "orderbook_delete.asp?oid=<%=oid%>&frompage=adv" onclick="return confirm('ȷ��ɾ���˶���?')">ɾ��</A></td>
					</tr>
			   <%'�ر����ӣ��ͷŽ���
				 rs_ob.close
			   %>
			   <tr height="20"><td colspan="9" class="STYLE2" align="left"><b>�� �� �� ϸ</b></td></tr>
			   <%
				 dim rs
				 '���ۻ����У����ݶ����Ų�ѯ�ö������ۻ���ϸ
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select "
					 sqltext = sqltext&"a2id,a2code,a2name,a2brand,a2oid,a2buy_price,a2sold_price,a2amount,a2chgtime,a2chguser " 
					 sqltext = sqltext&"from sold where a2mflag = 0  and a2oid = '"&oid&"'"
					 'response.write sqltext
					 'response.end
					 rs.open sqltext,conn,1,1
				 '�����ѯ����¼,����ʾ��ҳ����
				 if not rs.eof Then
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>������</td>
					   <td>��Ʒ����</td>
					   <td>Ʒ ��</td>
					   <td>�ۻ��۸�</td>
					   <td>�ۻ�����</td>
					   <td>�޸�ʱ��</td>
					   <td>�޸���</td>
					   <td colspan="2" align="center">����</td>
					</tr>
			   <%   dim i,color_td
					i = 0
					set a2id = rs("a2id")
					set a2oid = rs("a2oid")
					set a2code = rs("a2code")
					set a2name = rs("a2name")
					set a2brand = rs("a2brand")
					set a2buy_price = rs("a2buy_price")
					set a2sold_price = rs("a2sold_price")
					set a2amount = rs("a2amount")
					set a2chgtime = rs("a2chgtime")
					set a2chguser = rs("a2chguser")

					dim total_cost,total_gain
						total_cost = 0
						total_gain = 0

					do while not rs.eof
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if

					total_cost = total_cost + (a2buy_price * a2amount)
					total_gain = total_gain + ( (a2sold_price - a2buy_price) * a2amount )

			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a2code%></td>
					   <td><%=a2name%></td>
					   <td><%=a2brand%></td>
					   <td><%if int(a2sold_price)= 0 then response.write "<font color=red>��Ʒ</font>" else response.write a2sold_price end if%></td>
					   <td><%=a2amount%></td>
					   <td><%=kdztimeformat(a2chgtime,"2")%></td>
					   <td><%=a2chguser%></td>
					   <td  colspan="2" align="center"><A HREF = "sell_modify.asp?a2id=<%=a2id%>&frompage=oid=<%=oid%>">�޸�</A></td>
					</tr>
			   <%	rs.movenext
					loop
				 else
					response.redirect("messagebox.asp?msg=Ŀǰ��û���ۻ���¼")
					response.end
				 end if
				 '�ر����ӣ��ͷŽ���
				 rs.close
				 %>
			   <tr height="20"><td colspan="9" class="STYLE2" align="left"><b>�� �� �� ϸ</b></td></tr>
			   <%
				 dim rs_return,sqltext_return
				 '���˻����У����ݶ����Ų�ѯ�ö������˻���ϸ
				 set rs_return=server.createobject("adodb.recordset")
					 sqltext_return = "select R.a3code,R.a3name,R.a3brand,R.a3price,R.a3amount,R.a3chgtime,R.a3chguser,R.a3reason,R.a3status,S.a2buy_price "
					 sqltext_return = sqltext_return&"from returned R,sold S "
					 sqltext_return = sqltext_return&"where R.a3gid = S.a2gid "
					 sqltext_return = sqltext_return&"and R.a3mflag = 0  and a3status <> 1 and R.a3oid = '"&oid&"' "
					 sqltext_return = sqltext_return&"and S.a2mflag = 0  and S.a2oid = '"&oid&"' "
					 'response.write sqltext_return
					 'response.end
					 rs_return.open sqltext_return,conn,1,1
			   %>
					<tr height="20" bgcolor="#FF6633">
					   <td>������</td>
					   <td>��Ʒ����</td>
					   <td>Ʒ ��</td>
					   <td>�˻��۸�</td>
					   <td>�˻�����</td>
					   <td>�˻�ʱ��</td>
					   <td>�˻���</td>
					   <td>�˻�ԭ��</td>
					   <td>״̬</td>
					   <!--<td align="center">����</td>-->
					</tr>
			   <%   
				 '�����ѯ����¼,����ʾ��ҳ����
				 if not rs_return.eof Then
				  dim j,color_j
					j = 0
					set a3code = rs_return("a3code")
					set a3name = rs_return("a3name")
					set a3brand = rs_return("a3brand")
					set a3price = rs_return("a3price")
					set a3amount = rs_return("a3amount")
					set a3chgtime = rs_return("a3chgtime")
					set a3chguser = rs_return("a3chguser")
					set a3reason = rs_return("a3reason")
					set a3status = rs_return("a3status")

					set a2buy_price = rs_return("a2buy_price")
					'response.write "<br>"&rs_return("a2buy_price")

					'response.write total_cost&"<br>"
					'response.write total_gain&"<br>"

					do while not rs_return.eof
					j = j + 1
					if j mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if

					total_cost = total_cost - (a2buy_price * a3amount)
					total_gain = total_gain - ( (a3price - a2buy_price) * a3amount )
					'response.write total_cost&"<br>"
					'response.write total_gain&"<br>"

			   %>
					<tr height="20" bgcolor="<%=color_j%>">
					   <td><%=a3code%></td>
					   <td><%=a3name%></td>
					   <td><%=a3brand%></td>
					   <td><%=a3price%></td>
					   <td><%=a3amount%></td>
					   <td><%=kdztimeformat(a3chgtime,"2")%></td>
					   <td><%=a3chguser%></td>
					   <td><%=a3reason%></td>
					   <td><%if int(a3status) = 1 then response.write ("������") else response.write ("��ȷ��") end if%></td>
					   <!--<td align="center">�޸�</td>-->
					</tr>
			   <%	rs_return.movenext
					loop
				 else
				 response.write("<tr><td colspan="& 9 &" align= left>û���˻���¼</td></tr>")
				 end if
			   %>
			   <tr height="20"><td colspan="9" class="STYLE2" align="left"><b>�� �� �� ��</b></td></tr>
					<tr height="20" bgcolor="#FF6633">
					   <td colspan="2">��������</td>
					   <td colspan="7">����ë����</td>
					</tr>
					<tr height="20" bgcolor="#FFFFFF">
					   <td colspan="2"><%=round((total_gain-price_reduce)/total_cost,4)*100%>%</td>
					   <td colspan="7"><%=round((total_gain-price_reduce)/order_price,4)*100%>%</td>
					</tr>
			   <%
				 '�ر����ӣ��ͷŽ���
				 rs_return.close
				 %>
			   <%
				 conn.close
				 set conn=nothing
			   %>
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
