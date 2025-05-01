import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const LengSouSouApp());

class LengSouSouApp extends StatelessWidget {
  const LengSouSouApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '冷搜搜',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF2F2F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF2F2F7),
          foregroundColor: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 22, color: Colors.black),
        ),
      ),
      home: const JokePage(),
    );
  }
}

class JokePage extends StatefulWidget {
  const JokePage({super.key});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  final List<String> jokes = [
    '今天去買早餐時，\n後面的人拍了我的肩說：\n「我先到欸！」\n於是我微慍道：\n「我流川楓欸」',
    '吉野櫻跟八重櫻差在哪\n.\n.\n.\n插在土裡',
    '水的媽媽是誰？\n【水母】',
    '你知道什麼是最舒服的椅子嗎？\n【enjoy】',
    '哪一個按摩椅品牌最脆弱？\n【tokuyo】\n因為偷～～哭～～～唷',
    '十二生肖哪隻動物不會感冒？\n【雞】因為雞掃化痰',
    '什麼題目最時尚？\n【非選題】（fashion 題）',
    '白氣球揍了黑氣球一拳，黑氣球很痛很生氣於是決定\n.\n.\n.\n告白氣球',
    '有一天小明走著進超商，坐著輪椅出來\n知道為什麼嗎？\n因為他繳費了',
    '學校請了一位外師在朝會時演講，\n外師為了考驗學生的會話能力，\n於是點了小明上台，\n小明：我不會啦\n同學：不管啦！過去試就對了\n(上台後)\n外師：How are you?\n小明：I was fine.（過去式就對了）'
  ];

  Set<String> favorites = {};
  String currentJoke = '';
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _showRandomJoke();
  }

  void _showRandomJoke() {
    setState(() => opacity = 0.0);
    Future.delayed(const Duration(milliseconds: 300), () {
      final random = Random();
      setState(() {
        currentJoke = jokes[random.nextInt(jokes.length)];
        opacity = 1.0;
      });
    });
  }

  void _toggleFavorite() {
    setState(() {
      if (favorites.contains(currentJoke)) {
        favorites.remove(currentJoke);
      } else {
        favorites.add(currentJoke);
      }
    });
  }

  void _openFavoritesPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FavoritesPage(favorites: favorites),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = favorites.contains(currentJoke);

    return Scaffold(
      appBar: AppBar(
        title: const Text('冷搜搜'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _openFavoritesPage,
            icon: const Icon(Icons.folder_open),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 430,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onHorizontalDragEnd: (_) => _showRandomJoke(),
                  onVerticalDragEnd: (_) => _showRandomJoke(),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: opacity,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Text(
                        currentJoke,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _toggleFavorite,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _showRandomJoke,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('再來一個！'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final Set<String> favorites;
  const FavoritesPage({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('已收藏')),
      body: favorites.isEmpty
          ? const Center(child: Text('你還沒有收藏任何笑話'))
          : ListView(
              padding: const EdgeInsets.all(24),
              children: favorites.map((joke) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Text(
                    joke,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              )).toList(),
            ),
    );
  }
}
