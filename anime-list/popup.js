window.onload=function(){
    var list=document.getElementById('last');
    chrome.storage.local.get(null,function(items){
	for(var k in items){
	    var li=document.createElement('li'),
		a=document.createElement('a'),
		d_idx=items[k].lastIndexOf("-")+1,
		m_idx=items[k].lastIndexOf("/")+1,
		name=items[k].slice(m_idx,d_idx).replace(/-/g," ");
	    
	    a.innerHTML=name+"<br/><small>&ensp;capítulo "+items[k].slice(d_idx)+"</small>";
	    a.setAttribute("href",items[k]);
	    li.appendChild(a);
	    list.appendChild(li);
	}
    });
};
