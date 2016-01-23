import {State} from "stateInjector";
import {LoggedInOnlyState} from "stateClasses";


@State('root.inner.confirmationsSuccess')
export class ConfirmationsSuccessState extends LoggedInOnlyState {
  constructor() {
    super();
    this.url = '^/confirmed';
    this.templateUrl = 'auth/confirmations/confirmations-success.tpl.html';
  }
}
