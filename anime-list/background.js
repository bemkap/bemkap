chrome.commands.onCommand.addListener(function(command){
    switch(command){
    case "save-anime":
	chrome.tabs.query({active:true,currentWindow:true},function(tabs){
	    var idx0=tabs[0].url.lastIndexOf("/");
	    var idx1=tabs[0].url.lastIndexOf("-");
	    var anime_id="anime-list."+tabs[0].url.slice(idx0+1,idx1);
            chrome.cookies.set({url:"http://animeflv.net",name:anime_id,value:tabs[0].url});
        });
    }
});
