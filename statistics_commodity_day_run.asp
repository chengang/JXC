<!KDZ Studio Powered at 20070805">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵������Ʒ������ͳ�ƺ�̨
  '����DB����
  '����DB����
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/08/05  sky@kdz ����
  '2007/08/09  sky@kdz �޸� �����˻��������
  '2007/08/10  sky@kdz �޸� �춯���е�ǿ���޸Ŀ�����������
  '2007/10/25  sky@kdz �޸� ��Ȩ��Ϊ1���û�������Ʒ����ͳ��Ȩ��
  '2007/11/14  sky@kdz �޸� ���Ӱ��ղ�ѯ��������
  '2008/07/02  sky@kdz �޸� �ۻ�����ҳ����޸�
  '2008/11/08  sky@kdz �޸� �޸��˻�����
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ������Ʒ������ͳ��</TITLE>
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
uid = kdzcookie("uid")

'���ܴ�form����ֵ
dim starttime,endtime,brand,goodname
if request.form("startyear") <> "" then
   starttime = trim(request.form("startyear"))&trim(request.form("startmonth"))&trim(request.form("startday"))&"000000"
   endtime = trim(request.form("endyear"))&trim(request.form("endmonth"))&trim(request.form("endday"))&"250000"
   brand = trim(request.form("brand"))
   goodname = trim(request.form("goodname"))
else
   starttime = trim(request.queryString("starttime"))
   endtime = trim(request.queryString("endtime"))
   brand = trim(request.queryString("brand"))
   goodname = trim(request.queryString("goodname"))
end if

'response.write starttime & "<br>"
'response.write endtime & "<br>"
'response.write brand & "<br>"
'response.write goodname & "<br>"
'response.end

dim str_sta,str_end,count
str_sta = mid(starttime,1,4)&"-"&mid(starttime,5,2)&"-"&mid(starttime,7,2)
str_end = mid(endtime,1,4)&"-"&mid(endtime,5,2)&"-"&mid(endtime,7,2)
count = datediff("d",str_sta,str_end)

'�жϽ��ܵ��Ŀ�ʼʱ��ͽ�ֹʱ���Ƿ�Ϊ����
if (not isDate(str_sta) or not isDate(str_end))then
   response.redirect("messagebox.asp?msg=����Ĳ������ڣ���ȷ�Ϻ�������")
   response.end
end if

'��������ڿ�ʼʱ��ͽ�ֹʱ��֮�ڵ���������
dim temp_date()
redim temp_date(count)
temp_date(0) = str_sta
for i = 1 to count
    temp_date(i) = dateadd("d",1,temp_date(i-1))
next

'����������ת����ַ�����
dim str_date()
redim str_date(count)
for i = 0 to count
	str_date(i) = int((Year(temp_date(i)))&right("0"&CStr(Month(temp_date(i))),2)&right("0"&CStr(day(temp_date(i))),2))
	'response.write str_date(i) & "<br>"
next

'����������ʱ��ͽ�������
dim rs_buy
set rs_buy= server.createobject("adodb.recordset")
sqltext_buy = "select left(a1crttime,8) buy_date,sum(a1amount) buy_amount,sum(a1amount*a1buy_price) buy_money "
sqltext_buy = sqltext_buy&"from buy "
sqltext_buy = sqltext_buy&"where a1mflag = 0 and "
sqltext_buy = sqltext_buy&"a1crttime >= '"&starttime&"' and a1crttime <= '"&endtime&"' "

if brand <> "" then
sqltext_buy = sqltext_buy&" and a1brand like '%"&brand&"%'"
end if
if goodname <> "" then
sqltext_buy = sqltext_buy&" and a1name like '%"&goodname&"%'"
end if

sqltext_buy = sqltext_buy&"group by left(a1crttime,8) order by left(a1crttime,8)"
rs_buy.open sqltext_buy,conn,1,1

'response.write sqltext_buy & "<br>"

