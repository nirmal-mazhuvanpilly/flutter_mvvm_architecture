import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mvvm_architecture/model/passengers/passengers_model.dart';
import 'package:flutter_mvvm_architecture/res/enums/enums.dart';
import 'package:flutter_mvvm_architecture/src/passenger/repo/passenger_repo.dart';
import 'package:flutter_mvvm_architecture/src/passenger/view_model/passenger_provider.dart';
import 'package:flutter_mvvm_architecture/utils/routes/route_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class PassengerScreen extends StatefulWidget {
  const PassengerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _PassengerDetailViewState();
}

class _PassengerDetailViewState extends State<PassengerScreen> {
  late final PassengerProvider passengerProvider;

  @override
  void initState() {
    super.initState();
    passengerProvider =
        PassengerProvider(repo: GetIt.instance<PassengerRepo>());

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      passengerProvider.getPassengers(enableLoaderState: true);
    });
  }

  @override
  void dispose() {
    passengerProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("Build method rebuilds");

    return ChangeNotifierProvider.value(
      value: passengerProvider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Passenger"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouteConstants.routePassengerScreen);
                },
                icon: const Icon(Icons.next_plan_rounded))
          ],
        ),
        body: Selector<PassengerProvider, Tuple2<LoaderState?, bool?>>(
            selector: (context, provider) =>
                Tuple2(provider.loaderState, provider.enableLoaderState),
            builder: (context, value, child) {
              return SwitchView(
                  loaderState: value.item1,
                  enableLoaderState: value.item2,
                  loadedView: const PassengerLoadedView());
            }),
      ),
    );
  }
}

class SwitchView extends StatelessWidget {
  final LoaderState? loaderState;
  final Widget? loadedView;
  final bool? enableLoaderState;
  const SwitchView(
      {Key? key, this.loaderState, this.loadedView, this.enableLoaderState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (enableLoaderState ?? true) {
      switch (loaderState) {
        case LoaderState.loaded:
          return loadedView ?? const SizedBox();
        case LoaderState.loading:
          return const Center(child: CircularProgressIndicator());
        case LoaderState.error:
          return const Center(child: Text("Error"));
        default:
          return const SizedBox();
      }
    } else {
      return loadedView ?? const SizedBox();
    }
  }
}

class PassengerLoadedView extends StatefulWidget {
  const PassengerLoadedView({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _PassengerLoadedViewState();
}

class _PassengerLoadedViewState extends State<PassengerLoadedView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      pagination();
    });
  }

  void pagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<PassengerProvider>().getPassengers(
            enableLoaderState: false,
            page: context.read<PassengerProvider>().pageCount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<PassengerProvider,
            Tuple2<List<PassengerData>?, LoaderState?>>(
        selector: (context, provider) =>
            Tuple2(provider.passengersList, provider.loaderState),
        builder: (context, value, child) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final item = value.item1?.elementAt(index);
                  return Container(
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 25),
                    margin: const EdgeInsets.only(
                        bottom: 10, left: 10, right: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(item?.name ?? ""),
                            Expanded(
                                child: Text("ID : ${item?.id ?? ""}",
                                    textAlign: TextAlign.end)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text("Trips : ${item?.trips?.toString() ?? ""}"),
                      ],
                    ),
                  );
                }, childCount: value.item1?.length),
              ),
              SliverToBoxAdapter(
                child: SizedBox.square(
                  dimension: 100,
                  child: (value.item2 == LoaderState.loading)
                      ? const SizedBox.square(
                          dimension: 25,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              )
            ],
          );
        });
  }
}
