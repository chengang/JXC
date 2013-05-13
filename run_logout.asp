<!--kdz studio powered at 20080803-->
<%'机能说明：注销全部session和cookie
  '修改年月日、责任者、内容
  '2008/08/23  fans@kdz 新增

'注销所有Session
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

'注销所有Cookie
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