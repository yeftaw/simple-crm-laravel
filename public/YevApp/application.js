var app = angular.module('YevApp', [
    'ui.router',
    'ui.bootstrap',
    'angular-growl',
    'ngSanitize',
    'ngAnimate',
    'datatables',
    'tc.chartjs'
]);

app.config(['$stateProvider', '$urlRouterProvider', '$locationProvider',
    function($stateProvider, $urlRouterProvider, $locationProvider) {
        $urlRouterProvider
            .otherwise('/login');

        $stateProvider
            .state('login', {
                url : '/login',
                module: 'public',
                templateUrl: 'YevApp/apps/auth/login.html',
                controller: 'AuthCtrl'
            })
            .state('main', {
                url : '',
                abstract: true,
                module: 'private',
                views : {
                    '': {
                      templateUrl: 'YevApp/apps/main/index.html',
                      controller: 'MainCtrl'
                    },
                    'header': {
                      templateUrl: 'YevApp/apps/main/header.html',
                      controller: 'MainCtrl'
                    }
                }
            })
            .state('main.dashboard', {
                url: '/dashboard',
                module: 'private',
                templateUrl: 'YevApp/apps/dashboard/dashboard.html',
                controller: 'DashboardCtrl'
            })
            .state('main.leads', {
                url: '/leads',
                abstract: true,
                module: 'private',
                templateUrl: 'YevApp/apps/main/content.html',
            })
            .state('main.leads.index', {
                url: '',
                module: 'private',
                templateUrl: 'YevApp/apps/leads/index.html',
                controller: 'LeadCtrl'
            })
            .state('main.leads.create', {
                url: '/create',
                module: 'private',
                templateUrl: 'YevApp/apps/leads/create.html',
                controller: 'LeadCreateCtrl'
            })
            .state('main.leads.detail', {
                url: '/:leadId',
                module: 'private',
                templateUrl: 'YevApp/apps/leads/detail.html',
                controller: 'LeadDetailCtrl'
            })
            .state('main.users', {
                url: '/users',
                abstract: true,
                module: 'private',
                templateUrl: 'YevApp/apps/main/content.html',
            })
            .state('main.users.index', {
                url: '',
                module: 'private',
                templateUrl: 'YevApp/apps/users/index.html',
                controller: 'UserCtrl'
            })
            .state('main.users.create', {
                url: '/create',
                module: 'private',
                templateUrl: 'YevApp/apps/users/create.html',
                controller: 'UserCreateCtrl'
            })
            .state('main.users.detail', {
                url: '/:userId',
                module: 'private',
                templateUrl: 'YevApp/apps/users/detail.html',
                controller: 'UserDetailCtrl'
            });
    }
]);

app.config(['growlProvider', function (growlProvider) {
    growlProvider.globalTimeToLive({success: 3000, error: 4000, warning: 5000, info: 8000});
    growlProvider.onlyUniqueMessages(true);
    growlProvider.globalDisableCountDown(true);
}]);

app.config(function($httpProvider) {

    var logsOutUserOn401 = function($location, $injector, $q, SessionService, growl) {
        var success = function(response) {
            return response;
        };

        var error = function(response) {
            if(response.status === 401)
            {
                SessionService.unset('authenticated');
                $injector.get('$state').transitionTo('login');
                growl.error(response.data.flash);
                return $q.reject(response);
            } else {
                return $q.reject(response);
            }
        };

        return function(promise) {
            return promise.then(success, error);
        };
    };

    $httpProvider.responseInterceptors.push(logsOutUserOn401);
});

app.factory("SessionService", function() {
  return {
    get: function(key) {
      return sessionStorage.getItem(key);
    },
    set: function(key, val) {
      return sessionStorage.setItem(key, val);
    },
    unset: function(key) {
      return sessionStorage.removeItem(key);
    }
  }
});

app.factory("LocalStorageService", function() {
   return {
    get: function(key) {
    return localStorage.getItem(key);
    },
    set: function(key, val) {
    return localStorage.setItem(key, val);
    },
    unset: function(key) {
    return localStorage.removeItem(key);
    }
   }
});

app.run(function($rootScope, $state, AuthService, growl) {

    $rootScope.getBgClass = function() {
        if($state.current.name == 'login') {
            return 'bg-black';
        } else {
            return '';
        }
    };

    $rootScope.$on('$stateChangeStart', function(event, toState, toParams, fromState, fromParams) {
        if(toState.module === 'private' && !AuthService.isLoggedIn()) {
            $state.go('login');
            event.preventDefault();
            growl.error("Please log in to continue.");
        } else if (toState.module === 'public' && AuthService.isLoggedIn()) {
            $state.go('main.dashboard');
            event.preventDefault();
        }
    });
});

