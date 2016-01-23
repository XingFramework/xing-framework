import {State} from 'stateInjector';

@State('root')
export class RootState {
  constructor() {
    this.templateUrl = "root.tpl.html";
    this.controller = 'RootCtrl';
    this.abstract = true;
    this.url = "/";
  }
}

@State('root.inner')
export class RootInnerState {
  constructor() {
    this.templateUrl ="inner.tpl.html";
    this.abstract = true;
    this.url = "inner";
  }
}
