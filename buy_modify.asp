<!KDZ Studio Powered at 20070110">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵���������༭ҳ��
  '����DB����
  '����DB��buy
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/06/02  sky@kdz ����
  '2007/08/05  sky@kdz �޸� ��������ȥ�ո�Ĵ���
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ����������ѯ�༭</TITLE>
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
 if(inform.a1amount.value < 0) 
  { 
            alert("������������Ϊ��ֵ��");
            inform.a1amount.focus(); 
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
id = trim(request.queryString("a1id"))
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
	           <tr height = "50"><td colspan="7"></td></tr>
			   <tr height="20"><td colspan="7" class="STYLE2" align="center"><b>�� �� �� ��</b></td></tr>
			   <%
				 dim rs
				 '�����Զ���Ų�ѯҪ�޸ĵļ�¼
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select * " 
					 sqltext = sqltext&"from buy where a1id ="&id
					 'response.write sqltext
					 'response.end
					 rs.open sqltext,conn,1,1
			   %>
			     <form id="form1" name="form1" method="post" onsubmit = "return incheck(this)" action="buy_modify_run.asp">
					<tr height="20" bgcolor="#FF6633">
					   <td>������</td>
					   <td>��Ʒ����</td>
					   <td>Ʒ ��</td>
					   <td>�� ��</td>
					   <td>�� λ</td>
					   <td>¼��ʱ��</td>
					   <td>¼����</td>
					</tr>
			   <%   dim a1id,a1code,a1name,a1brand
			        dim a1amount,a1seat,a1crttime,a1crtuser
					set a1id = rs("a1id")
					set a1code = rs("a1code")
					set a1name = rs("a1name")
					set a1brand = rs("a1brand")
					set a1amount = rs("a1amount")
					set a1seat = rs("a1seat")
					set a1crttime = rs("a1crttime")
					set a1crtuser = rs("a1crtuser")
			   %>
					<tr height="25">
					   <td><%=a1code%></td>
					   <td><%=a1name%></td>
					   <td><%=a1brand%></td>
					   <td><input type="text" name="a1amount" maxlength="6" onfocus="this.select();" style="width:60px" value="<%=a1amount%>">
					       <input type="hidden" name="a1id" value="<%=a1id%>">
						   <input type="hidden" name="frompage" value="<%=frompage%>"></td>
					   <td><%=a1seat%></td>
					   <td><%=kdztimeformat(a1crttime,"1")%></td>
					   <td><%=a1crtuser%></td>
					</tr>
					<tr>
			        <td align="center" colspan="7"><input type="submit" name="submit" class="style_button" value="  ��    ��  "></td>
			        </tr>
			   <%
			     '�ر����ӣ��ͷŽ���
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