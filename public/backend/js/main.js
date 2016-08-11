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
    $(".select2").select2();
    
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
    // File input
    $(".file-styled").uniform({
        wrapperClass: 'bg-primary',
        fileButtonHtml: '<i class="icon-cloud-upload2"></i>'
    });
	
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
    
    // Validate form
    $("form.validate").validate();
});