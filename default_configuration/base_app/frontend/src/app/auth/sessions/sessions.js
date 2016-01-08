import {Module} from 'a1atscript';
import {Toast, Serializer} from 'xing-frontend-utils';
import Inflector from 'xing-inflector';
import Config from '../config.js';
import * as SessionsStates from './sessionsStates.js';
import SessionsController from './sessionsControllers.js';

var sessions = new Module('auth.sessions', [
  'ui.router.state',
  'ng-token-auth',
  Toast,
  Inflector,
  Serializer,
  Config,
  SessionsStates,
  SessionsController]);

export default sessions;
