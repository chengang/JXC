<!--kdz studio powered at 20080803-->
<%'����˵����ע��ȫ��session��cookie
  '�޸������ա������ߡ�����
  '2008/08/23  fans@kdz ����

'ע������Session
session_total =  Session.Contents.count
Dim sessionarray()
Redim sessionarray(session_total)
i = 0

For Each strName in Session.Contents
	i = i + 1
	sessionarray(i) = strName
Next

For i = 1 To session_total
  Session.Contents(strName) = ""
  Session.Contents.Remove(sessionarray(i))
Next

'ע������Cookie
DIM objItem , objItemKey
For Each objItem In Request.Cookies
  'If Request.Cookies(objItem).Haskeys Then
    'For Each objItemKey in Request.Cookies(objItem)
      'Response.Cookies(objItem)(objItemKey) = ""
      'Response.Cookies(objItem)(objItemKey).Expires = dateadd("d", -1, now())
    'Next
  'Else
    response.cookies(objItem) = ""
    response.cookies(objItem).expires = dateadd("d", -1, now())
  'End If
Next

response.redirect Request.ServerVariables("HTTP_REFERER")
%> 