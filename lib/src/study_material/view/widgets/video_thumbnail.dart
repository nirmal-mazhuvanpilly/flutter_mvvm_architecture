import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/study_material/model/feed_model.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/common_fade_in_image.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/custom_video_player.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/extensions.dart';

class VideoThumbnail extends StatelessWidget {
  final FeedModel? feedModel;
  const VideoThumbnail({super.key, this.feedModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => CustomVideoPlayer(
            videoUrl: feedModel?.video?.videoLink,
          ),
        ));
      },
      child: Container(
        height: context.sw(size: 1),
        color: Colors.grey.shade200,
        child: CommonCachedNetworkImage(
          image: feedModel?.video?.thumbnail ?? "",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
