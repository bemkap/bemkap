window.onload=function(){
    var list=document.getElementById('last');
    chrome.cookies.getAll({url:"http://animeflv.net"},function(cookies){
	for(var i=0; i<cookies.length; ++i){
            var context_name=cookies[i].name.split(".");
	    if(context_name[0]=="anime-list"){
		var li=document.createElement('li');
		var a=document.createElement('a');
		var idx=cookies[i].value.lastIndexOf("-")+1;
                var name=context_name[1].replace(/-/g," ");
		a.innerHTML=name+"<br/><small>&ensp;capítulo "+cookies[i].value.slice(idx)+"</small>";
		a.setAttribute("href",cookies[i].value);
		li.appendChild(a);
		list.appendChild(li);
	    }
	}
    });
};
