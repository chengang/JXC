<!kdz studio powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵����1������ģ���ǰ̨
  '          2��JS��֤ ������         �ǿ�
  '			           ��Ʒ����       �ǿ�
  '			           Ʒ��           �ǿ�
  '			           ����           �ǿա�����
  '			           ��λ           �ǿ�
  '			           ����۸�       �ǿա�����
  '			           ��ͨ��Ա�۸�   �ǿա�����  
  '			           vip��Ա�۸�    �ǿա�����
  '			           �����۸�       �ǿա�����
  '����DB����
  '����DB��seat,buy
  '����ҳ��buy_run.asp
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/23  sky@kdz ����
  '2007/07/21  sky@kdz �޸� ȡ����λ���볤�ȵ�����
  '2007/08/05  sky@kdz �޸� ��������ȥ�ո�Ĵ���
  '2007/08/22  sky@kdz �޸� ����ʱ��λŪ�������б�
  '2007/12/18  sky@kdz �޸� ���������ֹ�����ַ����޸�
  '2008/01/01  cg@kdz  �޸� ����tips����
  '2008/12/28  sky@kdz �޸� ������Ʒ����
%>
<html>
<head>
<title>������ϵͳ��������</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #ffffff;
}
.style1 {font-size:9pt}
.style2 {font-size:10.5pt}
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
<!--��������check-->
<script language="javascript" src="inc/jstrim.js">
</script>
<script language="javascript">
function bodyini()
{
  form1.a1name.focus(); 
}
function incheck(inform){
  if (jstrim(inform.a1name.value) == "")
  {
            alert ("��������Ʒ���ƣ�");
			inform.a1name.focus();
			return false;
  }
  if( isValidString(inform.a1name.value) == -1 )
  {
			alert ("������Ʒ���Ʋ����������ַ�");
			inform.a1name.focus();
			return false;
  }
  if (jstrim(inform.a1brand.value) == "")
  {
            alert ("��������ƷƷ�ƣ�");
			inform.a1brand.focus();
			return false;
  }
  if( isValidString(inform.a1brand.value) == -1 )
  {
			alert ("����������ƷƷ�Ʋ����������ַ�");
			inform.a1brand.focus();
			return false;
  }
  if (jstrim(inform.a1amount.value) == "")
  {
            alert ("���������������");
			inform.a1amount.focus();
			return false;
  }
 if(isNaN(inform.a1amount.value)) 
  { 
            alert("������������Ϊ���֣�");
            inform.a1amount.focus(); 
            return false; 
   } 
  if (inform.a1amount.value < 0)
  {
            alert ("��������Ϊ��ֵ��");
			inform.a1amount.focus();
			return false;
  }
  if (jstrim(inform.a1seat.value) == "")
  {
            alert ("�������λ��");
			inform.a1seat.focus();
			return false;
  }
  if( isValidString(inform.a1seat.value) == -1 )
  {
      alert ("�����λ�����������ַ�");
	    inform.a1seat.focus();
	    return false;
  }
  if (jstrim(inform.a1buy_price.value) == "")
  {
      alert ("����������۸�");
			inform.a1buy_price.focus();
			return false;
  }
 if(isNaN(inform.a1buy_price.value)) 
  { 
            alert("�۸����Ϊ���֣�");
            inform.a1buy_price.focus(); 
            return false; 
   } 
  if (inform.a1buy_price.value < 0)
  {
            alert ("�۸���Ϊ��ֵ��");
			inform.a1buy_price.focus();
			return false;
  }
if (inform.gifts.checked == false )
{
  if (jstrim(inform.a1price_common.value) == "")
  {
            alert ("��������ͨ��Ա�۸�");
			inform.a1price_common.focus();
			return false;
  }
 if(isNaN(inform.a1price_common.value)) 
  { 
            alert("�۸����Ϊ���֣�");
            inform.a1price_common.focus(); 
            return false; 
   } 
  if (inform.a1price_common.value < 0)
  {
            alert ("�۸���Ϊ��ֵ��");
			inform.a1price_common.focus();
			return false;
  }
  if (jstrim(inform.a1price_vip.value) == "")
  {
            alert ("������vip�۸�");
			inform.a1price_vip.focus();
			return false;
  }
 if(isNaN(inform.a1price_vip.value)) 
  { 
            alert("�۸����Ϊ���֣�");
            inform.a1price_vip.focus(); 
            return false; 
   } 
  if (inform.a1price_vip.value < 0)
  {
            alert ("�۸���Ϊ��ֵ��");
			inform.a1price_vip.focus();
			return false;
  }
  if (jstrim(inform.a1price_wholesale.value) == "")
  {
            alert ("�����������۸�");
			inform.a1price_wholesale.focus();
			return false;
  }
 if(isNaN(inform.a1price_wholesale.value)) 
  { 
            alert("�۸����Ϊ���֣�");
            inform.a1price_wholesale.focus(); 
            return false; 
   } 
  if (inform.a1price_wholesale.value < 0)
  {
            alert ("�۸���Ϊ��ֵ��");
			inform.a1price_wholesale.focus();
			return false;
  }
}
}
</script>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

