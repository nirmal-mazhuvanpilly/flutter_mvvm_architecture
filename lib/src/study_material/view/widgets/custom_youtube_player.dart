import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomYoutubePlayer extends StatefulWidget {
  final String? videoUrl;

  const CustomYoutubePlayer({super.key, this.videoUrl});

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  ValueNotifier<double> fadeOpacity = ValueNotifier(0.0);

  late final YoutubePlayerController _controller;
  ValueNotifier loadingVideo = ValueNotifier(false);

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId:
            YoutubePlayer.convertUrlToId(widget.videoUrl ?? "") ?? "",
        flags: const YoutubePlayerFlags(autoPlay: false));
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _toggleOpacity();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleOpacity() {
    fadeOpacity.value = fadeOpacity.value == 1.0 ? 0.0 : 1.0;
  }

  @override
  void didUpdateWidget(covariant CustomYoutubePlayer oldWidget) {
    if (oldWidget.videoUrl != widget.videoUrl) {
      loadingVideo.value = true;
      final newVideoId = YoutubePlayer.convertUrlToId(widget.videoUrl!);
      if (newVideoId != null) {
        _controller.load(newVideoId);
        setState(() {});
      }
      loadingVideo.value = false;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ValueListenableBuilder(
            valueListenable: fadeOpacity,
            builder: (context, child, __) {
              return AnimatedOpacity(
                duration: const Duration(seconds: 3),
                opacity: fadeOpacity.value,
                child: ValueListenableBuilder(
                    valueListenable: loadingVideo,
                    builder: (context, loading, child) {
                      if (loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return YoutubePlayerBuilder(
                          onEnterFullScreen: () {
                            SystemChrome.setEnabledSystemUIMode(SystemUiMode
                                .immersive); // Hides overlays for full screen
                          },
                          onExitFullScreen: () {
                            SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.manual,
                                overlays: [
                                  SystemUiOverlay.top,
                                  SystemUiOverlay.bottom
                                ]); // Shows overlays again
                          },
                          player: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.red,
                            progressColors: ProgressBarColors(
                              playedColor: Colors.red,
                              handleColor: Colors.red.withAlpha(250),
                            ),
                            onReady: () {
                              _controller.addListener(() {});
                            },
                            onEnded: (metaData) {},
                          ),
                          builder: (BuildContext context, Widget player) {
                            return Center(child: player);
                          },
                        );
                      }
                    }),
              );
            }),
      ),
    );
  }
}
