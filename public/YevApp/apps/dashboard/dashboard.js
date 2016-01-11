app.factory('DashboardService', function($q, $http, growl)
{
    var self = {};

    self.leadsPerMonth = function()
    {
        var d = $q.defer();
        $http.get('/api/leadsPerMonth')
            .success(function(data) {
                d.resolve(data);
            });
        return d.promise;
    };

    self.leadsByUsers = function()
    {
        var d = $q.defer();
        $http.get('/api/leadsByUsers')
            .success(function(data) {
                d.resolve(data);
            });
            return d.promise;
    };

    self.leadsByUser = function()
    {
        var d = $q.defer();
        $http.get('/api/leadsByUser')
            .success(function(data) {
                d.resolve(data);
            });
            return d.promise;
    };

    return self;
});

app.controller('DashboardCtrl', function($scope, DashboardService){
    DashboardService.leadsPerMonth().then(function(data) {
        $scope.leadsPerMonth = {
            labels: data.months,
            datasets: [
                {
                    label: 'Leads',
                    fillColor: 'rgba(151,187,205,0.2)',
                    strokeColor: 'rgba(151,187,205,1)',
                    pointColor: 'rgba(151,187,205,1)',
                    pointStrokeColor: '#fff',
                    pointHighlightFill: '#fff',
                    pointHighlightStroke: 'rgba(151,187,205,1)',
                    data: data.values
                }
            ]
        };

        $scope.optionsPerMonth = {
            responsive: true,
            scaleShowGridLines : true,
            scaleGridLineColor : "rgba(0,0,0,.05)",
            scaleGridLineWidth : 1,
            bezierCurve : true,
            bezierCurveTension : 0.4,
            pointDot : true,
            pointDotRadius : 4,
            pointDotStrokeWidth : 1,
            pointHitDetectionRadius : 20,
            datasetStroke : true,
            datasetStrokeWidth : 2,
            datasetFill : true,
            onAnimationProgress: function(){},
            onAnimationComplete: function(){}
        };
    });

    DashboardService.leadsByUsers().then(function(data) {
        $scope.leadsByUsers = {
            labels: data.users,
            datasets: [
                {
                    label: 'Leads',
                    fillColor: 'rgba(151,187,205,0.5)',
                    strokeColor: 'rgba(151,187,205,0.8)',
                    highlightFill: 'rgba(151,187,205,0.75)',
                    highlightStroke: 'rgba(151,187,205,1)',
                    data: data.values
                }
            ]
        };

        $scope.optionsByUsers = {
            responsive: true,
            scaleBeginAtZero : true,
            scaleShowGridLines : true,
            scaleGridLineColor : "rgba(0,0,0,.05)",
            scaleGridLineWidth : 1,
            barShowStroke : true,
            barStrokeWidth : 2,
            barValueSpacing : 5,
            barDatasetSpacing : 1
        };
    });

    DashboardService.leadsByUser().then(function(data) {
        $scope.leadsByUser = {
            labels: data.months,
            datasets: [
                {
                    label: 'Leads',
                    fillColor: 'rgba(151,187,205,0.2)',
                    strokeColor: 'rgba(151,187,205,1)',
                    pointColor: 'rgba(151,187,205,1)',
                    pointStrokeColor: '#fff',
                    pointHighlightFill: '#fff',
                    pointHighlightStroke: 'rgba(151,187,205,1)',
                    data: data.values
                }
            ]
        };

        $scope.optionsByUser = {
            responsive: true,
            scaleShowGridLines : true,
            scaleGridLineColor : "rgba(0,0,0,.05)",
            scaleGridLineWidth : 1,
            bezierCurve : true,
            bezierCurveTension : 0.4,
            pointDot : true,
            pointDotRadius : 4,
            pointDotStrokeWidth : 1,
            pointHitDetectionRadius : 20,
            datasetStroke : true,
            datasetStrokeWidth : 2,
            datasetFill : true,
            onAnimationProgress: function(){},
            onAnimationComplete: function(){}
        };
    });
});
