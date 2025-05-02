import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/study_material/model/feed_model.dart';
import 'package:flutter_mvvm_architecture/src/study_material/repo/feed_repo.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/tab_one/tab_one_widget_one.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view_model/tab_one_feed_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class TabOne extends StatefulWidget {
  const TabOne({super.key});

  @override
  State<TabOne> createState() => _TabOneState();
}

class _TabOneState extends State<TabOne> {
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
          feedViewModel.clearFeedData();
          feedViewModel.getFeeds();
        },
        child: Selector<TabOneFeedViewModel, List<FeedModel>>(
            selector: (context, provider) => provider.feedList,
            builder: (context, value, child) {
              return ListView.builder(
                controller: scrollController,
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final item = value.elementAt(index);
                  return TabOneWidgetOne(
                    feedModel: item,
                  );
                },
              );
            }),
      ),
    );
  }
}
