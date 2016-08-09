function ajustTabScroll() {
	var ts_width = $(".tabs-scroll").width();
	var tc_width = $(".tabs-scroll .tabs-scroll-cont").width();
	
	if (ts_width < tc_width) {
		$('.tabs-scroll .navi').show();
	} else {
		$('.tabs-scroll .navi').hide();
	}
}

function setTabName(url, name) {
	$('a[data-src="'+url+'"] .tab_name').html(name);
}

function removeTabUrl(url) {
	var index = tab_urls.indexOf(url);
	while (index != -1) {
    tab_urls.splice(index, 1);
		index = tab_urls.indexOf(url);
	}
}

function selectNextTab() {
	var next_id = tab_urls[tab_urls.length-1];
	selectTab(next_id);
}

function openTab(url, name, hide_close) {
	// Remove domain from url
	url = url.replace(/^.*\/\/[^\/]+/, '');
	
	// Check if tab already open
	if($('a[data-src="'+url+'"]').length) {
		selectTab(url);
		refreshTab(url);
		return;
	}
	
	// Show tab close buttons
	close_but = '';
	if(typeof(hide_close) == 'undefined' || !hide_close) {
		close_but = '<i class="icon-cross2 tab-close"></i>';
	}
	
	var id = randomString(10);
	$(".ns-main-tabs ul.nav").append('<li><a data-src="'+url+'" href="#'+id+'" data-toggle="tab"><span class="tab_name">'+name+'</span> <span class="tabs-buts"><i class="icon-reload-alt tab-refresh"></i> '+close_but+'</span></a></li>');
	$(".ns-main-tabs .tab-content").append('<div class="tab-pane" id="'+id+'"><iframe scrolling="no" src="'+url+'"></iframe></div>');
	
	// log tab actione
	tab_urls.push(url);
	
	// Check if iframe load
	$('#'+id+' iframe').load(function() {
		// height
		
		
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

function ajustTabbar() {
	// Fix top tabs width
	var width = 0;
	$(".ns-main-tabs ul li").each(function() {
		width += $(this).width();
	});
	$(".ns-main-tabs .tabs-scroll-cont").width(width+100);
}

function ajustActiveNavPos() {
	// ajust tab scroll
	if($(window).width() <= 768) {
		var ol = $(".ns-main-tabs .nav li.active").offset().left;
		var ou = $(".ns-main-tabs .nav").offset().left;
		$(".tabs-scroll").scrollLeft(ol - ou - 20);
	}	
	if($(window).width() > 768) {
		var ol = $(".ns-main-tabs .nav li.active").offset().left;
		var ow = $(".ns-main-tabs .nav li.active").width();
		var ou = $(".ns-main-tabs .nav").offset().left;
		var wo = $(".tabs-scroll").offset().left;
		var w = $(".tabs-scroll").width();
		if ((ol+ow)+50 > (wo+w)) {
			$(".tabs-scroll-out").scrollLeft($(".tabs-scroll-out").scrollLeft() + ((ol+ow) - (wo+w)) + 50);
		}
		if (ol - 50 < wo) {
			$(".tabs-scroll-out").scrollLeft($(".tabs-scroll-out").scrollLeft() - ((wo - ol)) - 50);
		}
	}
}

function autoLayout() {
	// Auto iframe
	$(".tab-pane iframe").each(function() {
		resizeIframe($(this));
	});
	// tabbar width
	ajustTabbar();
	// scroll active
	
	// tab layout
	if($(window).width() > 768) {
		$(".tabs-scroll").width($(window).width()-$(".navbar-right").width()-$(".sidebar").width()-48);
		$(".tabs-scroll .bottom-line").css("margin-right", "-"+($(".navbar-right").width()+35)+"px");
	} else {
		$(".tabs-scroll").removeAttr("style");
		$(".tabs-scroll .bottom-line").removeAttr("style");
	}
	
	// scroll tabs
	ajustTabScroll();
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
	
	// hide sidebar if open
	$(".sidebar-xs-indicator").removeClass("sidebar-mobile-main");
	
	// ative pos
	setTimeout("ajustActiveNavPos()", 300);
	
	// log tab actione
	tab_urls.push(url);
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
	
	// remove tab url
	setTimeout("removeTabUrl('"+url+"')", 100);
	
	// next tab
	setTimeout("selectNextTab()", 200);
}

function resizeIframe(obj) {
	if(typeof(obj[0].contentWindow) != 'undefined' && obj[0].contentWindow.document.body) {
			// obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
			obj.height(obj.contents().find(".inner-page").height()+20);
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

var tab_urls = ["tab_home"];
$(document).ready(function() {
	setInterval("autoLayout()", 200);
	
	// remove loading effect
	$(".tab-loading").hide();
	
	$(document).on('click', 'a', function(e) {
		if($(this).hasClass("no-tab")) {
			return;
		}
		
		var url = $(this).attr("href");
		var title = $(this).attr("title");
		
		if(typeof(title) == 'undefined') {
			title = $(this).text();
		}
		
		if (typeof(url) != 'undefined' && url[0] != "#" && url !="" ) {
			e.preventDefault();
			if (window.frameElement) {				
				parent.openTab(url, title);
				parent.selectTab(url)
			} else {
				openTab(url, title);
				selectTab(url)
			}
		}
	});	
	
	// select tab
	$(document).on('click', '.ns-main-tabs .nav li a', function(e) {
		// ative pos
		setTimeout("ajustActiveNavPos()", 500);
		
		//// log last tab click
		//// log tab actione
		url = $(this).attr("data-src");
		tab_urls.push(url);
	});
	
	// close tab
	$(document).on('click', '.ns-main-tabs .tab-close', function(e) {
		var url = $(this).parents("a").attr("data-src");
		closeTab(url);
	});
	
	$(document).on('click', '.ns-main-tabs .tab-refresh', function(e) {
		var url = $(this).parents("a").attr("data-src");
		refreshTab(url);
	});
	
	// update tab title
	if (window.frameElement) {
		var title = document.title.split(" - ")[0];
		var url = window.location.href.replace(/^.*\/\/[^\/]+/, '');
		if(url != "/admin/dashboard" && title != "") {
			parent.setTabName(url, title);
		}
	}
	
	$(document).on('click', '.tabs-scroll .navi-left', function(e) {
		$('.tabs-scroll-out').scrollLeft($('.tabs-scroll-out').scrollLeft() - 100);
	});
	$(document).on('click', '.tabs-scroll .navi-right', function(e) {
		$('.tabs-scroll-out').scrollLeft($('.tabs-scroll-out').scrollLeft() + 100);
	});
	
});