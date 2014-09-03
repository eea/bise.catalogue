/*******************************************
 * BISE Catalogue - http://eea.europa.eu
 * a: Jon Arrien Fernandez
 * m: jonarrien@gmail.com
 * t: @jonarrien
 *******************************************/

require.config({
    // optimizeAllPluginResources: true,
    text: {
        useXhr: function (url, protocol, hostname, port) {
            return true
        }
    },
    paths: {
        text       : 'lib/require/text',
        jquery     : 'lib/jquery/jquery-min',
        jqcloud    : 'lib/jquery/jqcloud-min',
        underscore : 'lib/underscore/underscore',
        backbone   : 'lib/backbone/backbone',
        bootstrap  : 'lib/bootstrap/bootstrap'
    },
    shim: {
        'bootstrap': {
            deps: ['jquery'],
            exports: 'Bootstrap'
        }
    },
    tpl: {
        extension: '.html'
    }
    // map: {
    //     // '*' means all modules will get 'jquery-private'
    //     // for their 'jquery' dependency.
    //     '*': { 'jquery': 'jq-priv' },

    //     // 'jquery-private' wants the real jQuery module
    //     // though. If this line was not here, there would
    //     // be an unresolvable cyclic dependency.
    //     'jq-priv': { 'jquery': 'jquery' }
    // }
});

require(['views/app'], function(AppView){
    window.Catalogue = new AppView({
        host: 'termite.eea.europa.eu'
        // host: 'bise.catalogue.dev'
    })
});
