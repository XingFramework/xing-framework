export default class OnLoginDirective {

  constructor($rootScope, $auth) {
    this.$rootScope = $rootScope;
    this.$auth = $auth;
    this.onLogout();
    this.$auth.validateUser().then((user) => {
      this.onLogin(user);
    });
    this.$rootScope.$on('auth:login-success', (ev, user) => {
      this.onLogin(user);
    });
    this.$rootScope.$on('auth:logout-success', (ev, user) => {
      this.onLogout();
    });
  }
}
