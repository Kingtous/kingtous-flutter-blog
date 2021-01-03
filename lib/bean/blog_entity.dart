import 'package:json_annotation/json_annotation.dart';

part 'blog_entity.g.dart';

@JsonSerializable()
class BlogEntity{

	List<BlogContent> content;
	BlogPageable pageable;
	int totalPages;
	int totalElements;
	bool last;
	int size;
	BlogSort sort;
	int number;
	int numberOfElements;
	bool first;
	bool empty;

	factory BlogEntity.fromJson(Map<String, dynamic> json) => _$BlogEntityFromJson(json);
	Map<String, dynamic> toJson() => _$BlogEntityToJson(this);

	BlogEntity(
      this.content,
      this.pageable,
      this.totalPages,
      this.totalElements,
      this.last,
      this.size,
      this.sort,
      this.number,
      this.numberOfElements,
      this.first,
      this.empty);
}

@JsonSerializable()
class BlogContent{

	int pageId;
	String createDate;
	String title;
	String subtitle;
	String tags;
	String content;

	factory BlogContent.fromJson(Map<String, dynamic> json) => _$BlogContentFromJson(json);
	Map<String, dynamic> toJson() => _$BlogContentToJson(this);

	BlogContent(this.pageId, this.createDate, this.title, this.subtitle,
      this.tags, this.content);
}

@JsonSerializable()
class BlogPageable{

	BlogPageableSort sort;
	int pageNumber;
	int pageSize;
	int offset;
	bool paged;
	bool unpaged;

	factory BlogPageable.fromJson(Map<String, dynamic> json) => _$BlogPageableFromJson(json);
	Map<String, dynamic> toJson() => _$BlogPageableToJson(this);

	BlogPageable(this.sort, this.pageNumber, this.pageSize, this.offset,
      this.paged, this.unpaged);
}

@JsonSerializable()
class BlogPageableSort{

	bool sorted;
	bool unsorted;
	bool empty;

	factory BlogPageableSort.fromJson(Map<String, dynamic> json) => _$BlogPageableSortFromJson(json);
	Map<String, dynamic> toJson() => _$BlogPageableSortToJson(this);

	BlogPageableSort(this.sorted, this.unsorted, this.empty);
}

@JsonSerializable()
class BlogSort{

	bool sorted;
	bool unsorted;
	bool empty;

	factory BlogSort.fromJson(Map<String, dynamic> json) => _$BlogSortFromJson(json);
	Map<String, dynamic> toJson() => _$BlogSortToJson(this);

	BlogSort(this.sorted, this.unsorted, this.empty);
}
