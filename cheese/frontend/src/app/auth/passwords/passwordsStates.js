import {State, Resolve} from 'stateInjector';
import {LoggedInOnlyState} from 'stateClasses';

@State( 'root.inner.passwordsRequest')
export class PasswordsRequestState {
  constructor() {
    this.url = '^/reset-password';
    this.controller = 'PasswordsRequestCtrl';
    this.templateUrl = 'auth/passwords/passwords-request.tpl.html';
  }
}

@State( 'root.inner.passwordsRequestSuccess')
export class PasswordsRequestSuccessState {
  constructor() {
    this.url = '^/reset-password-sent';
    this.templateUrl = 'auth/passwords/passwords-request-success.tpl.html';
  }
}

@State( 'root.inner.passwordsUpdate')
export class PasswordsUpdateState extends LoggedInOnlyState {
  constructor() {
    super();
    this.url = '^/update-password';
    this.controller = 'PasswordsUpdateCtrl';
    this.templateUrl = 'auth/passwords/passwords-update.tpl.html';
  }
}

@State( 'root.inner.passwordsUpdateSuccess')
export class PasswordsUpdateSuccessState extends LoggedInOnlyState {
  constructor() {
    super();
    this.url = '^/updated-password';
    this.templateUrl = 'auth/passwords/passwords-update-success.tpl.html';
  }
}
