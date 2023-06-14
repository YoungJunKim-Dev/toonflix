import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/episode_container_widget.dart';
import 'package:toonflix/widgets/image_card_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late SharedPreferences prefs;
  bool isFavorite = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isFavorite = true;
        });
      }
    } else {
      await prefs.setStringList('likedToons', []);
    }
  }

  void onPressedFavorite() async {
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (isFavorite) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      await prefs.setStringList('likedToons', likedToons);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
    print("clicked");
    print(isFavorite);
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final Future<WebtoonDetailModel> detail = ApiService.getDetail(widget.id);
    final Future<List<WebtoonEpisodeModel>> episodes =
        ApiService.getEpisodes(widget.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: onPressedFavorite,
              icon: isFavorite
                  ? const Icon(Icons.favorite_outlined)
                  : const Icon(Icons.favorite_outline_outlined))
        ],
        elevation: 0,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(tag: widget.id, child: ImageCard(thumb: widget.thumb)),
              const SizedBox(
                height: 40,
              ),
              FutureBuilder(
                future: detail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var detailInfo = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('제목 : ${detailInfo.title}'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('상세내용 : ${detailInfo.about}'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            '장르 : ${detailInfo.genre} / 연령 : ${detailInfo.age}'),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final eps = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var ep in eps!)
                          EpisodeContainer(
                              title: ep.title, id: widget.id, epNum: ep.id)
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
