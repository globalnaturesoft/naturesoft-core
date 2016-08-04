$(document).ready(function() {    
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
});