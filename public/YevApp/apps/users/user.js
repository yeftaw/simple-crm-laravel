// User Status Service
app.factory('UserService', function($q, $http, growl, CSRF_TOKEN)
{
    var self = {};

    self.all = function()
    {
        var d = $q.defer();
        $http.get('/api/users')
            .success(function(data) {
                d.resolve(data);
            });
        return d.promise;
    };

    self.show = function(id)
    {
        var d = $q.defer();
        $http.get('/api/users/'+id)
            .success(function(data) {
                d.resolve(data);
            });
            return d.promise;
    };

    self.grouplist = function()
    {
        var d = $q.defer();
        $http.get('/api/userGroupList')
            .success(function(data) {
                d.resolve(data);
            });
            return d.promise;
    };

    self.save = function(user)
    {
        var d = $q.defer();
        $http.post('/api/users', user)
            .success(function (data) {
                d.resolve(data);
                growl.success(data.flash);
            }).error(function(data) {
                d.reject(data);
                growl.error(data.flash);
            });
        return d.promise;
    };

    self.update = function(user)
    {
        var d = $q.defer();
        $http.put('/api/users/'+user.id, user)
            .success(function (data) {
                d.resolve(data);
                growl.success(data.flash);
            }).error(function(data) {
                d.reject(data);
                growl.error(data.flash);
            });
        return d.promise;
    };

    self.destroy = function(user)
    {
        var d = $q.defer();
        $http.delete('/api/users/'+user.id, user)
        .success(function (data) {
                d.resolve(data);
                growl.success(data.flash);
            }).error(function(data) {
                d.reject(data);
                growl.error(data.flash);
            });
        return d.promise;
    }

    return self;
});

app.controller("UserCtrl", function($scope)
{
    $scope.users = [];
});

app.controller("UserListCtrl", function($scope, UserService, DTOptionsBuilder, DTColumnDefBuilder, $modal)
{
    UserService.all().then(function(data) {
        $scope.users = data;
        $scope.dtOptions = DTOptionsBuilder.newOptions()
                                .withPaginationType('full_numbers')
                                .withOption('order', [4, 'desc'])
                                .withDisplayLength(10);
        $scope.dtColumnDefs = [
            DTColumnDefBuilder.newColumnDef(0),
            DTColumnDefBuilder.newColumnDef(1),
            DTColumnDefBuilder.newColumnDef(2),
            DTColumnDefBuilder.newColumnDef(3),
            DTColumnDefBuilder.newColumnDef(4),
            DTColumnDefBuilder.newColumnDef(5).notSortable()
        ];
    });

    $scope.editModal = function(row) {
        var modalInstance = $modal.open({
            templateUrl: "../YevApp/apps/users/edit.html",
            controller: "UserEditCtrl",
            resolve: {
                usr: function() {
                    return row;
                }
            }
        });
    };

    $scope.showModal = function(row) {
        var modalInstance = $modal.open({
            templateUrl: "../YevApp/apps/users/detail.html",
            size: "lg",
            controller: "ShowUserCtrl",
            resolve: {
                usr: function() {
                    return row;
                }
            }
        });
    };

    $scope.deleteModal = function(row) {
        var modalInstance = $modal.open({
            templateUrl: "../YevApp/apps/users/del.html",
            controller: "UserDelCtrl",
            size: 'sm',
            scope: $scope,
            resolve: {
                usr: function() {
                    return row;
                }
            }
        });
    };
});

app.controller('UserCreateCtrl', function($state, $scope, UserService)
{
    UserService.grouplist().then(function(data) {
        $scope.grouplist = data;
    });

    $scope.createUser = function (isValid) {
        var usr = $scope.usr;
        if (isValid) {
            UserService.save(usr).then(function(data) {
                    $state.go('main.users.index');
            });
        }
    };

    $scope.cancel = function () {
        $state.go('main.users.index');
    };
});

app.controller('UserEditCtrl', function($scope, $state, $modalInstance, UserService, usr)
{
    $scope.usr = usr;
    $scope.master = {};
    $scope.master= angular.copy(usr);

    $scope.editUser = function () {
        UserService.update(usr).then(function(data){
            $modalInstance.close();
        });
    };

    $scope.cancel = function() {
        angular.copy($scope.master, $scope.usr);
        $modalInstance.dismiss('cancel');
    };
});

app.controller('UserDelCtrl', function($scope, $state, $modalInstance, UserService, usr)
{
    $scope.usr = usr;

    $scope.deleteUser = function () {
        UserService.destroy(usr).then(function(data){
            UserService.all().then(function(data){
                $scope.users.length = 0; //empty the current array
                $scope.users.push.apply($scope.users,data);
            });
            $modalInstance.dismiss('cancel');
        });
    };

    $scope.cancel = function() {
        $modalInstance.dismiss('cancel');
    };
});

app.controller('ShowUserCtrl', function($scope, $state, $modalInstance, LeadService, usr)
{
    $scope.usr = usr;
    $scope.cancel = function() {
        $modalInstance.dismiss('cancel');
    };
});

app.directive('uiValidateEquals', function() {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function(scope, elm, attrs, ctrl) {

            function validateEqual(myValue, otherValue) {
                if (myValue === otherValue) {
                    ctrl.$setValidity('equal', true);
                    return myValue;
                } else {
                    ctrl.$setValidity('equal', false);
                    return undefined;
                }
            }

            scope.$watch(attrs.uiValidateEquals, function(otherModelValue) {
                validateEqual(ctrl.$viewValue, otherModelValue);
            });

            ctrl.$parsers.unshift(function(viewValue) {
                return validateEqual(viewValue, scope.$eval(attrs.uiValidateEquals));
            });

            ctrl.$formatters.unshift(function(modelValue) {
                return validateEqual(modelValue, scope.$eval(attrs.uiValidateEquals));
            });
        }
    };
});
