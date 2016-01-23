import RL from "relayer";
import {Module, Config, applyAnnotation} from "a1atscript";
import {backendUrl} from 'config';
// import other resources from src/common/resources here

class Resources extends RL.Resource {
}

RL.Describe(Resources, (desc) => {
  // put top level links to resources here
});

// sets up default API as 'resources' service
function setupResources(relayerProvider) {
  relayerProvider.createApi("resources", Resources, backendUrl+"resources")
}

// this is a syntax for applying an annotation without an ES7 Decorator
applyAnnotation(setupResources, Config, "relayerProvider");

var resourcesModule = new Module('xing.resources', [setupResources,
  RL]);

export default resourcesModule;
