<!KDZ Studio Powered at 20070805">
<!--#include file="inc/function.asp"-->
<!--#include file="admin_kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/FusionCharts.asp" -->
<%response.Expires = 0%>
<%'����˵����ͼ����ʾ�¶����۶�
  '����DB����
  '����DB��orderbook
  '�޸�����
  '�޸������ա������ߡ�����
  '2008/01/01  CG@kdz ���� 
  '2008/01/02  sky@kdz �޸� �˻����������۸��ֶα��Ϊ����ɱ�
  '2008/11/08  sky@kdz �޸� �޸��˻�����
  '2008/11/16  sky@kdz �޸� ��ʾʱ����ʽ�޸�
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ����ͼ��ͳ��</TITLE>
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
			   <%
				 dim rs
				 '�����¶Ȳ�ѯ���۶�
				set rs=server.createobject("adodb.recordset")
				sqltext =         "select  "
				sqltext = sqltext&"a9month, "
				sqltext = sqltext&"(order_volume-IsNull(return_volume,0)) as sale_volume, "
				sqltext = sqltext&"((order_volume-buy_volume)-(IsNull(return_volume,0)-IsNull(return_cost,0))) as gain, "
				sqltext = sqltext&"(buy_volume-IsNull(return_cost,0)) as cost, "
				sqltext = sqltext&"(((order_volume-buy_volume)-(IsNull(return_volume,0)-IsNull(return_cost,0)))/(order_volume-IsNull(return_volume,0))) as gross, "
				sqltext = sqltext&"(((order_volume-buy_volume)-(IsNull(return_volume,0)-IsNull(return_cost,0)))/(buy_volume-IsNull(return_cost,0))) as huibao "

				sqltext = sqltext&"from  "

				sqltext = sqltext&"(select left(a9crttime,6) as a9month, "
				sqltext = sqltext&"sum(a9sub_price-a9price_reduce+a9postage) as order_volume  "
				sqltext = sqltext&"from orderbook  "
				sqltext = sqltext&"where a9mflag = 0  "
				sqltext = sqltext&"group by left(a9crttime,6)) tb1 "

				sqltext = sqltext&"left join "
				sqltext = sqltext&"(select left(a3crttime,6) as a3month, "
				sqltext = sqltext&"sum(a3price*a3amount) as return_volume, "
				sqltext = sqltext&"sum(a3buy_price*a3amount) as return_cost "
				sqltext = sqltext&"from returned "
				sqltext = sqltext&"where a3mflag = 0 and a3status <> 1 "
				sqltext = sqltext&"group by left(a3crttime,6)) tb2 "
				sqltext = sqltext&"on "
				sqltext = sqltext&"tb2.a3month =tb1.a9month "

				sqltext = sqltext&"left join "
				sqltext = sqltext&"(select left(a2crttime,6) as a2month, "
				sqltext = sqltext&"sum(a2amount*a2buy_price) as buy_volume "
				sqltext = sqltext&"from sold "
				sqltext = sqltext&"where a2mflag = 0 "
				sqltext = sqltext&"group by left(a2crttime,6)) tb3 "
				sqltext = sqltext&"on "
				sqltext = sqltext&"tb3.a2month =tb1.a9month "

				sqltext = sqltext&"order by a9month"
					 'response.write sqltext
					 'response.end
					 rs.open sqltext,conn,1,1
				 '�����ѯ����¼,����ʾ��ҳ����
if not rs.eof Then
					dim a9month,a9order_volume
					dim i,color_td

					set a9month = rs("a9month")
					set sale_volume = rs("sale_volume")
					set gain = rs("gain")
					set cost = rs("cost")
					set gross = rs("gross")
					set huibao = rs("huibao")

			   %>
		 <td width="590" valign="top">
		 <table border="0">
		 <tr><td>
		 <br/>
		 <!-----------------------------���۶�ͼ����ʾ ��ʼ--------------------------------->
		 <center><b>�� �� �� �� �� �� ��</b></center>
		 <%
			rs.movefirst
			strXML = ""
			strXML = strXML & "<graph xAxisName='Month' yAxisName='RMB/yuan' decimalPrecision='0' formatNumberScale='0'>"
			do while not (rs.eof)
				strXML = strXML & "<set name='" &kdztimeformat(a9month,"4")& "' value='" &round(sale_volume,2)& "' alpha='50'/>"
			rs.movenext
			loop
			strXML = strXML & "</graph>"
			
			Call renderChartHTML("inc/FCF_Bar2D.swf", "", strXML, "myNext", 600, 500)
		 %>
		 <!-----------------------------���۶�ͼ����ʾ ����--------------------------------->
		 </td></tr>
		 <tr><td>
		 <!-----------------------------ë����ͼ����ʾ ��ʼ--------------------------------->
		 <center><b>�� �� ë �� �� �� �� ��</b></center>
		 <%
		    rs.movefirst
			strXML = ""
			strXML = strXML & "<graph xAxisName='Month' yAxisName='RMB/yuan' decimalPrecision='0' formatNumberScale='0'>"
			do while not (rs.eof)
				strXML = strXML & "<set name='" &kdztimeformat(a9month,"4")& "' value='" &round(gain,2)& "' alpha='50' color='F6BD0F'/>"
			rs.movenext
			loop
			strXML = strXML & "</graph>"
			
			Call renderChartHTML("inc/FCF_Bar2D.swf", "", strXML, "myNext", 600, 500)
		 %>
		 <!-----------------------------ë����ͼ����ʾ ����--------------------------------->
		 </td></tr>
		 <tr><td>
		 <!-----------------------------ë������ͼ����ʾ ��ʼ--------------------------------->
		 <center><b>�� �� ë �� �� �� �� ��</b></center>
		 <%
		    rs.movefirst
			strXML = ""
			strXML = strXML & "<graph xAxisName='Month' yAxisName='PERCENT/100' decimalPrecision='0' formatNumberScale='0'>"
			do while not (rs.eof)
				strXML = strXML & "<set name='" &kdztimeformat(a9month,"4")& "' value='" &gross*100& "' alpha='50' color='AFD8F8'/>"
			rs.movenext
			loop
			strXML = strXML & "</graph>"
			
			Call renderChartHTML("inc/FCF_Bar2D.swf", "", strXML, "myNext", 600, 500)
		 %>
		 <!-----------------------------ë������ͼ����ʾ ����--------------------------------->
		 </td></tr>
		 <tr><td>
		 <!-----------------------------Ͷ�ʻر���ͼ����ʾ ��ʼ--------------------------------->
		 <center><b>�� �� Ͷ �� �� �� �� �� ��</b></center>
		 <%
		    rs.movefirst
			strXML = ""
			strXML = strXML & "<graph xAxisName='Month' yAxisName='PERCENT/100' decimalPrecision='0' formatNumberScale='0'>"
			do while not (rs.eof)
				strXML = strXML & "<set name='" &kdztimeformat(a9month,"4")& "' value='" &huibao*100& "' alpha='50' color='8BBA00'/>"
			rs.movenext
			loop
			strXML = strXML & "</graph>"
			
			Call renderChartHTML("inc/FCF_Bar2D.swf", "", strXML, "myNext", 600, 500)
		 %>
		 <!-----------------------------Ͷ�ʻر���ͼ����ʾ ����--------------------------------->
		 </td></tr>
		 </table>
<%
else
	response.redirect("messagebox.asp?msg=Ŀǰ��û�в������ۼ�¼")
	response.end
end if
'�ر����ӣ��ͷŽ���
rs.close
conn.close
set conn=nothing
			   %>
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