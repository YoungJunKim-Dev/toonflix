//단순히 get을 사용하면 헤깔릴까봐
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    final List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    } else {
      throw Error();
    }
  }

  static Future<WebtoonDetailModel> getDetail(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoonDetail = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoonDetail);
    } else {
      throw Error();
    }
  }

  static Future<List<WebtoonEpisodeModel>> getEpisodes(String id) async {
    List<WebtoonEpisodeModel> episodes = [];

    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    final episodeList = jsonDecode(response.body);
    for (var episode in episodeList) {
      episodes.add(WebtoonEpisodeModel.fromJson(episode));
    }
    return episodes;
  }
}
