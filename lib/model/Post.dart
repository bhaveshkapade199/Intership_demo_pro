import 'package:time_degnitor__project/class_model.dart';

class Products {
  num? id;
  String? title;
  String? description;
  String? category;
  num? price;
  num? discountPercentage;
  num? rating;
  num? stock;
  List<String>? tagsList;
  String? brand;
  String? sku;
  num? weight;
  Dimensions? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<Reviews>? reviewsList;
  String? returnPolicy;
  num? minimumOrderQuantity;
  Meta? meta;
  List<String>? imagesList;
  String? thumbnail;

  Products({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tagsList,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviewsList,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.imagesList,
    this.thumbnail,
  });

  Products copyWith({
    num? id,
    String? title,
    String? description,
    String? category,
    num? price,
    num? discountPercentage,
    num? rating,
    num? stock,
    List<String>? tagsList,
    String? brand,
    String? sku,
    num? weight,
    Dimensions? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    List<Reviews>? reviewsList,
    String? returnPolicy,
    num? minimumOrderQuantity,
    Meta? meta,
    List<String>? imagesList,
    String? thumbnail,
  }) => Products(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    price: price ?? this.price,
    discountPercentage: discountPercentage ?? this.discountPercentage,
    rating: rating ?? this.rating,
    stock: stock ?? this.stock,
    tagsList: tagsList ?? this.tagsList,
    brand: brand ?? this.brand,
    sku: sku ?? this.sku,
    weight: weight ?? this.weight,
    dimensions: dimensions ?? this.dimensions,
    warrantyInformation: warrantyInformation ?? this.warrantyInformation,
    shippingInformation: shippingInformation ?? this.shippingInformation,
    availabilityStatus: availabilityStatus ?? this.availabilityStatus,
    reviewsList: reviewsList ?? this.reviewsList,
    returnPolicy: returnPolicy ?? this.returnPolicy,
    minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
    meta: meta ?? this.meta,
    imagesList: imagesList ?? this.imagesList,
    thumbnail: thumbnail ?? this.thumbnail,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["description"] = description;
    map["category"] = category;
    map["price"] = price;
    map["discountPercentage"] = discountPercentage;
    map["rating"] = rating;
    map["stock"] = stock;
    map["tags"] = tagsList;
    map["brand"] = brand;
    map["sku"] = sku;
    map["weight"] = weight;
    if (dimensions != null) {
      map["dimensions"] = dimensions?.toJson();
    }
    map["warrantyInformation"] = warrantyInformation;
    map["shippingInformation"] = shippingInformation;
    map["availabilityStatus"] = availabilityStatus;
    if (reviewsList != null) {
      map["reviews"] = reviewsList?.map((v) => v.toJson()).toList();
    }
    map["returnPolicy"] = returnPolicy;
    map["minimumOrderQuantity"] = minimumOrderQuantity;
    if (meta != null) {
      map["meta"] = meta?.toJson();
    }
    map["images"] = imagesList;
    map["thumbnail"] = thumbnail;
    return map;
  }

  Products.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    category = json["category"];
    price = json["price"];
    discountPercentage = json["discountPercentage"];
    rating = json["rating"];
    stock = json["stock"];
    tagsList = json["tags"] != null ? json["tags"].cast<String>() : [];
    brand = json["brand"];
    sku = json["sku"];
    weight = json["weight"];
    dimensions = json["dimensions"] != null
        ? Dimensions.fromJson(json["dimensions"])
        : null;
    warrantyInformation = json["warrantyInformation"];
    shippingInformation = json["shippingInformation"];
    availabilityStatus = json["availabilityStatus"];
    if (json["reviews"] != null) {
      reviewsList = [];
      json["reviews"].forEach((v) {
        reviewsList?.add(Reviews.fromJson(v));
      });
    }
    returnPolicy = json["returnPolicy"];
    minimumOrderQuantity = json["minimumOrderQuantity"];
    meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
    imagesList = json["images"] != null ? json["images"].cast<String>() : [];
    thumbnail = json["thumbnail"];
  }
}

class Post {
  List<Products>? productsList;
  num? total;
  num? skip;
  num? limit;

  Post({this.productsList, this.total, this.skip, this.limit});

  Post copyWith({
    List<Products>? productsList,
    num? total,
    num? skip,
    num? limit,
  }) => Post(
    productsList: productsList ?? this.productsList,
    total: total ?? this.total,
    skip: skip ?? this.skip,
    limit: limit ?? this.limit,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (productsList != null) {
      map["products"] = productsList?.map((v) => v.toJson()).toList();
    }
    map["total"] = total;
    map["skip"] = skip;
    map["limit"] = limit;
    return map;
  }

  Post.fromJson(dynamic json) {
    if (json["products"] != null) {
      productsList = [];
      json["products"].forEach((v) {
        productsList?.add(Products.fromJson(v));
      });
    }
    total = json["total"];
    skip = json["skip"];
    limit = json["limit"];
  }
}
