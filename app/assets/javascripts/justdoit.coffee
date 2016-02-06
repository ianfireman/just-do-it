justdoit = angular.module('justdoit',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
])

justdoit.config([ '$routeProvider',
  ($routeProvider)->

    $routeProvider
     .when('/',
         templateUrl: "index.html"
         controller: 'TasksController'
      )
])

angular.module 'justdoit.controllers', []
