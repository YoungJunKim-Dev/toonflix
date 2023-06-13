import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';
import 'package:toonflix/widgets/image_card_widget.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  void onTapped(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetailScreen(title: title, thumb: thumb, id: id),
          fullscreenDialog: true,
        ));
  }

  const Webtoon(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapped(context),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Hero(tag: id, child: ImageCard(thumb: thumb)),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
