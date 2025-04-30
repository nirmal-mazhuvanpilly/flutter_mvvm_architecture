import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/tabs/tab_four.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/tabs/tab_one.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/tabs/tab_three.dart';
import 'package:flutter_mvvm_architecture/src/study_material/view/widgets/tabs/tab_two.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late final TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: double.maxFinite,
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Heading"),
                  Text("SubHeading"),
                ],
              ),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TabBar(
                controller: tabController,
                tabs: const [
                  Tab(
                    child: Text("Tab One"),
                  ),
                  Tab(
                    child: Text("Tab Two"),
                  ),
                  Tab(
                    child: Text("Tab Three"),
                  ),
                  Tab(
                    child: Text("Tab Four"),
                  ),
                ],
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.red,
                indicatorPadding: EdgeInsets.zero,
                dividerColor: Colors.white,
              ),
              Expanded(
                  child: TabBarView(controller: tabController, children: const [
                TabOne(),
                TabTwo(),
                TabThree(),
                TabFour(),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
