import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/study_material/model/feed_model.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/common_fade_in_image.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/custom_web_view.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/extensions.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/hex_color.dart';

class ImageSlider extends StatefulWidget {
  final FeedModel? feedModel;
  final PageController controller;
  const ImageSlider({
    Key? key,
    this.feedModel,
    required this.controller,
  }) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int page = 0;
  late int nextPage;

  Future<List<CachedNetworkImageProvider>> loadAllImages() async {
    List<CachedNetworkImageProvider> cachedImages = [];
    widget.feedModel?.postImage?.forEach((element) {
      var configuration = createLocalImageConfiguration(context);
      cachedImages
          .add(CachedNetworkImageProvider(element)..resolve(configuration));
    });
    return cachedImages;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.feedModel?.postImage != null &&
          (widget.feedModel?.postImage?.length ?? 0) > 1) {
        _listenController();
        _animateSlider();
      }
    });
    super.initState();
  }

  void _listenController() {
    widget.controller.addListener(() {
      page = widget.controller.page!.round();
      nextPage = page + 1;
    });
  }

  double getHeight() {
    switch (widget.feedModel?.imageSize ?? 1) {
      case 1:
        return context.sw(size: 0.5);
      case 2:
        return context.sw(size: 0.75);
      case 3:
        return context.sw(size: 1);
      default:
        return context.sw();
    }
  }

  void _animateSlider() {
    Future.delayed(const Duration(milliseconds: 300)).then((_) {
      if (widget.controller.hasClients) {
        nextPage = page + 1;
        Future.delayed(const Duration(seconds: 3)).then((value) {
          if (widget.controller.hasClients) {
            if (nextPage <= (widget.feedModel?.postImage?.length ?? 0)) {
              widget.controller
                  .animateToPage(nextPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear)
                  .then((_) => _animateSlider());
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.feedModel?.postImage != null
        ? Container(
            width: double.maxFinite,
            alignment: Alignment.center,
            child: SizedBox(
              height: getHeight(),
              width: double.maxFinite,
              child: Stack(
                children: [
                  (widget.feedModel?.postImage != null &&
                          (widget.feedModel?.postImage?.length ?? 0) > 1)
                      ? FutureBuilder<List<CachedNetworkImageProvider>>(
                          future: loadAllImages(),
                          builder: (context, snapshot) {
                            return ((snapshot.hasData &&
                                    snapshot.data != null &&
                                    (snapshot.data?.isNotEmpty ?? false))
                                ? PageView.builder(
                                    controller: widget.controller,
                                    itemBuilder: (context, index) {
                                      int currentIndex =
                                          index % (snapshot.data?.length ?? 0);
                                      return CommonCachedNetworkImage(
                                        image: snapshot.data!
                                            .elementAt(currentIndex)
                                            .url,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                : const SizedBox.shrink());
                          },
                        )
                      : CommonCachedNetworkImage(
                          image: widget.feedModel?.postImage?.first ?? "",
                          fit: BoxFit.cover,
                        ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: OpenWidget(feedModel: widget.feedModel),
                  )
                ],
              ),
            ))
        : const SizedBox();
  }
}

class OpenWidget extends StatelessWidget {
  final FeedModel? feedModel;
  const OpenWidget({super.key, this.feedModel});

  @override
  Widget build(BuildContext context) {
    switch (feedModel?.linkOpen) {
      case "none":
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const CustomWebView();
              },
            ));
          },
          child: Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            decoration: BoxDecoration(
                color: HexColor(feedModel?.buttonColor ?? "FF6961"),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Text(
                  feedModel?.buttonText ?? "",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                )),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                        child: Icon(
                      Icons.offline_bolt,
                      color: Colors.white,
                    )),
                  ],
                )
              ],
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
