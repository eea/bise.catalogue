# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->

    $('ul.nav.nav-tabs li a').click () ->
        $(this).parent().addClass('active').siblings().removeClass('active')
        sectionName = $(this).data('article');
        $(sectionName).siblings().hide();
        $(sectionName).show()

    # ----------------- PUBLISHED
    # $('#article_published').toggleButtons(
    #     style:
    #         enabled: "success",
    #         disabled: "danger"
    #     label:
    #         enabled: "YES",
    #         disabled: "NO"

    # )
    $('#article_published_on').datepicker();

    # ----------------- CONCEPTS
    $("#concepts_tree").fancytree({
        autoCollapse: true
        autoFocus: false
        extensions: ["filter"]
        selectMode: 2
        clickFolderMode: 3
        # checkbox: true
        selectMode: 2
        noLink: true
        source:
            url: "/themes.json"
        filter:
            mode: "hide"
        rendernode: (event, data) ->
            data.node.li.children[0].children[1].style.display = 'none' if (data.node.folder)
        init: (event, data) ->
            $('#filterpane').show()
            selected = $('#concepts_tree').data('selected')
            for s in selected
                console.log s
                window.tree.getNodeByKey(s).setSelected(true)
        activate: (e, data) ->
            # --- ON CLICK ---
            if !(data.node.folder)
                tag = $('<span>').addClass('tag').html(data.node.title)
                $('.tag_container').append(tag)
    })
    window.tree = $("#concepts_tree").fancytree("getTree");

    # ----------------- SEARCH CONCEPTS
    $("input[name=search]").keyup( (e) ->
        match = $(this).val()
        if(e && e.which == $.ui.keyCode.ESCAPE || $.trim(match) == "" )
            $('a#reset').click()
            return
        n = window.tree.applyFilter(match)
        $("a#reset").attr("disabled", false)
        $("span#matches").text("(" + n + " matches)")
    ).focus()

    # ----------------- RESET BUTTON
    $("a#reset").click( (e) ->
        $("input[name=search]").val("")
        $("span#matches").html("")
        window.tree.clearFilter()
    ).attr("disabled", true)

    # ----------------- SUBMIT
    $("form").submit( () ->
        # Render hidden <input> elements for active and selected nodes
        $("#concepts_tree").fancytree("getTree").generateFormElements();
    )


    # tinyMCE.init
    #     mode: 'textareas'
    #     theme: 'advanced'
    #     # plugins : "autolink,lists,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

    #     # # Theme options
    #     theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect"
    #     # theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect"
    #     # theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor"
    #     # theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen"
    #     # theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,spellchecker,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,blockquote,pagebreak,|,insertfile,insertimage"
    #     theme_advanced_toolbar_location : "top"
    #     theme_advanced_toolbar_align : "left"
    #     theme_advanced_statusbar_location : "bottom"
    #     # theme_advanced_resizing : true

    #     # Skin options
    #     # skin : "thebigreason"
    #     # skin_variant : "black",

    #     # Example content CSS (should be your site CSS)
    #     # content_css : "css/example.css",

    #     # # Drop lists for link/image/media/template dialogs
    #     # template_external_list_url : "js/template_list.js",
    #     # external_link_list_url : "js/link_list.js",
    #     # external_image_list_url : "js/image_list.js",
    #     # media_external_list_url : "js/media_list.js",

    #     # # Replace values for the template plugin
    #     # template_replace_values : {
    #     #         username : "Some User",
    #     #         staffid : "991234"
    #     # }


    if ($("#articles_graph").length > 0)
        Morris.Bar
            element: 'articles_graph'
            pointSize: 1
            data: [
              {y: 'January', a: 246}
              {y: 'February', a: 103}
              {y: 'February', a: 246}
              {y: 'April', a: 103}
              {y: 'May', a: 66}
              {y: 'June', a: 204}
              {y: 'July', a: 27}
              {y: 'August', a: 246}
              {y: 'September', a: 103}
              {y: 'October', a: 66}
              {y: 'November', a: 204}
              {y: 'December', a: 27}
            ]
            xkey: 'y'
            ykeys: ['a']
            labels: ['Series a']
            barColors: [ '#86a000' ]
