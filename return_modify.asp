<!KDZ Studio Powered at 20070110">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵�����˻��༭ҳ��
  '����DB����
  '����DB��returned
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/06/03  sky@kdz ����
  '2007/08/05  sky@kdz �޸� ��������ȥ�ո�Ĵ���
  '2008/11/08  sky@kdz �޸� �޸��˻�����
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ�����˻���ѯ�༭</TITLE>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #FFFFFF;
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
function incheck(inform){
  if (jstrim(inform.a3amount.value) == "")
  {
            alert ("�������˻�������");
			inform.a3amount.focus();
			return false;
  }
 if(isNaN(inform.a3amount.value)) 
  { 
            alert("�˻���������Ϊ���֣�");
            inform.a3amount.focus(); 
            return false; 
   } 
 if(inform.a3amount.value < 0) 
  { 
            alert("�˻���������Ϊ��ֵ��");
            inform.a3amount.focus(); 
            return false; 
   } 
}
</script>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")

dim id,frompage
id = trim(request.queryString("a3id"))
frompage = trim(request.queryString("frompage"))

'response.write frompage
'response.end
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
	     <td width="160" valign="top">
		   <!--#include file="inc/left_mini.inc"-->
		 </td>
		 <td width="590" valign="top">
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
	       <tr height = "50"><td colspan="9"></td></tr>
			   <%
				 dim rs
				 '�����Զ���Ų�ѯҪ�޸ĵļ�¼
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select * " 
					 sqltext = sqltext&"from returned where a3status = 1 and a3id ="&id
					 'response.write sqltext
					 'response.end
					 rs.open sqltext,conn,1,1
					 if rs.eof then
              response.redirect("messagebox.asp?msg=����������ȷ�Ϻ����޸�")
              response.end
					 else
			   %> 
			   <tr height="20"><td colspan="9" class="STYLE2" align="center"><b>�� �� �� ��</b></td></tr>
			     <form id="form1" name="form1" method="post" onsubmit = "return incheck(this)" action="return_modify_run.asp">
					<tr height="20" bgcolor="#FF6633">
					   <td>������</td>
					   <td>��Ʒ����</td>
					   <td>Ʒ ��</td>
					   <td>�� ��</td>
					   <td>�� ��</td>
					   <td>������</td>
					   <td>����ʱ��</td>
					   <td>������</td>
					   <td>�˻�ԭ��</td>
					</tr>
			   <%   
			        dim a3id,a3code,a3name,a3brand,a3price,a3amount,a3oid
					dim a3crttime,a3crtuser
					set a3id = rs("a3id")
					set a3code = rs("a3code")
					set a3name = rs("a3name")
					set a3brand = rs("a3brand")
					set a3price = rs("a3price")
					set a3amount = rs("a3amount")
					set a3oid = rs("a3oid")
					set a3crttime = rs("a3crttime")
					set a3crtuser = rs("a3crtuser")
					set a3reason = rs("a3reason")
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a3code%></td>
					   <td><%=a3name%></td>
					   <td><%=a3brand%></td>
					   <td><%=a3price%></td>
					   <td><input type="text" name="a3amount" maxlength="6" onfocus="this.select();" style="width:60px" value="<%=a3amount%>">
					       <input type="hidden" name="a3id" value="<%=a3id%>">
						   <input type="hidden" name="frompage" value="<%=frompage%>"></td>
					   <td><%=a3oid%></td>
					   <td><%=kdztimeformat(a3crttime,"1")%></td>
					   <td><%=a3crtuser%></td>
					   <td><%=a3reason%></td>
					</tr>
					<tr>
			        <td align="center" colspan="9"><input type="submit" name="submit" class="style_button" value="  ��    ��  "></td>
			        </tr>
			   <%
				 '�ر����ӣ��ͷŽ���
				 end if
				 rs.close
				 conn.close
				 set conn=nothing
			   %>
			   </form>
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