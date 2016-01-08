import {Controller} from 'a1atscript';

@Controller('SessionsCtrl', ['$scope', '$auth', '$state', '$lrdToast', 'Serializer', 'authConfig', 'Inflector'])
export default function SessionsController( $scope, $auth, $state, $lrdToast, Serializer, authConfig, Inflector) {
  $scope.session = {
    password: ''
  };
  $scope.session[authConfig.authKey] = '';
  $scope.authKey = authConfig.authKey;
  $scope.humanAuthKey = Inflector.humanize(authConfig.authKey);
  $scope.passwordShow = authConfig.recoverable;

  $scope.sessionSubmit = function() {
    var serializer = new Serializer();

    $auth.submitLogin(serializer.serialize({user: $scope.session}))
      .then(function(resp) {
        $state.go('root.inner.sessionsSuccess');
      })
      .catch(function(resp) {
        $lrdToast.error(resp.errors);
        // handle error response
      });
  };

}
