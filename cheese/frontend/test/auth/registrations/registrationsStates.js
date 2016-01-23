import {appName} from 'config';
import {} from '../../../src/app/auth/registrations/registrations.js';
import {} from '../../support/testStates.js';

describe('registrations states', function() {

  var $rootScope, $state, $injector, state, $auth, $q;

  beforeEach(function() {

    module(`${appName}.testStates`);

    module(`${appName}.auth.registrations`);

    inject(function(_$rootScope_, _$state_, _$injector_, $templateCache, _$q_, _$auth_) {
      $rootScope = _$rootScope_;
      $state = _$state_;
      $injector = _$injector_;
      $q = _$q_;

      $auth = _$auth_;

      $templateCache.put('auth/registrations/registrations.tpl.html', '');
      $templateCache.put('auth/registrations/registrations-success.tpl.html', '');
    });
  });

  describe("registrations", function() {

    beforeEach(function() {
      state = $state.get('root.inner.registrations');
    });

    it('should respond to URL', function() {
      expect($state.href(state)).toEqual('#/sign-up');
    });

    it('should render the sessions template', function() {
      expect(state.templateUrl).toEqual('auth/registrations/registrations.tpl.html');
    });

    it('should use the sessions controller', function() {
      expect(state.controller).toEqual('RegistrationsCtrl');
    });

  });

  describe("registrationsSuccess", function() {

    beforeEach(function() {
      state = $state.get('root.inner.registrationsSuccess');
    });

    it('should respond to URL', function() {
      expect($state.href(state)).toEqual('#/signed-up');
    });

    it('should render the sessions template', function() {
      expect(state.templateUrl).toEqual('auth/registrations/registrations-success.tpl.html');
    });

  });

});
