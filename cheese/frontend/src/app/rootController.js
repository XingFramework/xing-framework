import {Controller} from 'a1atscript';

@Controller( 'RootCtrl', ['$scope', '$state', '$rootScope', '$window' ])
export default function RootCtrl( $scope, $state, $rootScope, $window ) {
  $rootScope.$on("$viewContentLoaded", function(event) {
    $window.frontendContentLoaded = true;
  });
}
