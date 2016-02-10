controllers = angular.module('controllers')
controllers.controller("TasksController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.completed = (keywords) -> $location.path("/").search('keywords',keywords)
    $scope.today = (keywords) -> $location.path("/").search('keywords',keywords)
    $scope.week = (keywords) -> $location.path("/").search('keywords',keywords)
    $scope.month = (keywords) -> $location.path("/").search('keywords',keywords)
    $scope.after = (keywords) -> $location.path("/").search('keywords',keywords)
    $scope.late = (keywords) -> $location.path("/").search('keywords',keywords)
    $scope.search = (keywords) -> $location.path("/").search('keywords',keywords)
    Task = $resource('/tasks/:taskId', { taskId: "@id", format: 'json' })
    
    if $routeParams.keywords
      Task.query(keywords: $routeParams.keywords, (results)-> $scope.tasks = results)
    else
      $scope.tasks = Task.query()
    
    $scope.index = -> 
      $location.path("/")
      $location.search('keywords', null)
      $location.search('id', null)
    $scope.show = (taskId)-> $location.path("/tasks/#{taskId}")  
    $scope.newTask = -> $location.path("/tasks/new")
    $scope.edit = (taskId)-> $location.path("/tasks/#{taskId}/edit")
    $scope.currentParams = -> $routeParams.keywords
    $scope.currentLocation = -> $location.path()
])