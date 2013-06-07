$ ->
    $("a[rel=popover]").popover()
    $(".tooltip").tooltip()
    $("a[rel=tooltip]").tooltip()

    $('.toolbar .btn-toolbar .btn').on 'click', (e) ->
        $(this).siblings().removeClass 'active'
        $(this).addClass 'active'
