import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/study_material/repo/feed_repo.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/tab_two/tab_two_widget_one.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view_model/tab_one_feed_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class TabTwo extends StatefulWidget {
  const TabTwo({super.key});

  @override
  State<TabTwo> createState() => _TabTwoState();
}

class _TabTwoState extends State<TabTwo> {
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
            TabTwoWidgetOne(),
            TabTwoWidgetOne(),
            TabTwoWidgetOne(),
            TabTwoWidgetOne(),
          ],
        ),
      ),
    );
  }
}
