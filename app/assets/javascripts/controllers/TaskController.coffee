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
          flash.error   = "Não existe uma tarefa com o id #{$routeParams.taskId}"
        )
      )
    else
      $scope.task = {}

    $scope.back = -> $location.path("/")
    
    $scope.edit = -> $location.path("/tasks/#{$scope.task.id}/edit")
    
    $scope.complete = -> 
      onError = (_httpResponse)-> flash.error = "Algo deu errado"
      if !$scope.task.complete
        $scope.task.complete = true
        $scope.task.$save(
          ( ()-> $location.path("/tasks/#{$scope.task.id}") ),
          onError)
      else
        $scope.task.complete = false
        $scope.task.$save(
          ( ()-> $location.path("/tasks/#{$scope.task.id}") ),
          onError)
          
    $scope.cancel = ->
      if $scope.task.id
        $location.path("/tasks/#{$scope.task.id}")
      else
        $location.path("/")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Algo deu errado"
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
      
    if $routeParams.taskId
      Task.get({taskId: $routeParams.taskId},
        ( (subtasks)-> $scope.subtasks = subtasks ),
        ( (httpResponse)->
          $scope.subtasks = null
          flash.error   = "Não existe uma tarefa com o id #{$routeParams.taskId}"
        )
      )
    else
      $scope.task = {}
      
    $scope.showSt = (subtask) -> $location.path("/subtasks/#{subtask}")
    $scope.newSubtask = (taskPaiId) -> $location.path("/subtasks/new").search('id', taskPaiId)
    $scope.currentLocation = -> $location.path()
])