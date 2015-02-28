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
      get: (id) -> Restangular.one(model, id).get();
  ])