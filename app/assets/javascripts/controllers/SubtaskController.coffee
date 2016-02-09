controllers = angular.module('controllers')
controllers.controller("SubtaskController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    Task = $resource('/subtasks/:subtaskId', { subtaskId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.subtaskId
      Task.get({subtaskId: $routeParams.subtaskId},
        ( (task)-> $scope.task = task ),
        ( (httpResponse)->
          $scope.task = null
          flash.error   = "Não existe uma tarefa com o id #{$routeParams.subtaskId}"
        )
      )
    else
      $scope.task = {}

    $scope.back = -> $location.path("/tasks/#{$scope.task.task_id}")
    
    $scope.edit = -> $location.path("/subtasks/#{$scope.task.id}/edit")
    
    $scope.complete = -> 
      onError = (_httpResponse)-> flash.error = "Algo deu errado"
      if !$scope.task.complete
        $scope.task.complete = true
        $scope.task.$save()
      else
        $scope.task.complete = false
        $scope.task.$save()
          
    $scope.cancel = ->
      if $scope.task.id
        $location.path("/subtasks/#{$scope.task.id}")
      else
        $location.path("/tasks/#{$routeParams.id}")
        $location.search('id', null)

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Algo deu errado"
      if $scope.task.id
        $scope.task.$save()
        $location.path("/subtasks/#{$scope.task.id}")
      else
        Task.create($scope.task,onError)
        $location.path("/tasks/#{$routeParams.id}")
        $location.search('id', null)

    $scope.delete = ->
      $scope.task.$delete()
      $scope.back()
      
    $scope.currentParams = -> $routeParams.id
    $scope.currentLocation = -> $location.path()
])