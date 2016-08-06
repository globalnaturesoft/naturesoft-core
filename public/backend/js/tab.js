function openTab(url, name) {
	// Remove domain from url
	url = url.replace(/^.*\/\/[^\/]+/, '')
	
	// Check if tab already open
	if($('a[data-src="'+url+'"]').length) {
		selectTab(url);
		refreshTab(url);
		return;
	}
	
	var id = randomString(10);
	$(".ns-main-tabs ul.nav").append('<li><a data-src="'+url+'" href="#'+id+'" data-toggle="tab">'+name+' <i class="icon-reload-alt tab-refresh"></i> <i class="icon-cross2 tab-close"></i></a></li>');
	$(".ns-main-tabs .tab-content").append('<div class="tab-pane" id="'+id+'"><iframe src="'+url+'"></iframe></div>');
	
	tab_ids.push(id);
	
	// Check if iframe load
	$('#'+id+' iframe').load(function() {
		var current_url = $(this)[0].contentWindow.location.href.replace(/^.*\/\/[^\/]+/, '');
		
		// Check if page exist
		if(current_url != url) {
			// Check if redirect page
			if(!$('#'+id+' iframe').contents().find("#error_explanation").length) {
				closeTab(url);
				openTab(current_url);				
			}
		}
	});
}

function resizeAllFrame() {
	$(".tab-pane iframe").each(function() {
		resizeIframe($(this)[0]);
	});
}

function refreshTab(url) {
	var tab_but = $("a[data-src='"+url+"']");
	var id = tab_but.attr("href").slice(1);
	var iframe = $("#"+id).find("iframe");
	iframe.attr("src", url);
}

function selectTab(url) {
	var tab_but = $("a[data-src='"+url+"']");
	tab_but.click();
}

function selectTabById(id) {
	$("a[href='#"+id+"']").click();
}

function closeTab(url) {
	var tab_but = $("a[data-src='"+url+"']");
	var id = tab_but.attr("href").slice(1);
	var tab = $("#"+id);
	tab_but.remove();
	tab.remove();
	
	var index = tab_ids.indexOf(id);
	tab_ids.splice(index, 1);
	var next_id = tab_ids[tab_ids.length-1];
	selectTabById(next_id);
}

function resizeIframe(obj) {
	if(typeof(obj.contentWindow) != 'undefined' && obj.contentWindow.document.body) {
		obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
	}	
}

var randomString = function (len, bits)
{
    bits = bits || 36;
    var outStr = "", newStr;
    while (outStr.length < len)
    {
        newStr = Math.random().toString(bits).slice(2);
        outStr += newStr.slice(0, Math.min(newStr.length, (len - outStr.length)));
    }
    return outStr.toUpperCase();
};

var tab_ids = ["tab_home"];
$(document).ready(function() {
	setInterval("resizeAllFrame()", 500);
	
	// remove loading effect
	$(".tab-loading").hide();
	
	$(document).on('click', 'a', function(e) {
		var url = $(this).attr("href");
		var title = $(this).attr("title");
		
		if(typeof(title) == 'undefined') {
			title = $(this).text();
		}
		
		if (typeof(url) != 'undefined' && url[0] != "#" && url !="" ) {
			if (window.frameElement) {
				e.preventDefault();
				parent.openTab(url, title);
				parent.selectTab(url)
			} else {
				e.preventDefault();
				openTab(url, title);
				selectTab(url)
			}
		}
	});
	
	$(document).on('click', '.ns-main-tabs .tab-close', function(e) {
		var url = $(this).parent().attr("data-src");
		closeTab(url);
	});
	
	$(document).on('click', '.ns-main-tabs .tab-refresh', function(e) {
		var url = $(this).parent().attr("data-src");
		refreshTab(url);
	});
});