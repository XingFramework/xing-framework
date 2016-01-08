import {Module} from 'a1atscript';
import * as ConfirmationsStates from './confirmationsStates.js';

var confirmations = new Module( 'auth.confirmations', [
  'ui.router.state',
  'ng-token-auth',
  ConfirmationsStates]);
export default confirmations;
