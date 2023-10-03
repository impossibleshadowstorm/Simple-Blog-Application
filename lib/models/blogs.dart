class Blog {
  String? id;
  String? imageUrl;
  String? title;

  Blog({this.id, this.imageUrl, this.title});

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['title'] = title;
    return data;
  }
}
