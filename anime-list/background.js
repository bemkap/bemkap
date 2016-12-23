chrome.commands.onCommand.addListener(function(command){
    switch(command){
    case "save-anime":
	chrome.tabs.query({active:true,currentWindow:true},function(tabs){
            chrome.browserAction.setBadgeText({text:"+",tabId:tabs[0].id});
	    var idx0=tabs[0].url.lastIndexOf("/");
	    var idx1=tabs[0].url.lastIndexOf("-");
	    var anime_id="anime-list."+tabs[0].url.slice(idx0+1,idx1);
            var d={}; d[anime_id]=tabs[0].url;
            chrome.storage.local.set(d);
        });
    }
});
