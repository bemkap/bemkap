window.onload=function(){
    var table=document.getElementById('last');
    chrome.cookies.getAll({url:"http://animeflv.net"},function(cookies){
	for(var i=0; i<cookies.length; ++i){
	    var context_name=cookies[i].name.split(".");
	    if(context_name[0]=="anime-list"){
		var tr=document.createElement('tr');
		var th1=document.createElement('th');
		var a=document.createElement('a');
		var idx=cookies[i].value.lastIndexOf("-")+1;
		//a.textContent=context_name[1];
		a.innerHTML=context_name[1]+"<br/>&emsp;&emsp;Capítulo "+cookies[i].value.slice(idx);
		a.setAttribute("href",cookies[i].value);
		th1.appendChild(a);
		tr.appendChild(th1);
		table.appendChild(tr);
	    }
	}
    });
};
