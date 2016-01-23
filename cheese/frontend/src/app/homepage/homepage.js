import {Module} from 'a1atscript';
import * as HomepageControllers from './homepageControllers.js';
import * as HomepageStates from './homepageStates.js';

var Homepage = new Module('homepage', [
  HomepageControllers,
  HomepageStates
]);

export default Homepage;
