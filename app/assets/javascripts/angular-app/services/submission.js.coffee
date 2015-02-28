angular.module('gta')
  .factory('SubmissionService', [
    'Restangular', 'Submission',
    (Restangular, Submission)->

      model = 'submissions'
      Restangular.setBaseUrl("/api")

      Restangular.extendModel(model, (obj)->
        angular.extend(obj, Submission)
      )

      list: ()     -> Restangular.all(model).getList(),
      get: () -> Restangular.one(model, $route.current.params.id).get();
  ])