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
        jquery     : 'lib/jquery/jquery-min',
        underscore : 'lib/underscore/underscore',
        backbone   : 'lib/backbone/backbone',
        bootstrap  : 'lib/bootstrap/bootstrap',
        text       : 'lib/require/text'
    },
    shim: {
        'bootstrap': {
            deps: ['jquery'],
            exports: 'Bootstrap'
        }
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
        host: 'localhost:3000'
    })
});
