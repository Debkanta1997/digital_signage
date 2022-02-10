class videoLists {
  String? status;
  List<VideoList>? videoList;

  videoLists({this.status, this.videoList});

  videoLists.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['video_list'] != null) {
      videoList = <VideoList>[];
      json['video_list'].forEach((v) {
        videoList!.add(new VideoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.videoList != null) {
      data['video_list'] = this.videoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoList {
  String? signageUrl;

  VideoList({this.signageUrl});

  VideoList.fromJson(Map<String, dynamic> json) {
    signageUrl = json['signage_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signage_url'] = this.signageUrl;
    return data;
  }
}
