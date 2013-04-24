
$ ->

    eu15 = [
        'austria',
        'belgium',
        'denmark',
        'finland',
        'france',
        'germany',
        'greece',
        'ireland',
        'italy',
        'luxembourg',
        'netherlands',
        'portugal',
        'spain',
        'sweden',
        'united-kingdom'
    ]

    eu25 = eu15.concat [
        'cyprus',
        'czech-republic',
        'estonia',
        'hungary',
        'latvia',
        'lithuania',
        'malta',
        'poland',
        'slovakia',
        'slovenia'
    ]

    eu27 = eu25.concat [
        'bulgaria',
        'romania'
    ]

    eu28 = eu27.concat [

    ]

    eea = [
        'austria', 'belgium', 'bulgaria', 'cyprus', 'czech-republic', 'denmark',
        'estonia', 'finland', 'france', 'germany', 'greece', 'hungary', 'ireland',
        'italy', 'latvia', 'lithuania', 'luxembourg', 'malta', 'netherlands',
        'poland', 'portugal', 'romania', 'slovakia', 'slovenia', 'spain', 'sweden',
        'united-kingdom', 'iceland', 'liechtenstein', 'norway', 'switzerland', 'turkey'
    ]

    $('#countries .btn-group .btn').click( ()->

        $(@).siblings().removeClass('btn-success')
        $(@).addClass('btn-success')

        if $(@).hasClass('eu15')
            $('#countries').find('input').prop('checked', false)
            for c in eu15
                $('#' + c).prop('checked', true);
        else if $(@).hasClass('eu25')
            $('#countries').find('input').prop('checked', false)
            for c in eu25
                $('#' + c).prop('checked', true);
        else if $(@).hasClass('eu27')
            $('#countries').find('input').prop('checked', false)
            for c in eu27
                $('#' + c).prop('checked', true);
        else if $(@).hasClass('eu28')
            $('#countries').find('input').prop('checked', false)
        else if $(@).hasClass('eea-members')
            for c in eea
                $('#' + c).prop('checked', true);
        else if $(@).hasClass('no-country')
            $('#countries').find('input').prop('checked', false)
            $(@).removeClass('btn-success')
    )
