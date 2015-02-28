angular.module('gta').controller("SubmissionListCtrl", [
  '$scope', 'SubmissionService',
  ($scope, SubmissionService)->

    SubmissionService.list().then((submissions) ->
      $scope.submissions = submissions
      
    )
])