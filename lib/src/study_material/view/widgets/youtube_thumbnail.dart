import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/study_material/model/feed_model.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/common_fade_in_image.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/custom_youtube_player.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/extensions.dart';

class YoutubeThumbnail extends StatelessWidget {
  final FeedModel? feedModel;
  const YoutubeThumbnail({super.key, this.feedModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => CustomYoutubePlayer(
            videoUrl: feedModel?.youtube?.youtubeLink,
          ),
        ));
      },
      child: Container(
        height: context.sw(size: 1),
        color: Colors.grey.shade200,
        child: CommonCachedNetworkImage(
          image: feedModel?.youtube?.thumbnail ?? "",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
