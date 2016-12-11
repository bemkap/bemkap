window.onload=function(){
    var list=document.getElementById('last');
    chrome.storage.local.get(null,function(items){
        var v=Object.values(items);
	for(var i=0; i<v.length; ++i){
	    var li=document.createElement('li');
	    var a=document.createElement('a');
	    var d_idx=v[i].lastIndexOf("-")+1;
            var m_idx=v[i].lastIndexOf("/")+1;
            var name=v[i].slice(m_idx,d_idx).replace(/-/g," ");
	    a.innerHTML=name+"<br/><small>&ensp;capítulo "+v[i].slice(d_idx)+"</small>";
	    a.setAttribute("href",v[i]);
	    li.appendChild(a);
	    list.appendChild(li);
	}
    });
};
