chrome.runtime.onMessage.addListener(function(message,sender,sendResponse){
    chrome.tabs.query({active: true,currentWindow: true},function(tabs){
	chrome.storage.local.get('animes',function(items){
	    items.animes.append(sender.id);
	    chrome.storage.local.set({'animes': items.animes},function(){});})})});
