export function xpath(context, expr, resType){
  if(!resType) { resType = XPathResult.ORDERED_NODE_SNAPSHOT_TYPE; }
  var result = document.evaluate(expr, context[0], null, resType, null);
  return result;
}

export function stringAtXpath(context, expr){
  return xpath(context, expr, XPathResult.STRING_TYPE).stringValue;
}
