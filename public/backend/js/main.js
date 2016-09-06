function showTabValidate() {
    $(".tab-pane").each(function() {
        var id = $(this).attr("id");
        if($(this).find("input.error").length || $(this).find("select.error").length) {
            $(this).parents(".tabbable").find("ul li a[href='#"+id+"']").addClass("tab-error");
        } else {
            $(this).parents(".tabbable").find("ul li a[href='#"+id+"']").removeClass("tab-error");
        }
    });
}

function initEditor(item) {
    tinyMCE.editors=[];
    // tinymce
    tinymce.init({
        selector: item,
        height: 500,
        plugins: [
          'advlist autolink lists link image charmap print preview anchor',
          'searchreplace visualblocks code fullscreen',
          'insertdatetime media table contextmenu paste code'
        ],
        toolbar: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image media ',
        content_css: [
          // '//fast.fonts.net/cssapi/e6dc9b99-64fe-4292-ad98-6974f93cd2a2.css',
          // '//www.tinymce.com/css/codepen.min.css'
        ]
    });
}

function select2Ajax(item) {
    var url = item.attr("data-url");
    var id = item.attr("value");
    var text = item.attr("text");
    var placeholder = item.attr("placeholder");
    var excluded = item.attr("data-excluded");
    var multiple = item.attr("multiple");
    var allowClear = true;
    if(typeof(placeholder) == 'undefined') {
        placeholder = 'none';
    }
    if(typeof(excluded) == 'undefined') {
        excluded = '';
    }
    if(typeof(multiple) != 'undefined' && multiple != "false") {
        allowClear = false;
    }
    item.select2({
        ajax: {
            url: url,
            dataType: 'json',
            delay: 250,            
            data: function (params) {
              return {
                q: params.term, // search term
                page: params.page,
                excluded: excluded
              };
            },
            processResults: function (data, params) {
                // parse the results into the format expected by Select2
                // since we are using custom formatting functions we do not need to
                // alter the remote JSON data, except to indicate that infinite
                // scrolling can be used
                params.page = params.page || 1;
          
                return {
                    results: data.items,
                    pagination: {
                        more: (params.page * 30) < data.total_count
                    }
                };
            },
            cache: true
        },
        //initSelection: function (element, callback) {
        //    if(typeof(id) != 'undefined') {
        //        callback({ id: id, text: text });
        //    } else {
        //        callback({ id: "", text: "none" });
        //    }
        //},
        placeholder: placeholder,
        escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
        allowClear: allowClear,
        minimumInputLength: 0,
    }).on("change", function (e) {
        $(this).valid(); //jquery validation script validate on change
    });;
}

function format_number(element, digits) {
    element.inputmask("decimal", { radixPoint: ".", autoGroup: true, groupSeparator: "", digits: digits, groupSize: 3 });
}

// crop image in box
function cropImage(img) {
    var box = img.parent();
    
    // calculate crop part
    var box_width = box.width();
    var box_height = box.height();
    var width = img[0].naturalWidth;
    var height = img[0].naturalHeight;
    var cal_width, cal_height;

    if(width/height < box_width/box_height) {
        cal_height = box_height;
        cal_width = box_height*(height/width);
    } else {
        cal_width = box_width;
        cal_height = box_width*(width/height);
    }
    
    img.width(cal_height);
    img.height(cal_width);
    
    var mleft = -Math.abs(cal_width - box_width)/2;
    var mtop = -Math.abs(cal_height - box_height)/2;
    img.css("margin-left", mtop+"px");
    img.css("margin-top", mleft+"px");
}

// Preview upload image
function readURL(input, img) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            img.attr('src', e.target.result);
            
            // calculate crop part
            cropImage(img);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

