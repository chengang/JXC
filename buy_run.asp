<!KDZ Studio Powered at 20070329">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵����1��������Ʒ���Ʋ�ѯ�������Ƿ��ǰ��������Ʒ
  '             (1)�������,��ѯ����Ʒ��gid
  '             (2)���û��,���ѯgid���ɱ�,gid��һ��Ϊ
  '                ����Ʒ��gid,���Ҹ��µ���Ʒgid���ɱ���
  '          2���ڽ������в��������¼
  '          3�����¿������²�λ��
  '             (1)����д���Ʒ�Ŀ������¿����ͼ۸�
  '             (2)���û�д���Ʒ�Ŀ�������һ���µļ�¼
  '             (3)����gid�Ͳ�λ��ѯ��λ��
  '                ����м�¼����¼�¼����������¼
  '����DB��buy��stock
  '����DB��goods_id_creater
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/11  sky@kdz �޸�
  '2007/05/14  sky@kdz �޸� ��λ����޸�flag�ֶε�׷���޸�
  '2007/05/15  sky@kdz �޸� ͬ����Ʒ��ͬ���������֤
  '2007/06/02  sky@kdz �޸� buy���޸�mflag�ֶε�����
  '2007/06/07  sky@kdz �޸� ����ʱ������۸���뵽������
  '2007/10/29  sky@kdz �޸� ��һ������ʾ����������޸�
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
  '2008/12/23  sky@kdz �޸� ��Ʒ��ʱ�򣬲�check�����۸�
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ��������ȷ��</TITLE>
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
	dim code,gid,name,brand,amount,seat,buy_price
	dim price_common,price_vip,price_wholesale,gifts
	dim crtuser,chguser,gid_temp
	gid_temp = trim(request.form("a1gid"))
	code = trim(request.form("a1code"))
	name = trim(request.form("a1name"))
	brand = trim(request.form("a1brand"))
	amount = trim(request.form("a1amount"))
	seat = trim(request.form("a1seat"))
	gifts = trim(request.form("gifts"))
	buy_price = trim(request.form("a1buy_price"))
	price_common = int(trim(request.form("a1price_common")))
	price_vip = int(trim(request.form("a1price_vip")))
	price_wholesale = int(trim(request.form("a1price_wholesale")))
	crtuser = username
	chguser = username
  if gifts <> "1" then
	   if int(buy_price) >  int(price_wholesale) then
        response.redirect("messagebox.asp?msg=����۸��ܴ��������۸�")
	      response.end
	   end if
	   if int(price_wholesale) >  int(price_vip) then
        response.redirect("messagebox.asp?msg=�����۸��ܴ���VIP�۸�")
	      response.end
	   end if
	   if int(price_vip) >  int(price_common) then
        response.redirect("messagebox.asp?msg=VIP�۸��ܴ�����ͨ��Ա�۸�")
	      response.end
	   end if
  else
     price_common = 0
     price_vip = 0
     price_wholesale = 0
	end if
	if gid_temp = "" then
		dim rs_buy_code,sqltext_code,rs_buy_code_name
		set rs_buy_code = server.createobject("adodb.recordset")
		sqltext_code = "select a1name from buy "
		sqltext_code = sqltext_code&"where a1code='"&code&"'"
		'response.write sqltext_code
		'response.end
		rs_buy_code.open sqltext_code,conn,1,1

		while not rs_buy_code.eof
		  if name = rs_buy_code("a1name") then
		   rs_buy_code.close
		   response.redirect("messagebox.asp?msg=����Ʒ���Ѿ����ڣ���ȷ�Ϻ���������")
		   response.end
		  end if
		rs_buy_code.movenext
		wend
		rs_buy_code.close
	end if
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
				'ȷ����ʲô����
				  dim FromPage
					  FromPage = request.form("FromPage")
				'ȡϵͳʱ��Ϊ��ֵ
				  dim timestr
					  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
				%>

				<%if FromPage = "add" then%>
				<!-- ���� Begin-->
				<%
				   dim rs_goods_id_creater
				   set rs_goods_id_creater = server.createobject("adodb.recordset")
					   sqltext2 = "select * from goods_id_creater where a7reason = 'gid_creater'"
					   rs_goods_id_creater.open sqltext2,conn,1,2

					   dim goods_id_creater
					   if rs_goods_id_creater.eof then
						  'û�в�ѯ����¼
						  response.redirect("messagebox.asp?msg=����ϵ����Ա����ʼ�����ݿ�")
						  rs_goods_id_creater.Close
						  response.end
					   else

							'��ѯ�������Ƿ��ǰ��������Ʒ
							dim rs_buy
							set rs_buy = server.createobject("adodb.recordset")
								sqltext1 = "select * "
								sqltext1 = sqltext1&"from buy "
								sqltext1 = sqltext1&"where a1name='"&name&"' and a1gid <>'' "
								sqltext1 = sqltext1&"order by a1crttime"
								rs_buy.open sqltext1,conn,1,2

								if not rs_buy.eof Then
								   '----------------------------------------------------------------------------------------------------
								   '------------------------------------------070605�¸��޸�and gid_temp = ""---------------------------
								   '�ж�ͬ����Ʒ�Ƿ�ӵ�в�ͬ��������
								   if rs_buy("a1code") <> code and gid_temp = "" then
								    'response.write("DB"&rs("a1code"))
									  'response.write("<br>")
									  'response.write("page"&code)
								    response.redirect("messagebox.asp?msg=ͬһ����Ʒ�����в�ͬ�������룬��ȷ�Ϻ�������")
									  'response.end
								   end if
								   '------------------------------------------070605�¸��޸�and gid_temp = ""---------------------------
								   '----------------------------------------------------------------------------------------------------


								   '�����˻�,��ѯ����Ʒ��gid�����ѽ�����¼���뵽��������
								   'response.write ("�ڽ��������и���Ʒ")
								   'response.write("<br>")
								   gid = rs_buy("a1gid")
								   'response.write ("a1gid:")
								   'response.write (gid)
								   'response.write ("<br>")
								   
								else
								   'û��������Ʒ����ѯ��Ʒ����ID��������ƷID���Ѽ�¼�嵽��������
								   'response.write ("�ڽ�������û�в�ѯ������Ʒ")
								   'response.write("<br>")
									 '��Ʒ����ID��1���µ�����
									  goods_id_creater = clng(rs_goods_id_creater("a7id")) + 1
									  rs_goods_id_creater("a7id") = goods_id_creater
									  rs_goods_id_creater.Update
									  'response.write("�����µ���ƷID�����µ�����")
									  'response.write ("<br>")
								    rs_goods_id_creater.Close
								    gid="g"&goods_id_creater
								   'response.write gid
								   'response.write ("<br>")
								   'response.end
								end if

								 '�ѽ�����¼���뵽��������
								 rs_buy.addnew
								 rs_buy("a1code")=code
								 rs_buy("a1gid")=gid
								 rs_buy("a1name")=name
								 rs_buy("a1brand")=brand
								 rs_buy("a1amount")=amount
								 rs_buy("a1seat")=seat
								 rs_buy("a1buy_price")=buy_price
								 rs_buy("a1price_common")=price_common
								 rs_buy("a1price_vip")=price_vip
								 rs_buy("a1price_wholesale")=price_wholesale
								 rs_buy("a1mflag")=0
								 rs_buy("a1crttime")=int(timestr)
								 rs_buy("a1crtuser")=crtuser
								 rs_buy("a1chgtime")=int(timestr)
								 rs_buy("a1chguser")=chguser
								 'response.write ("db_code:")
								 'response.write (rs_buy("a1code"))
								 'response.write ("<br>")
								 rs_buy.update
								 rs_buy.close
								 'response.write("������¼�Ѳ��뵽��������")

							'�ѽ�����¼���µ��������
							'��ѯ�������Ƿ��и���Ʒ�Ŀ��
							dim rs_stock,stock,total_money
							set rs_stock = server.createobject("adodb.recordset")
								sqltext3 = "select top 1 * "
								sqltext3 = sqltext3&"from stock "
								sqltext3 = sqltext3&"where a4gid='"&gid&"'"
								sqltext3 = sqltext3&"order by a4crttime"
								rs_stock.open sqltext3,conn,1,2
								if not rs_stock.eof then
								  '��ѯ����¼�����¿��
								  stock = int(rs_stock("a4stock")) + amount
								  total_money = int(rs_stock("a4total_money")) + amount * buy_price
								  'response.write ("����ǰ���:")
								  'response.write (rs_stock("a4stock"))
								  'response.write ("<br>")
								  'response.write ("���º���:")
								  'response.write stock
								  'response.write ("<br>")
								  'response.end
								  rs_stock("a4stock") = stock
								  rs_stock("a4buy_price")=buy_price
								  rs_stock("a4price_common")=price_common
								  rs_stock("a4price_vip")=price_vip
								  rs_stock("a4price_wholesale")=price_wholesale
								  rs_stock("a4total_money")=total_money
								  rs_stock("a4chgtime")=int(timestr)
								  rs_stock("a4chguser")=chguser
								  'response.write("����Ѹ���")
								else
								  'û�в�ѯ����¼���ڱ��в���һ����¼
								  rs_stock.Addnew
								  rs_stock("a4gid")=gid
								  rs_stock("a4code")=code
								  rs_stock("a4name")=name
								  rs_stock("a4brand")=brand
								  rs_stock("a4stock")=amount
								  rs_stock("a4buy_price")=buy_price
								  rs_stock("a4price_common")=price_common
								  rs_stock("a4price_vip")=price_vip
								  rs_stock("a4price_wholesale")=price_wholesale
								  rs_stock("a4total_money")=amount * buy_price
								  rs_stock("a4cflag")=0
								  rs_stock("a4crttime")=int(timestr)
								  rs_stock("a4crtuser")=crtuser
								  rs_stock("a4chgtime")=int(timestr)
								  rs_stock("a4chguser")=chguser
								 'response.write ("db_code:")
								 'response.write (rs_buy("a1code"))
								 'response.write ("<br>")
								 'response.write("������¼�Ѳ�����")
								end if
							  rs_stock.Update
								rs_stock.Close

							'��ѯ��λ��
							'����м�¼����£�����Ϊ����
							dim rs_seat,total_amount
							set rs_seat = server.createobject("adodb.recordset")
								sqltext4 = "select top 1 * "
								sqltext4 = sqltext4&"from seat "
								sqltext4 = sqltext4&"where a10gid='"&gid&"' and a10seat = '"&seat&"'"
								sqltext4 = sqltext4&"order by a10crttime"
								rs_seat.open sqltext4,conn,1,2
								if not rs_seat.eof then
								  '��ѯ����¼�����¿��
								  total_amount = int(rs_seat("a10amount")) + amount
								  'response.write ("����ǰ��λ���:")
								  'response.write (rs_seat("a10amount"))
								  'response.write ("<br>")
								  'response.write ("���º��λ���:")
								  'response.write total_amount
								  'response.write ("<br>")
								  'response.end
								  rs_seat("a10amount") = total_amount
								  rs_seat("a10chgtime")=int(timestr)
								  rs_seat("a10chguser")=chguser
								  'response.write("����Ѹ���")
								else
								  'û�в�ѯ����¼���ڱ��в���һ����¼
								  rs_seat.Addnew
								  rs_seat("a10gid")=gid
								  rs_seat("a10name")=name
								  rs_seat("a10code")=code
								  rs_seat("a10seat")=seat
								  rs_seat("a10amount")=amount
								  rs_seat("a10crttime")=int(timestr)
								  rs_seat("a10crtuser")=crtuser
								  rs_seat("a10chgtime")=int(timestr)
								  rs_seat("a10chguser")=chguser
								 'response.write ("db_code:")
								 'response.write (rs_buy("a1code"))
								 'response.write ("<br>")
								 'response.write("������¼�Ѳ����λ��")
								end if
							  rs_seat.Update
								rs_seat.Close
				%>
				<!-- ���� End-->
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%=username%> ����¼�����Ʒ
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2">
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						�����룺
						</td>
						<td width="180">
						<%=code%>
						</td>
					    <td width="50"></td>
					  </tr>
					  
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						��Ʒ���ƣ�
						</td>
						<td width="180">
						<%=name%>
						</td>
					    <td width="50"></td>
					  </tr>

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
						������
						</td>
						<td width="180">
						<%=amount%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						��λ��
						</td>
						<td width="180">
						<%=seat%>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						����۸�
						</td>
						<td width="180">
						<%=buy_price%>
						</td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						��ͨ�۸�
						</td>
						<td width="180">
						<%=price_common%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						vip�۸�
						</td>
						<td width="180">
						<%=price_vip%>
						</td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">
						�����۸�
						</td>
						<td width="180">
						<%=price_wholesale%>
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
				  <%  end if
					  set conn=nothing
			      end if
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
