import {appName} from 'config';
import {} from '../../../src/app/auth/auth.js';
import {} from '../../support/testStates.js';
import {LoggedInOnlyState} from "stateClasses";

describe('confirmations states', function() {

  var $rootScope, $state, $injector, state, $auth, $q;

  beforeEach(function() {

    module(`${appName}.testStates`);

    module(`${appName}.auth.confirmations`);

    inject(function(_$rootScope_, _$state_, _$injector_, $templateCache, _$q_, _$auth_) {
      $rootScope = _$rootScope_;
      $state = _$state_;
      $injector = _$injector_;
      $q = _$q_;

      $auth = _$auth_;

      $templateCache.put('auth/confirmations/confirmations-success.tpl.html', '');
    });
  });

  describe("confirmationsSuccess", function() {

    beforeEach(function() {
      state = $state.get('root.inner.confirmationsSuccess');
    });

    it('should extend LoggedInOnlyState', function() {
      expect(state instanceof LoggedInOnlyState).toBe(true);
    });

    it('should respond to URL', function() {
      expect($state.href(state)).toEqual('#/confirmed');
    });

    it('should render the sessions template', function() {
      expect(state.templateUrl).toEqual('auth/confirmations/confirmations-success.tpl.html');
    });
  });
});
