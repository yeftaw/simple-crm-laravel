<!DOCTYPE html>
<html ng-app="YevApp" ng-class="getBgClass()">
<head>
    <meta charset="UTF-8">
    <title>CRM Tokodata Indonesia</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

    <!-- CSS -->
    {{ HTML::style("/css/bootstrap.min.css") }}
    {{ HTML::style("/packages/font-awesome/css/font-awesome.min.css") }}
    {{ HTML::style("/css/ionicons.min.css") }}
    {{ HTML::style("/css/datatables/dataTables.bootstrap.css") }}
    {{ HTML::style("/css/AdminLTE.css") }}
    {{ HTML::style("/YevApp/modules/growl/angular-growl.min.css") }}

    <!--[if lt IE 9]>
    {{ HTML::script("https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js") }}
    {{ HTML::style("https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js") }}
    <![endif]-->

    @yield('styles')

</head>

<body ng-class="getBgClass()" class="fixed">

    <header ui-view="header" class="header"></header>

    <div growl></div>

    <div ui-view class="wrapper row-offcanvas row-offcanvas-left"></div>

    <!--Plugins-->
    {{ HTML::script("/js/jquery-1.11.1.min.js") }}
    {{ HTML::script("/js/jquery-ui.min.js") }}
    {{ HTML::script("/js/AdminLTE/app.js") }}
    {{ HTML::script("/js/plugins/datatables/jquery.dataTables.min.js") }}
    {{ HTML::script("/js/plugins/datatables/dataTables.bootstrap.js") }}
    {{ HTML::script("/YevApp/modules/chartjs/chart.min.js") }}

    <!-- AngularJS Resources -->
    {{ HTML::script("/js/angular.min.js") }}
    {{ HTML::script("/js/angular-ui-router.min.js") }}
    {{ HTML::script("/js/angular-sanitize.min.js") }}
    {{ HTML::script("/js/angular-animate.min.js") }}
    {{ HTML::script("/js/underscore.js") }}

    <!-- Dependency -->
    {{ HTML::script("/YevApp/modules/growl/angular-growl.min.js") }}
    {{ HTML::script("/js/ui-bootstrap-tpls-0.11.2.min.js") }}
    {{ HTML::script("/YevApp/modules/datatable/angular-datatables.min.js") }}
    {{ HTML::script("/YevApp/modules/chartjs/tc-angular-chartjs.min.js") }}

    <!-- AngularJS Apps -->
    {{ HTML::script("/YevApp/application.js") }}
    {{ HTML::script("/YevApp/apps/main/main.js") }}
    {{ HTML::script("/YevApp/apps/auth/login.js") }}
    {{ HTML::script("/YevApp/apps/dashboard/dashboard.js") }}
    {{ HTML::script("/YevApp/apps/leads/lead.js") }}
    {{ HTML::script("/YevApp/apps/users/user.js") }}

    <script>
        angular.module("YevApp").constant("CSRF_TOKEN", '{{ csrf_token() }}');
    </script>

    @yield('scripts')

</body>
</html>
