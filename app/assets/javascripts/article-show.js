/**
 * Created by sachin on 2/8/15.
 */
$(document).ready(function() {
    $('.align-settings').on('click', '*', function () {
        var align_css_class = { 'text-align' : $(this).attr('align-value') };
        $('.article-content').css(align_css_class);
    });

    $('.length-settings').on('click', '*', function() {
        var action = $(this).attr('length-action');
        var currentSetting = Math.round( 100 * parseFloat($('.main-container').css('width')) / parseFloat($('.main-container').parent().css('width')) ); // Converts px to %
        if (action == '+') {
            newSetting = currentSetting + 10 + '%';
        }
        else if (action == '-') {
            newSetting = currentSetting - 10 + '%';
        }
        var extend_css_class = { 'width' : newSetting };
        $('.main-container').css(extend_css_class);
    })
});