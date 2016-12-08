window.onload=function(){
    var ul=document.getElementById('last');
    chrome.storage.local.get('animes',function(animes){
	for(var i=0; i<animes.length; ++i){
	    var li=document.createElement('li');
	    li.textContent=animes[i];
	    li.value=animes[i];
	    ul.appendChild(li);
	}});}