'�ѽ����������������������
dim amount_buy(),buy_money()
redim amount_buy(count),buy_money(count)
for i = 0 to count
   if str_date(i) = int(rs_buy("buy_date")) then
      amount_buy(i) = rs_buy("buy_amount")
      buy_money(i) = rs_buy("buy_money")
	  rs_buy.movenext
   end if
   
'response.write str_date(i)&"  "
'response.write amount_buy(i) & "<br>"
next
rs_buy.close

'�������ۻ�ʱ����ۻ�����
dim rs_sold
set rs_sold= server.createobject("adodb.recordset")
sqltext_sold = "select left(a2crttime,8) sold_date,sum(a2amount) sold_amount,sum(a2amount*a2sold_price) sold_money "
sqltext_sold = sqltext_sold&"from sold "
sqltext_sold = sqltext_sold&"where a2mflag = 0 and "
sqltext_sold = sqltext_sold&"a2crttime >= '"&starttime&"' and a2crttime <= '"&endtime&"' "

if brand <> "" then
sqltext_sold = sqltext_sold&" and a2brand like '%"&brand&"%'"
end if
if goodname <> "" then
sqltext_sold = sqltext_sold&" and a2name like '%"&goodname&"%'"
end if

sqltext_sold = sqltext_sold&"group by left(a2crttime,8) order by left(a2crttime,8)"
rs_sold.open sqltext_sold,conn,1,1

'response.write sqltext_sold & "<br>"

'���ۻ����������ۻ���������
dim amount_sold(),sold_money()
redim amount_sold(count),sold_money(count)
for i = 0 to count
   if str_date(i) = int(rs_sold("sold_date")) then
      amount_sold(i) = rs_sold("sold_amount")
      sold_money(i) = rs_sold("sold_money")
	  rs_sold.movenext
   end if
'response.write str_date(i)&"  "
'response.write amount_sold(i) & "<br>"
next
rs_sold.close

'�������˻�ʱ����˻�����
dim rs_return
set rs_return= server.createobject("adodb.recordset")
sqltext_return = "select left(a3crttime,8) return_date,sum(a3amount) return_amount,sum(a3amount*a3price) return_money "
sqltext_return = sqltext_return&"from returned "
sqltext_return = sqltext_return&"where a3mflag = 0 and a3status <> 1 and "
sqltext_return = sqltext_return&"a3crttime >= '"&starttime&"' and a3crttime <= '"&endtime&"' "

if brand <> "" then
sqltext_return = sqltext_return&" and a3brand like '%"&brand&"%'"
end if
if goodname <> "" then
sqltext_return = sqltext_return&" and a3name like '%"&goodname&"%'"
end if

sqltext_return = sqltext_return&"group by left(a3crttime,8) order by left(a3crttime,8)"
rs_return.open sqltext_return,conn,1,1

'response.write sqltext_return & "<br>"

'���˻����������˻���������
dim amount_return(),return_money()
redim amount_return(count),return_money(count)
for i = 0 to count
   if str_date(i) = int(rs_return("return_date")) then
      amount_return(i) = rs_return("return_amount")
      return_money(i) = rs_return("return_money")
	  rs_return.movenext
   end if
'response.write str_date(i)&"  "
'response.write amount_sold(i) & "<br>"
next
rs_return.close

'������ǿ���޸Ŀ��ʱ���ǿ���޸Ŀ������
dim rs_stock_modify
set rs_stock_modify= server.createobject("adodb.recordset")
sqltext_stock_modify = "select left(a11crttime,8) stock_modify_date,sum(a11amount_new - a11amount_old) stock_modify_amount "
sqltext_stock_modify = sqltext_stock_modify&"from stock_modify "
sqltext_stock_modify = sqltext_stock_modify&"where a11crttime >= '"&starttime&"' and a11crttime <= '"&endtime&"' "

if brand <> "" then
sqltext_stock_modify = sqltext_stock_modify&" and a11brand like '%"&brand&"%'"
end if
if goodname <> "" then
sqltext_stock_modify = sqltext_stock_modify&" and a11name like '%"&goodname&"%'"
end if

