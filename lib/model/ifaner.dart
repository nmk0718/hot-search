class ifanr {
  Meta meta;
  List<Objects> objects;

  ifanr({this.meta, this.objects});

  ifanr.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['objects'] != null) {
      objects = <Objects>[];
      json['objects'].forEach((v) {
        objects.add(new Objects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.objects != null) {
      data['objects'] = this.objects.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int limit;
  String next;
  int offset;
  Null previous;
  int totalCount;

  Meta({this.limit, this.next, this.offset, this.previous, this.totalCount});

  Meta.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    next = json['next'];
    offset = json['offset'];
    previous = json['previous'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['next'] = this.next;
    data['offset'] = this.offset;
    data['previous'] = this.previous;
    data['total_count'] = this.totalCount;
    return data;
  }
}

class Objects {
  String categoryUri;
  int createdAt;
  String createdAtFormat;
  CreatedBy createdBy;
  int id;
  String postCategory;
  String postCoverImage;
  String postExcerpt;
  String postId;
  List<String> postTag;
  String postTitle;
  String postType;
  String postUrl;

  Objects(
      {this.categoryUri,
        this.createdAt,
        this.createdAtFormat,
        this.createdBy,
        this.id,
        this.postCategory,
        this.postCoverImage,
        this.postExcerpt,
        this.postId,
        this.postTag,
        this.postTitle,
        this.postType,
        this.postUrl});

  Objects.fromJson(Map<String, dynamic> json) {
    categoryUri = json['category_uri'];
    createdAt = json['created_at'];
    createdAtFormat = json['created_at_format'];
    createdBy = json['created_by'] != null
        ? new CreatedBy.fromJson(json['created_by'])
        : null;
    id = json['id'];
    postCategory = json['post_category'];
    postCoverImage = json['post_cover_image'];
    postExcerpt = json['post_excerpt'];
    postId = json['post_id'];
    postTag = json['post_tag'].cast<String>();
    postTitle = json['post_title'];
    postType = json['post_type'];
    postUrl = json['post_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_uri'] = this.categoryUri;
    data['created_at'] = this.createdAt;
    data['created_at_format'] = this.createdAtFormat;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy.toJson();
    }
    data['id'] = this.id;
    data['post_category'] = this.postCategory;
    data['post_cover_image'] = this.postCoverImage;
    data['post_excerpt'] = this.postExcerpt;
    data['post_id'] = this.postId;
    data['post_tag'] = this.postTag;
    data['post_title'] = this.postTitle;
    data['post_type'] = this.postType;
    data['post_url'] = this.postUrl;
    return data;
  }
}

class CreatedBy {
  String authorUrl;
  String avatar;
  String email;
  int id;
  String job;
  String name;
  String signature;

  CreatedBy(
      {this.authorUrl,
        this.avatar,
        this.email,
        this.id,
        this.job,
        this.name,
        this.signature});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    authorUrl = json['author_url'];
    avatar = json['avatar'];
    email = json['email'];
    id = json['id'];
    job = json['job'];
    name = json['name'];
    signature = json['signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author_url'] = this.authorUrl;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['id'] = this.id;
    data['job'] = this.job;
    data['name'] = this.name;
    data['signature'] = this.signature;
    return data;
  }
}