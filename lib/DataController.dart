import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hot_search/model/weibotopic.dart';
import 'package:hot_search/model/zhidemai.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/ifaner.dart';
import 'model/sspai.dart';
import 'model/websitedata.dart';
import 'model/weibohot.dart';
import 'model/zhihu.dart';

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
          "menuUrl":
              "https://sspai.com/api/v1/article/tag/page/get?limit=20&offset=0&tag=热门文章&released=false"
        },
        {
          "menuName": "最新文章",
          "menuUrl":
              "https://sspai.com/api/v1/article/index/page/get?limit:20&offset:0"
        },
        {
          "menuName": "应用推荐",
          "menuUrl":
              "https://sspai.com/api/v1/article/tag/page/get?limit=10&offset=0&tag=应用推荐&search_type=1"
        },
        {
          "menuName": "Matrix",
          "menuUrl":
              "https://sspai.com/api/v1/article/matrix/hot/page/get?offset=0&limit=20"
        },
        {
          "menuName": "一派话题广场",
          "menuUrl":
              "https://sspai.com/api/v1/bullet/search/page/get?limit=20&offset=0"
        }
      ]
    },
    {
      "website": "什么值得买",
      "icon": "https://res.smzdm.com/resources/public/img/pc_global/logo.png",
      "menu": [
        {
          "menuName": "好文原创榜",
          "menuUrl":
              "https://www.smzdm.com/top/json_more?rank_type=haowen&rank_id=yc"
        },
        {
          "menuName": "好价品类榜",
          "menuUrl":
              "https://www.smzdm.com/top/json_more?rank_type=pinlei&rank_id=11"
        },
        {
          "menuName": "好价电商榜",
          "menuUrl":
              "https://www.smzdm.com/top/json_more?rank_type=dianshang&rank_id=26"
        },
        {
          "menuName": "海淘Top榜",
          "menuUrl":
              "https://www.smzdm.com/top/json_more?rank_type=haitao&rank_id=39"
        },
        {
          "menuName": "好文资讯榜",
          "menuUrl":
              "https://www.smzdm.com/top/json_more?rank_type=haowen&rank_id=zx"
        },
        {
          "menuName": "新晋好物榜",
          "menuUrl":
              "https://www.smzdm.com/top/json_more?rank_type=haowu&rank_id=hwall"
        },
        {
          "menuName": "消费众测榜",
          "menuUrl":
              "https://www.smzdm.com/top/json_more?rank_type=haowu&rank_id=zc"
        }
      ]
    },
    {
      "website": "微博",
      "icon":
          "https://tvax2.sinaimg.cn/crop.0.0.178.178.180/61ecce97ly8gdi76ihgcwj204y04ygli.jpg",
      "menu": [
        {
          "menuName": "热搜榜",
          "menuUrl": "https://weibo.com/ajax/statuses/hot_band"
        },
        {
          "menuName": "话题榜",
          "menuUrl":
              "https://weibo.com/ajax/statuses/topic_band?sid=v_weibopro&category=all&page=1&count=10"
        },
      ]
    },
    {
      "website": "爱范儿",
      "icon":
          "https://images.ifanr.cn/wp-content/themes/ifanr-5.0-pc/static/images/favicon.ico",
      "menu": [
        {
          "menuName": "最新",
          "menuUrl": "https://sso.ifanr.com/api/v5/wp/web-feed"
        },
        {
          "menuName": "每日早报",
          "menuUrl":
              "https://sso.ifanr.com/api/v5/wp/article/?post_category=%E6%97%A9%E6%8A%A5"
        },
        {
          "menuName": "AppSolution",
          "menuUrl": "https://sso.ifanr.com/api/v5/wp/article/?post_type=app"
        },
        {
          "menuName": "玩物志",
          "menuUrl":
              "https://sso.ifanr.com/api/v5/wp/article/?post_type=coolbuy"
        },
      ]
    },
    {
      "website": "IT之家",
      "icon": "https://img.ithome.com/m/images/logo.png",
      "menu": [
        {"menuName": "日榜", "menuUrl": "https://m.ithome.com/rankm/"},
      ]
    },
    {
      "website": "百度",
      "icon": "https://www.baidu.com/favicon.ico",
      "menu": [
        {
          "menuName": "热搜榜",
          "menuUrl": "https://top.baidu.com/board?tab=realtime"
        },
        {"menuName": "小说", "menuUrl": "https://top.baidu.com/board?tab=novel"},
        {"menuName": "电影", "menuUrl": "https://top.baidu.com/board?tab=movie"},
      ]
    },
    {
      "website": "36氪",
      "icon": "https://www.36kr.com/favicon.ico",
      "menu": [
        {"menuName": "人气榜", "menuUrl": "https://www.36kr.com/hot-list/catalog"},
      ]
    },
    {
      "website": "知乎",
      "icon": "https://static.zhihu.com/heifetz/favicon.ico",
      "menu": [
        {
          "menuName": "时榜",
          "menuUrl":
              "https://www.zhihu.com/api/v4/creators/rank/hot?domain=0&period=hour"
        },
        {
          "menuName": "日榜",
          "menuUrl":
              "https://www.zhihu.com/api/v4/creators/rank/hot?domain=0&period=day"
        },
        {
          "menuName": "数码",
          "menuUrl":
              "https://www.zhihu.com/api/v4/creators/rank/hot?domain=100001&period=day"
        },
        {
          "menuName": "科技",
          "menuUrl":
              "https://www.zhihu.com/api/v4/creators/rank/hot?domain=100002&period=day"
        },
        {
          "menuName": "互联网",
          "menuUrl":
              "https://www.zhihu.com/api/v4/creators/rank/hot?domain=100003&period=day"
        },
      ]
    },
    {
      "website": "吾爱破解",
      "icon": "https://avatar.52pojie.cn/images/noavatar_middle.gif",
      "menu": [
        {
          "menuName": "今日热帖",
          "menuUrl":
              "https://www.52pojie.cn/misc.php?mod=ranklist&type=thread&view=heats&orderby=today"
        },
      ]
    },
    {
      "website": "虎扑",
      "icon":
          "https://w1.hoopchina.com.cn/channel/website/static/images/basketball-nba-logo.png",
      "menu": [
        {"menuName": "步行街热帖", "menuUrl": "https://bbs.hupu.com/all-gambia"},
        {"menuName": "NBA热帖", "menuUrl": "https://bbs.hupu.com/all-nba"},
        {"menuName": "电竞热帖", "menuUrl": "https://bbs.hupu.com/all-gg"}
      ]
    },
    {
      "website": "小红书",
      "icon": "https://ci.xiaohongshu.com/49fd555a-b46b-49fd-b5a5-053fb4a536dc",
      "menu": [
        {"menuName": "社区精选", "menuUrl": "https://www.xiaohongshu.com/explore"},
      ]
    },
    {
      "website": "豆瓣",
      "icon": "https://img3.doubanio.com/favicon.ico",
      "menu": [
        {"menuName": "讨论精选", "menuUrl": "https://www.douban.com/group/explore"},
        {"menuName": "热门话题", "menuUrl": "https://www.douban.com"},
        {"menuName": "24小时话题", "menuUrl": "https://www.douban.com/gallery"},
      ]
    }
  ].obs;

  RxList _websiteList = [].obs;

  RxList get websiteList => _websiteList;

  //默认为0 显示模式为卡片模式,1为直接显示
  RxInt _model = 0.obs;

  RxInt get model => _model;

  RxBool _isLoading = true.obs;

  RxBool get isLoading => _isLoading;

  updateloading(value) {
    _isLoading.value = value;
  }

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('website') != null) {
      String valueStr = prefs.getString('website');
      List result = json.decode(valueStr);
      _websiteList.addAll(result);
      websitedata website = websitedata.fromJson(_websiteList[0]);
      updateData(website.menu[0].menuUrl);
    } else {
      _websiteList.value = _webdataList.value;
      websitedata website = websitedata.fromJson(_websiteList[0]);
      updateData(website.menu[0].menuUrl);
      var result = json.encode(_webdataList.value);
      prefs.setString('website', result);
    }
  }

  updateData(url) async {
    var response = await Dio().get(url);
    if (response.statusCode == 200) {
      if (url.indexOf('sspai') != -1) {
        sspai datas = sspai.fromJson(json.decode(response.toString()));
        List<Map<String, dynamic>> linkMap = [];
        for (var link in datas.data) {
          linkMap.add({
            'title': link["title"],
            'link': 'https://sspai.com/post/${link["id"]}',
          });
        }
        _hotsearchData.value = linkMap;
        //什么值得买
      }
      if (url.indexOf('smzdm') != -1) {
        zhidemai datas = zhidemai.fromJson(json.decode(response.toString()));
        List<Map<String, dynamic>> linkMap = [];
        for (var link in datas.data.list) {
          for (int i = 0; i < 2; i++) {
            if (link[i] == null || link[i].isEmpty) {
              // (datas.data.list[i][j]);
            } else {
              linkMap.add({
                'title': link[i]["article_title"],
                'link': link[i]['article_url'],
              });
            }
          }
        }
        _hotsearchData.value = linkMap;
        //微博
      }
      if (url.indexOf('weibo') != -1) {
        if (url.indexOf('hot_band') != -1) {
          weibohot datas = weibohot.fromJson(json.decode(response.toString()));
          List<Map<String, dynamic>> linkMap = [];
          for (var link in datas.data.bandList) {
            linkMap.add({
              'title': link["note"],
              'link':
                  'https://m.weibo.cn/search?containerid=100103type%3D1%26q%3D%23${link["note"]}%23',
            });
          }
          _hotsearchData.value = linkMap;
        } else {
          weibotopic datas =
              weibotopic.fromJson(json.decode(response.toString()));
          List<Map<String, dynamic>> linkMap = [];
          for (var link in datas.data.statuses) {
            linkMap.add({
              'title': link["note"],
              'link':
                  'https://m.weibo.cn/search?containerid=100103type%3D1%26q%3D%23${link["note"]}%23',
            });
          }
          _hotsearchData.value = linkMap;
        }
      }
      if (url.indexOf('ifanr') != -1) {
        ifanr datas = ifanr.fromJson(json.decode(response.toString()));
        List<Map<String, dynamic>> linkMap = [];
        for (var link in datas.objects) {
          linkMap.add({
            'title': link.postTitle,
            'link': link.postUrl,
          });
        }
        _hotsearchData.value = linkMap;
      }
      if (url.indexOf('ithome') != -1) {
        Document document = parse(response.data);
        List<Element> links = document.querySelectorAll('div.placeholder > a');
        List<Map<String, dynamic>> linkMap = [];
        for (var link in links) {
          linkMap.add({
            'title': link.querySelector('p.plc-title').text,
            'link': link.attributes['href'],
          });
        }
        _hotsearchData.value = linkMap;
      }
      if (url.indexOf('baidu') != -1) {
        Document document = parse(response.data);
        List<Element> links =
            document.querySelectorAll('div.content_1YWBm > a');
        List<Map<String, dynamic>> linkMap = [];
        for (var link in links) {
          linkMap.add({
            'title': link.querySelector('div.c-single-text-ellipsis').text,
            'link': link.attributes['href'],
          });
        }
        _hotsearchData.value = linkMap;
      }
      if (url.indexOf('36kr') != -1) {
        Document document = parse(response.data);
        List<Element> links = document.querySelectorAll('p.title-wrapper > a');
        List<Map<String, dynamic>> linkMap = [];
        for (var link in links) {
          linkMap.add({
            'title': link.text,
            'link': 'https://www.36kr.com' + link.attributes['href'],
          });
        }
        _hotsearchData.value = linkMap;
      }
      if (url.indexOf('zhihu') != -1) {
        zhihu datas = zhihu.fromJson(json.decode(response.toString()));
        List<Map<String, dynamic>> linkMap = [];
        for (var link in datas.data) {
          linkMap.add({
            'title': link.question.title,
            'link': link.question.url,
          });
        }
        _hotsearchData.value = linkMap;
      }
      if (url.indexOf('52pojie') != -1) {
        Document document = parse(response.data);
        List<Element> links = document.querySelectorAll('th > a');
        List<Map<String, dynamic>> linkMap = [];
        for (var link in links) {
          linkMap.add({
            'title': link.text,
            'link': 'https://www.52pojie.cn/' + link.attributes['href'],
          });
        }
        _hotsearchData.value = linkMap;
      }
      if (url.indexOf('hupu') != -1) {
        Document document = parse(response.data);
        List<Element> links = document.querySelectorAll('div.t-info > a');
        List<Map<String, dynamic>> linkMap = [];
        for (var link in links) {
          linkMap.add({
            'title': link.text,
            'link': 'https://m.hupu.com/bbs' + link.attributes['href'],
          });
        }
        _hotsearchData.value = linkMap;
      }
      if (url.indexOf('xiaohongshu') != -1) {
        Document document = parse(response.data);
        List<Element> links = document.querySelectorAll('div.note-info > a');
        List<Map<String, dynamic>> linkMap = [];
        for (var link in links) {
          linkMap.add({
            'title': link.text,
            'link': 'https://www.xiaohongshu.com' + link.attributes['href'],
          });
        }
        _hotsearchData.value = linkMap;
      }
      if (url.indexOf('douban') != -1) {
        Document document = parse(response.data);
        List<Element> links;
        if (url.indexOf('gallery') != -1) {
          links = document.querySelectorAll('ul.trend > li > a');
        } else if (url.indexOf('explore') != -1) {
          links = document.querySelectorAll('div.bd > h3 > a');
        } else {
          links = document.querySelectorAll('li.rec_topics > a');
        }
        List<Map<String, dynamic>> linkMap = [];
        for (var link in links) {
          linkMap.add({
            'title': link.text,
            'link': link.attributes['href'],
          });
        }
        _hotsearchData.value = linkMap;
      }
    }
  }
}

//flutter解析接口返回的html
//https://blog.csdn.net/zheng0906/article/details/105689693
//https://itnext.io/write-your-first-web-scraper-in-dart-243c7bb4d05
