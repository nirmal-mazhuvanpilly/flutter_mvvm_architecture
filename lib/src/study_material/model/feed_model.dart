class FeedModel {
  final int? channelId;
  final String? channelName;
  final String? channelThumbnail;
  final int? id;
  final String? description;
  final String? postType;
  final String? buttonText;
  final String? buttonColor;
  final String? linkOpen;
  final String? link;
  final String? shareText;
  final String? shareLink;
  final String? shareImage;
  final String? imageSize;
  final List<String>? postImage;
  final Youtube? youtube;
  final Video? video;
  final String? hashtags;
  final String? postCategory;
  final bool? whatsappJoinStatus;
  final bool? channelSubscribed;
  final String? createdAt;
  final int? listingOrder;
  final bool? publish;
  final int? totalShares;
  final int? totalLikes;
  final int? totalSaves;
  final Course? university;
  final Course? course;
  final Course? stream;
  final Course? semester;
  final Audio? audio;

  FeedModel({
    this.channelId,
    this.channelName,
    this.channelThumbnail,
    this.id,
    this.description,
    this.postType,
    this.buttonText,
    this.buttonColor,
    this.linkOpen,
    this.link,
    this.shareText,
    this.shareLink,
    this.shareImage,
    this.imageSize,
    this.postImage,
    this.youtube,
    this.video,
    this.hashtags,
    this.postCategory,
    this.whatsappJoinStatus,
    this.channelSubscribed,
    this.createdAt,
    this.listingOrder,
    this.publish,
    this.totalShares,
    this.totalLikes,
    this.totalSaves,
    this.university,
    this.course,
    this.stream,
    this.semester,
    this.audio,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        channelId: json["channel_id"],
        channelName: json["channel_name"],
        channelThumbnail: json["channel_thumbnail"],
        id: json["id"],
        description: json["description"],
        postType: json["post_type"],
        buttonText: json["button_text"],
        buttonColor: json["button_color"],
        linkOpen: json["link_open"],
        link: json["link"],
        shareText: json["share_text"],
        shareLink: json["share_link"],
        shareImage: json["share_image"],
        imageSize: json["image_size"],
        postImage: json["post_image"] == null
            ? null
            : List<String>.from(json["post_image"].map((x) => x)),
        youtube:
            json["youtube"] == null ? null : Youtube.fromJson(json["youtube"]),
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        hashtags: json["hashtags"],
        postCategory: json["post_category"],
        whatsappJoinStatus: json["whatsapp_join_status"],
        channelSubscribed: json["channel_subscribed"],
        createdAt: json["created_at"],
        listingOrder: json["listing_order"],
        publish: json["publish"],
        totalShares: json["total_shares"],
        totalLikes: json["total_likes"],
        totalSaves: json["total_saves"],
        university: json["university"] == null
            ? null
            : Course.fromJson(json["university"]),
        course: json["course"] == null ? null : Course.fromJson(json["course"]),
        stream: json["stream"] == null ? null : Course.fromJson(json["stream"]),
        semester:
            json["semester"] == null ? null : Course.fromJson(json["semester"]),
        audio: json["audio"] == null ? null : Audio.fromJson(json["audio"]),
      );
}

class Audio {
  final String? duration;
  final String? thumbnail;
  final String? audioLink;

  Audio({
    this.duration,
    this.thumbnail,
    this.audioLink,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        duration: json["duration"],
        thumbnail: json["thumbnail"],
        audioLink: json["audio_link"],
      );
}

class Course {
  final int? id;
  final String? name;

  Course({
    this.id,
    this.name,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
      );
}

class Video {
  final String? thumbnail;
  final String? videoLink;
  final String? videoSize;

  Video({
    this.thumbnail,
    this.videoLink,
    this.videoSize,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        thumbnail: json["thumbnail"],
        videoLink: json["video_link"],
        videoSize: json["video_size"],
      );
}

class Youtube {
  final String? thumbnail;
  final String? youtubeLink;

  Youtube({
    this.thumbnail,
    this.youtubeLink,
  });

  factory Youtube.fromJson(Map<String, dynamic> json) => Youtube(
        thumbnail: json["thumbnail"],
        youtubeLink: json["youtube_link"],
      );
}
