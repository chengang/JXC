<!KDZ Studio Powered at 20070722">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵��������춯��¼
  '          ��ѯ���п���춯��¼
  '����DB����
  '����DB��stock_modify
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/07/22  sky@kdz ����
  '2007/07/03  sky@kdz �޸� ���������Ӽ��ٵ���ʾ��������������
  '2007/12/16  sky@kdz �޸� ����춯��¼������ٴβ�ѯ����
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
  '2008/11/23  sky@kdz �޸� ¼���ˡ��޸�����ID��ʾ����Ϊ�����ֱ�ʾ
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ��������춯��¼</TITLE>
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
dim name,brand,code

if (request.queryString("a11name") = "" and request.queryString("a11brand") = "" and request.queryString("a11code") = "") then
   name = trim(request.form("a11name"))
   brand = trim(request.form("a11brand"))
   code = trim(request.form("a11code"))
else
   name = request.queryString("a11name")
   brand = request.queryString("a11brand")
   code = request.queryString("a11code")
end if

'��ȡ�����ֶ���
dim ipage,index_word,que,sequence

'��ȡҳ��
ipage = request.queryString("pagen")

'��ȡ�����ֶ���
if request.queryString("orderby") = "" then
   index_word = "a11crttime"
else
   index_word = request.queryString("orderby")
end if

'��ȡ����˳��
que = int(request.queryString("que"))
if que="" then
   que = 0
end if
if que mod 2 = 0 then
  sequence = "desc"
else
  sequence = "asc"
end if
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
		     <form id="form1" name="form1" method="post" action="stock_abnormal.asp">
		     <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" valign="bottom">
			   <tr>
			     <td colspan="7" class="STYLE2" align="center"><b>�� �� �� ѯ</b>
				 </td>
			   </tr>
			   <tr>
			     <td>������<input type="text" name="a11code"  style="width:110;">
				 </td>
			     <td>��Ʒ����<input type="text" name="a11name" style="width:110;">
				 </td>
			     <td>Ʒ��<input type="text" name="a11brand"  style="width:110;">
				 </td>
			     <td><input type="submit" name="Submit" value="��ѯ" style="width:60;">
				 </td>
			   </tr>
			 </table>
			 </form>
			 <table width="590" class="STYLE1" border="1" cellpadding="5" cellspacing="0" align="right" valign="bottom">
			   <tr height="20"><td colspan="9" class="STYLE2" align="center"><b>�� �� �� �� �� ¼</b></td></tr>
			   <%
				 dim rs
				 '��ǿ���޸Ŀ���У���ѯȫ����¼
				 set rs=server.createobject("adodb.recordset")
					 sqltext = "select a11name,a11code,a11brand,a11amount_old,a11amount_new,"
					 sqltext = sqltext&"a11amount_old - a11amount_new  diff,a11crttime,a11crtuser,a11reason "
					 sqltext = sqltext&"from stock_modify "
					 sqltext = sqltext&"where a11code like '%"&code&"%' and a11name like '%"&name&"%' and a11brand like '%"&brand&"%' "
					 sqltext = sqltext&"order by "&index_word&" "&sequence
					 'response.write sqltext
					 'response.end
					 rs.open sqltext,conn,1,1
					 rs.pagesize = 20
					 pagec = rs.pagecount
					 rs.absolutepage = ipage

					 'dim recordc
					 'recordc = rs.recordcount
					 'response.write recordc
					 'response.write pagec
					 'response.end
				 '�����ѯ����¼,����ʾ��ҳ����
				 if not rs.eof Then
			   %>
					<tr>
					  <td colspan="9" align="right">
					     <input name="orderby" type="hidden" value="<%=index_word%>">
					     <input name="que" type="hidden" value="<%=que%>">
					     <input name="code" type="hidden" value="<%=code%>">
					     <input name="a11name" type="hidden" value="<%=name%>">
					     <input name="brand" type="hidden" value="<%=brand%>">
					     ��<%=pagec%>ҳ&nbsp;&nbsp;&nbsp;��
						  <%
							if ipage = "" then
							   que = que + 1
							end if
						%>
					     <select name="pagen" style="width:45px;font-size:9pt;" onChange="window.location.href('stock_abnormal.asp?pagen='+pagen.value+'&a11code='+code.value+'&a11name='+a11name.value+'&a11brand='+brand.value+'&orderby='+orderby.value+'&que='+que.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>ҳ
					  </td>
					</tr>
					<tr height="20" bgcolor="#FF6633">
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11name&que=<%=que%>">��Ʒ����</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11code&que=<%=que%>">������</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11brand&que=<%=que%>">Ʒ��</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11amount_old&que=<%=que%>">�޸�ǰ����</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11amount_new&que=<%=que%>">�޸ĺ�����</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=diff&que=<%=que%>">�������</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11crttime&que=<%=que%>">¼��ʱ��</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11crtuser&que=<%=que%>">¼����</a></td>
					   <td><a href = "stock_abnormal.asp?a11code=<%=code%>&a11name=<%=name%>&a11brand=<%=brand%>&orderby=a11reason&que=<%=que%>">�޸�ԭ��</a></td>
					</tr>
			   <%   dim i,color_td
					i = 0
					set a11name = rs("a11name")
					set a11code = rs("a11code")
					set a11brand = rs("a11brand")
					set a11amount_old = rs("a11amount_old")
					set a11amount_new = rs("a11amount_new")
					set diff = rs("diff")
					set a11reason = rs("a11reason")
					set a11crttime = rs("a11crttime")
					set a11crtuser = rs("a11crtuser")
					do while ((not rs.eof) and i < rs.pagesize)
					i = i + 1
					if i mod 2 = 0 then
					color_td = "#CCFFFF"
					else
					color_td = "#FFFFFF"
					end if
			   %>
					<tr height="25" bgcolor="<%=color_td%>">
					   <td><%=a11name%></td>
					   <td><%=a11code%></td>
					   <td><%=a11brand%></td>
					   <td><%=a11amount_old%></td>
					   <td><%=a11amount_new%></td>
					   <td><%if diff > 0 then
					            response.write ("<font color=red>����</font>")
							     else if diff < 0 then
							             response.write ("����")
								        else
								           response.write ("����")
								        end if
						       end if
							%>
					   </td>
					   <td><%=kdztimeformat(a11crttime,"1")%></td>
					   <td><%=a11crtuser%></td>
					   <td><%=a11reason%></td>
					</tr>
			   <%	rs.movenext
					loop
				%>
					<tr>
					  <td colspan="9" align="right">��<%=pagec%>ҳ&nbsp;&nbsp;&nbsp;��
					     <select name="pagen2" style="width:45px;font-size:9pt;" onChange="window.location.href('stock_abnormal.asp?pagen='+pagen2.value+'&a11code='+code.value+'&a11name='+a11name.value+'&a11brand='+brand.value+'&orderby='+orderby.value+'&que='+que.value)" >
						 <%for i = 1 to pagec%>
							<option value="<%=i%>"<%if int(i)=int(ipage) then response.write("selected") end if%>><%=i%></option>
						 <%next%>
						  </select>ҳ
					  </td>
					</tr>
				 <%else
					response.redirect("messagebox.asp?msg=Ŀǰ��û�п���춯��¼")
					response.end
				 end if
				 '�ر����ӣ��ͷŽ���
				 rs.close
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
