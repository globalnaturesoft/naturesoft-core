function initSort() {
	var string = '<i class="icon-move sort-show ml-10" data-action="move"></i>' +
								'<a href="#"><i class="icon-move text-muted sort-hide enable-sort ml-10"></i></a>';
	$('.listing-form.sortable tr').each(function() {
		$(this).find("td").first().append(string);
	});
	
	$(".listing-form").each(function() {
		updateSort($(this));
	});
}

function updateSort(form) {
	var sortable = true;
	form.find("[sort-cond]").each(function() {
		var val = $(this).val();
		var data = $(this).attr("sort-cond");
		if(val != data) {
			sortable = false;
		}
	});
	
	if (sortable) {
		form.find(".sort-hide").hide();
		form.find(".sort-show").show();
	} else {
		form.find(".sort-show").hide();
		form.find(".sort-hide").show();
	}
}

function enableSort(form) {
	form.find("[sort-cond]").each(function() {
		var data = $(this).attr("sort-cond");
		$(this).val(data);
		$(this).trigger("change");
	});	
}

function urlParams(url) {
	var result = {};

	var params = url.split(/\?|\&/);

	params.forEach( function(it) {
		if (it) {
			var param = it.split("=");
			result[param[0]] = param[1];
		}
	});

	return result;
}

function hiliter(word, element) {
    var rgxp = new RegExp(word, 'gi');
    var string = element.html().match(rgxp);
    var repl = '<hl>' + string + '</hl>';    
    element.html(element.html().replace(rgxp, repl));
}

function hiliterList(form, keyword) {    
    if (keyword.length > 1) {
        form.find(".kq_search").each(function() {
            hiliter(keyword, $(this));
        });
    }
}

function tableFilterAll() {
    $(".listing-form").each(function() {
        tableFilter($(this));
    });
}

var currentFilter = null; 
function tableFilter(form, custom_url) {
    var url = form.attr("data-url");
    var per_page = form.attr("per-page")
    var sort_order = form.find("select[name='sort-order']").val();
	var container = form.find(".table-container");
    
    // Remove sort direction when sort order == custom_order
    if(sort_order == 'custom_order') {
        form.find(".sort-direction").attr("rel", "asc");
        form.find(".sort-direction").find("i").attr("class", "icon-sort-amount-asc");
        form.find(".sort-direction").hide();
    } else {
        form.find(".sort-direction").show();
    }
    
    var sort_direction = form.find(".sort-direction").attr("rel");
    var keyword = form.find("input[name='keyword']").val();
	
	// Default page
	var page = 1;
	
	// Current page
    if(typeof(container.attr("data-page")) != 'undefined') {
		page = container.attr("data-page");
    }	
	
    // Custom page
    if(typeof(custom_url) != 'undefined') {
		if (typeof(urlParams(custom_url)["page"]) != 'undefined') {
			page = urlParams(custom_url)["page"];
		}
    }
	
	// Set current page
	container.attr("data-page", page);
    
    // showed columns
    var columns = form.find("input[name='columns[]']:checked").map(function () {
        return this.value;
    }).get().join(",");
    
    // all data
    var data = {
		ajax: true,
        per_page: per_page,
				page: page,
        sort_direction: sort_direction,
        columns: columns
    };
    
    form.serializeArray().forEach(function(entry) {
        if(entry.value != "") {
            data[entry.name] = entry.value
        }
    });
    
	// Brefore filter
	if(!container.find(".table-loading").length) {
		container.prepend('<div class="table-loading"><i class="icon-spinner11 spinner position-left"></i></div>');
	}
	
    // ajax update custom sort
	if(currentFilter && currentFilter.readyState != 4){
		currentFilter.abort();
	}
    currentFilter = $.ajax({
        method: "GET",
        url: url,
        data: data
    })
    .done(function( msg ) {        
        container.html($("<div>").html(msg).find(".table-container").html());
        
        // Uniform
        container.find(".styled").uniform({
            radioClass: 'choice'
        });
        
        // Default tooltip
        container.find('[data-popup=tooltip]').tooltip({
            template: '<div class="tooltip"><div class="bg-teal-800"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div></div>'
        });
        
        // Pagination class
        // ------------------------------
        form.find(".pagination").addClass('pagination-separated');
        
        // Select2
        // ------------------------------
        // form.find(".select").select2({minimumResultsForSearch: -1});
        
        // Hightlight
        if (typeof(keyword) != 'undefined' && keyword.trim() != '') {
            keywords = keyword.split(" ");
            keywords.forEach(function (v) {
                hiliterList(form, v.trim());
            });            
        }
        
        // update checklist
        updateCheckList();
				
				updateSort(form);
				
				initSort();
		
			// After filter
			// form.find(".table-loading").hide();
    });
}

function listCheckAll(form) {
    form.find('table input[type=checkbox]').prop("checked", true);
    form.find('.check_all_list').removeClass('check-some');
    form.find('.list_actions').removeClass('hide');
    $.uniform.update();
}

function listUncheckAll(form) {
    form.find('table input[type=checkbox]').prop("checked", false);
    form.find('.check_all_list').removeClass('check-some');
    form.find('.list_actions').addClass('hide');
    $.uniform.update();
}