$(document).ready(function() {
    // Default select2
    $(".select2").select2().on("change", function (e) {
        $(this).valid(); //jquery validation script validate on change
    });
    $(".select").select2().on("change", function (e) {
        $(this).valid(); //jquery validation script validate on change
    });;
    
    // Default initialization
    $(".styled").uniform();
    
    // Add active class to last breadscrumb
    $(".breadcrumb li").last().addClass("active");
    
    // Checkboxes and radios
    $(".styled-level-1, .multiselect-container input").uniform({
        radioClass: 'choice',
        checkboxClass: 'checker',
        wrapperClass: "border-teal text-teal-600"
    });
    // Checkboxes and radios
    $(".styled-level-2, .multiselect-container input").uniform({
        radioClass: 'choice',
        checkboxClass: 'checker',
        wrapperClass: "border-warning text-warning-600"
    });
    // Select2 ultiselect item color
    $('.multi-select2-article-categories').select2({
        formatSelectionCssClass: function (data, container) { return "bg-primary"; }
    });
    $('.multi-select2-categories').select2({
        formatSelectionCssClass: function (data, container) { return "bg-primary"; }
    });
    $('.multi-select2-labels').select2({
        formatSelectionCssClass: function (data, container) { return "bg-primary"; }
    });
    $('.multi-select2-properties').select2({
        formatSelectionCssClass: function (data, container) { return "bg-primary"; }
    });
    
    // File input
    $(".file-styled").uniform({
        wrapperClass: 'bg-primary',
        fileButtonHtml: '<i class="icon-cloud-upload2"></i>'
    });
    
    // Validate form
    $("form.validate").validate({ 
        ignore: [],
        highlight: function (element, errorClass, validClass) {
            var elem = $(element);
            
            if (elem.hasClass("select2-hidden-accessible")) {
                elem.parent().find(".select2-selection").addClass("error");
            }

            elem.addClass(errorClass);
            showTabValidate();
        },    
        unhighlight: function (element, errorClass, validClass) {
            var elem = $(element);
            
            if (elem.hasClass("select2-hidden-accessible")) {
                elem.parent().find(".select2-selection").removeClass("error");
            }
            
            elem.removeClass(errorClass);
            showTabValidate();
        },
    });
    
    // format number input
    format_number($(".number_input"), 0);    
    
    // Select2 ajax
    $(".select2-ajax").each(function() {
        select2Ajax($(this));        
    });
    
    // tinymce
    initEditor(".editor");
	
	//replace delete-confirm link
	$(document).on('click', '[data-method]', function(e) {
		var msg = $(this).attr("data-confirm");
		var url = $(this).attr("href");
		var modal = $('#modal_cofirm');
        var redirect = $(this).attr("redirect_to");
        if (window.frameElement) {
            modal = parent.$('#modal_cofirm');
        }
		var method = $(this).attr("data-method");
		if(typeof(msg) != 'undefined') {
			modal.find('.btn-confirm').attr('href', url);
			modal.find('.btn-confirm').attr('data-method', method);
			modal.find('.modal-body h4').html(msg);
			modal.modal("show");			
		} else {
			modal.modal("hide");
			$.ajax({ url: url,
				type: method,
				beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
				success: function(response) {
                    // modern message
                    if (response != "") {
                        var config = {
                            title: response,
                            confirmButtonColor: "#00acc1",
                            type: "success",
                            allowOutsideClick: true
                        }
                        if (window.frameElement) {
                            tableFilterAll();
                            parent.swal(config);
                        } else {
                            $(".tab-pane.active iframe")[0].contentWindow.tableFilterAll();
                            swal(config);
                        }
                    }
                    
                    // redirect if has attr                    
                    if (typeof(redirect) != 'undefined') {
                        window.location = redirect;
                    }
				}
			});
		}
		e.preventDefault();
        e.stopPropagation();
        e.stopImmediatePropagation();
	});
    
    // Preview upload image    
    $(".previewable").change(function() {
        var img = $("img[preview-for='" + $(this).attr("name") + "']");
        readURL(this, img);
    });
    $(".remove-profile-image").click(function() {
        var img = $(this).parents(".profile-image").find("img");
        var imput = $(this).parents(".profile-image").find("input[name='_remove_image']");
        img.attr("src", img.attr("empty-src"));
        imput.val("true");
    });
    
    // Addable form
    $(document).on('click', '.addable-add', function() {
        var form = $(this).parents(".addable-form");
        var sample = $('.'+form.attr("data-sample"));
        if(sample.find("span.select2").length) {
            sample.find("select.select2").select2('destroy');
        }
        if(sample.find("select.select2-ajax").length) {
            sample.find("select.select2-ajax").select2('destroy');
        }
        var data = sample.html();
        var container = form.find(".addable-container");
        
        // calculate index
        var index = 0;
        container.children().each(function() {
            if(index <= parseInt($(this).attr("data-index"))) {
                index = parseInt($(this).attr("data-index")) + 1;
            }
        });
        
        // add child
        data = data.replace(/\<\<index\>\>/g, index);

        container.append(data);
        
        // select2
        container.children().last().find('.select2').select2();
        
        // format number input
        container.children().last().find('.number_input').each(function() {
            format_number($(this), 0);
        });
        
        //// File input
        //container.children().last().find("input[type=file]").uniform({
        //    wrapperClass: 'bg-primary',
        //    fileButtonHtml: '<i class="icon-cloud-upload2"></i>'
        //});
        
        // Select2 ajax
        container.children().last().find("select.select2-ajax").each(function() {
            select2Ajax($(this));        
        });
    });
    $(document).on('click', '.addable-remove', function() {
        var row = $(this).parents(".addable-row").remove();
    });
    $(document).on('click', '.addable-nested-remove', function() {
        var row = $(this).parents(".addable-row");
        row.find('input.delete').prop('checked', true);;        
        $(this).parents(".addable-row").hide();
    });
    
    // check group
    $(document).on('change', 'input[check-group]', function(e) {
        var group = $(this).attr('check-group');
        $('input[check-group="' + group + '"]').prop('checked', false);
        $(this).prop('checked', true);
    });
    
    // module select
    $(document).on("change", ".module-type-select", function() {
        var val = $(this).val();
        var url = $(this).attr("data-url");
        
        if(val != "") {
            $.ajax({
                method: "GET",
                url: url,
                data: { type: val }
            })
            .done(function( msg ) {
                // Success alert
                $('.module_options_container').html(msg);
                
                // Select2 ajax
                $(".module_options_container select.select2-ajax").each(function() {
                    select2Ajax($(this));        
                });
                
                // Select2 ajax
                $(".module_options_container select.select2").select2();
                
                // format number input
                format_number($(".module_options_container .number_input"), 0);
            });
        } else {
            $('.module_options_container').html('');
        }
    });    
    $(".module-type-select").trigger("change");
    
    // menu type select
    $(document).on("change", ".menu-type-select", function() {
        var val = $(this).val();
        var url = $(this).attr("data-url");
        
        if(val != "") {
            $.ajax({
                method: "GET",
                url: url,
                data: { type: val }
            })
            .done(function( msg ) {
                // Success alert
                $('.menu_params_container').html(msg);
                
                // Select2 ajax
                $(".menu_params_container select.select2-ajax").each(function() {
                    select2Ajax($(this));        
                });
                
                // Select2 ajax
                $(".menu_params_container select.select2").select2();
                
                // format number input
                format_number($(".menu_params_container .number_input"), 0);
            });
        } else {
            $('.menu_params_container').html('');
        }
    });    
    $(".menu-type-select").trigger("change");
});