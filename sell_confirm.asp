<!KDZ Studio Powered at 20070105">
<!--#include file="inc/function.asp"-->
<!--#include file="kick_user.asp"-->
<!--#include file="inc/conn.asp"-->
<%'����˵����������Ʒҳ��2����������Ʒ
  '�޸�����
  '�޸������ա������ߡ�����
  '2007/05/12  cg@kdz  ����
  '2007/05/12  sky@kdz �޸� Ψһgid�ķ���
  '2007/06/05  cg@kdz  �޸� �Żݽ�����Ϊ��ֵ
  '2007/06/07  cg@kdz  ���� ��֤�Żݼ۸��ܴ��ڻ������Ʒ�ܼ�
  '2007/06/07  cg@kdz  ���� ȷ���ύʱ��ʾ�۳��Żݺ�ļ۸�С��
  '2007/07/01  sky@kdz �޸� �ۻ�ʱ�����ʷѵ��޸�
  '2007/08/05  sky@kdz �޸� ��������ȥ�ո�Ĵ���
  '2007/12/18  sky@kdz �޸� ���������ֹ�����ַ����޸�
  '2007/12/30  cg@kdz  �޸� ���ӵ����¼��ȫ���� ����conn
  '2008/12/28  cg@kdz  �޸� �����Ʒ����js�޸� �Żݽ����Ե�����Ʒ�ܼ�

  dim pr,gid,goodslist,rs,sqltext,len_goodlist
'======================================================
'�޸� Ψһgid�ķ��ؿ�ʼ sky 2007/05/24
'======================================================
  pr = request.queryString("pr")
  'a2code = request.form("a2code")
  'goodslist = request.form("goodslist")
  'goodslist = goodslist&"'"&a2code&"',"
  gid = request.form("a4gid")
  goodslist = request.form("goodslist")
  goodslist = goodslist&",'"&gid&"'," 
  
  len_goodlist = len(goodslist)
  'response.write len_goodlist
  'response.write ("<br>")
  if left(goodslist,1) = "," then
     goodslist = right(goodslist,len_goodlist-1)
  end if

  len_goodlist = len(goodslist)
  'response.write len_goodlist
  'response.write ("<br>")
  if right(goodslist,1) = "," then
     goodslist = left(goodslist,len_goodlist-1)
  end if
  'response.write goodslist
  'response.write ("<br>")
'======================================================
'�޸� Ψһgid�ķ��ؽ��� sky 2007/05/24
'======================================================

  set rs=server.createobject("adodb.recordset")
  select case pr
   case 1
    sqltext = "select a4code,a4name,a4gid,a4price_common as a4price"
   case 2
    sqltext = "select a4code,a4name,a4gid,a4price_vip as a4price"
   case 3
    sqltext = "select a4code,a4name,a4gid,a4price_wholesale as a4price"
  end select
  'sqltext = sqltext&" from stock"
'======================================================
'�޸� Ψһgid�ķ��ؿ�ʼ sky 2007/05/24
'======================================================
  'sqltext = sqltext&" from stock where a4code in ("&goodslist&") order by a4gid"
  sqltext = sqltext&" from stock where a4gid in ("&goodslist&") order by a4gid"
'======================================================
'�޸� Ψһgid�ķ��ؽ��� sky 2007/05/24
'======================================================
  'response.write sqltext
  'response.end
  rs.open sqltext,conn,1,1
%>
<HTML>
<HEAD>
<TITLE>������ϵͳ�����ۻ�</TITLE>
<script language="javascript" src="inc/jstrim.js">
</script>
<script language="javascript"> 
function bodyf()
{
  form1.a2code.focus(); 
}
function submit1()
{
//document.form1.data.value="111";
//document.form1.action="sell_code_to_gid.asp?pr=<%=pr%>";
   document.form1.submit();
}
function checkcode(inform)
{
  if ( isValidString(form1.a2code.value) == -1 )
  {
            alert ("���������벻���������ַ���");
			form1.a2code.focus();
			return false;
  }
  else
  {
			return true;
  }
}
function checkform(inform)
{
  if (jstrim(inform.a9postage.value) == "")
  {
            alert ("�������ʷѼ۸�");
			inform.a9postage.focus();
			return false;
  }
  if(isNaN(inform.a9postage.value)) 
  { 
            alert("�ʷѼ۸����Ϊ���֣�");
            inform.a9postage.focus(); 
            return false; 
   }
  if (inform.a9postage.value < 0)
  {
            alert ("�ʷѼ۸���Ϊ��ֵ��");
			inform.a9postage.focus();
			return false;
  }
  if (jstrim(inform.reduce1.value) == "")
  {
            alert ("�������Żݼ۸�");
			inform.reduce1.focus();
			return false;
  }
  if(isNaN(inform.reduce1.value)) 
  { 
            alert("�Żݼ۸����Ϊ���֣�");
            inform.reduce1.focus(); 
            return false; 
   }
  /*-----------------------------------------------------------------
  ----------------------�¸�070605�޸��Żݽ�����Ϊ��ֵ-------------
  if (inform.reduce1.value < 0)
  {
            alert ("�Żݼ۸���Ϊ��ֵ��");
			inform.reduce1.focus();
			return false;
  }
  ----------------------�¸�070605�޸��Żݽ�����Ϊ��ֵ-------------
  ------------------------------------------------------------------*/
   if (jstrim(inform.oid.value) == "")
  {
            alert ("�����붩���ţ�");
			inform.oid.focus();
			return false;
  }
  if( isValidString(inform.oid.value) == -1 )
  {
            alert ("���붩���Ų����������ַ�");
			inform.oid.focus();
			return false;
  }

  //-------------------------------------------------------------------------------------------------
  //----------------------�¸�070607������֤�Żݼ۸��ܴ��ڻ������Ʒ�ܼ�---------------------------
  //----------------------�¸�070607����ȷ���ύʱ��ʾ�۳��Żݺ�ļ۸�С��---------------------------
  var sum_money = 0;
  var soso=inform.a4price.length;
  if (isNaN(soso))
  {soso=1;
   sum_money=inform.a4price.value*inform.amount.value;
  }
  else
  {soso = soso-1
  var i;
    for(i=0;i<=soso;i++){sum_money = sum_money-(-inform.a4price[i].value*inform.amount[i].value);}
  }

  if(sum_money < inform.reduce1.value) 
  { 
            alert("�Żݼ۸��ܴ�����Ʒ�ܼۣ�");
            inform.reduce1.focus(); 
            return false; 
   }

  var total_money = sum_money - (-inform.a9postage.value) - inform.reduce1.value
  if(confirm('С�ƽ��'+total_money+'Ԫ��ȷ���ύ������')) 
  {return   true;}
    else 
  {return   false;}   
  //----------------------�¸�070607����ȷ���ύʱ��ʾ�۳��Żݺ�ļ۸�С��---------------------------
  //----------------------�¸�070607������֤�Żݼ۸��ܴ��ڻ������Ʒ�ܼ�---------------------------
  //-------------------------------------------------------------------------------------------------
}
</script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #FFFFFF;
	}