'��form��ȡֵ
dim gid,a1code
code = trim(request.form("a1code"))
gid = trim(request.form("a4gid"))
'response.write gid
'��ѯ���������Ƿ��и���Ʒ�Ľ�����¼
dim rs_buy
set rs_buy = server.createobject("adodb.recordset")
	sqltext = "select top 1 * "
	sqltext = sqltext&"from buy "
	sqltext = sqltext&"where a1gid='"&gid&"' "
	sqltext = sqltext&"order by a1crttime desc"
	rs_buy.open sqltext,conn,1,1
    
	dim name,brand,seat,buy_price
	dim price_common,price_vip,price_wholesale
	if not rs_buy.eof then
	   name = rs_buy("a1name")
       brand = rs_buy("a1brand")
       seat = rs_buy("a1seat")
       buy_price = rs_buy("a1buy_price")
       price_common = rs_buy("a1price_common")
       price_vip = rs_buy("a1price_vip")
       price_wholesale = rs_buy("a1price_wholesale")
  end if

'�ڲ�λ���в�ѯ���еĲ�λ
dim rs_seat,sqltext_seat
set rs_seat=server.createobject("adodb.recordset")
    sqltext_seat = "select distinct a10seat,sum(a10amount) as seat_amount "
	  sqltext_seat = sqltext_seat&"from seat "
	  sqltext_seat = sqltext_seat&"group by a10seat order by a10seat"
	  'response.write sqltext_seat
	  'response.end
	  rs_seat.open sqltext_seat,conn,1,1

%>
</head>

<body onload="bodyini()">
<table width="762" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
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
	<table width="760" cellpadding="0" cellspacing="0" style="border-right:#ff0000 6px solid;border-top:#ff0000 6px solid;border-bottom:#ff0000 6px solid;border-left:#ff0000 6px solid;">
	   <tr>
	     <td width="380">
		   <!--#include file="inc/left.inc"-->
		   </td>
		   <td width="380" valign="top">
		    <br>
		    <table>
			  <tr>
			    <td>
				    <table class="style1" align="center" width="330"><tr><td>
					  <!--#include file="inc/marquee_tips.inc"-->
					</td></tr></table>
				  </td>
			  </tr>
			  <tr>
			    <td>
				  <table class="style2" align="center">
					<form id="form1" name="form1" method="post" onsubmit = "return incheck(this)" action="buy_run.asp">
				    <input name="frompage" type="hidden" value="add">
					  
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">������</td>
						  <td width="180"><font color="#666666"><% response.write(code) %></font>
						  <input type="hidden" name="a1code" value="<%=code%>"></td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">��Ʒ����</td>
						  <td width="180">
						  <%if gid="" then%><input type="text" name="a1name" maxlength="20">
						  <%else response.write name%>
						  <input type="hidden" name="a1name" value="<%=name%>">
						  <input type="hidden" name="a1gid" value="<%=gid%>">
						  <%end if%></td>
					    <td width="50"></td>
					  </tr>
					 
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">Ʒ��</td>
						  <td width="180">
						  <%if gid="" then%><input type="text" name="a1brand" maxlength="10">
						  <%else response.write brand%>
						  <input type="hidden" name="a1brand" value="<%=brand%>">
						  <%end if%></td>
					    <td width="50"></td>
					   </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">����</td>
						  <td width="180"><input type="text" name="a1amount" maxlength="6"></td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">��λ</td>
						  <td width="180">
						  <select name="a1seat" style="width:150px;font-size:9pt;">
					    <%
						   rs_seat.movefirst
						   while not rs_seat.eof
						   if rs_seat("a10seat")=seat then%>
							 <option value="<%=rs_seat("a10seat")%>" selected="selected"><%=rs_seat("a10seat")%></option>
						   <%else%>
							 <option value="<%=rs_seat("a10seat")%>"><%=rs_seat("a10seat")%></option>
						   <%end if%>
						  <%
						   rs_seat.movenext
						   wend%>
					    </select></td>
					    <td width="50"></td>
					   </tr>
					 
					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">����۸�</td>
						  <td width="180"><input type="text" name="a1buy_price" maxlength="10" value="<%=buy_price%>"></td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">��ͨ��Ա�۸�</td>
						  <td width="180"><input type="text" name="a1price_common" maxlength="10" value="<%=price_common%>"></td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">vip��Ա�۸�</td>
						  <td width="180"><input type="text" name="a1price_vip" maxlength="10" value="<%=price_vip%>"></td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">�����۸�</td>
						  <td width="180"><input type="text" name="a1price_wholesale" maxlength="10" value="<%=price_wholesale%>"></td>
					    <td width="50"></td>
					  </tr>

					  <tr>
					    <td width="50" height="20"></td>
					    <td width="100">��Ʒ</td>
						  <td width="180"><input type="checkbox" name="gifts" value="1" <% if gid<>"" and int(price_common) = 0 then response.write "checked" end if %> ></td>
					    <td width="50"></td>
					  </tr>

					   <tr>
						 <td colspan="4" height="60" align="center"><input type="submit" name="submit" value="¼ �� �� �� Ʒ" class="style_button">
						 </td>
					   </tr>
					   <%
	             rs_buy.close
	             rs_seat.close
	             set conn=nothing
					   %>
					   </form>
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
</body>
</html>