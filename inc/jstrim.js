//ȥ���ҿո�; 
function jstrim(s){ 
 var ltrim
 ltrim = s.replace( /^\s*/, ""); 
 return ltrim.replace( /\s*$/, ""); 
}
//�ж��Ƿ��������ַ�
//���û���򷵻�-1; 
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
