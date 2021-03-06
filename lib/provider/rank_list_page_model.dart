import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankListPageModel with ChangeNotifier {
  List<Item> itemList = [];
  bool loading = true;
  String apiUrl;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void init(String apiUrl) {
    this.apiUrl = apiUrl;
  }

  void loadData(){
    ApiService.getData(apiUrl,
        success: (result) {
          Issue issueModel = Issue.fromJson(result);

          itemList = issueModel.itemList;
          loading = false;
          refreshController.refreshCompleted();
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
          refreshController.refreshFailed();
          loading = false;
        },
        complete: () => notifyListeners());
  }
}
