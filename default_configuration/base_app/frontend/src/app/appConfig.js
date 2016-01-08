import {Config} from 'a1atscript';
import {whenGoto} from 'xing-frontend-utils';

@Config('$stateProvider', '$urlRouterProvider', '$locationProvider')
export default function appConfig( $stateProvider, $urlRouterProvider, $locationProvider ) {
  // enable html5 mode
  $locationProvider.html5Mode(true);

  // html5 mode when frontend urls hit directly they become a backend request
  // backend in-turn redirects to /?goto=url wher url is the intended frontend url
  // this function then redirects frontend (via history API) to appropriate frontend
  // route
  $urlRouterProvider.when(/.*/, ['$location', whenGoto]);

  $urlRouterProvider.otherwise(($injector, $location) => {
    $injector.get('$state').go('root.homepage.show');
    //return '/home';
  });
}
