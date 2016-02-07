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
    
    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
     .when('/',
         templateUrl: "index.html"
         controller: 'TasksController'
      ).when('/completed',
        templateUrl: "completed.html"
        controller: 'TasksController'
      ).when('/tasks/new',
        templateUrl: "form.html"
        controller: 'TaskController'
      ).when('/tasks/:taskId',
        templateUrl: "show.html"
        controller: 'TaskController'
      ).when('/tasks/:taskId/edit',
        templateUrl: "form.html"
        controller: 'TaskController'
      ).when('/tasks/:taskId/complete',
        templateUrl: "show.html"
        controller: 'TaskController'
      )
])

controllers = angular.module('controllers',[])

justdoit.filter 'capitalize', ->
  (input) ->
    if ! !input then input.charAt(0).toUpperCase() + input.substr(1).toLowerCase() else ''