sqltext_stock_modify = sqltext_stock_modify&"group by left(a11crttime,8) order by left(a11crttime,8)"
rs_stock_modify.open sqltext_stock_modify,conn,1,1

'response.write sqltext_stock_modify & "<br>"

'��ǿ���޸Ŀ����������ǿ���޸Ŀ����������
dim amount_stock_modify()
redim amount_stock_modify(count)
for i = 0 to count
   if str_date(i) = int(rs_stock_modify("stock_modify_date")) then
      amount_stock_modify(i) = rs_stock_modify("stock_modify_amount")
	  rs_stock_modify.movenext
   end if
'response.write str_month(i)&"  "
'response.write amount_stock_modify(i) & "<br>"
next
rs_stock_modify.close

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
	           <tr height = "50"><td colspan="8"></td></tr>
			   <tr height="20"><td colspan="8" class="STYLE2" align="right"><b>�� Ʒ �� �� (��) �� ѯ �� ��</b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
			       <a href = "statistics_commodity_day_all_run.asp?starttime=<%=starttime%>&endtime=<%=endtime%>&brand=<%=brand%>&goodname=<%=goodname%>"><span class="STYLE1">��ʾȫ������</span></a></td>
			   </tr>
					<tr height="20" bgcolor="#FF6633">
					   <td colspan="8">��ѯ����Ϊ��</td>
					</tr>
					<tr height="25">
					   <td>��ֹʱ��</td>
					   <td><%=str_sta%></td>
					   <td>����ʱ��</td>
					   <td><%=str_end%></td>
					   <td>Ʒ��</td>
					   <td><%if brand = "" then response.write ("��") else response.write brand %></td>
					   <td>��Ʒ����</td>
					   <td><%if goodname = "" then response.write ("��") else response.write goodname %></td>
					</tr>
					<tr height="20" bgcolor="#FF6633">
					   <td>ʱ��</td>
					   <td colspan="2">��������</td>
					   <td colspan="2">�ۻ�����</td>
					   <td colspan="2">�˻�����</td>
					   <td>ǿ���޸�����</td>
					</tr>
			   <%   dim i,j,color_td
			            j = 0
					for i = 0 to count
                        if (amount_buy(i) <> "" or amount_sold(i) <> "" or amount_return(i) <> "" or amount_stock_modify(i) <> "") then
                           if j mod 2 = 0 then
					          color_td = "#CCFFFF"
					       else
					          color_td = "#FFFFFF"
					       end if
						   j = j + 1
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=kdztimeformat(str_date(i),"3")%></td>
					   <td colspan="2"><%if amount_buy(i) <> "" then response.write(amount_buy(i)&"(��"&round(buy_money(i),2)&")") end if%></td>
					   <td colspan="2">
					       <!--<a href = "inquire_orderbook_select_run.asp?starttime=<%=str_date(i)&"000000"%>&endtime=<%=str_date(i)&"240000"%>"><%if amount_sold(i) <> "" then response.write(amount_sold(i)&"(��"&round(sold_money(i),2)&")") end if%></a>-->
						   <a href = "inquire_sell_select.asp?starttime=<%=str_date(i)&"000000"%>&endtime=<%=str_date(i)&"240000"%>&brand=<%=brand%>&goodname=<%=goodname%>"><%if amount_sold(i) <> "" then response.write(amount_sold(i)&"(��"&round(sold_money(i),2)&")") end if%></a>
					   </td>
					   <td colspan="2"><%if amount_return(i) <> "" then response.write(amount_return(i)&"(��"&round(return_money(i),2)&")") end if%></td>
					   <td><%if amount_stock_modify(i) <> "" then if amount_stock_modify(i) < 0 then response.write("����"&amount_stock_modify(i)) else response.write("����"&amount_stock_modify(i)) end if%></td>
					</tr>
			   <%
                        end if
                    next
				%>
				<%
				  if j = 0 then
				     response.write("<tr><td colspan="& 8 &" align= left>û�в�ѯ�����������ļ�¼</td></tr>")
				  end if
				 '�ͷŽ���
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