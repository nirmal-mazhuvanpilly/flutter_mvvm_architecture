import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/study_material/model/feed_model.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/image_slider.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/video_thumbnail.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/youtube_thumbnail.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TabOneWidgetOne extends StatefulWidget {
  final FeedModel? feedModel;
  const TabOneWidgetOne({super.key, this.feedModel});

  @override
  State<TabOneWidgetOne> createState() => _TabOneWidgetOneState();
}

class _TabOneWidgetOneState extends State<TabOneWidgetOne> {
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: CachedNetworkImage(
                  imageUrl: widget.feedModel?.channelThumbnail ?? "",
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.feedModel?.channelName ?? ""),
                ],
              )),
              const SizedBox(width: 10),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.feedModel?.description ?? "",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        SwitchBasedOnType(
          pageController: pageController,
          feedModel: widget.feedModel,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if ((widget.feedModel?.postType ?? "") == "normal")
                Expanded(
                    child: SmoothPageIndicator(
                  controller: pageController,
                  count: (widget.feedModel?.postImage?.length ?? 0),
                  effect: ScrollingDotsEffect(
                      strokeWidth: 1.0,
                      activeStrokeWidth: 1.0,
                      paintStyle: PaintingStyle.fill,
                      activeDotColor: Colors.black,
                      activeDotScale: 1.0,
                      spacing: 5,
                      dotColor: Colors.black.withAlpha(30),
                      dotHeight: 5,
                      dotWidth: 5),
                )),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none)),
                  IconButton(
                      onPressed: () {
                        SharePlus.instance.share(
                          ShareParams(
                              title: widget.feedModel?.shareText ?? "",
                              uri:
                                  Uri.parse(widget.feedModel?.shareLink ?? "")),
                        );
                      },
                      icon: const Icon(Icons.share)),
                ],
              ))
            ],
          ),
        )
      ],
    );
  }
}

class SwitchBasedOnType extends StatelessWidget {
  final FeedModel? feedModel;
  final PageController pageController;
  const SwitchBasedOnType(
      {super.key, this.feedModel, required this.pageController});

  @override
  Widget build(BuildContext context) {
    switch (feedModel?.postType ?? "") {
      case "normal":
        return ImageSlider(
          controller: pageController,
          feedModel: feedModel,
        );
      case "video":
        return VideoThumbnail(
          feedModel: feedModel,
        );
      case "youtube":
        return YoutubeThumbnail(
          feedModel: feedModel,
        );
      default:
        return const SizedBox();
    }
  }
}
