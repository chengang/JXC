<%'����˵����ҳ����߱������ļ�
  '����DB����
  '����DB��history_login
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/12/30  cg@kdz  �޸� ���ӵ����¼��ȫ����

'��ѯ��ʷ�����û����һ�ε����¼
dim rs_history_login2,sqltext_history_login2
dim logintime2,loginip2,loginnum2
set rs_history_login2 = server.createobject("adodb.recordset")
sqltext_history_login2 = "select a15logintime,a15loginip,a15loginnum "
sqltext_history_login2 = sqltext_history_login2&"from history_login "
sqltext_history_login2 = sqltext_history_login2&"where a15uid='"&uid&"' and a15work = '"&"1"&"' order by a15id desc"
'response.write sqltext_history_login2
rs_history_login2.open sqltext_history_login2,conn,1,1
rs_history_login2.movenext
logintime2 = rs_history_login2("a15logintime")
loginip2 = rs_history_login2("a15loginip")
loginnum2 = rs_history_login2("a15loginnum")
rs_history_login2.close

'��ѯ�û��������״̬
set rs_tdl=server.createobject("adodb.recordset")
sqltext_tdl = "select a1status,count(*) as num from  tdl_tasklist where a1pointuser='"&username&"' and a1creatuser<>'ϵͳ' group by a1status "
rs_tdl.open sqltext_tdl,conn,1,1
while not rs_tdl.eof
	if rs_tdl("a1status")="���" then
		complete_num = rs_tdl("num")
	end if
	if rs_tdl("a1status")="δ���" then
		ing_num = rs_tdl("num")
	end if
	rs_tdl.movenext
wend

%>
	<table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	   <tr>
		 <td height="190" width="190"><img src="image\1.gif" border="0"></td>
		 <td height="190" width="190" bgcolor="red"></td>
	   </tr>
	   <tr>
		 <td height="190" width="190" bgcolor="red"></td>
		 <td height="190" width="190" bgcolor="red" align="right" class="style1">
		 <font color="white">
		 <%=username%>&nbsp;���&nbsp;&nbsp;&nbsp;<br>
		 <br>
		 ���Ѿ������<%=complete_num%>��������!&nbsp;&nbsp;&nbsp;<br>
		 ����&nbsp;<span class="style2"><b><%=ing_num%></b></span>&nbsp;���������<a href="../tdl/index.asp">ȥ��Ŷ</a>~&nbsp;&nbsp;&nbsp;<br>
		 <br>
		 ��һ�ε�¼&nbsp;&nbsp;&nbsp;<br>
		 IP:<%response.write(loginip2)%>&nbsp;&nbsp;&nbsp;<br>
		 ʱ��:<%response.write(mid(logintime2,1,4)&"-"&mid(logintime2,5,2)&"-"&mid(logintime2,7,2))%>&nbsp;<%response.write(mid(logintime2,9,2)&":"&mid(logintime2,11,2)&":"&mid(logintime2,13,2))%>&nbsp;&nbsp;&nbsp;<br>
                 ���<a href="run_logout.asp" onfocus='this.blur()'>����</a>��ȫ�˳�&nbsp;&nbsp;&nbsp;<br><br>
		 </font>
		 </td>
	   </tr>
	</table>