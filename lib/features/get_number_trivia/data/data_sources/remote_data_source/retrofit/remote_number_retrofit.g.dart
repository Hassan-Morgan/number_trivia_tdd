// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_number_retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RemoteNumberRetrofit implements RemoteNumberRetrofit {
  _RemoteNumberRetrofit(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://numbersapi.com';
  }

  final Dio _dio;
  String? baseUrl;

  @override
  Future<NumberTriviaModel> getRandomTrivia() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NumberTriviaModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/random/trivia?json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = NumberTriviaModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<NumberTriviaModel> getConcreteTrivia(number) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NumberTriviaModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/${number}/trivia?json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = NumberTriviaModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
