import 'package:flutter_mvvm_architecture/utils/helpers/type_convertors.dart';

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
  final int? imageSize;
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
        channelId: convertToInt(json["channel_id"]),
        channelName: convertToString(json["channel_name"]),
        channelThumbnail: convertToString(json["channel_thumbnail"]),
        id: convertToInt(json["id"]),
        description: convertToString(json["description"]),
        postType: convertToString(json["post_type"]),
        buttonText: convertToString(json["button_text"]),
        buttonColor: convertToString(json["button_color"]),
        linkOpen: convertToString(json["link_open"]),
        link: convertToString(json["link"]),
        shareText: convertToString(json["share_text"]),
        shareLink: convertToString(json["share_link"]),
        shareImage: convertToString(json["share_image"]),
        imageSize: convertToInt(json["image_size"]),
        postImage: convertToList<String>(json["post_image"]),
        youtube:
            json["youtube"] == null ? null : Youtube.fromJson(json["youtube"]),
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        hashtags: convertToString(json["hashtags"]),
        postCategory: convertToString(json["post_category"]),
        whatsappJoinStatus: convertToBool(json["whatsapp_join_status"]),
        channelSubscribed: convertToBool(json["channel_subscribed"]),
        createdAt: convertToString(json["created_at"]),
        listingOrder: convertToInt(json["listing_order"]),
        publish: convertToBool(json["publish"]),
        totalShares: convertToInt(json["total_shares"]),
        totalLikes: convertToInt(json["total_likes"]),
        totalSaves: convertToInt(json["total_saves"]),
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
        duration: convertToString(json["duration"]),
        thumbnail: convertToString(json["thumbnail"]),
        audioLink: convertToString(json["audio_link"]),
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
        id: convertToInt(json["id"]),
        name: convertToString(json["name"]),
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
        thumbnail: convertToString(json["thumbnail"]),
        videoLink: convertToString(json["video_link"]),
        videoSize: convertToString(json["video_size"]),
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
        thumbnail: convertToString(json["thumbnail"]),
        youtubeLink: convertToString(json["youtube_link"]),
      );
}
