import {appName} from 'config';
import {} from '../../../src/app/auth/sessions/sessions.js';

describe( 'Sessions controllers', function() {

  beforeEach( module( `${appName}.auth.sessions` ) );

  var $scope, $stateMock, $authMock, $toastMock;

  beforeEach(inject(function($q) {
    $toastMock = {};
    $toastMock.error = jasmine.createSpy('error');
    $toastMock.errorList = jasmine.createSpy('errorList');

    $stateMock = {
      go(state){}
    };

    spyOn($stateMock, 'go').and.callThrough();

    $authMock = {
      submitLogin(session) {
        if ((session.user.email == "bob") && (session.user.password = "password")) {
          return $q((resolve, reject) => {
            resolve();
          });
        } else {
          return $q((resolve, reject) => {
            reject({errors: "Invalid Login"});
          });
        }
      }
    };

    spyOn($authMock, 'submitLogin').and.callThrough();

  }));

  describe("Sessions Controller", function() {

    beforeEach( inject(function($controller, $rootScope) {
      $scope = $rootScope.$new();
      $controller('SessionsCtrl', {
        $scope: $scope,
        $state: $stateMock,
        $auth: $authMock,
        $xngToast: $toastMock
      });
      $scope.$apply();
    }));

    it('should assign session', function(){
      expect($scope.session).toEqualData({email: "", password: ""});
    });

    it('should assign humanAuthKey', function () {
      expect($scope.humanAuthKey).toEqual("Email");
    });

    describe("sessionSubmit", function() {
      describe("with valid login", function() {
        beforeEach(function() {
          $scope.session = { email: "bob", password: "password" };
          $scope.sessionSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.submitLogin).toHaveBeenCalled();
        });

        it ("should redirect to the sign in success page", function() {
          expect($stateMock.go).toHaveBeenCalledWith("root.inner.sessionsSuccess");
        });

      });

      describe("with invalid login", function() {
        beforeEach(function() {
          $scope.session = { email: "jill", password: "wrong password" };
          $scope.sessionSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.submitLogin).toHaveBeenCalled();
        });

        it ("should set the toast error message", function() {
          expect($toastMock.error).toHaveBeenCalledWith("Invalid Login");
        });
      });
    });
  });
});
