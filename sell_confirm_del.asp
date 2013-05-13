<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<%'机能说明：卖出商品页面3——加入商品页中的删除功能
  '          通过操作goodlist字符串实现
  '          自动提交回卖出商品页面2
  '修改履历
  '修改年月日、责任者、内容
  '2007/05/18  cg@kdz  新增
Dim delstr,goodslist,pr
pr = Request.Querystring("pr")
delstr = "'"&Request.Querystring("No")&"'"
goodslist = Request.Querystring("goodslist")
Dim l1,l2,j,src1,src2,answer
l1 = Len(goodslist)
l2 = Len(delstr)
j = InStr(goodslist,delstr)

If j = 1 Then
src2 = Right(goodslist, l1 - l2 - 1)
answer = src2
Else 
	If j = l1 - l2 + 1 Then 
	src1 = Left(goodslist, l1 - l2 -1)
	answer = src1
	else
	src1 = Left(goodslist, j - 1)
	src2 = Right(goodslist, l1 - j - l2)
	answer = src1 + src2
	End If
End If
'response.write answer
'response.end
%>

<form name="form1" method="post">
<input name="goodslist" type="hidden" value="<%=answer%>">
</form>
<script language="javascript"> 
<!--
document.form1.action="sell_confirm.asp?pr=<%=pr%>";
document.form1.submit();
-->
</script>