<!KDZ Studio Powered at 20080928">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%response.Expires = 0%>
<%'����˵����Ʒ�ƽ����嵥ɾ��ҳ��
  '����DB��jxc_buy_brand
  '����DB����
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/09/28  cg@kdz  ���� 
%>
<%
a17id = request.queryString("a17id")

if a17id = "" then
   response.redirect Request.ServerVariables("HTTP_REFERER")
	 response.end
end if

'ɾ������
sql =    "delete from jxc_buy_brand where a17id = " &a17id
conn.execute(sql)

response.redirect Request.ServerVariables("HTTP_REFERER")
%>
