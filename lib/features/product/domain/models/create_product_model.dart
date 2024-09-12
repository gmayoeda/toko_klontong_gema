class CreateProduct {
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

  CreateProduct({
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
    this.harga,
  });

  CreateProduct.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'sku': sku,
        'name': name,
        'description': description,
        'weight': weight,
        'width': width,
        'length': length,
        'height': height,
        'image': image,
        'harga': harga,
      };
}



// {
//   "id": 86,
//   "CategoryId": 14,
//   "categoryName": "Cemilan",
//   "sku": "MHZVTK",
//   "name": "Ciki ciki",
//   "description": "Ciki ciki yang super enak, hanya di toko klontong kami",
//   "weight": 500,
//   "width": 5,
//   "length": 5,
//   "height": 5,
//   "image": "https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b",
//   "harga": 30000
// }
