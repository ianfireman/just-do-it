controllers = angular.module('controllers')
controllers.controller("TasksController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.desligado = 'Ligado';
    Task = $resource('/tasks/:taskId', { taskId: "@id", format: 'json' })
    $scope.tasks = Task.query()
    
    $scope.show = (taskId)-> $location.path("/tasks/#{taskId}")  
    $scope.newTask = -> $location.path("/tasks/new")
    $scope.completed = -> $location.path("/completed")
    $scope.edit = (taskId)-> $location.path("/tasks/#{taskId}/edit")
    $scope.complete = (taskId)-> $location.path("/tasks/#{taskId}/complete")
])