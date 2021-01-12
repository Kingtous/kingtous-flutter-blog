import 'package:kingtous_blog/bean/blog_entity.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://blog-server.kingtous.cn/")
abstract class ApiService {

  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/blog/list")
  Future<BlogEntity> getPages(@Query("offset") int offset);

  @GET("/blog/search")
  Future<BlogEntity> searchPage(@Query("offset") int offset,@Query("keyword") String  words);

  @GET("/blog/detail")
  Future<BlogContent> getBlogContent(@Query("id") String blogId);
}