.style1 {font-size:9pt}

.style2 {font-size:10.5pt}

.style_button {border-right: #62b0ff 1px solid; 
               padding-right: 1px; 
			   border-top: #bfdfff 1px solid; 
			   padding-left: 1px; 
			   font-size: 12px; 
			   padding-bottom: 1px; 
			   border-left: #bfdfff 1px solid; 
			   color: #085878; 
			   padding-top: 1px; 
			   border-bottom: #62b0ff 1px solid; 
			   font-family: verdana, arial, ����; 
			   height: 30px; 
			   background-color: #ddeeff"
			   }
-->
</style>
<%
dim username,power,uid
username = kdzcookie("tdl_name")
power = kdzcookie("power")
uid= kdzcookie("uid")
%>
</head>

<BODY onload="bodyf()">
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
		    <!--#include file="inc\left_mini.inc"-->
		 </td>
		 <td width="580" valign="top">
		    <br>
		    <table width="580">
			  <tr>
			    <td>
				 <!--��߿� ��ʼ-->
				 <!--onpropertychange="submit1()"-->
				 <table class="STYLE1">
				   <tr>
				    <td align="center" valign="top">
					  <form name="form1" id="form1" method="post" onsubmit="return checkcode(this)" action="sell_code_to_gid.asp?pr=<%=pr%>">
					  <input type="hidden" name="goodslist" value="<%=goodslist%>">
					  ������:&nbsp;&nbsp;&nbsp;<input type="text" name="a2code" style="width:100px" onchange="submit1()"><br><br><br><br><br><br><br><br><br>
					  </form>
					  <form name="form2" method="post" onsubmit="return checkform(this)" action="sell_run.asp">
					  �ʷѽ��:&nbsp;<input type="text" name="a9postage" value="0" maxlength="9" style="width:100px"><br>
					  �Żݽ��:&nbsp;<input type="text" name="reduce1" value="0" maxlength="9" style="width:100px"><input type="hidden" name="pr" value="<%=pr%>"><br>
					  ������:&nbsp;&nbsp;&nbsp;<input type="text" name="oid" style="width:100px"><br><br>
					  <input type="submit" name="submit" value="ȷ �� �� ��" class="style_button">
					</td>
				<!--��߿� ����-->
				<!--�ұ߿� ����-->
					<td align="center" valign="top">
					 <fieldset>
					   <table class="STYLE1">
					    <tr>
						 <td align="center" width="200">��Ʒ����</td>
						 <td align="center" width="50">����</td>
						 <td align="center" width="50">�۸�</td>
						 <td align="center" width="30">ɾ��</td>
						</tr>
					   </table>
					 </fieldset><br>
					 <fieldset>
					   <table class="STYLE1">
					    <%while not rs.eof%>
					    <tr>
						 <td width="200" align="left"><%=rs("a4name")%></td>
						 <td width="50" align="center"><input name="amount" type="text" value="1" size="3" maxlength="4"><input type="hidden" name="goodslist" value="<%=rs("a4gid")%>"></td>
						 <td width="50" align="center"><%=rs("a4price")%><input type="hidden" name="a4price" value="<%=rs("a4price")%>"></td>
						 <td align="center" width="30"><%response.write("<a href=""sell_confirm_del.asp?No="&rs("a4gid")&"&pr="&pr&"&goodslist="&goodslist&""">ɾ��</a>")%></td>
						</tr>
						<%rs.movenext
						  wend%>
						</form>
				<!--�ұ߿� ����-->
					   </table>
					 </fieldset><br>
					 <fieldset>
					   <table class="STYLE1">
					    <tr>
						 <td width="330" align="right">����&nbsp<%=rs.recordcount%>&nbsp����Ʒ</td>
						</tr>
					   </table>
					 </fieldset>
					 <%rs.close%>
					</td>
				   </tr>
				 </table>
				 <!--��߿� ����-->
			    </td>
			  </tr>
			</table>
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