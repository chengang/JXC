<!KDZ Studio Powered at 20070602">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵�����ۻ��༭ִ��ҳ��
  '         1����ѯ�ۻ�����˻����ж��������������ܴ����˻�����
  '         2���ж����������Ĳ��ܳ������
  '         2�����¿���
  '         3�������ۻ���
  '         4�����¶�������ۻ����
  '����DB��sold��stock,oderbook
  '����DB��return
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/06/02  sky@kdz ����
  '2007/06/27  sky@kdz �޸� �Ӳ�ͬҳ�����
  '                         �޸ĺ���ת��ͬ��ҳ��
  '2007/07/01  sky@kdz �޸� �ۻ�ʱ�����ʷѽ����޸�
  '                         �޸��ۻ�ʱ,������ͬʱ�����ʷѽ��
  '2007/07/21  sky@kdz �޸� �ظ��޸��ۻ�bug���޸�
  '2007/10/29  sky@kdz �޸� ��һ������ʾ����������޸�
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim id,amount,frompage
id = trim(request.form("a2id"))
amount = trim(request.form("a2amount"))
frompage = trim(request.form("frompage"))
response.write left(frompage,3)
response.write ("<br>")
response.write frompage
'response.end


'ȡϵͳʱ��Ϊ��ֵ
dim timestr
    timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)

'�����Զ���Ų�ѯ�ۻ���
dim rs_sold,a2id,a2gid,a2name,a2code,a2brand,a2buy_price,a2sold_price,a2amount
dim a2oid,a2flow,a2status,a2mflag,a2crttime,a2crtuser
set rs_sold=server.createobject("adodb.recordset")
    sqltext1 = "select * " 
    sqltext1 = sqltext1&"from sold where a2mflag = 0 and a2id ="&id
    'response.write sqltext1
	  'response.write ("<br>")
	  'response.end
    rs_sold.open sqltext1,conn,1,2

if rs_sold.eof then
   response.redirect("messagebox.asp?msg=�벻Ҫ��������ϵĺ��˰�ť�����޸ģ����²�ѯ�����޸�")
   response.end
