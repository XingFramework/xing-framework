import {appName} from 'config';
import {} from '../../../src/app/auth/passwords/passwords.js';

describe( 'Passwords controllers', function() {

  beforeEach( module( `${appName}.auth.passwords` ) );

  var $scope, $stateMock, $authMock, $toastMock, mockSerializer, mockLocation;

  beforeEach(inject(function($q) {
    $toastMock = {};
    $toastMock.errorList = jasmine.createSpy('errorList');

    $stateMock = jasmine.createSpyObj('$state', ["go", "href"]);

    mockSerializer = function() {
      this.serialize = function(data) {
        return data;
      };
    };

    // Lest anyone see this and think to imitate: don't.
    // What should be happening is that we check that the authMock receives
    // calls to requestPasswordReset with certain arguments, possibly returning
    // certain values - *not* building a little mini $auth service in the test.
    $authMock = {
      requestPasswordReset(password_request) {
        if (password_request.user.email) {
          return $q((resolve, reject) => {
            resolve();
          });
        } else {
          return $q((resolve, reject) => {
            reject({
              data: {
                errors: ["Missing Email"]
              }
            });
          });
        }
      },
      updatePassword(password_update) {
        if (password_update.user.password &&
            (password_update.user.password == password_update.user.passwordConfirmation)) {
          return $q((resolve, reject) => {
            resolve();
          });
        } else {
          return $q((resolve, reject) => {
            reject({
              data: {
                errors: { passwordConfirmation: "must match password" }
              }
            });
          });
        }
      }
    };

    // And just to be clear "and.callThrough()" is the code smell here.
    spyOn($authMock, 'requestPasswordReset').and.callThrough();
    spyOn($authMock, 'updatePassword').and.callThrough();
  }));

  describe("Passwords Request Controller", function() {
    var theUpdateUrl;

    beforeEach( inject(function($controller, $rootScope) {
      theUpdateUrl = "the://update.url/for_passwords";
      $scope = $rootScope.$new();
      $controller('PasswordsRequestCtrl', {
        $scope: $scope,
        $state: $stateMock,
        $auth: $authMock,
        $xngToast: $toastMock,
        $location: mockLocation,
        Serializer: mockSerializer
      });
      $scope.$apply();
    }));

    it('should assign password request', function(){
      expect($scope.passwordRequest).toEqualData({
        email: ""});
    });

    describe("passwordRequestSubmit", function() {
      describe("with valid request", function() {
        beforeEach(function() {
          $stateMock.href.and.returnValue(theUpdateUrl);
          $scope.passwordRequest = { email: "bob@bob.com" };
          $scope.passwordRequestSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.requestPasswordReset).toHaveBeenCalled();
          expect($authMock.requestPasswordReset.calls.mostRecent().args[0].update_url).toEqual(theUpdateUrl);
        });

        it ("should redirect to the password request success page", function() {
          expect($stateMock.go).toHaveBeenCalledWith("root.inner.passwordsRequestSuccess");
        });
      });

      describe("with invalid request", function() {
        beforeEach(function() {
          $scope.passwordRequest = { email: ''};
          $scope.passwordRequestSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.requestPasswordReset).toHaveBeenCalled();
        });

        it ("should set the toast error message", function() {
          expect($toastMock.errorList).toHaveBeenCalledWith(["Missing Email"]);
        });
      });
    });
  });

  describe("Passwords Update Controller", function() {
    var theToken;

    beforeEach( inject(function($controller, $rootScope) {
      theToken = "someCryptoThingOrWhat";
      mockLocation = jasmine.createSpyObj('$location', ['search']);
      mockLocation.search.and.returnValue({token: theToken});

      $scope = $rootScope.$new();
      $controller('PasswordsUpdateCtrl', {
        $scope: $scope,
        $state: $stateMock,
        $auth: $authMock,
        $xngToast: $toastMock,
        Serializer: mockSerializer,
        $location: mockLocation
      });
      $scope.$apply();
    }));

    it('should assign password update', function(){
      expect($scope.passwordUpdate).toEqualData({
        password: "",
        passwordConfirmation: ""
      });
    });

    describe("passwordUpdateSubmit", function() {
      describe("with valid update", function() {
        beforeEach(function() {
          $scope.passwordUpdate = {
            password: "jimbo",
            passwordConfirmation: "jimbo"
          };
          $scope.passwordUpdateSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.updatePassword).toHaveBeenCalled();
          expect($authMock.updatePassword.calls.mostRecent().args[0].token).toEqual(theToken);
        });

        it ("should redirect to the passwords update success page", function() {
          expect($stateMock.go).toHaveBeenCalledWith("root.inner.passwordsUpdateSuccess");
        });
      });

      describe("with invalid request", function() {
        beforeEach(function() {
          $scope.passwordUpdate = {
            password: "jimbo",
            passwordConfirmation: "billyBob"
          };
          $scope.passwordUpdateSubmit();
          $scope.$apply();
        });

        it ("should call the auth service", function() {
          expect($authMock.updatePassword).toHaveBeenCalled();
        });

        it ("should set the toast error message", function() {
          expect($toastMock.errorList).toHaveBeenCalledWith({ passwordConfirmation: "must match password" },
          "We could not update your password because:");
        });
      });
    });
  });
});
