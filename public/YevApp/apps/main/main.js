// Main Controller
app.controller("MainCtrl", function($scope, $location, AuthService, LocalStorageService) {
    $scope.user;
    $scope.user = JSON.parse(LocalStorageService.get('user_information'));

    $scope.logout = function() {
        AuthService.logout().success(function() {
            $location.path('/login');
        });
    };
});

// Main Filter
app.filter('capitalize', function() {
    return function(input, scope) {
        if (input!=null)
            return input.substring(0,1).toUpperCase()+input.substring(1);
    }
});
