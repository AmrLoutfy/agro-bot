/// channel : {"id":2718757,"name":"dht22 sensor","latitude":"0.0","longitude":"0.0","field1":"humidity","field2":"temperature","created_at":"2024-10-28T22:52:07Z","updated_at":"2024-10-28T22:52:07Z","last_entry_id":9}
/// feeds : [{"created_at":"2024-10-28T22:53:54Z","entry_id":1,"field1":"44.50"},{"created_at":"2024-10-28T22:54:10Z","entry_id":2,"field1":"46.30"},{"created_at":"2024-10-28T22:54:25Z","entry_id":3,"field1":"45.90"},{"created_at":"2024-10-28T22:54:41Z","entry_id":4,"field1":"45.90"},{"created_at":"2024-10-28T22:54:56Z","entry_id":5,"field1":"46.20"},{"created_at":"2024-10-28T22:55:12Z","entry_id":6,"field1":"46.30"},{"created_at":"2024-10-28T22:55:27Z","entry_id":7,"field1":"46.50"},{"created_at":"2024-10-28T22:55:43Z","entry_id":8,"field1":"46.60"},{"created_at":"2024-10-28T22:55:58Z","entry_id":9,"field1":"46.60"}]

class FeedsResponse {
  FeedsResponse({
      this.channel, 
      this.feeds,});

  FeedsResponse.fromJson(dynamic json) {
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

/// created_at : "2024-10-28T22:53:54Z"
/// entry_id : 1
/// field1 : "44.50"

class Feeds {
  Feeds({
      this.createdAt, 
      this.entryId, 
      this.field1,});

  Feeds.fromJson(dynamic json) {
    createdAt = json['created_at'];
    entryId = json['entry_id'];
    field1 = json['field1'];
  }
  String? createdAt;
  int? entryId;
  String? field1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['created_at'] = createdAt;
    map['entry_id'] = entryId;
    map['field1'] = field1;
    return map;
  }

}

/// id : 2718757
/// name : "dht22 sensor"
/// latitude : "0.0"
/// longitude : "0.0"
/// field1 : "humidity"
/// field2 : "temperature"
/// created_at : "2024-10-28T22:52:07Z"
/// updated_at : "2024-10-28T22:52:07Z"
/// last_entry_id : 9

class Channel {
  Channel({
      this.id, 
      this.name, 
      this.latitude, 
      this.longitude, 
      this.field1, 
      this.field2, 
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
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['last_entry_id'] = lastEntryId;
    return map;
  }

}