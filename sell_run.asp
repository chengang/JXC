<!KDZ Studio Powered at 20070517">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵�����ۻ�ִ��ҳ��
  '          1���ж���Ʒ���鳤�Ⱥ��������鳤���Ƿ����
  '          2���ж����������Ƿ�Ϊ��ֵ
  '          3����ѯ�������Ƿ���ڸö�����
  '             (1)����иö���������
  '          4����ѯ����ѭ���ж���Ļ����Ƿ���ڴ��
  '             (1)������ڴ��������
  '          5��ѭ������������
  '          6��ѭ�����¿���
  '             (1)cflag,sflag��ֵΪ1
  '          7�������Żݶ�����
  '����DB��sold��stock��orderbook
  '����DB��orderbook��stock
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/17  sky@kdz ����
  '2007/05/31  sky@kdz �޸� ��sold��orderbook�м��빺�������
  '2007/06/02  sky@kdz �޸� �ۻ������޸�flag�ֶε�����
  '2007/06/03  sky@kdz �޸� �Żݶ������޸�flag�ֶε�����
  '2007/06/03  sky@kdz �޸� �Żݶ�������ˮ�����ֶε�����
  '2007/06/07  sky@kdz �޸� ����ʱ������۸���뵽�ۻ�����
  '2007/07/01  sky@kdz �޸� ����ʱ���ʷѼ۸���뵽�ʷѱ���
  '2007/07/22  sky@kdz �޸� ��ѯ������ʱ����ѯ�����м���mflag=0������
  '2007/10/29  sky@kdz �޸� ��һ������ʾ����������޸�
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ�����ۻ�ȷ��</TITLE>
<meta http-equiv="refresh" content="90;url=sell.asp">
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
<script language=javascript>
function doPrint() {
window.print(); 
}
</script>
<%
	dim username,power,uid
	username = kdzcookie("tdl_name")
	power = kdzcookie("power")
	uid= kdzcookie("uid")

	'��form��ȡֵ
	dim amount_temp,gid_temp,amount,gid
	dim reduce1,a9postage,oid,pr
	dim gidlist
	amount_temp = request.form("amount")
	gid_temp = request.form("goodslist")
	a9postage = request.form("a9postage")
	reduce1 = request.form("reduce1")
	oid = request.form("oid")
	pr = request.form("pr")

	'�жϹ��ﳵ��Ϊ��
	if gid_temp = "" then
     response.redirect("messagebox.asp?msg=���ﳵΪ��,������������")
	   response.end
	end if
	'�������
	amount = Split(amount_temp,",")
	gid = Split(gid_temp,",")

	'ƴ��
	for i = 0 to UBound(gid)
     gidlist = gidlist&"'"&trim(gid(i))&"',"
  next

    'response.write gidlist
    'response.write ("<br>")
  dim len_gidlist
	len_gidlist = len(gidlist)
	gidlist = left(gidlist,len_gidlist-1)
    'response.write gidlist
    'response.write ("<br>")

	'�ж���Ʒ����������Ƿ���ͬ
	'�˶δ������������鴫�룬����Ӧ����ȣ���Ϊ���ô���
	if UBound(amount) <> UBound(gid) then
     response.redirect("messagebox.asp?msg=��Ʒ���������಻ͬ����ȷ�Ϻ�������")
	   response.end
	end if
    
	'�ж���Ʒ�����Ƿ�Ϊ��ֵ�ͺͱ��������
	for i = 0 to UBound(amount)
	    if not IsNumeric(amount(i)) then
		  response.redirect("messagebox.asp?msg=��Ʒ��������Ϊ���֣�����������")
	    response.end
		end if
	    if amount(i) <= 0 then
      response.redirect("messagebox.asp?msg=��Ʒ������������㣬����������")
	    response.end
		end if
	next
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
	     <td width="160" valign="top">
		   <!--#include file="inc/left_mini.inc"-->
		 </td>
		 <td width="590" valign="top">
				<%
				'ȡϵͳʱ��Ϊ��ֵ
				  dim timestr,flow
					  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

					  flow = timestr&uid
				%>
				<!-- �ۻ� Begin-->
				<%
				   '��ѯ�������Ƿ���ڸö�����
				   dim rs_orderbook
				   set rs_orderbook = server.createobject("adodb.recordset")
					   sqltext1 = "select * from orderbook where a9mflag = 0 and a9oid='"&oid&"'"
					   rs_orderbook.open sqltext1,conn,1,2
                       
					   if not rs_orderbook.eof then
						  '���ڸö���
						  rs_orderbook.close
						  response.redirect("messagebox.asp?msg=�˶����������룬��ȷ�϶�������������")
						  response.end
					   else
						   '��ѯ�����ж����������Ƿ���ڿ������
						   dim rs_stock
						   set rs_stock = server.createobject("adodb.recordset")
						     sqltext2 = "select * "
							   sqltext2 = sqltext2&"from stock "
							   sqltext2 = sqltext2&"where a4gid in ("&gidlist&")"
							   sqltext2 = sqltext2&"order by a4gid"
							   rs_stock.open sqltext2,conn,2,2

							   dim i
							       i = 0
							   do while not rs_stock.eof
							      if int(rs_stock("a4stock")) < int(trim(amount(i))) then
							        '�������С����������
								     response.redirect("messagebox.asp?msg=��Ʒ"&rs_stock("a4name")&"���Ϊ"&rs_stock("a4stock")&",����������")
									   rs_stock.close
								     response.end
								  end if
								  rs_stock.movenext
								  i = i + 1
							   loop
							   
							   rs_stock.movefirst()

							   dim gid_temp2,amount_temp2,diff_temp
							   dim str_name(100),code,str_brand(100),str_buy_price(100),str_price(100)
							   dim str_amount(100),str_price_name
							   dim total_money,money
							   dim j
								   j = 0
								   total_money = 0
								   diff_temp = 0

							   dim rs_sold
				               set rs_sold = server.createobject("adodb.recordset")
					               sqltext3 = "select top 1 * from sold"
					               rs_sold.open sqltext3,conn,1,2

							   do while not rs_stock.eof
								  money = 0
								  gid_temp2 = trim(gid(j))
								  str_amount(j) =int(trim(amount(j)))
								  str_name(j) = rs_stock("a4name")
								  code = rs_stock("a4code")
								  str_brand(j) = rs_stock("a4brand")
								  str_buy_price(j) = rs_stock("a4total_money") / rs_stock("a4stock")
								  'response.write "����"&str_buy_price(j)&"<br>"

								  select case pr
								     case 1
										    str_price(j) = rs_stock("a4price_common")
											  str_price_name = "��ͨ�۸�"
										 case 2
											  str_price(j) = rs_stock("a4price_vip")
											  str_price_name = "VIP�۸�"
										 case 3
										    str_price(j) = rs_stock("a4price_wholesale")
											  str_price_name = "�����۸�"
										 end select
                  money = str_price(j) * str_amount(j)
								  total_money = total_money + money
								
								'ѭ������������
                 rs_sold.addnew
								 rs_sold("a2gid") = gid_temp2
								 rs_sold("a2name") = str_name(j)
								 rs_sold("a2code") = code
								 rs_sold("a2brand") = str_brand(j)
								 rs_sold("a2buy_price") = str_buy_price(j)
								 rs_sold("a2sold_price") = str_price(j)
								 rs_sold("a2amount") = str_amount(j)
								 rs_sold("a2oid") = oid
								 rs_sold("a2flow") = flow
								 '2007/05/31 ��ӿ�ʼ
								 rs_sold("a2status") = pr
								 '2007/05/31 ��ӽ���
								 '2007/06/02 ��ӿ�ʼ
								 rs_sold("a2mflag") = 0
								 '2007/06/02 ��ӽ���
								 rs_sold("a2crttime") = timestr
								 rs_sold("a2crtuser") = username
								 rs_sold("a2chgtime") = timestr
								 rs_sold("a2chguser") = username
								 rs_sold.update
								 'rs_sold.movenext
                                
								 'ѭ�����¿���
								  amount_temp2 = 0
								  amount_temp2 = rs_stock("a4stock") - str_amount(j)
								  diff_temp = rs_stock("a4diff") - str_amount(j)

								  rs_stock("a4total_money") = rs_stock("a4total_money") - (rs_stock("a4total_money")*str_amount(j)/rs_stock("a4stock"))

								  rs_stock("a4stock") = amount_temp2
								  rs_stock("a4diff") = diff_temp
								  rs_stock("a4cflag") = 1
								  rs_stock("a4sflag") = 1
								  rs_stock("a4chgtime") = timestr
								  rs_stock("a4chguser") = username
								  rs_stock.update
								  rs_stock.movenext

							     j = j + 1
							   loop
				       end if
							   
					   '�����Żݶ�����
					   dim fi_money
					   fi_mononey = 0
					   fi_money = total_money - reduce1 + a9postage
					   rs_orderbook.addnew
					   rs_orderbook("a9oid") = oid
					   '2007/06/03 ��ӿ�ʼ
					   rs_orderbook("a9flow") = flow
					   '2007/06/03 ��ӽ���
					   rs_orderbook("a9sub_price") = total_money
					   rs_orderbook("a9price_reduce") = reduce1
					   rs_orderbook("a9postage") = a9postage
					   '2007/05/31 ��ӿ�ʼ
					   rs_orderbook("a9status") = pr
					   '2007/05/31 ��ӽ���
					   '2007/06/03 ��ӿ�ʼ
					   rs_orderbook("a9mflag") = 0
					   '2007/06/03 ��ӽ���
					   rs_orderbook("a9crttime") = timestr
					   rs_orderbook("a9crtuser") = username
					   rs_orderbook("a9chgtime") = timestr
					   rs_orderbook("a9chguser") = username
					   rs_orderbook.update

					   rs_stock.Close
					   rs_sold.Close
					   rs_orderbook.Close
				 '�ر����ӣ��ͷŽ���
				 set conn=nothing
				%>
				<!-- �ۻ� End-->
			 <table width="590" name="pritable" id="pritable" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
	           <tr height = "50"><td colspan="6"></td></tr>
			   <tr height="20" bgcolor="#CCCCCC">
			      <td colspan="6" class="STYLE2" align="center"><b>�� ����<%=str_price_name%>�� ȷ ��</b></td>
			   </tr>
			   <tr height="20" bgcolor="#CCCCCC">
			      <td colspan="3" class="STYLE1" align="left">��ˮ����:(<%=flow%>)</td>
			      <td colspan="3" class="STYLE1" align="left">������:(<%=oid%>)</td>
			   </tr>
			   <tr height="20" bgcolor="#FF6633">
					   <td width="100">��Ʒ����</td>
					   <td width="60">Ʒ ��</td>
					   <td width="100"><%=str_price_name%></td>
					   <td width="30">�� ��</td>
					   <td width="90">¼��ʱ��</td>
					   <td width="40">¼����</td>
			   </tr>
			   <%   dim k,color_td
					k = 0
					k = k + 1
					if k mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
                    
					rs_stock.movefirst()
					dim m
					for m = 0 to UBound(amount)
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=str_name(m)%></td>
					   <td><%=str_brand(m)%></td>
					   <td><%=str_price(m)%></td>
					   <td><%=str_amount(m)%></td>
					   <td><%=kdztimeformat(timestr,"1")%></td>
					   <td><%=username%></td>
					</tr>
			   <%
				    next
			   %>
					<tr height="25" bgcolor="#CCCCCC">
					   <td colspan="2">�ۻ����ܼ۸�Ϊ��<%=total_money%>Ԫ</td>
					   <td colspan="1">�ʷѼ۸�Ϊ��<%=a9postage%>Ԫ</td>
					   <td colspan="1">�Żݼ۸�Ϊ��<%=reduce1%>Ԫ</td>
					   <td colspan="2">���ռ۸�Ϊ��<%=fi_money%>Ԫ</td>
					</tr>
					<tr>
						 <td colspan="6" height="60" align="center" class="STYLE1">
						 <a href="sell.asp">90����Զ������ۻ�ҳ�����ֱ�ӷ���</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="�� ӡ С Ʊ" onclick="doPrint()" class="style_button">
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