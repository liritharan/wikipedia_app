import 'dart:convert';

SearchResponse searchResponseFromJson(Map<String, dynamic> str) => SearchResponse.fromJson(str);

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  SearchResponse({
    this.batchcomplete,
    this.query,
  });

  bool batchcomplete;
  Query query;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
    batchcomplete: json["batchcomplete"],
    query: json["query"] == null ? null : Query.fromJson(json["query"]),
  );

  Map<String, dynamic> toJson() => {
    "batchcomplete": batchcomplete,
    "query": query == null ? null:  query.toJson(),
  };
}

class Query {
  Query({
    this.pages,
  });

  List<Page> pages;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    pages: List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pages": List<dynamic>.from(pages.map((x) => x.toJson())),
  };
}

class Page {
  Page({
    this.pageid,
    this.title,
    this.terms,
    this.thumbnail,
  });

  int pageid;
  String title;
  Terms terms;
  Thumbnail thumbnail;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
    pageid: json["pageid"],
    title: json["title"],
    terms: json["terms"] == null ? null : Terms.fromJson(json["terms"]),
    thumbnail: json["thumbnail"] == null ? null : Thumbnail.fromJson(json["thumbnail"]),
  );

  Map<String, dynamic> toJson() => {
    "pageid": pageid,
    "title": title,
    "terms": terms == null ? null : terms.toJson(),
    "thumbnail": thumbnail == null ? null : thumbnail.toJson(),
  };
}

class Terms {
  Terms({
    this.description,
  });

  List<String> description;

  factory Terms.fromJson(Map<String, dynamic> json) => Terms(
    description: List<String>.from(json["description"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "description": List<dynamic>.from(description.map((x) => x)),
  };
}

class Thumbnail {
  Thumbnail({
    this.source,
    this.width,
    this.height,
  });

  String source;
  int width;
  int height;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
    source: json["source"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "source": source,
    "width": width,
    "height": height,
  };
}

