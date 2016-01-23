import {State} from 'stateInjector';

@State( 'root.inner.registrations')
export class RegistrationsState {
  constructor() {
    this.url = '^/sign-up';
    this.controller = 'RegistrationsCtrl';
    this.templateUrl = 'auth/registrations/registrations.tpl.html';
  }
}

@State( 'root.inner.registrationsSuccess')
export class RegistrationsSuccessState {
  constructor() {
    this.url = '^/signed-up';
    this.templateUrl = 'auth/registrations/registrations-success.tpl.html';
  }
}
