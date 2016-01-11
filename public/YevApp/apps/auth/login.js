// Authentication
app.factory("AuthService", function($http, $sanitize, SessionService, LocalStorageService, growl, CSRF_TOKEN) {

    var cacheSession   = function(response) {
        SessionService.set('authenticated', true);
        growl.success("You've successfully logged in.");
        LocalStorageService.set('user_information', JSON.stringify(response));
    };

    var uncacheSession = function() {
        SessionService.unset('authenticated');
        LocalStorageService.unset('user_information');
        growl.success("You've logged out.");
    };

    var loginError = function(response) {
        growl.error(response.flash);
    };

    var sanitizeCredentials = function(credentials) {
        return {
            email: $sanitize(credentials.email),
            password: $sanitize(credentials.password),
            csrf_token: CSRF_TOKEN
        };
    };

    return {
        login: function(credentials) {
            var login = $http.post("/api/auth/login", sanitizeCredentials(credentials));
                login.success(cacheSession);
                login.error(loginError);
            return login;
        },
        logout: function() {
            var logout = $http.get("/api/auth/logout");
                logout.success(uncacheSession);
            return logout;
        },
        isLoggedIn: function() {
            return SessionService.get('authenticated');
        },
        currentUser: function(data) {
            return
        }
    };
});

// Login Controller
app.controller("AuthCtrl", function($scope, $location, AuthService) {
    $scope.credentials = { email: "", password: "" };

    $scope.login = function() {
        AuthService.login($scope.credentials).success(function(data) {
            $location.path('/dashboard');
        });
    };
});
