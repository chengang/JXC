<%'机能说明：页面左边被包含文件
  '更新DB：无
  '参照DB：history_login
  '修改履历
  '修改年月日、责任者、内容
  '2007/12/30  cg@kdz  修改 增加登入记录安全功能

'查询历史表中用户最后一次登入记录
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

'查询用户任务管理状态
set rs_tdl=server.createobject("adodb.recordset")
sqltext_tdl = "select a1status,count(*) as num from  tdl_tasklist where a1pointuser='"&username&"' and a1creatuser<>'系统' group by a1status "
rs_tdl.open sqltext_tdl,conn,1,1
while not rs_tdl.eof
	if rs_tdl("a1status")="完成" then
		complete_num = rs_tdl("num")
	end if
	if rs_tdl("a1status")="未完成" then
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
		 <%=username%>&nbsp;你好&nbsp;&nbsp;&nbsp;<br>
		 <br>
		 你已经完成了<%=complete_num%>件事情啦!&nbsp;&nbsp;&nbsp;<br>
		 还有&nbsp;<span class="style2"><b><%=ing_num%></b></span>&nbsp;件事情等你<a href="../tdl/index.asp">去办哦</a>~&nbsp;&nbsp;&nbsp;<br>
		 <br>
		 上一次登录&nbsp;&nbsp;&nbsp;<br>
		 IP:<%response.write(loginip2)%>&nbsp;&nbsp;&nbsp;<br>
		 时间:<%response.write(mid(logintime2,1,4)&"-"&mid(logintime2,5,2)&"-"&mid(logintime2,7,2))%>&nbsp;<%response.write(mid(logintime2,9,2)&":"&mid(logintime2,11,2)&":"&mid(logintime2,13,2))%>&nbsp;&nbsp;&nbsp;<br>
                 点击<a href="run_logout.asp" onfocus='this.blur()'>这里</a>安全退出&nbsp;&nbsp;&nbsp;<br><br>
		 </font>
		 </td>
	   </tr>
	</table>