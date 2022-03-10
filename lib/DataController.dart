import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hot_search/model/weibotopic.dart';
import 'package:hot_search/model/zhidemai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/sspai.dart';
import 'model/websitedata.dart';
import 'model/weibohot.dart';


class DataController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    //初始化数据
    getwebsite();
  }
  RxList _webdataList = [
    //至少保留一个
    {
      "website": "少数派",
      "icon": "https://cdn.sspai.com/ui/logo/logo_sspai_icon.png",
      "menu": [
        {
          "menuName": "热门文章",
          "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
        },
        {
          "menuName": "最新文章",
          "menuUrl": "https://sspai.com/api/v1/article/index/page/get?limit:20&offset:0"
        },
        {
          "menuName": "应用推荐",
          "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=10&offset=0&tag=应用推荐&search_type=1"
        },
        {
          "menuName": "Matrix",
          "menuUrl": "https://sspai.com/api/v1/article/matrix/hot/page/get?offset=0&limit=20"
        },
        {
          "menuName": "一派话题广场",
          "menuUrl": "https://sspai.com/api/v1/bullet/search/page/get?limit=20&offset=0"
        }
      ]
    },
    {
      "website": "什么值得买",
      "icon": "https://res.smzdm.com/resources/public/img/pc_global/logo.png",
      "menu": [
        {
          "menuName": "好文原创榜",
          "menuUrl": "https://www.smzdm.com/top/json_more?rank_type=haowen&rank_id=yc"
        },
        {
          "menuName": "好价品类榜",
          "menuUrl": "https://www.smzdm.com/top/json_more?rank_type=pinlei&rank_id=11"
        },
        {
          "menuName": "好价电商榜",
          "menuUrl": "https://www.smzdm.com/top/json_more?rank_type=dianshang&rank_id=26"
        },
        {
          "menuName": "海淘Top榜",
          "menuUrl": "https://www.smzdm.com/top/json_more?rank_type=haitao&rank_id=39"
        },
        {
          "menuName": "好文资讯榜",
          "menuUrl": "https://www.smzdm.com/top/json_more?rank_type=haowen&rank_id=zx"
        },
        {
          "menuName": "新晋好物榜",
          "menuUrl": "https://www.smzdm.com/top/json_more?rank_type=haowu&rank_id=hwall"
        },
        {
          "menuName": "消费众测榜",
          "menuUrl": "https://www.smzdm.com/top/json_more?rank_type=haowu&rank_id=zc"
        }
      ]
    },
    {
      "website": "微博",
      "icon": "https://tvax2.sinaimg.cn/crop.0.0.178.178.180/61ecce97ly8gdi76ihgcwj204y04ygli.jpg",
      "menu": [
        {
          "menuName": "热搜榜",
          "menuUrl": "https://weibo.com/ajax/statuses/hot_band"
        },
        {
          "menuName": "话题榜",
          "menuUrl": "https://weibo.com/ajax/statuses/topic_band?sid=v_weibopro&category=all&page=1&count=10"
        },
      ]
    },
    // {
    //   "website": "吾爱破解",
    //   "icon": "https://avatar.52pojie.cn/images/noavatar_middle.gif",
    //   "menu": [
    //     {
    //       "menuName": "今日热帖",
    //       "menuUrl": "https://www.52pojie.cn/misc.php?mod=ranklist&type=thread&view=heats&orderby=today"
    //     },
    //     {
    //       "menuName": "人气热门",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     },
    //     {
    //       "menuName": "精品软件区",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     },
    //     {
    //       "menuName": "最新热门",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     },
    //     {
    //       "menuName": "原创发布区",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     },
    //     {
    //       "menuName": "吾爱破解 ‧ 最新发表",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     }
    //   ]
    // },
    // {
    //   "website": "虎扑",
    //   "icon":
    //   "https://w1.hoopchina.com.cn/channel/website/static/images/basketball-nba-logo.png",
    //   "menu": [
    //     // https://bbs.hupu.com/all-gambia  返回的html
    //     {
    //       "menuName": "步行街热帖",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     },
    //     {
    //       "menuName": "NBA论坛热帖",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     },
    //     {
    //       "menuName": "游戏电竞热帖",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     }
    //   ]
    // },
    // {
    //   "website": "豆瓣",
    //   "icon": "https://img3.doubanio.com/favicon.ico",
    //   "menu": [
    //     {
    //       "menuName": "24小时话题",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     },
    //     {
    //       "menuName": "冷笑话小组",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     },
    //     {
    //       "menuName": "一周口碑榜",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     },
    //     {
    //       "menuName": "上映的超过7.5分的电影",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     },
    //     {
    //       "menuName": "blabla",
    //       "menuUrl": "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
    //     }
    //   ]
    // }
  ].obs;

  RxList _websiteList = [].obs;

  RxList get websiteList => _websiteList;

  //默认为0 显示模式为卡片模式,1为直接显示
  RxInt _model = 0.obs;

  RxInt get model => _model;

  updatemodel(value) {
    _model.value = value;
  }

  additem(index) async {
    _websiteList.add(index);
  }

  removeitem(index) async {
    _websiteList.remove(index);
  }

  RxInt _tabindex = 0.obs;
  RxInt get tabindex => _tabindex;
  updatetabindex(index) {
    _tabindex.value = index;
  }

  RxList _hotsearchData = [].obs;

  RxList get hotsearchData => _hotsearchData;

  getwebsite() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance();
    if(prefs.getString('website') !=null){
      String valueStr = prefs.getString('website');
      List result = json.decode(valueStr);
      _websiteList.addAll(result);
      websitedata website = websitedata.fromJson(
          _websiteList[0]);
      updateData(website.menu[0].menuUrl);
    }else{
      _websiteList.value = _webdataList.value;
      websitedata website = websitedata.fromJson(
          _websiteList[0]);
      updateData(website.menu[0].menuUrl);
      var result = json.encode(_webdataList.value);
      prefs.setString('website',result);
    }
  }
  updateData(url) async {
    var response = await Dio().get(url);
    //少数派
    if (url.indexOf('sspai') != -1) {
      sspai datas = sspai.fromJson(json.decode(response.toString()));
      _hotsearchData.value = datas.data;
      //什么值得买
    } else if (url.indexOf('smzdm') != -1) {
      zhidemai datas = zhidemai.fromJson(json.decode(response.toString()));
      List zhangdama = [];
      for (int i = 0; i < datas.data.list.length; i++) {
        for (int j = 0; j < 2; j++) {
          if(datas.data.list[i][j] == null || datas.data.list[i][j].isEmpty){
            // print(datas.data.list[i][j]);
          }else{
            zhangdama.add(datas.data.list[i][j]);
          }
        }
      }
      _hotsearchData.value = zhangdama;
      //微博
    } else if (url.indexOf('weibo') != -1) {

        if(url.indexOf('hot_band') != -1){
          weibohot datas = weibohot.fromJson(json.decode(response.toString()));
          _hotsearchData.value = datas.data.bandList;
        }else{
          weibotopic datas = weibotopic.fromJson(json.decode(response.toString()));
          _hotsearchData.value = datas.data.statuses;
          print(datas.data.statuses[1]["topic"]);
        }
      // Document document = parse(response.data);

      // print(document.outerHtml);
      // print(document.querySelector("th").outerHtml);
      // print(document.getElementsByTagName("th"));
    }
}


//zhihu 热搜
//全部 https://www.zhihu.com/api/v4/creators/rank/hot?domain=0&period=day
//数码 https://www.zhihu.com/api/v4/creators/rank/hot?domain=100001&period=day
//
}
