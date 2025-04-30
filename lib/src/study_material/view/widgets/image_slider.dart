import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/common_fade_in_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailImageSlider extends StatefulWidget {
  final List<String?>? images;
  final PageController controller;

  const ProductDetailImageSlider({
    Key? key,
    this.images,
    required this.controller,
  }) : super(key: key);

  @override
  State<ProductDetailImageSlider> createState() =>
      _ProductDetailImageSliderState();
}

class _ProductDetailImageSliderState extends State<ProductDetailImageSlider> {
  int page = 0;
  late int nextPage;

  Future<List<CachedNetworkImageProvider>> loadAllImages() async {
    List<CachedNetworkImageProvider> cachedImages = [];
    widget.images?.forEach((element) {
      var configuration = createLocalImageConfiguration(context);
      cachedImages.add(
          CachedNetworkImageProvider(element ?? "")..resolve(configuration));
    });
    return cachedImages;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.images != null && (widget.images?.length ?? 0) > 1) {
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

  void _animateSlider() {
    Future.delayed(const Duration(milliseconds: 300)).then((_) {
      if (widget.controller.hasClients) {
        nextPage = page + 1;
        Future.delayed(const Duration(seconds: 3)).then((value) {
          if (widget.controller.hasClients) {
            if (nextPage <= (widget.images?.length ?? 0)) {
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
    return widget.images != null
        ? Container(
            width: double.maxFinite,
            alignment: Alignment.center,
            child: Stack(
              children: [
                SizedBox(
                    height: 250,
                    child: (widget.images != null &&
                            (widget.images?.length ?? 0) > 1)
                        ? FutureBuilder<List<CachedNetworkImageProvider>>(
                            future: loadAllImages(),
                            builder: (context, snapshot) {
                              return ((snapshot.hasData &&
                                      snapshot.data != null &&
                                      (snapshot.data?.isNotEmpty ?? false))
                                  ? PageView.builder(
                                      controller: widget.controller,
                                      itemBuilder: (context, index) {
                                        int currentIndex = index %
                                            (snapshot.data?.length ?? 0);
                                        return CommonCachedNetworkImage(
                                            image: snapshot.data!
                                                .elementAt(currentIndex)
                                                .url);
                                      },
                                    )
                                  : const SizedBox.shrink());
                            },
                          )
                        : CommonCachedNetworkImage(
                            image: widget.images?.first ?? "",
                          )),
              ],
            ))
        : const SizedBox();
  }
}
