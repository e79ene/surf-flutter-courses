import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Raleway'),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Моя визитка'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Profile(
                avatarImage: AssetImage('assets/profile.jpg'),
                name: 'Даша Птицина',
              ),
              const SizedBox(height: 20),
              About(
                items: [
                  AboutItem(
                    title: 'Разработка на Flutter',
                    text: 'Создаю самые разные кроссплатформенные приложения.',
                    icon: SvgPicture.asset('assets/flutter_logo.svg'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final ImageProvider<Object> avatarImage;
  final String name;

  const Profile({
    super.key,
    required this.avatarImage,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          foregroundImage: avatarImage,
          radius: 60,
        ),
        const SizedBox(width: 20),
        Text(name),
      ],
    );
  }
}

class AboutItem extends StatelessWidget {
  final String title;
  final String text;
  final Widget? icon;

  const AboutItem({
    super.key,
    required this.title,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox.square(
              dimension: 30,
              child: icon,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class About extends StatelessWidget {
  final List<AboutItem> items;

  const About({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'О себе / Увлечения',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        for (final item in items)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item,
              const SizedBox(height: 16),
            ],
          ),
      ],
    );
  }
}
