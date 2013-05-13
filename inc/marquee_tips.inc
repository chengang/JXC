<marquee scrollamount="2">
	<%
	set rs_tips=server.createobject("adodb.recordset")
	sqltext_tips =             "select top 1 a16content "
	sqltext_tips = sqltext_tips&"from tips "
	sqltext_tips = sqltext_tips&"order by newid()"
	'response.write sqltext_tips
	'response.end
	rs_tips.open sqltext_tips,conn,1,1
	response.write rs_tips("a16content")
	rs_tips.close
	%>
</marquee>