// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://blog-server.kingtous.cn/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<BlogEntity> getPages(offset) async {
    ArgumentError.checkNotNull(offset, 'offset');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'offset': offset};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/blog/list',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BlogEntity.fromJson(_result.data);
    return value;
  }

  @override
  Future<BlogEntity> searchPage(offset, words) async {
    ArgumentError.checkNotNull(offset, 'offset');
    ArgumentError.checkNotNull(words, 'words');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'keyword': words
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/blog/search',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BlogEntity.fromJson(_result.data);
    return value;
  }

  @override
  Future<BlogContent> getBlogContent(blogId) async {
    ArgumentError.checkNotNull(blogId, 'blogId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': blogId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/blog/detail',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BlogContent.fromJson(_result.data);
    return value;
  }
}
