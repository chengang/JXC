<%
'����getֵ
function kdzget(s)
	t = trim(request.querystring(s))
	t = replace(t,"""" , "")
	t = replace(t,"'" , "")
	t = replace(t,"\" , "")
	t = replace(t,"-" , "")
	t = replace(t,"%" , "")
	t = replace(t,"?" , "")
	t = replace(t,"|" , "")
	t = replace(t,"+" , "")
	t = replace(t,"=" , "")
	kdzget = t
end function

'����postֵ
function kdzpost(s)
	t = trim(request.form(s))
	t = replace(t,"""" , "")
	t = replace(t,"'" , "")
	t = replace(t,"\" , "")
	t = replace(t,"-" , "")
	t = replace(t,"%" , "")
	t = replace(t,"?" , "")
	t = replace(t,"|" , "")
	t = replace(t,"+" , "")
	t = replace(t,"=" , "")
	kdzpost = t
end function

'����cookiesֵ
function kdzcookie(s)
	t = trim(request.cookies(s))
	t = replace(t,"""" , "")
	t = replace(t,"'" , "")
	t = replace(t,"\" , "")
	t = replace(t,"-" , "")
	t = replace(t,"%" , "")
	t = replace(t,"?" , "")
	t = replace(t,"|" , "")
	t = replace(t,"+" , "")
	t = replace(t,"=" , "")
	kdzcookie = t
end function

'���ڸ�ʽת��
function kdztimeformat(s,flag)
  if len(s)>0 then
    if (len(s)=14 and trim(flag) = "1") then
       timeformatstr = mid(s,1,4)&"-"&mid(s,5,2)&"-"&mid(s,7,2)&" "&mid(s,9,2)&":"&mid(s,11,2)
    end if
    if (len(s)=14 and trim(flag) = "2") then
       timeformatstr = mid(s,1,4)&"-"&mid(s,5,2)&"-"&mid(s,7,2)
    end if
    if (len(s)=8 and trim(flag) = "3") then
       timeformatstr = mid(s,1,4)&"-"&mid(s,5,2)&"-"&mid(s,7,2)
    end if
    if (len(s)=6 and trim(flag) = "4") then
       timeformatstr = mid(s,1,4)&"-"&mid(s,5,2)
    end if
  else
    timeformatstr = s
  end if
	kdztimeformat = timeformatstr
end function

%>
