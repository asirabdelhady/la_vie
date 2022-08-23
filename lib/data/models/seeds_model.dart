class SeedsModel {
  String? type;
  String? message;
  List<Data>? data;

  SeedsModel({this.type, this.message, this.data});

  SeedsModel.fromJson(dynamic json) {
    type = json['type'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

}

class Data {
  var seedId;
  var name;
  var description;
  var imageUrl;

  Data({this.seedId, this.name, this.description, this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    seedId = json['seedId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

}