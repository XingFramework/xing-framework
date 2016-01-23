import {appName} from 'config';
import {} from '../../../src/app/auth/sessions/sessions.js';
import {} from '../../support/testStates.js';
import {LoggedInOnlyState} from 'stateClasses';

describe('Sessions states', function() {

  var $rootScope, $state, $injector, state, $auth, $q;

  beforeEach(function() {

    module(`${appName}.testStates`);

    module(`${appName}.auth.sessions`);

    inject(function(_$rootScope_, _$state_, _$injector_, $templateCache, _$q_, _$auth_) {
      $rootScope = _$rootScope_;
      $state = _$state_;
      $injector = _$injector_;
      $q = _$q_;

      $auth = _$auth_;

      $templateCache.put('auth/sessions/sessions.tpl.html', '');
      $templateCache.put('auth/sessions/sessions-success.tpl.html', '');
    });
  });

  describe("sessions", function() {

    beforeEach(function() {
      state = $state.get('root.inner.sessions');
    });

    it('should respond to URL', function() {
      expect($state.href(state)).toEqual('#/sign-in');
    });

    it('should render the sessions template', function() {
      expect(state.templateUrl).toEqual('auth/sessions/sessions.tpl.html');
    });

    it('should use the sessions controller', function() {
      expect(state.controller).toEqual('SessionsCtrl');
    });

  });

  describe("sessionsSuccess", function() {

    beforeEach(function() {
      state = $state.get('root.inner.sessionsSuccess');
    });

    it('should extend LoggedInOnlyState', function() {
      expect(state instanceof LoggedInOnlyState).toBe(true);
    });

    it('should respond to URL', function() {
      expect($state.href(state)).toEqual('#/signed-in');
    });

    it('should render the sessions template', function() {
      expect(state.templateUrl).toEqual('auth/sessions/sessions-success.tpl.html');
    });
  });
});
