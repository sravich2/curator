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
        var currentSetting = pxToPercent($('.main-container'));
        if (action == '+') {
            newSetting = currentSetting + 10 + '%';
        }
        else if (action == '-') {
            newSetting = currentSetting - 10 + '%';
        }
        if (parseInt(newSetting) <= 100 && parseInt(newSetting)  >= 30) {
            var extend_css_class = {'width': newSetting};
            $('.main-container').css(extend_css_class);
        }
    });

    $(document).keydown(function(e) {
        if (e.which == 39) {
            $('.main-container').hide('drop', {direction: 'left'}, 1000);
        }
        e.preventDefault();
    });

    var pxToPercent = function(element) {
        return Math.round( 100 * parseFloat(element.css('width')) / parseFloat(element.parent().css('width')) ); // Converts px to %
    }
});