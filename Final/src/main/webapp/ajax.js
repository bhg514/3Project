var httpRequest=null;
//$.ajax({method:post,content:find.jsp;function(){처리}})
function createHttpRequest(){
	if(window.ActiveXObject){

		return new ActiveXObject("Msxml2.XMLHTTP");
	}else if(window.XMLHttpRequest){

		return new XMLHttpRequest();
	}else{
		alert("지원하지 않은 브라우저");
		return null;
	}
	
}
function sendMessage(method,url,param,callback){
	httpRequest=createHttpRequest();

	var httpMethod=method;
	var httpUrl=url;
	
	var httpParam=param;
	if(httpMethod=="GET" || httpMethod!="POST"){
		httpMethod="GET";
	}

	if(httpMethod=="GET" || httpMethod==null){
		if(httpParam!=null){
			httpUrl=httpUrl+"?"+httpParam;
		}		
	}
	//readystate=>1

	httpRequest.open(method,httpUrl,true);//2

	httpRequest.onreadystatechange=callback;

	httpRequest.setRequestHeader("content-type","application/x-www-form-urlencoded");//3
	httpRequest.send(method=="GET"||method==null?null:param);
	//4
	
	
}