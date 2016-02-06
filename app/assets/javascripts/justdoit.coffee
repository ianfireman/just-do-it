justdoit = angular.module('justdoit',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

justdoit.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

    $routeProvider
     .when('/',
         templateUrl: "index.html"
         controller: 'TasksController'
      )
      
    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")
])

controllers = angular.module('controllers',[])