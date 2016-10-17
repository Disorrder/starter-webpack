function requireAll(requireContext) {
    modules = requireContext.keys();
    modules = _(modules)
        .map((v) => {
            if (~v.indexOf('/__')) return; // exclude prefix
            requireContext(v);
        })
        .value()
    ;
}

requireAll( require.context('./', true, /\.js$/) ); // auto require from project

angular.module('app', [
    'ui.router',
    'ui.bootstrap',
])

.config(['$urlRouterProvider', '$locationProvider', ($urlRouterProvider, $locationProvider) => {
    $locationProvider.html5Mode({
        enabled: true,
        requireBase: false
    });
    // $urlRouterProvider.otherwise('/');
    // $urlRouterProvider.otherwise(($injector) => {
    //     $state = $injector.get '$state'
    //     $state.go '404'
    // });
}])

.run(['$rootScope', '$state', ($rootScope, $state) => {
    window.__rootScope = $rootScope;
    $rootScope.$on('$stateChangeStart', (e, to) => {
        if (to.parent) return;
        path = to.name.split('.');
        if (path.length > 1) {
            path.pop();
            to.parent = path.join('.');
        }
    });
}])

// Debug
.run(['$rootScope', '$state', ($rootScope, $state) => {
    $rootScope.$on('$stateChangeStart', (e, to) => {
        console.log('stateChangeStart', to);
    });
    $rootScope.$on('$stateChangeSuccess', (e, to) => {
        console.log('stateChangeSuccess', to);
    });
    $rootScope.$on('$stateChangeError', (e, to, toParams, from, fromParams, err) => {
        console.log('stateChangeError', err);
        $state.go('404');
    });
}])