else
  a2id = rs_sold("a2id")
	a2gid = rs_sold("a2gid")
	a2name = rs_sold("a2name")
	a2code = rs_sold("a2code")
	a2brand = rs_sold("a2brand")
  '--------------------------------------------------------------------------------------
  '---------------------------070627����۸������---------------------------------------
	a2buy_price = rs_sold("a2buy_price")
  '---------------------------070627����۸������---------------------------------------
  '--------------------------------------------------------------------------------------
	a2sold_price = rs_sold("a2sold_price")
	a2amount = rs_sold("a2amount")
	a2oid = rs_sold("a2oid")
	a2flow = rs_sold("a2flow")
	a2status = rs_sold("a2status")
	a2crttime = rs_sold("a2crttime")
	a2crtuser = rs_sold("a2crtuser")
	'�޸����������Ĳ�
	diff_amount = amount - a2amount
	diff_monoy = diff_amount * a2sold_price

    'response.write a2amount
    'response.write ("<br>")
    'response.write diff_amount
    'response.write ("<br>")
    'response.write a2sold_price
    'response.write ("<br>")
    'response.write diff_monoy
    'response.write ("<br>")
    'response.end

    '�����ۻ������Ʒgid�Ͷ����Ų�ѯ�˻���
	dim rs_return,a3amount,total_amount
	set rs_return=server.createobject("adodb.recordset")
    sqltext2 = "select a3amount " 
    sqltext2 = sqltext2&"from returned where a3gid ='"&a2gid&"' and a3oid ='"&a2oid&"' and a3mflag = 0"
    'response.write sqltext2
    'response.write ("<br>")
	  'response.end
    rs_return.open sqltext2,conn,1,1

	'����Ʒ�˻������ϼƵ����
	if not rs_return.eof then
	   total_amount = 0
	   do while not rs_return.eof
	   total_amount = total_amount + rs_return("a3amount")
     rs_return.movenext
	   loop

       'response.write "total_amount="&total_amount
       'response.write ("<br>")
       'response.write "amount="&amount
       'response.write ("<br>")
       'response.end

	   '�ж�������������С���˻�����
	   if total_amount - amount > 0 then
	      rs_return.close
	      rs_sold.close
	      set conn = nothing
	      response.redirect("messagebox.asp?msg=������������С���˻�����")
	      response.end
     end if
	end if
    re_return.close

    '�ж��޸����������Ĳ��ܳ������
    '����gid��ѯ����
    dim rs_stock,stock,diff
    set rs_stock=server.createobject("adodb.recordset")
        sqltext3 = "select * " 
        sqltext3 = sqltext3&"from stock where a4gid ='"&a2gid&"'"
       'response.write sqltext3
       'response.write ("<br>")
	     'response.end
       rs_stock.open sqltext3,conn,1,2

       stock = rs_stock("a4stock")
	     diff = 0
	     diff = rs_stock("a4diff")

	   'response.write stock
	   'response.write ("<br>")
	   'response.write diff
	   'response.write ("<br>")
	   'response.write diff_amount
	   'response.write ("<br>")
	   'response.end

	   '�޸ĺ�����������Ϊ��ֵ
	   if stock - diff_amount < 0 then
	      rs_sold.close
	      re_return.close
	      rs_stock.close
	      set conn = nothing
	      response.redirect("messagebox.asp?msg=��ֹ�޸ģ��Ƿ�����")
	      response.end
	   end if

    '�ж��޸ĺ���������С���Żݽ��
    dim rs_orderbook,fi_sub_price,a9sub_price,a9postage,a9price_reduce
	  dim a9id,a9oid,a9flow,a9status,a9crttime,a9crtuser
	  set rs_orderbook = server.createobject("adodb.recordset")
	  sqltext4 = "select * from orderbook where a9mflag = 0 and a9oid='"&a2oid&"'"
    'response.write sqltext4
    'response.write ("<br>")
	  'response.end
	rs_orderbook.open sqltext4,conn,1,2

    if not rs_orderbook.eof then
	   a9sub_price = rs_orderbook("a9sub_price")
     '--------------------------------------------------------------------------------------
     '---------------------------070701�ʷѽ�������---------------------------------------
	   a9postage = rs_orderbook("a9postage")
     '---------------------------070701�ʷѽ�������---------------------------------------
     '--------------------------------------------------------------------------------------
	   a9price_reduce = rs_orderbook("a9price_reduce")
	   a9id = rs_orderbook("a9id")
	   a9oid = rs_orderbook("a9oid")
     '--------------------------------------------------------------------------------------
     '---------------------------070627��ˮ���ŵ�����---------------------------------------
	   a9flow = rs_orderbook("a9flow")
     '---------------------------070627��ˮ���ŵ�����---------------------------------------
     '--------------------------------------------------------------------------------------
	   a9status = rs_orderbook("a9status")
	   a9crttime = rs_orderbook("a9crttime")
	   a9crtuser = rs_orderbook("a9crtuser")
	   
	   fi_sub_price = a9sub_price + diff_monoy
	   
	   if fi_sub_price - a9price_reduce < 0 then
	      rs_sold.close
	      re_return.close
        rs_stock.close
        rs_orderbook.close
	      set conn = nothing
	      response.redirect("messagebox.asp?msg=�Żݽ�������������,��ֹ�޸ģ��Ƿ�����")
	      response.end
	   end if
	   
	   '�����Żݶ�����
	   '����ɾ�����޸ĵ���������
	   rs_orderbook("a9mflag") = 1
	   rs_orderbook("a9chgtime") = timestr
	   rs_orderbook("a9chguser") = username
	   rs_orderbook.update

     '����һ���޸ĺ������
     rs_orderbook.addnew
	   rs_orderbook("a9oid") = a9oid
     '--------------------------------------------------------------------------------------
     '---------------------------070627��ˮ���ŵ�����---------------------------------------
	   rs_orderbook("a9flow") = a9flow
     '---------------------------070627��ˮ���ŵ�����---------------------------------------
     '--------------------------------------------------------------------------------------
	   rs_orderbook("a9sub_price") = fi_sub_price
     '--------------------------------------------------------------------------------------
     '---------------------------070701�ʷѽ�������---------------------------------------
	   rs_orderbook("a9postage") = a9postage
     '---------------------------070701�ʷѽ�������---------------------------------------
     '--------------------------------------------------------------------------------------
	   rs_orderbook("a9price_reduce") = a9price_reduce
	   rs_orderbook("a9status") = a9status
	   rs_orderbook("a9mflag") = 0
	   rs_orderbook("a9relation") = a9id
	   rs_orderbook("a9crttime") = a9crttime
	   rs_orderbook("a9crtuser") = a9crtuser
	   rs_orderbook("a9chgtime") = timestr
	   rs_orderbook("a9chguser") = username
	   rs_orderbook.update
   end if
   rs_orderbook.close

	'���¿���
	rs_stock("a4total_money") = rs_stock("a4total_money") - (a2buy_price * diff_amount)

	rs_stock("a4stock") = stock - diff_amount
	rs_stock("a4diff") = diff - diff_amount
	rs_stock("a4cflag") = 1
	rs_stock("a4chgtime") = timestr
  rs_stock("a4chguser") = username
	'response.write stock
	'response.write ("<br>")
	'response.write diff
	'response.end
	rs_stock.update
	rs_stock.close

	'�����ۻ���
  '����ɾ�����޸ĵ���������
	rs_sold("a2mflag") = 1
	rs_sold("a2chgtime") = timestr
	rs_sold("a2chguser") = username
	rs_sold.update

	'����һ���޸ĺ������
	rs_sold.addnew
	rs_sold("a2gid") = a2gid
	rs_sold("a2name") = a2name
	rs_sold("a2code") = a2code
	rs_sold("a2brand") = a2brand
  '--------------------------------------------------------------------------------------
  '---------------------------070627����۸������---------------------------------------
	rs_sold("a2buy_price") = a2buy_price
  '---------------------------070627����۸������---------------------------------------
  '--------------------------------------------------------------------------------------
	rs_sold("a2sold_price") = a2sold_price
	rs_sold("a2amount") = amount
	rs_sold("a2oid") = a2oid
	rs_sold("a2flow") = a2flow
	rs_sold("a2status") = a2status
	rs_sold("a2mflag") = 0
	rs_sold("a2relation") = a2id
	rs_sold("a2crttime") = a2crttime
	rs_sold("a2crtuser") = a2crtuser
	rs_sold("a2chgtime") = timestr
	rs_sold("a2chguser") = username
	rs_sold.update
	rs_sold.close

	set conn = nothing

	if frompage = "adv" then
       response.redirect("admin_sell_select.asp")
	   response.end
	elseif left(frompage,3) = "oid" then
       response.redirect("admin_orderbook_particular.asp?"&frompage)
	   response.end
	else
       response.redirect("sell_select.asp")
       response.end
	end if
end if
%>