import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/multi_value_listenable.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String? videoUrl;
  const CustomVideoPlayer({
    super.key,
    this.videoUrl,
  });

  @override
  CustomVideoPlayerState createState() => CustomVideoPlayerState();
}

class CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  ValueNotifier<bool> isPlaying = ValueNotifier(false);
  ValueNotifier<bool> showToolBar = ValueNotifier(false);
  bool isInitialPlay = false;
  ValueNotifier<String> currentDuration = ValueNotifier("");
  int count = 1;

  @override
  void initState() {
    super.initState();
    videoInitialise();
  }

  @override
  void dispose() {
    _controller.dispose();
    onDispose();
    super.dispose();
  }

  void onDispose() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void videoInitialise({String? url}) {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(url ?? widget.videoUrl ?? ""),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false),
    )..initialize().then((_) {
        setState(() {});
        listenVideo();
        _controller.play();
        count = 1;
        isPlaying.value = true;
      });
  }

  void listenVideo() {
    _controller.addListener(
      () {
        currentDuration.value =
            _controller.value.position.toString().split(".").first;
        if (_controller.value.isPlaying) {
          isPlaying.value = true;
        } else {
          isPlaying.value = false;
          showToolBar.value = false;
        }
        if (_controller.value.isCompleted) {
          //TODO
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          onDispose();
          if (orientation == Orientation.portrait) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: !_controller.value.isInitialized
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              : ValueListenableBuilder(
                  valueListenable: isPlaying,
                  builder: (context, isPlay, __) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Center(
                          child: InkWell(
                              onTap: () {
                                showToolBar.value = !showToolBar.value;
                              },
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    VideoPlayer(_controller),
                                    ValueListenableBuilder(
                                        valueListenable: showToolBar,
                                        builder: (context, show, __) {
                                          return AnimatedCrossFade(
                                            firstCurve: Curves.easeInSine,
                                            secondCurve: Curves.easeInSine,
                                            duration: const Duration(
                                                milliseconds: 200),
                                            crossFadeState: showToolBar.value
                                                ? CrossFadeState.showFirst
                                                : CrossFadeState.showSecond,
                                            secondChild: const SizedBox(
                                              height: 40,
                                              width: double.maxFinite,
                                            ),
                                            firstChild: SizedBox(
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  const SizedBox(height: 2),
                                                  ValueListenableBuilder(
                                                      valueListenable:
                                                          currentDuration,
                                                      builder: (context,
                                                          duration, ___) {
                                                        return Text(
                                                            currentDuration
                                                                .value
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600));
                                                      }),
                                                  Expanded(
                                                    child:
                                                        VideoProgressIndicator(
                                                      _controller,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 1,
                                                          horizontal: 5),
                                                      allowScrubbing: true,
                                                      colors:
                                                          VideoProgressColors(
                                                              bufferedColor:
                                                                  Colors.red
                                                                      .withAlpha(
                                                                          300),
                                                              playedColor:
                                                                  Colors.red),
                                                    ),
                                                  ),
                                                  Text(
                                                    _controller.value.duration
                                                        .toString()
                                                        .split(".")
                                                        .first,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 2,
                                                            right: 5),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if (orientation !=
                                                            Orientation
                                                                .landscape) {
                                                          await SystemChrome
                                                              .setPreferredOrientations([
                                                            DeviceOrientation
                                                                .landscapeLeft,
                                                            DeviceOrientation
                                                                .landscapeRight,
                                                          ]);
                                                          await SystemChrome
                                                              .setEnabledSystemUIMode(
                                                                  SystemUiMode
                                                                      .immersive);
                                                        } else {
                                                          await SystemChrome
                                                              .setEnabledSystemUIMode(
                                                                  SystemUiMode
                                                                      .manual,
                                                                  overlays: [
                                                                SystemUiOverlay
                                                                    .top,
                                                                SystemUiOverlay
                                                                    .bottom
                                                              ]);
                                                          await SystemChrome
                                                              .setPreferredOrientations([
                                                            DeviceOrientation
                                                                .portraitUp,
                                                            DeviceOrientation
                                                                .portraitDown,
                                                          ]);
                                                        }
                                                      },
                                                      child: Icon(
                                                        orientation ==
                                                                Orientation
                                                                    .portrait
                                                            ? Icons.fullscreen
                                                            : Icons
                                                                .fullscreen_exit,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              )),
                        ),
                        Center(
                          child: isPlaying.value == false
                              ? InkWell(
                                  onTap: () {
                                    isInitialPlay = false;
                                    _controller.play().whenComplete(
                                        () => isPlaying.value = true);
                                    Future.delayed(
                                      const Duration(seconds: 2),
                                      () {
                                        if (showToolBar.value) {
                                          showToolBar.value = false;
                                        }
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                )
                              : ValueListenableBuilder(
                                  valueListenable: MultiValueListenable(
                                      [isPlaying, showToolBar]),
                                  builder: (context, show, __) {
                                    if (showToolBar.value) {
                                      return AnimatedCrossFade(
                                        crossFadeState: isPlaying.value
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        firstCurve: Curves.easeInSine,
                                        secondCurve: Curves.easeInSine,
                                        alignment: Alignment.center,
                                        secondChild: InkWell(
                                          onTap: () {
                                            _controller.pause();
                                            isPlaying.value == false;
                                          },
                                          child: const Icon(
                                            Icons.pause,
                                            color: Colors.white,
                                            size: 60,
                                          ),
                                        ),
                                        firstChild: InkWell(
                                          onTap: () {
                                            _controller.play().whenComplete(
                                                () => isPlaying.value = true);
                                            Future.delayed(
                                              const Duration(seconds: 2),
                                              () {
                                                if (showToolBar.value) {
                                                  showToolBar.value = false;
                                                }
                                              },
                                            );
                                          },
                                          child: const Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 60,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }),
                        )
                      ],
                    );
                  }),
        ),
      );
    });
  }
}
