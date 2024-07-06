// ignore_for_file: library_private_types_in_public_api

class RestConstants {
  static const String baseUrl = 'url do site';
  static const String monetaEndpint = '/';
  static const String portalEndpointUrl = '/';
  // static String endpointTOTvsRMBase = '/api-corporerm';

  static _Endpoints authEndpoints = _Endpoints();
  static _Header headers = _Header();
  static _HeaderAuthorization headerAuthorization = _HeaderAuthorization();
}

class Language {
  static const String ptBR = 'pt-BR';
  static const String enEU = 'en-EU';
  static const String esES = 'es-ES';
}

class Version {
  static const String version = 'v1';
}

class _Endpoints {
  final tokenUrl = 'token';
  final tokenRefreshUrl = 'refresh-token';
  final authUrl = 'identity';
}

class _Header {
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE',
    'Access-Control-Allow-Headers':
        'Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers',
    'Accept': '*/*'
  };
}

class _HeaderAuthorization {
  Map<String, String> header = {
    'Authorization': 'Bearer ',
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE',
    'Access-Control-Allow-Headers':
        'Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers',
    'accept': '*/*'
  };
}
