function updateCountdown() {
    // 140 is the max message length
    var remaining = 140 - jQuery('#micropost_content').val().length;
    if (remaining > 0) {
    jQuery('#countdown').text(remaining + ' characters remaining').css('color', 'black');
    } 
    else {
        jQuery('#countdown').text('0 characters remaining').css('color', 'red');
    }  
}

jQuery(document).ready(function($) {
    updateCountdown();
    $('#micropost_content').change(updateCountdown);
    $('#micropost_content').keyup(updateCountdown);
});