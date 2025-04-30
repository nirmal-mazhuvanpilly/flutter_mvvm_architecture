import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/custom_youtube_player.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/image_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TabOneWidgetOne extends StatefulWidget {
  const TabOneWidgetOne({super.key});

  @override
  State<TabOneWidgetOne> createState() => _TabOneWidgetOneState();
}

class _TabOneWidgetOneState extends State<TabOneWidgetOne> {
  late final PageController pageController;
  final List<String> images = [
    "https://images.pexels.com/photos/3030268/pexels-photo-3030268.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/3030268/pexels-photo-3030268.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
  ];

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
              CachedNetworkImage(
                imageUrl: "",
                width: 35,
                height: 35,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider)),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              const Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Heading"),
                  Text("Sub Heading"),
                ],
              )),
              const SizedBox(width: 10),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Heading"),
              SizedBox(height: 5),
              Text("Sub Heading"),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                // return const CustomVideoPlayer(
                //   videoUrl:
                //       "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                // );
                return const CustomYoutubePlayer(
                  videoUrl:
                      "https://www.youtube.com/watch?v=pxCWiYFkvTg&list=RDpxCWiYFkvTg&start_radio=1",
                );
              },
            ));
          },
          child: ProductDetailImageSlider(
            controller: pageController,
            images: images,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: SmoothPageIndicator(
                controller: pageController,
                count: (images.length),
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
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                ],
              ))
            ],
          ),
        )
      ],
    );
  }
}
