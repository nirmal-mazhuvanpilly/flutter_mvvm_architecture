import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/study_material/repo/feed_repo.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/tab_three/tab_three_widget_one.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view_model/tab_one_feed_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class TabThree extends StatefulWidget {
  const TabThree({super.key});

  @override
  State<TabThree> createState() => _TabThreeState();
}

class _TabThreeState extends State<TabThree> {
  late final ScrollController? scrollController;
  final TabOneFeedViewModel feedViewModel =
      TabOneFeedViewModel(repo: GetIt.instance<FeedRepo>());

  @override
  void initState() {
    scrollController = ScrollController();
    feedViewModel.getFeeds();
    super.initState();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    feedViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: feedViewModel,
      child: RefreshIndicator(
        onRefresh: () async {
          feedViewModel.getFeeds();
        },
        child: ListView(
          controller: scrollController,
          children: const [
            TabThreeWidgetOne(),
            TabThreeWidgetOne(),
            TabThreeWidgetOne(),
            TabThreeWidgetOne(),
          ],
        ),
      ),
    );
  }
}
