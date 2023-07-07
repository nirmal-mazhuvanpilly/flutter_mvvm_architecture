import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mvvm_architecture/data/local/hive/user_details.dart';
import 'package:flutter_mvvm_architecture/data/local/local_storage.dart';
import 'package:flutter_mvvm_architecture/src/global_view_model/app_data_provider.dart';
import 'package:flutter_mvvm_architecture/src/user/model/user.dart';
import 'package:flutter_mvvm_architecture/src/user/repo/user_repo.dart';
import 'package:flutter_mvvm_architecture/src/user/view/widgets/user_details_view.dart';
import 'package:flutter_mvvm_architecture/utils/common_widgets/switch_state.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/provider_helper_class.dart';
import 'package:flutter_mvvm_architecture/src/user/view_model/user_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  UserProvider userProvider = UserProvider(
    services: GetIt.instance<UserRepo>(),
    localStorage: GetIt.instance<LocalStorage>(),
  );

  final hive = GetIt.instance<LocalStorage>();

  @override
  void initState() {
    super.initState();
    userProvider.getCompleteDetails(loaderStateEnabled: true);
  }

  @override
  void dispose() {
    userProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userProvider,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Selector<UserProvider, Tuple2<UserModel?, LoaderState>>(
                  selector: (context, provider) =>
                      Tuple2(provider.userModel, provider.loaderState),
                  builder: (context, value, child) {
                    return SwitchState(
                      loaderState: value.item2,
                      loadingView: const CircularProgressIndicator(),
                      loadedView: UserDetailsView(userModel: value.item1),
                      networkErrorView: const Text("Network Error"),
                      errorView: const Text("Error"),
                      noDataView: const Text("No Details Found"),
                    );
                  }),
              TextButton(
                  onPressed: () {
                    userProvider.getCompleteDetails(loaderStateEnabled: true);
                  },
                  child: const Text("Refresh")),
              TextButton(
                  onPressed: () async {
                    final user = User(
                      name: "Nirmal M M",
                      age: 25,
                      friends: [
                        "Risto",
                        "Laiju",
                      ],
                    );
                    hive.addUserDetails(user);
                    hive.getUserDetails().then((value) {});
                  },
                  child: const Text("Add")),
              ValueListenableBuilder<Box>(
                  valueListenable: Hive.box<User>('userBox').listenable(),
                  builder: (context, box, child) {
                    User? user = box.get("CurrentUser");
                    return Column(
                      children: [
                        Text(user?.name ?? ""),
                        Text(user?.age.toString() ?? ""),
                      ],
                    );
                  }),
              NextPageButton(userRepo: UserRepoImplements()),
            ],
          ),
        ),
      ),
    );
  }
}

class NextPageButton extends StatefulWidget {
  final UserRepo userRepo;
  const NextPageButton({Key? key, required this.userRepo}) : super(key: key);

  @override
  State<NextPageButton> createState() => _NextPageButtonState();
}

class _NextPageButtonState extends State<NextPageButton> {
  @override
  void dispose() {
    widget.userRepo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appDataModel = context.read<AppDataProvider>();
    return ValueListenableBuilder<LoaderState>(
        valueListenable: widget.userRepo.navigateLoaderState,
        builder: (context, value, child) {
          if (value == LoaderState.loaded) {
            // Use SchedulerBinding.instance.addPostFrameCallback(): If you want to schedule a state change after the current frame is painted,
            // This ensures that the state change happens in the next frame, avoiding the issue of modifying the state during the build process.
            // For example: setState() or markNeedsBuild() called during build error will throw

            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewWidget(),
                ),
              );
            });
          }
          return GestureDetector(
            onTap: () async {
              if (value == LoaderState.loading) return;
              final res = await widget.userRepo
                  .navigateToNextPage(value: "Rastafarian");
              appDataModel.userName = res;
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: double.maxFinite,
              color: Colors.blue,
              child: value == LoaderState.loading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white))
                  : const Text(
                      "Next Page",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
            ),
          );
        });
  }
}

class NewWidget extends StatelessWidget {
  NewWidget({
    Key? key,
  }) : super(key: key);

  final appBar = AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 25),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(.50),
                Colors.black.withOpacity(.10),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    ),
    title: const Text(
      "NFT Details",
      style: TextStyle(color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final appDataModel = context.read<AppDataProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: appBar.preferredSize.height +
                  (MediaQuery.of(context).padding.top * 1.5),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      "https://images.squarespace-cdn.com/content/5e55383538da6e7b34219641/1620689168715-407HF2XX7U03CFBNHEDM/VADER.jpg?content-type=image%2Fjpeg",
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 500,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: imageProvider)),
                    );
                  },
                  placeholder: (context, url) {
                    return Container(
                      height: 500,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.pink,
                              Colors.pinkAccent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                    );
                  },
                ),
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(.05),
                      Colors.black,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(.10),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                )
              ],
            ),
            const GetSizeWidget(),
            Text("User Name : ${appDataModel.userName}",
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 1000),
          ],
        ),
      ),
    );
  }
}

class GetSizeWidget extends StatefulWidget {
  const GetSizeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GetSizeWidget> createState() => _GetSizeWidgetState();
}

class _GetSizeWidgetState extends State<GetSizeWidget> {
  Size? size;

  @override
  Widget build(BuildContext context) {
    return WidgetSizeOffsetWrapper(
        onSizeChange: (Size size) {
          setState(() {
            this.size = size;
            // print('Size: ${size.width}, ${size.height}');
          });
        },
        child: Transform.translate(
          offset: Offset(0, -(size?.height ?? 0)),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(.10),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Efficiency Index",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(.75)),
                )
              ],
            ),
          ),
        ));
  }
}

typedef OnWidgetSizeChange = void Function(Size size);

class WidgetSizeOffsetWrapper extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onSizeChange;

  const WidgetSizeOffsetWrapper({
    Key? key,
    required this.onSizeChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return WidgetSizeRenderObject(onSizeChange);
  }
}

class WidgetSizeRenderObject extends RenderProxyBox {
  final OnWidgetSizeChange onSizeChange;
  Size? currentSize;

  WidgetSizeRenderObject(this.onSizeChange);

  @override
  void performLayout() {
    super.performLayout();

    try {
      Size? newSize = child?.size;

      if (newSize != null && currentSize != newSize) {
        currentSize = newSize;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onSizeChange(newSize);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