function updateCheckList() {
    $(".listing-form").each(function() {
        var form = $(this);
        var total = form.find("input[name='ids[]']").length;        
        var vals = form.find("input[name='ids[]']:checked").map(function () {
                    return this.value;
                }).get();
        
        // Check if none checked
        if (vals.length == 0) {            
            form.find('.check_all_list input').prop("checked", false);            
            form.find('.check_all_list').removeClass('check-some');
            form.find('.list_actions').removeClass('check-some');
            form.find('.list_actions').addClass('hide');
            $.uniform.update();
        }
        
        // Check if some checked
        else if (total > vals.length) {
            form.find('.check_all_list input').prop("checked", true);
            form.find('.check_all_list').addClass('check-some');
            form.find('.list_actions').removeClass('hide');
            $.uniform.update();
        }
        
        // check if all checked
        else if (total == vals.length) {
            form.find('.check_all_list input').prop("checked", true);
            form.find('.check_all_list').removeClass('check-some');
            form.find('.list_actions').removeClass('hide');
            listCheckAll(form);
        }
        
    });
}

function updateCustomOrder(form) {
    var sort = [];
    var sort_url = form.attr("sort-url");
    form.find("table tr input[name='custom_order']").each(function(index) {
        var num = $(this).parents("td").find("input[name='ids[]']").val();
        var row = [];
        row.push($(this).val());
        row.push(num);
        sort.push(row);
    });
    console.log(JSON.stringify(sort));
    
    // ajax update custom sort
    if (typeof(sort_url) != 'undefined') {				
        $.ajax({
            method: "GET",
            url: sort_url,
            data: { sort: JSON.stringify(sort) }
        })
        .done(function( msg ) {
            // Success alert
            parent.swal({
                title: msg,
                text: "",
                confirmButtonColor: "#00695C",
                type: "success",
                allowOutsideClick: true,
                confirmButtonText: "OK",
            });
						
						tableFilter(form);
        });
    }
}

var drag_child;
$(document).ready(function() {
    
    $(".listing-form").each(function() {
        var form = $(this);
        
        // Make list sortable        
        form.sortable({
            connectWith: '.sortable',
            items: 'tr',
            helper: 'original',
            cursor: 'move',
            handle: '[data-action=move]',
            revert: 100,
            containment: 'tbody',
            forceHelperSize: true,
            // placeholder: 'sortable-placeholder',
            forcePlaceholderSize: true,
            tolerance: 'pointer',
            start: function(e, ui) {
                //drag_child = ui.item.next().next();
                //$("tr.child").hide();
                //ui.placeholder.height(ui.item.outerHeight());
            },
            update: function(e, ui) {
                //$("tr.child").each(function() {
                //    var rel = $(this).attr("parent");
                //    $(this).insertAfter($("tr[rel='"+rel+"']"));   
                //});
                //$("tr.child").fadeIn();
                updateCustomOrder(form);
            },
            stop: function(event, ui) {
                //$("tr.child").fadeIn();
            }
        });
        
        // Render table
        tableFilter(form);
    });
    
    // Update checkbox list
    $(document).on("change", "input[name='ids[]']", function() {
        updateCheckList();
    });
    
    // Check / Uncheck all
    $(document).on("mouseup", ".check_all_list", function() {
        var checked = $(this).find('input').is(':checked');

        if (checked) {
            listUncheckAll($(this).parents(".listing-form"));
        } else {
            listCheckAll($(this).parents(".listing-form"));
        }
        
        setTimeout("updateCheckList()", 200);
    });
    
    // Change page
    $(document).on("click", ".listing-form .pagination a", function(e) {
        tableFilter($(this).parents(".listing-form"), $(this).attr("href"));

				e.preventDefault();
				e.stopPropagation();
				e.stopImmediatePropagation();
    });
    
    // Change item per page
    $(document).on("change", ".num_per_page select", function(e) {
        var form = $(this).parents(".listing-form");
        var value = $(this).val();
        
        form.attr("per-page", value);
        
        tableFilter(form);
    });
    
    // Sort direction button
    $(document).on("click", ".sort-direction", function(e) {
        var val = $(this).attr("rel");
        var form = $(this).parents(".listing-form");
        
        if (val == "asc") {
            $(this).attr("rel", "desc");
            $(this).find("i").attr("class", "icon-sort-amount-desc");
        } else {
            $(this).attr("rel", "asc");
            $(this).find("i").attr("class", "icon-sort-amount-asc");
        }
        
        tableFilter(form);
    });
    
    // Sort button
    $(document).on("change", ".listing-form select", function() {
        var form = $(this).parents(".listing-form");
				var container = form.find(".table-container");
				container.attr("data-page", 1);
        
        tableFilter(form);
    });    
    $(document).on("keyup", ".listing-form input", function() {
        var form = $(this).parents(".listing-form");
				var container = form.find(".table-container");
				container.attr("data-page", 1);
        
        tableFilter(form);
    });
    
    //// Search when typing
    // $(document).on("keyup", "input[name='keyword']", function() {
        // var form = $(this).parents(".listing-form");
        
        // tableFilter(form);
    // });
    
    // Columns filters
    $(document).on("click", ".list_columns ul li", function(e) {
        e.stopImmediatePropagation();
    });
    
    // Columns filters
    $(document).on("change", ".listing-form input[name='columns[]']", function(e) {
        var form = $(this).parents(".listing-form");
        
        tableFilter(form);
    });
		
		// Action list event
    // ------------------------------
    $(document).on("click", ".list_actions a", function(e) {
        var form = $(this).parents(".listing-form");
        var vals = form.find("input[name='ids[]']:checked").map(function () {
            return this.value;
        }).get();
        
        $(this).attr("href", $(this).attr("data-href") + "?ids=" + vals.join(","));
        $(this).attr("items-count", vals.length);
    });
		
		// Enable sort
		$(document).on("click", ".enable-sort", function() {
			var form = $(this).parents(".listing-form");
			enableSort(form);
		});
});