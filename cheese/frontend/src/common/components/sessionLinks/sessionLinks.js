import SignOut from 'components/signOut/signOut.js';
import {Module, Component, Template} from 'a1atscript';
import OnLoginDirective from 'components/OnLoginDirective/OnLoginDirective.js';

@Module( 'sessionLinks', [
  'ng-token-auth',
  SignOut])
@Component({
  selector: 'xngSessionLinks',
  services: ['$rootScope', '$auth']
})
@Template({
  url: 'components/sessionLinks/session-links.tpl.html'
})
export default class SessionLinks extends OnLoginDirective {

  onLogin(user) {
    this.isLoggedIn = true;
  }

  onLogout() {
    this.isLoggedIn = false;
  }

}
