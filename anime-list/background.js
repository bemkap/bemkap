chrome.commands.onCommand.addListener(function(command){
    switch(command){
    case "save-anime":
	chrome.tabs.query({active:true,currentWindow:true},function(tabs){
	    anime_id=tabs[0].url.split("/")[4];
            chrome.cookies.get({url:tabs[0].url,name:anime_id.toString()},function(cookie){
                if(cookie==null)
                    chrome.cookies.set({url:tabs[0].url,name:anime_id.toString()});
                else
                    alert(anime_id.toString());
                
            //chrome.storage.local.set({anime_id.toString():tabs[0].url});
	    });
        });
    }
});
