<!KDZ Studio Powered at 20080928">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'机能说明：品牌进货清单删除页面
  '更新DB：jxc_buy_brand
  '参照DB：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/09/28  cg@kdz  新增 
%>
<%
a17id = request.queryString("a17id")

if a17id = "" then
   response.redirect Request.ServerVariables("HTTP_REFERER")
	 response.end
end if

'删除任务
sql =    "delete from jxc_buy_brand where a17id = " &a17id
conn.execute(sql)

response.redirect Request.ServerVariables("HTTP_REFERER")
%>
