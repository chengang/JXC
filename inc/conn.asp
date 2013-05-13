<%
   dim conn   
   dim connstr

   on error resume next
   connstr = "Driver={sql server};server=someip;database=somedbname;uid=someuid;pwd=somepwd;" 
   set conn=server.createobject("ADODB.CONNECTION")
   if err then 
      err.clear
   else
        conn.open connstr 
        if err then 
           err.clear
        end if
   end if
%>
