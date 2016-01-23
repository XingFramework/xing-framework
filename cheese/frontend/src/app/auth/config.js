import {Provider, Module} from 'a1atscript';

@Module('auth.config')
@Provider('authConfig')
export default function authConfig() {
  var config = {
    authKey: "email",
    recoverable: false
  };

  this.authKey = function (name) {
    config.authKey = name;
  };

  this.enableRecovery = function() {
    config.recoverable = true;
  };

  this.$get = [function authKey() {
    return config;
  }];
}
