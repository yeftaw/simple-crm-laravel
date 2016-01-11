// Lead Status Service
app.factory('LeadService', function($q, $http, growl, CSRF_TOKEN)
{
    var self = {};

    self.all = function()
    {
        var d = $q.defer();
        $http.get('/api/leads')
            .success(function(data) {
                d.resolve(data);
            });
        return d.promise;
    };

    self.showMyLeads = function()
    {
        var d = $q.defer();
        $http.get('/api/showMyLeads')
            .success(function(data) {
                d.resolve(data);
            });
            return d.promise;
    };

    self.statuses = function()
    {
        var d = $q.defer();
        $http.get('/api/leadstatuses')
            .success(function(data) {
                d.resolve(data);
            });
            return d.promise;
    };

    self.save = function(lead)
    {
        var d = $q.defer();
        $http.post('/api/leads', lead)
            .success(function (data) {
                d.resolve(data);
                growl.success(data.flash);
            }).error(function(data) {
                d.reject(data);
                growl.error(data.flash);
            });
        return d.promise;
    };

    self.update = function(lead)
    {
        var d = $q.defer();
        $http.put('/api/leads/'+lead.id, lead)
            .success(function (data) {
                d.resolve(data);
                growl.success(data.flash);
            }).error(function(data) {
                d.reject(data);
                growl.error(data.flash);
            });
        return d.promise;
    };

    self.destroy = function(lead)
    {
        var d = $q.defer();
        $http.delete('/api/leads/'+lead.id, lead)
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

app.controller("LeadCtrl", function($scope)
{
    $scope.leads = [];
});

app.controller("LeadListCtrl", function($rootScope, $scope, LeadService, DTOptionsBuilder, DTColumnDefBuilder, $modal)
{
    LeadService.all().then(function(data) {
        $scope.leads = data;
    });

    $scope.dtOptions = DTOptionsBuilder.newOptions()
                                .withPaginationType('full_numbers')
                                .withOption('aaSorting', [])
                                .withDisplayLength(10)
                                .withBootstrap();
    $scope.dtColumnDefs = [
        DTColumnDefBuilder.newColumnDef(0),
        DTColumnDefBuilder.newColumnDef(1),
        DTColumnDefBuilder.newColumnDef(2),
        DTColumnDefBuilder.newColumnDef(3),
        DTColumnDefBuilder.newColumnDef(4),
        DTColumnDefBuilder.newColumnDef(5),
        DTColumnDefBuilder.newColumnDef(6).notSortable()
    ];

    $scope.editModal = function(row) {
        var modalInstance = $modal.open({
            templateUrl: "../YevApp/apps/leads/edit.html",
            controller: "LeadEditCtrl",
            resolve: {
                lead: function() {
                    return row;
                }
            }
        });
    };

    $scope.showModal = function(row) {
        var modalInstance = $modal.open({
            templateUrl: "../YevApp/apps/leads/detail.html",
            size: "lg",
            controller: "ShowLeadCtrl",
            resolve: {
                lead: function() {
                    return row;
                }
            }
        });
    };

    $scope.deleteModal = function(row) {
        var modalInstance = $modal.open({
            templateUrl: "../YevApp/apps/leads/del.html",
            controller: "LeadDelCtrl",
            size: 'sm',
            scope: $scope,
            resolve: {
                lead: function() {
                    return row;
                }
            }
        });
    };
});

app.controller('LeadCreateCtrl', function($state, $scope, LeadService)
{
    LeadService.statuses().then(function(data) {
        $scope.statuses = data;
    });

    $scope.salutations = {
        'Mr.' : 'Mr.',
        'Mrs.' : 'Mrs.',
        'Ms.' : 'Ms.'
    };

    $scope.createLead = function (isValid) {
        var lead = $scope.lead;
        if (isValid) {
            LeadService.save(lead).then(function(data) {
                    $state.go('main.leads.index');
            });
        }
    };

    $scope.cancel = function () {
        $state.go('main.leads.index');
    };
});

app.controller('LeadEditCtrl', function($scope, $state, $modalInstance, LeadService, lead)
{
    LeadService.statuses().then(function(data) {
        $scope.statuses = data;
    });

    $scope.salutations = {
        'Mr.' : 'Mr.',
        'Mrs.' : 'Mrs.',
        'Ms.' : 'Ms.'
    };

    $scope.lead = lead;
    $scope.master = {};
    $scope.master= angular.copy(lead);

    $scope.editLead = function () {
        LeadService.update(lead).then(function(response){
            $modalInstance.close();
        });
    };

    $scope.cancel = function() {
        angular.copy($scope.master, $scope.lead);
        $modalInstance.dismiss('cancel');
    };
});

app.controller('LeadDelCtrl', function($scope, $state, $modalInstance, LeadService, lead)
{
    $scope.lead = lead;

    $scope.deleteLead = function () {
        LeadService.destroy(lead).then(function(response){
            LeadService.all().then(function(data){
                $scope.leads.length = 0; //empty the current array
                $scope.leads.push.apply($scope.leads,data);
            });
            $modalInstance.dismiss('cancel');
        });
    };

    $scope.cancel = function() {
        $modalInstance.dismiss('cancel');
    };
});

app.controller('ShowLeadCtrl', function($scope, $state, $modalInstance, LeadService, lead)
{
    $scope.lead = lead;
    $scope.cancel = function() {
        $modalInstance.dismiss('cancel');
    };
});
