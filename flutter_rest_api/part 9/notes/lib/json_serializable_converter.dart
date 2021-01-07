import 'package:chopper/chopper.dart';

import 'models/resource_error.dart';

typedef T JsonFactory<T>(Map<String, dynamic> json);

class JsonSerializableConverter extends JsonConverter {
  final Map<Type, JsonFactory> factories;

  JsonSerializableConverter(this.factories);

  T _decodeMap<T>(Map<String, dynamic> values, { Type type }) {
    /// Get jsonFactory using Type parameters
    /// if not found or invalid, throw error or return null

    var jsonFactory;
    if (T == dynamic) {
      jsonFactory = factories[type];
    } else {
      jsonFactory = factories[T];
    }
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      /// throw serializer not found error;
      return null;
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(List values) =>
      values.where((v) => v != null).map<T>((v) => _decode<T>(v)).toList();

  dynamic _decode<T>(entity, { Type type }) {
    if (entity is Iterable) return _decodeList<T>(entity);

    if (entity is Map) return _decodeMap<T>(entity, type: type);

    return entity;
  }

  @override
  Response<ResultType> convertResponse<ResultType, Item>(Response response, { Type type }) {
    // use [JsonConverter] to decode json
    final jsonRes = super.convertResponse(response);

    return jsonRes.replace<ResultType>(body: _decode<Item>(jsonRes.body, type: type));
  }

  @override
  // all objects should implements toJson method
  Request convertRequest(Request request) => super.convertRequest(request);

  Response convertError<ResultType, Item>(Response response) {
    // use [JsonConverter] to decode json
    final jsonRes = super.convertError(response);

    return jsonRes.replace<ResourceError>(
      body: ResourceError.fromJsonFactory(jsonRes.body),
    );
  }
}
