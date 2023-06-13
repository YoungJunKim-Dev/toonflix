import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EpisodeContainer extends StatelessWidget {
  final baseUrl = 'https://comic.naver.com/webtoon/detail';
  final String id;
  final String title;
  final String epNum;
  const EpisodeContainer(
      {super.key, required this.title, required this.id, required this.epNum});

  void onTapped() async {
    final webtoonUrl = Uri.parse('$baseUrl?titleId=$id&no=$epNum');
    print(webtoonUrl);
    await launchUrl(webtoonUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTapped,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.green),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.length <= 15 ? title : '${title.substring(0, 15)}...',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.chevron_right_sharp),
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
