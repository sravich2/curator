$(document).ready(function () {
    $('.article-item').on('click', '*', function () {
        var info = {
            article_id: $(this).closest('.article-item').data('id'),
            user_id: 1
        };

        $.ajax({
            url: '/likes/create',
            type: 'POST',
            data: info,
            remote: true
        })
    })
});