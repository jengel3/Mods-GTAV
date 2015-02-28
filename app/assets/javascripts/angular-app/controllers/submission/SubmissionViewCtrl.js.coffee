angular.module('gta').controller("SubmissionViewCtrl", [
  '$scope', '$routeParams', 'SubmissionService',
  ($scope, $routeParams, SubmissionService)->

    SubmissionService.get($routeParams.id).then((submission) ->
      $scope.submission = submission
      
    )
])