<!KDZ Studio Powered at 20070329">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：1、把邮费插入到数据库中
  '             (1)如果是未来日期的邮费,则不能插入
  '             (2)如果此日期的邮费数据库中已经有记录，
  '                则不能插入
  '更新DB：postage
  '参照DB：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/12  sky@kdz 修改
  '2007/05/26  sky@kdz 修改 修改mflag和关联字段的添加
  '2007/08/05  sky@kdz 修改 更新数据库的user改为uid
  '2008/11/23  sky@kdz 修改 录入人、修改人用ID表示，改为用名字表示
%>

<HTML>
<HEAD>
<TITLE>进销存系统——邮费确认</TITLE>
<meta http-equiv="refresh" content="10;url=postage.asp">
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
%>
</head>

<BODY>
<table width="762" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td align="center"><img src="image\logo.gif"></td>
  </tr>
<!--------------------------------------------------------------------------------------->
<!---------------------------070610陈钢制作上方导航-------------------------------------->
  <tr>
    <td align="right">
     <%if power = "5" then%>
	     <!--#include file="inc/top_admin.inc"-->
	   <%else%>
         <!--#include file="inc/top.inc"-->
	   <%end if%>
	</td>
  </tr>
<!---------------------------070610陈钢制作上方导航-------------------------------------->
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
				'确定是什么操作
				  dim FromPage
				  FromPage = request.form("FromPage")
				'取系统日期,时间为数值
				  dim datestr,timestr,yearmonthstr
				  datestr = int(Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)
				  yearmonthstr = int(Year(now))&right("0"&CStr(Month(now)),2)
				  timestr = (Year(now))&right("0"&CStr(Month(now)),2)&right("0"&CStr(day(now)),2)&right("0"&CStr(hour(now)),2)&right("0"&CStr(minute(now)),2)&right("0"&CStr(second(now)),2)
				%>

				<%if FromPage = "postage" then%>
				<!-- 添加修改邮费 Begin-->
				<%
				 dim yearstr,monthstr,postage,crttime,crtuser,chgtime,chguser
				 dim mflag
				   yearstr = trim(request.form("yearstr"))
					 monthstr = trim(request.form("monthstr"))
					 yearmonth = yearstr&monthstr
           postage = trim(request.form("a8postage"))
					 mflag = 0
           crttime = timestr
           crtuser = username
           chgtime = timestr
           chguser = username
				 '如果是未来日期的邮费,则不能插入
				 if yearmonth > yearmonthstr then
					  response.redirect("messagebox.asp?msg=不能录入未来日期的邮费")
	          response.end
				 else
					set rs_postage = server.createobject("adodb.recordset")
					sqltext = "select * from postage where a8date='"&yearmonth&"'"
					'response.write sqltext
					rs_postage.open sqltext,conn,1,2

					if not rs_postage.eof then
				     '如果此日期的邮费数据库中已经有记录,则不能插入
					   response.redirect("messagebox.asp?msg=此日期的邮费已存在")
	           response.end
					else
						rs_postage.addnew
						rs_postage("a8date") = yearmonth
						rs_postage("a8postage") = postage
						rs_postage("a8mflag") = mflag
						rs_postage("a8crttime") = crttime
						rs_postage("a8crtuser") = crtuser
						rs_postage("a8chgtime") = chgtime
						rs_postage("a8chguser") = chguser

						'更新数据
						rs_postage.update
						rs_postage.close
						conn.close
						set conn = nothing
					%>
			    <!--  添加修改邮费 End-->
			  <tr>
			    <td>
				    <table class="STYLE1" align="center"><tr><td>
					  <%username%> 你已录入邮费
					</td></tr></table>
				</td>
			  </tr>
			  <tr>
			    <td>
				    <table class="STYLE2">
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						日期：
						</td>
						<td width="180">
						<%=yearstr%>年<%=monthstr%>月
						</td>
					    <td width="50"></td>
					  </tr>
					  
					  <tr>
					    <td width="50" height="40"></td>
					    <td width="100">
						邮费数额：
						</td>
						<td width="180">
						<%=postage%>
						</td>
					    <td width="50"></td>
					  </tr>
					   <tr>
						 <td colspan="4" height="60" align="center" class="STYLE1">
						 <a href="postage.asp">10秒后将自动返回邮费录入页面</a>
						 </td>
					   </tr>
			        </form>
					</table>
			    </td>
			  </tr>
			<%      end if
			     end if
			   end if
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
