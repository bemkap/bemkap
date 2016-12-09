chrome.commands.onCommand.addListener(function(command){
    switch(command){
    case "save-anime":
	chrome.tabs.query({active:true,currentWindow:true},function(tabs){
	    anime_id=tabs[0].url.split("/")[4];
	    chrome.bookmarks.search({title:anime_id.toString()},function(nodes){
	    	if(nodes == null)
	    	    chrome.bookmarks.create({url:tabs[0].url,title:anime_id.toString()});
	    	else
	    	    chrome.bookmarks.update(anime_id.toString(),{url:tabs[0].url});
	    });
	});
    }
});
