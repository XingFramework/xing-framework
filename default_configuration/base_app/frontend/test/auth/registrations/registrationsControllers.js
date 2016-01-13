import {appName} from '../../../src/common/config.js';
import {} from '../../../src/app/auth/registrations/registrations.js';

describe( 'Registrations controllers', function() {

  beforeEach( module( `${appName}.auth.registrations` ) );

  var $scope, $stateMock, $authMock, $toastMock, mockSerializer;

  beforeEach(inject(function($q) {
    $toastMock = {};
    $toastMock.errorList = jasmine.createSpy('errorList');

    $stateMock = {
      go(state){}
    };

    mockSerializer = function() {
      this.serialize = function(data) {
        return data;
      };
    };

    spyOn($stateMock, 'go').and.callThrough();

    $authMock = {
      submitRegistration(registration) {
        if (registration.user.email &&
            (registration.user.email == registration.user.emailConfirmation) &&
            registration.user.password &&
            (registration.user.password == registration.user.passwordConfirmation)) {
          return $q((resolve, reject) => {
            resolve();
          });
        } else {
          return $q((resolve, reject) => {
            reject({
              data: {
                errors: { emailConfirmation: "must match email" }
              }
            });
          });
        }
      }
    };

    spyOn($authMock, 'submitRegistration').and.callThrough();

  }));

  describe("Registrations Controller", function() {

    beforeEach( inject(function($controller, $rootScope) {
      $scope = $rootScope.$new();
      $controller('RegistrationsCtrl', {
        $scope: $scope,
        $state: $stateMock,
        $auth: $authMock,
        $xngToast: $toastMock,
        Serializer: mockSerializer
      });
      $scope.$apply();
    }));

    it('should assign session', function(){
      expect($scope.registration).toEqualData({
        email: "",
        emailConfirmation: "",
        password: "",
        passwordConfirmation: ""});
    });

    describe("registrationSubmit", function() {
      describe("with valid sign up", function() {
        beforeEach(function() {
          $scope.registration = { email: "bob@bob.com",
            emailConfirmation: "bob@bob.com",
            password: "password",
            passwordConfirmation: "password"
          };
          $scope.registrationSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.submitRegistration).toHaveBeenCalled();
        });

        it ("should redirect to the sign in success page", function() {
          expect($stateMock.go).toHaveBeenCalledWith("root.inner.registrationsSuccess");
        });

      });

      describe("with invalid login", function() {
        beforeEach(function() {
          $scope.registration = { email: "bob@bob.com",
            emailConfirmation: "jill@jill.com",
            password: "wrong password",
            passwordConfirmation: "wrong password"
          };
          $scope.registrationSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.submitRegistration).toHaveBeenCalled();
        });

        it ("should set the toast error message", function() {
          expect($toastMock.errorList).toHaveBeenCalledWith({ emailConfirmation: "must match email" },
            "We cannot process your registration because:");
        });
      });
    });
  });
});
