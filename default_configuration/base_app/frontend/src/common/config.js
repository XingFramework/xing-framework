import { environment } from "./environment.js";


export var backendUrl = (function(){
  var cookies = [];
  if(document.cookie) {
    cookies = document.cookie.split(/;\s*/);
  }

  var matches = cookies.filter((cookie) => {
    return /^xingBackendUrl=/.test(cookie);
  });

  if(matches.length > 0) {
    return matches[0].split('=')[1];
  } else {
    return environment.backendUrl;
  }
}());
export var appName = "XING-BASE";
export var configuration = { backendUrl, appName };

if(environment.name){
  configuration.appTitle = `${configuration.appName} - ${environment.name}`;
} else {
  configuration.appTitle = configuration.appName;
}
