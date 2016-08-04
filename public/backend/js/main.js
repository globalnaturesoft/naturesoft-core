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
});