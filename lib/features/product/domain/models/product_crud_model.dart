class ProductCrudModel {
  String? sId;
  int? id;
  int? categoryId;
  String? categoryName;
  String? sku;
  String? name;
  String? description;
  int? weight;
  int? width;
  int? length;
  int? height;
  String? image;
  int? harga;

  ProductCrudModel(
      {this.sId,
      this.id,
      this.categoryId,
      this.categoryName,
      this.sku,
      this.name,
      this.description,
      this.weight,
      this.width,
      this.length,
      this.height,
      this.image,
      this.harga});

  ProductCrudModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    categoryId = json['CategoryId'];
    categoryName = json['categoryName'];
    sku = json['sku'];
    name = json['name'];
    description = json['description'];
    weight = json['weight'];
    width = json['width'];
    length = json['length'];
    height = json['height'];
    image = json['image'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['CategoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['sku'] = sku;
    data['name'] = name;
    data['description'] = description;
    data['weight'] = weight;
    data['width'] = width;
    data['length'] = length;
    data['height'] = height;
    data['image'] = image;
    data['harga'] = harga;
    return data;
  }
}
