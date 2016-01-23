import {Module} from 'a1atscript';
import * as PasswordsStates from './passwordsStates.js';
import * as PasswordsControllers from './passwordsControllers.js';

var passwords = new Module('auth.passwords', [
  'ui.router.state',
  'ng-token-auth',
  PasswordsStates,
  PasswordsControllers]);

export default passwords;
