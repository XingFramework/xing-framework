import {appName} from 'config';
import {} from '../../../src/app/auth/passwords/passwords.js';
import {} from '../../support/testStates.js';
import {LoggedInOnlyState} from "stateClasses";

describe('Password Recovery states', function() {

  var $rootScope, $state, $injector, state, $auth, $q;

  beforeEach(function() {

    module(`${appName}.testStates`);

    module(`${appName}.auth.passwords`);

    inject(function(_$rootScope_, _$state_, _$injector_, $templateCache, _$q_, _$auth_) {
      $rootScope = _$rootScope_;
      $state = _$state_;
      $injector = _$injector_;
      $q = _$q_;

      $auth = _$auth_;

      $templateCache.put('auth/passwords/passwords-request.tpl.html', '');
      $templateCache.put('auth/passwords/passwords-request-success.tpl.html', '');
      $templateCache.put('auth/passwords/passwords-update.tpl.html', '');
      $templateCache.put('auth/passwords/passwords-update-success.tpl.html', '');
    });
  });

  describe("passwordsRequest", function() {

    beforeEach(function() {
      state = $state.get('root.inner.passwordsRequest');
    });

    it('should respond to URL', function() {
      expect($state.href(state)).toEqual('#/reset-password');
    });

    it('should render the passwords request template', function() {
      expect(state.templateUrl).toEqual('auth/passwords/passwords-request.tpl.html');
    });

    it('should use the passwords request controller', function() {
      expect(state.controller).toEqual('PasswordsRequestCtrl');
    });

  });

  describe("passwordsRequestSuccess", function() {

    beforeEach(function() {
      state = $state.get('root.inner.passwordsRequestSuccess');
    });

    it('should respond to URL', function() {
      expect($state.href(state)).toEqual('#/reset-password-sent');
    });

    it('should render the passwords request template', function() {
      expect(state.templateUrl).toEqual('auth/passwords/passwords-request-success.tpl.html');
    });

  });

  describe("passwordsUpdate", function() {

    beforeEach(function() {
      state = $state.get('root.inner.passwordsUpdate');
    });

    it('should extend LoggedInOnlyState', function() {
      expect(state instanceof LoggedInOnlyState).toBe(true);
    });

    it('should respond to URL', function() {
      expect($state.href(state)).toEqual('#/update-password');
    });

    it('should render the passwords update template', function() {
      expect(state.templateUrl).toEqual('auth/passwords/passwords-update.tpl.html');
    });

    it('should use the passwords request controller', function() {
      expect(state.controller).toEqual('PasswordsUpdateCtrl');
    });
  });

  describe("passwordsUpdateSuccess", function() {

    beforeEach(function() {
      state = $state.get('root.inner.passwordsUpdateSuccess');
    });

    it('should extend LoggedInOnlyState', function() {
      expect(state instanceof LoggedInOnlyState).toBe(true);
    });

    it('should respond to URL', function() {
      expect($state.href(state)).toEqual('#/updated-password');
    });

    it('should render the sessions template', function() {
      expect(state.templateUrl).toEqual('auth/passwords/passwords-update-success.tpl.html');
    });
  });
});
