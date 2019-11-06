class FluroUtils {
  static paramsToRoute(String route, Map<String,List<String>> data) {
    List params = route.split("/:");
    for ( int i = 1; i < params.length; ++i ) {
      params[i] = "/" + data[params[i]][0];
    }

    return params.join("");
    // route.splitMapJoin(pattern)
  }

  // **Asumption: Each value only has one parameter
  // static routeToParams( String route, String url ) {
  //   List params = route.split("/:");
  //   List values = (url.substring(params[0].length)).split("/");
    
  //   assert(params.length == values.length);

  //   Map<String, String> data;
  //   for ( int i = 1; i < params.length; ++i ) {
  //     data[params[i]] = values[i];
  //   }

  //   return data;
  // } 
  static paramsToMap(String route, Map<String, List<String>> params) {

    List arguments = route.split("/:");
    Map<String,String> data = {};
    for ( int i = 1; i < arguments.length; ++i ) {
      String key = arguments[i];
      String value = (params[key])[0];
      data[key] = value;
    }

    return data;
  }
}