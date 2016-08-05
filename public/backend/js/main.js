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
	$(document).on('click', 'a[data-method=delete]', function(e) {
		var msg = $(this).attr("data-confirm");
		var url = $(this).attr("href");
		var modal = $('#modal_delete_cofirm');
		if(typeof(msg) != 'undefined') {
			modal.find('.btn-confirm').attr('href', url);
			modal.find('.modal-body h4').html(msg);
			modal.modal("show");
			e.preventDefault();
		}
	});
	$(document).on('click', '#modal_delete_cofirm a.btn-confirm', function(e) {
		var url = $(this).attr("href");
		var modal = $('#modal_delete_cofirm');
		modal.modal("hide");
		
		$.ajax({ url: url,
			type: 'DELETE',
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			success: function(response) {
				tableFilterAll();
				swal({
					title: response,
					confirmButtonColor: "#00acc1",
					type: "success",
					allowOutsideClick: true
				});
			}
		});
		
		
		e.preventDefault();
	});
});