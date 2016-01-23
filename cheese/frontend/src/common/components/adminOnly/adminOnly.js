import { Module, Component, Template } from 'a1atscript';
import OnLoginDirective from 'components/OnLoginDirective/OnLoginDirective.js';

@Module('adminOnly', ['ng-token-auth'])
@Component({
  selector: 'adminOnly',
  services: ['$rootScope', '$auth'],
  transclude: true
})
@Template({
  url: 'components/adminOnly/admin-only.tpl.html'
})
export default class AdminOnly extends OnLoginDirective {

  onLogout() {
    this.showAdmin = false;
  }

  onLogin(user) {
    this.showAdmin = true;
  }

}
