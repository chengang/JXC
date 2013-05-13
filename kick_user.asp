<%'机能说明：根据cookie值踢飞非注册人员到登录页index.htm
  '更新DB：无
  '参照DB：无
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/14  cg@kdz  新增
  '2008/10/18  cg@kdz  修改 由根据session踢人改为cookie
  
Response.CacheControl = "no-cache"

if kdzcookie("power")<"1" or kdzcookie("power")="" then
response.redirect ("index.asp")
end if
%>