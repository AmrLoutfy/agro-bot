/// channel : {"id":2718757,"name":"smart agriculture system","latitude":"0.0","longitude":"0.0","field1":"humidity","field2":"temperature","field3":"moisture","field4":"raindrop","created_at":"2024-10-28T22:52:07Z","updated_at":"2024-11-15T20:23:16Z","last_entry_id":49}
/// feeds : [{"created_at":"2024-11-15T21:10:11Z","entry_id":49,"field1":"nan","field2":"nan","field3":"28","field4":"0\r\n\r\n"}]

class FieldsResponse {
  FieldsResponse({
      this.channel, 
      this.feeds,});

  FieldsResponse.fromJson(dynamic json) {
    channel = json['channel'] != null ? Channel.fromJson(json['channel']) : null;
    if (json['feeds'] != null) {
      feeds = [];
      json['feeds'].forEach((v) {
        feeds?.add(Feeds.fromJson(v));
      });
    }
  }
  Channel? channel;
  List<Feeds>? feeds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (channel != null) {
      map['channel'] = channel?.toJson();
    }
    if (feeds != null) {
      map['feeds'] = feeds?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// created_at : "2024-11-15T21:10:11Z"
/// entry_id : 49
/// field1 : "nan"
/// field2 : "nan"
/// field3 : "28"
/// field4 : "0\r\n\r\n"

class Feeds {
  Feeds({
      this.createdAt, 
      this.entryId, 
      this.field1, 
      this.field2, 
      this.field3, 
      this.field4,});

  Feeds.fromJson(dynamic json) {
    createdAt = json['created_at'];
    entryId = json['entry_id'];
    field1 = json['field1'];
    field2 = json['field2'];
    field3 = json['field3'];
    field4 = json['field4'];
  }
  String? createdAt;
  int? entryId;
  String? field1;
  String? field2;
  String? field3;
  String? field4;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['created_at'] = createdAt;
    map['entry_id'] = entryId;
    map['field1'] = field1;
    map['field2'] = field2;
    map['field3'] = field3;
    map['field4'] = field4;
    return map;
  }

}

/// id : 2718757
/// name : "smart agriculture system"
/// latitude : "0.0"
/// longitude : "0.0"
/// field1 : "humidity"
/// field2 : "temperature"
/// field3 : "moisture"
/// field4 : "raindrop"
/// created_at : "2024-10-28T22:52:07Z"
/// updated_at : "2024-11-15T20:23:16Z"
/// last_entry_id : 49

class Channel {
  Channel({
      this.id, 
      this.name, 
      this.latitude, 
      this.longitude, 
      this.field1, 
      this.field2, 
      this.field3, 
      this.field4, 
      this.createdAt, 
      this.updatedAt, 
      this.lastEntryId,});

  Channel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    field1 = json['field1'];
    field2 = json['field2'];
    field3 = json['field3'];
    field4 = json['field4'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastEntryId = json['last_entry_id'];
  }
  int? id;
  String? name;
  String? latitude;
  String? longitude;
  String? field1;
  String? field2;
  String? field3;
  String? field4;
  String? createdAt;
  String? updatedAt;
  int? lastEntryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['field1'] = field1;
    map['field2'] = field2;
    map['field3'] = field3;
    map['field4'] = field4;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['last_entry_id'] = lastEntryId;
    return map;
  }

}