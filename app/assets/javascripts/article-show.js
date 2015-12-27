/**
 * Created by sachin on 2/8/15.
 */
$(document).ready(function() {
    $('.align-settings').on('click', '*', function () {
        var align_css_class = { 'text-align' : $(this).attr('align-value') };
        $('.article-content').css(align_css_class);
    });

    $('.length-settings').on('click', '*', function() {
        var article = $('.article');
        var action = $(this).attr('length-action');
        var currentSetting = pxToPercent(article);
        var newSetting;
        if (action == '+') {
            newSetting = currentSetting + 10 + '%';
        }
        else if (action == '-') {
            newSetting = currentSetting - 10 + '%';
        }
        if (parseInt(newSetting) <= 100 && parseInt(newSetting)  >= 30) {
            var extend_css_class = {'width': newSetting};
            article.css(extend_css_class);
        }
    });

    $('.font-size-settings').on('click', '*', function() {
        var paragraphs = $('p');
        var action = $(this).attr('font-size-action');
        var currentSetting = paragraphs.css('font-size');
        var newSetting;
        if (action == '+') {
            newSetting = (parseInt(currentSetting) + 1) + 'px';
        }
        else if (action == '-') {
            newSetting = (parseInt(currentSetting) - 1) + 'px';
        }
        //var font_size_css_class = {'font-size': newSetting};
        paragraphs.attr('style', 'font-size: '.concat(newSetting).concat(' !important') );
    });

    $('.background-settings').on('click', '*', function() {
        var newBgColor = $(this).attr('bg-color-value');
        var bg_color_css_class;
        if (newBgColor != 'black') {
            bg_color_css_class = {'background': newBgColor, color: 'black'};
        }
        else {
            bg_color_css_class = {'background-color': newBgColor, color: 'white'}
        }
        $('.article-container').css(bg_color_css_class);
    });

    $(document).keydown(function(e) {
        if (e.which == 39) {
            $('.article').hide('drop', {direction: 'left'}, 1000);
        }
        e.preventDefault();
    });

    var pxToPercent = function(element) {
        return Math.round( 100 * parseFloat(element.css('width')) / parseFloat(element.parent().css('width')) ); // Converts px to %
    }
});

$(document).ready(function() {

    config = {
        url: $('#url').data('url'),
        ui: {
            flyout: 'middle left'
        }
    };

    var share = new ShareButton('.share-button', config);
    window.alert(share.config.url);
    //window.alert($('#url').data('url'));
});