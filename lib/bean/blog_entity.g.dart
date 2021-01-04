// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogEntity _$BlogEntityFromJson(Map<String, dynamic> json) {
  return BlogEntity(
    (json['content'] as List)
        ?.map((e) =>
            e == null ? null : BlogContent.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['pageable'] == null
        ? null
        : BlogPageable.fromJson(json['pageable'] as Map<String, dynamic>),
    json['totalPages'] as int,
    json['totalElements'] as int,
    json['last'] as bool,
    json['size'] as int,
    json['sort'] == null
        ? null
        : BlogSort.fromJson(json['sort'] as Map<String, dynamic>),
    json['number'] as int,
    json['numberOfElements'] as int,
    json['first'] as bool,
    json['empty'] as bool,
  );
}

Map<String, dynamic> _$BlogEntityToJson(BlogEntity instance) =>
    <String, dynamic>{
      'content': instance.content,
      'pageable': instance.pageable,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'last': instance.last,
      'size': instance.size,
      'sort': instance.sort,
      'number': instance.number,
      'numberOfElements': instance.numberOfElements,
      'first': instance.first,
      'empty': instance.empty,
    };

BlogContent _$BlogContentFromJson(Map<String, dynamic> json) {
  return BlogContent(
    json['pageId'] as int,
    json['createDate'] as String,
    json['title'] as String,
    json['subtitle'] as String,
    json['tags'] as String,
    json['content'] as String,
  );
}

Map<String, dynamic> _$BlogContentToJson(BlogContent instance) =>
    <String, dynamic>{
      'pageId': instance.pageId,
      'createDate': instance.createDate,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'tags': instance.tags,
      'content': instance.content,
    };

BlogPageable _$BlogPageableFromJson(Map<String, dynamic> json) {
  return BlogPageable(
    json['sort'] == null
        ? null
        : BlogPageableSort.fromJson(json['sort'] as Map<String, dynamic>),
    json['pageNumber'] as int,
    json['pageSize'] as int,
    json['offset'] as int,
    json['paged'] as bool,
    json['unpaged'] as bool,
  );
}

Map<String, dynamic> _$BlogPageableToJson(BlogPageable instance) =>
    <String, dynamic>{
      'sort': instance.sort,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'offset': instance.offset,
      'paged': instance.paged,
      'unpaged': instance.unpaged,
    };

BlogPageableSort _$BlogPageableSortFromJson(Map<String, dynamic> json) {
  return BlogPageableSort(
    json['sorted'] as bool,
    json['unsorted'] as bool,
    json['empty'] as bool,
  );
}

Map<String, dynamic> _$BlogPageableSortToJson(BlogPageableSort instance) =>
    <String, dynamic>{
      'sorted': instance.sorted,
      'unsorted': instance.unsorted,
      'empty': instance.empty,
    };

BlogSort _$BlogSortFromJson(Map<String, dynamic> json) {
  return BlogSort(
    json['sorted'] as bool,
    json['unsorted'] as bool,
    json['empty'] as bool,
  );
}

Map<String, dynamic> _$BlogSortToJson(BlogSort instance) => <String, dynamic>{
      'sorted': instance.sorted,
      'unsorted': instance.unsorted,
      'empty': instance.empty,
    };
