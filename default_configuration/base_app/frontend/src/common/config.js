import { environment } from "./environment.js";


export var backendUrl = (function(){
  var cookies = [];
  if(document.cookie) {
    cookies = document.cookie.split(';');
  }

  var matches = cookies.filter((cookie) => {
    return /^lrdBackendUrl=/.test(cookie);
  });

  if(matches.length > 0) {
    return matches[0].split('=')[1];
  } else {
    return environment.backendUrl;
  }
}());
export var appName = "LRD-CMS2";
export var configuration = { backendUrl, appName };

if(environment.name){
  configuration.appTitle = `${configuration.appName} - ${environment.name}`;
} else {
  configuration.appTitle = configuration.appName;
}
