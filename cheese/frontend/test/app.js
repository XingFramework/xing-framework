import '../src/app/app.js';
import {appName} from 'config';

describe( 'RootCtrl', function() {
  describe( 'isCurrentUrl', function() {
    var RootCtrl, $location, $scope, mockMain;

    beforeEach( module( appName ) );

    beforeEach( inject( function( $controller, _$location_, $rootScope ) {
      $location = _$location_;
      $scope = $rootScope.$new();
      mockMain = {
        children: {}
      };

      RootCtrl = $controller( 'RootCtrl', { $location: $location, $scope: $scope });
    }));

    it( 'should pass a dummy test', inject( function() {
      expect( RootCtrl ).toBeTruthy();
    }));
  });
});
