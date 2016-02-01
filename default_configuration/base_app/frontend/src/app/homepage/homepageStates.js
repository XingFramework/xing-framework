import {State, Resolve} from 'stateInjector';
import {AdminOnlyState, TrackAdminState} from 'stateClasses';

@State('root.homepage')
export class HomepageState extends TrackAdminState {
  constructor() {
    super();
    this.controller = 'HomepageCtrl';
    this.controllerAs = 'homepage';
    this.templateUrl = 'homepage/homepage.tpl.html';
    this.abstract = true;
    this.url = 'home';
  }
}

@State('root.homepage.show')
export class HomepageShowState {
  constructor() {
    this.url = '';
    this.controller = 'HomepageShowCtrl';
    this.controllerAs = 'homepageShow';
    this.templateUrl = 'homepage/homepage-show.tpl.html';
  }
}
