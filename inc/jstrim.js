//去左右空格; 
function jstrim(s){ 
 var ltrim
 ltrim = s.replace( /^\s*/, ""); 
 return ltrim.replace( /\s*$/, ""); 
}
//判断是否有特殊字符
//如果没有则返回-1; 
function isValidString(s){
 //var voidstr1 = "`~!@#$%^&*+-={}[]|:;<>,.?/";
 //var voidstr2 = "\\\"\'";
 //var voidstr = voidstr1 + voidstr2 ;
 var voidstr = "\"\'";
 for(i = 0 ; i < voidstr.length; i ++){
	 tempchar = voidstr.substring(i, i + 1);
     if(s.indexOf(tempchar) > -1)
	 {
	    return -1;
	 }
 }
 return 0;
}
