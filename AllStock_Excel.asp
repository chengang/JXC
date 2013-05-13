<%@ CODEPAGE=936 %>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/conn.asp"-->
<%'机能说明：库存情况报表页
  '          根据stock表生成excel文件
  '参照数据：stock,buy
  '更新数据：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/16  cg@kdz  新增
  '2007/05/20  sky@kdz 修改
  '2008/11/16  sky@kdz 修改 显示时间样式修改
  '2009/03/06  sky@kdz 修改 导出错误bug修改
%>
<%
response.ContentType ="application/vnd.ms-excel;"
if ( kdzcookie("power") <> "1"  and kdzcookie("power")<>"5" ) then
   response.redirect ("index.asp")
end if

dim username,power,uid,rs,sqltext,i,color_tr
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")
set rs=server.createobject("adodb.recordset")
sqltext = "select * from stock "
rs.open sqltext,conn,1,1
i = 0
dim arr_cflag(2)
	arr_cflag(0) = "正常"
	arr_cflag(1) = "特殊(需整理)"
%>
<table width="100%" border="1" cellspacing="0" cellpadding="0">
  <tr height="60" bgcolor="#CCFFFF">
   <td colspan="14" align="center"><font size="5"><b>Webmama.cn库存信息报告总表</b></font></td>
  </tr>
  <tr>
   <td colspan="7"><i>导出人：<%=username%></i></td>
   <td colspan="7"><i>导出时间：<%=date()%></i></td>
  </tr>
  <tr height="25" bgcolor="#FFCC66">
   <td>GID</td>
   <td>商品名称</td>
   <td>条形码</td>
   <td>品牌</td>
   <td>库存量</td>
   <td>加权买入价</td>
   <td>普通售价</td>
   <td>VIP售价</td>
   <td>批销价</td>
   <td>库存情况</td>
   <td>录入时间</td>
   <td>录入者</td>
   <td>修改时间</td>
   <td>修改者</td>
  </tr>
<%
'======================================================
'加入变量名定义开始 sky 2007/05/20
'======================================================
dim a4gid,a4name,a4code,a4brand,a4stock
dim a4price_common,a4price_vip,a4price_wholesale
dim a4cflag,a4crttime,a4crtuser,a4chgtime,a4chguser
'======================================================
'加入变量名定义结束 sky 2007/05/20
'======================================================
set a4gid = rs("a4gid")
set a4name = rs("a4name")
set a4code = rs("a4code")
set a4brand = rs("a4brand")
set a4stock = rs("a4stock")
set a4price_common = rs("a4price_common")
set a4price_vip = rs("a4price_vip")
set a4price_wholesale = rs("a4price_wholesale")
set a4cflag = rs("a4cflag")
set a4crttime = rs("a4crttime")
set a4crtuser = rs("a4crtuser")
set a4chgtime = rs("a4chgtime")
set a4chguser = rs("a4chguser")
	while not rs.eof
	i = i + 1
	if i mod 2 = 0 then
	color_tr = "#CCFFFF"
	else
	color_tr = "#FFFFFF"
	end if
	'======================================================
	'加入加权买入价算出开始 sky 2007/05/20
	'======================================================
	   dim rs_buy,sqltext2,price,total_amount,total_money
       set rs_buy=server.createobject("adodb.recordset")
           sqltext2 = "select * from buy where a1gid = '"&a4gid&"'"
           rs_buy.open sqltext2,conn,1,1

		   total_amount = 0
	       total_money = 0
           while not rs_buy.eof
		        total_amount = total_amount + rs_buy("a1amount")
                total_money = total_money + rs_buy("a1amount") * rs_buy("a1buy_price")
              rs_buy.movenext
           wend
		   rs_buy.close
		   price = total_money / total_amount
	'======================================================
	'加入加权买入价算出结束 sky 2007/05/20
	'======================================================
%>
  <tr height="25" bgcolor="<%=color_tr%>">
   <td><%=a4gid%></td>
   <td align="center"><%=a4name%></td>
   <td><%=a4code%></td>
   <td align="center"><%=a4brand%></td>
   <td><%=a4stock%></td>
   <td><%=price%></td>
   <td><%=a4price_common%></td>
   <td><%=a4price_vip%></td>
   <td><%=a4price_wholesale%></td>
   <td align="center"><%=arr_cflag(a4cflag)%></td>
   <td><%response.write kdztimeformat(a4crttime,"1")%></td>
   <td><%=a4crtuser%></td>
   <td><%response.write kdztimeformat(a4chgtime,"1")%></td>
   <td><%=a4chguser%></td>
  </tr>
<%
rs.movenext
wend
rs.close
set conn = nothing
%>
</table>
