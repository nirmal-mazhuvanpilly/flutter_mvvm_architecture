import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/global_view_model/app_data_provider.dart';
import 'package:flutter_mvvm_architecture/src/nft_details/view/widgets/get_size_widget.dart';
import 'package:provider/provider.dart';

class NftDetailsView extends StatelessWidget {
  NftDetailsView({
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
