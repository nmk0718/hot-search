import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hot_search/model/zhidemai.dart';
import 'model/alapi.dart';
import 'model/sspai.dart';

class DataController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    //初始化数据
    sspaiList();
    // zhidemaiList();
    // alapiList('NKGoRAzel6');
    // Future.delayed(
    //   Duration(seconds: 1),
    //   () {
    //     alapiList('G47o8weMmN');
    //     Future.delayed(
    //       Duration(seconds: 1),
    //       () {
    //         alapiList('LwkvlBqez1');
    //       },
    //     );
    //   },
    // );
  }

  RxList _sspaiData = [].obs;

  RxList get sspaiData => _sspaiData;

  sspaiList() async {
    var _parameters = {
      "limit": "20",
      "offset": "0",
      "created_at": "1640329566",
      "tag": "热门文章",
      "released": "false"
    };
    var response;
    response = await Dio().get('https://sspai.com/api/v1/article/tag/page/get',
        queryParameters: _parameters);
    sspai datas = sspai.fromJson(json.decode(response.toString()));
    _sspaiData.value = datas.data;
  }

  RxList _zhidemaiData = [].obs;

  RxList get zhidemaiData => _zhidemaiData;

  zhidemaiList() async {
    var _parameters = {"rank_type": "haowen", "rank_id": "yc"};
    var response;
    response = await Dio().get('https://www.smzdm.com/top/json_more',
        queryParameters: _parameters);
    zhidemai datas = zhidemai.fromJson(json.decode(response.toString()));
    for (int i = 0; i < datas.data.list.length; i++) {
      for (int j = 0; j < 2; j++) {
        zhidemaiData.add(datas.data.list[i][j]);
      }
    }
  }

  RxList _pojieData = [].obs;

  RxList get pojieData => _pojieData;

  RxList _hupuData = [].obs;

  RxList get hupuData => _hupuData;

  RxList _doubanData = [].obs;

  RxList get doubanData => _doubanData;

  Future alapiList(String id) async {
    var _parameters = {"token": "n8ZGQDctjwsem8Sc", "id": "${id}"};
    var response;
    response = await Dio()
        .get('https://v2.alapi.cn/api/tophub', queryParameters: _parameters);
    alapi datas = alapi.fromJson(json.decode(response.toString()));
    if (datas != null && datas.data != null && datas.data.list != null) {
      if (id == 'NKGoRAzel6') {
        _pojieData.value = datas.data.list;
      } else if (id == 'G47o8weMmN') {
        _hupuData.value = datas.data.list;
      } else if (id == 'LwkvlBqez1') {
        _doubanData.value = datas.data.list;
      }
    } else {
      print('后端数据为null');
    }
  }
}
