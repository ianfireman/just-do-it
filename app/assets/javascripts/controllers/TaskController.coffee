controllers = angular.module('controllers')
controllers.controller("TaskController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    Task = $resource('/tasks/:taskId', { taskId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.taskId
      Task.get({taskId: $routeParams.taskId},
        ( (task)-> $scope.task = task ),
        ( (httpResponse)->
          $scope.task = null
          flash.error   = "There is no task with ID #{$routeParams.taskId}"
        )
      )
    else
      $scope.task = {}

    $scope.back   = -> $location.path("/")
    $scope.edit   = -> $location.path("/tasks/#{$scope.task.id}/edit")
    $scope.cancel = ->
      if $scope.task.id
        $location.path("/tasks/#{$scope.task.id}")
      else
        $location.path("/")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.task.id
        $scope.task.$save(
          ( ()-> $location.path("/tasks/#{$scope.task.id}") ),
          onError)
      else
        Task.create($scope.task,
          ( (newTask)-> $location.path("/tasks/#{newTask.id}") ),
          onError)
        $scope.back()

    $scope.delete = ->
      $scope.task.$delete()
      $scope.back()
])