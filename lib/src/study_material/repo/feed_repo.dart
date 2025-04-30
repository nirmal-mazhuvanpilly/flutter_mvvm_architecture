import 'package:either_dart/either.dart';
import 'package:flutter_mvvm_architecture/data/remote/network_base_services.dart';
import 'package:flutter_mvvm_architecture/res/constants/app_constants.dart';
import 'package:flutter_mvvm_architecture/src/study_material/model/feed_model.dart';
import 'package:flutter_mvvm_architecture/src/study_material/model/sample_json.dart';

import 'package:get_it/get_it.dart';

abstract class FeedRepo {
  Future<Either<ResponseError, List<FeedModel>?>> getFeed({int? page = 0});
}

class FeedRepoTestImplements extends FeedRepo {
  final dio = GetIt.instance<NetWorkBaseServices>();

  @override
  Future<Either<ResponseError, List<FeedModel>?>> getFeed(
      {int? page = 0}) async {
    return Right(
        List<FeedModel>.from(sampleJson.map((x) => FeedModel.fromJson(x))));
  }
}

class FeedRepoImplements extends FeedRepo {
  final dio = GetIt.instance<NetWorkBaseServices>();

  @override
  Future<Either<ResponseError, List<FeedModel>?>> getFeed(
      {int? page = 0}) async {
    return dio
        .safe(dio.getRequest(endPoint: "${AppConstants.feed}page=$page"))
        .thenRight(dio.checkHttpStatus)
        .thenRight(dio.parseJson)
        .mapRight((right) =>
            List<FeedModel>.from(right.map((x) => FeedModel.fromJson(x))));
  }
}
