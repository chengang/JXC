<%'����˵��������cookieֵ�߷ɷ�ע����Ա����¼ҳindex.htm
  '����DB����
  '����DB����
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/14  cg@kdz  ����
  '2008/10/18  cg@kdz  �޸� �ɸ���session���˸�Ϊcookie
  
Response.CacheControl = "no-cache"

if kdzcookie("power")<"1" or kdzcookie("power")="" then
response.redirect ("index.asp")
end if
%>