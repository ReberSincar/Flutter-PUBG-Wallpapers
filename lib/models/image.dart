class ImageModel {
  String thumbImage;
  String originalImage;
  int viewCount;
  int favCount;
  String createdAt;
  String id;

  ImageModel(
      {this.id,
      this.originalImage,
      this.thumbImage,
      this.viewCount,
      this.favCount,
      this.createdAt});

  factory ImageModel.fromMap(Map<String, dynamic> document) {
    ImageModel image = new ImageModel(
        id: document['id'] ?? '',
        originalImage: document['original_image'] ?? '',
        thumbImage: document['thumb_image'] ?? '',
        viewCount: document['view_count'] ?? 0,
        favCount: document['fav_count'] ?? 0,
        createdAt: document['created_at'].toString() ?? '');
    return image;
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'original_image': originalImage,
        'thumb_image': thumbImage,
        'view_count': viewCount,
        'fav_count': favCount,
        'created_at': createdAt
      };
}
