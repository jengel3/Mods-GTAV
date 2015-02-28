angular.module('gta').controller("SubmissionViewCtrl", [
  '$scope', 'SubmissionService',
  ($scope, SubmissionService)->

    SubmissionService.get().then((submission) ->
      $scope.submission = submission
      
    )
])