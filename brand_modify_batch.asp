<!--kdz studio powered at 20090215">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵���������޸�Ʒ�����Ƶ�ǰ̨
  '����DB����
  '����DB��stock
  '�޸�����
  '�޸������ա������ߡ�����
  '2009/02/15  sky@kdz ���� ���������޸�Ʒ�����ƹ���
%>
<html>
<head>
<title>������ϵͳ���������޸�Ʒ������</title>
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
<script language="javascript" src="inc/jstrim.js"></script>
<script language="javascript">
function bodyini()
{
  form1.new_brand.focus(); 
}
function incheck(inform){
  if (confirm('�˲�����������ݿ������д���Ʒ�ļ�¼��ȷ����?') == false)
  {
	return false;
  }
  if (jstrim(inform.new_brand.value) == "")
  {
    alert ("�������޸ĺ��Ʒ�����ƣ�");
	inform.new_brand.focus();
	return false;
  }
}
</script>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")
%>
</head>

<body onload="bodyini()">
<table width="762" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
  <tr><td align="center"><img src="image\logo.gif"></td></tr>
  <tr><td align="right">
       <%if power = "5" then%>
	       <!--#include file="inc/top_admin.inc"-->
	     <%else%>
         <!--#include file="inc/top.inc"-->
	     <%end if%></td></tr>
  <tr><td align="center">
	    <table width="760" cellpadding="0" cellspacing="0" style="border-right:#ff0000 6px solid;border-top:#ff0000 6px solid;border-bottom:#ff0000 6px solid;border-left:#ff0000 6px solid;">
	      <tr><td width="380"><!--#include file="inc/left.inc"--></td>
		        <td width="380" valign="top"><br>
		            <table>
                   <tr><td><table class="style1" align="center" width="330">
                           <tr><td><!--#include file="inc/marquee_tips.inc"--></td></tr>
                           </table></td></tr>
			             <tr><td><table class="style2" align="center">
					                 <form id="form1" name="form1" method="post" onsubmit = "return incheck(this)" action="brand_modify_batch_run.asp">
					                   <tr height="50">
                               <td width="50"></td>
                               <td width="100">�޸�Ʒ��</td>
                               <td width="180"><select name="old_brand" style="width:150px;font-size:9pt;">
						<%dim rs,recordcount
				       '�ڽ������У���ѯȫ���Ľ�����¼���
				          set rs=server.createobject("adodb.recordset")
					          sqltext = "select a4brand "
					          sqltext = sqltext&"from stock group by a4brand order by a4brand desc"
					          rs.open sqltext,conn,1,1
                    recordcount = rs.recordcount
							      'response.write recordcount
					          'response.end
					     for i = 1 to recordcount
             %>
							<option><%=rs("a4brand")%></option>
						 <% rs.movenext
							next
						 %>
                               </select></td>
						  <%rs.close
						    set conn = nothing
						  %>
                               <td width="50"></td></tr>
                             <tr  height="50">
                               <td width="50"></td>
                               <td width="100">�޸ĳ�</td>
                               <td width="180"><input type="text" name="new_brand" maxlength="20"></td>
                               <td width="50"></td></tr>
                             <tr><td colspan="4" height="80" align="center"><input type="submit" name="submit" value="��         ��" class="style_button"></td></tr>
                           </form>
					                 </table></td></tr>
			          </table>
            </td>
	      </tr>
	    </table>
	    </td>
  </tr>
	<tr><td>
       <%if power = "5" then%>
	       <!--#include file="inc/bottom_admin.inc"-->
	     <%else%>
         <!--#include file="inc/bottom.inc"-->
	     <%end if%></td></tr>
	<tr><td align="center"><img src="image\logo_mini.gif"></td></tr>
</table>
</body>
</html>
