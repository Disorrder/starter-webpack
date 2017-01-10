import 'angular';

// import 'bootstrap';
// import uiBootstrap  from 'angular-bootstrap';
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap/dist/css/bootstrap-theme.css';

angular.module('app', [
    // 'ui.router',
    // 'ui.bootstrap',
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
        let path = to.name.split('.');
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


import {requireAll} from '../utils';
requireAll();
