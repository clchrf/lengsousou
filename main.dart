import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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
    '''什麼職業比大學生厲害
鎖匠
因為他是研究所的''',
    '''曹操字孟德
劉備字玄德
伍佰字心得''',
    '''沈默是金下一句是什麼
今晚的康橋''',
    '''葡萄點名
葡萄柚''',
    '''超人保護地球
那誰保護城市
螢幕
因為螢幕保護程式''',
    '''海有幾層
十層
因為十層大海''',
    '''蛤蜊放很久會變成什麼
白酒蛤蜊''',
    '''中國歷代哪一個皇帝最漂亮
秦始皇
因為他暴政''',
    '''有一隻狗跪在冰上
結果變成貴賓狗''',
    '''水的媽媽是誰
水母''',
    '''什麼椅子最舒服？
enjoy''',
    '''哪一個按摩椅品牌最脆弱？
tokuyo
因為偷哭唷''',
    '''十二生肖哪隻動物不會感冒
雞
因為雞掃化痰''',
    '''什麼題目最時尚
非選題（fashion 題）''',
    '''白氣球揍了黑氣球一拳
黑氣球很痛很生氣於是決定
告白氣球''',
    '''有一天小明走著進超商
坐著輪椅出來
知道為什麼嗎
因為他繳費了''',
    '''為什麼泰國人都喜歡喝健康的沙瓦？
因為他們喜歡：沙瓦低卡～''',
    '''葡萄點名
葡萄柚''',
    '''為何有隻雞常常喜歡在墾丁岸邊吹海風？
因為他是一隻
吹風雞''',
    '''皮卡丘站起來變成什麼？
皮卡兵''',
    '''那皮卡丘左右跳呢？
皮卡乓乒乓乒乓''',
    '''皮卡丘跳遠
皮卡乒乓乒乓乒乓乒丘丘丘丘丘丘丘兵''',
    '''沈默是金下一句是什麼
今晚的康橋''',
    '''羊看到什麼東西會暴怒？
揚聲器''',
    '''在動物園抽煙 哪種動物會害怕？
火雞
因為抽煙要前準備打火機''',
    '''姊姊要生了！
這樣我能獲得什麼？
成舅感''',
    '''落枕要搭什麼車去醫院？
接駁車''',
    '''哈利波特住在哪裡?
燈泡裡
因為他是巫師''',
    '''超人保護地球，那誰保護城市？
螢幕
因為螢幕保護程式''',
    '''你走什麼路回家？
安全
安全是回家唯一的路''',
    '''蛤蜊放很久會變什麼？
白酒蛤蜊''',
    '''幾點不能講笑話
一點
一點都不好笑''',
    '''手機的媽媽是誰？
手機螢幕''',
    '''我一個朋友很喜歡稀有的東西 所以我送他
吸油面紙''',
    '''有一天貝殼回家了
他就說：
「I am back」''',
    '''警衛在笑什麼?
警衛在校門口''',
    '''哪一種水果最高貴
釋迦
貴族釋迦''',
    '''有一天螃蟹在沙灘上走著走著撞到了海龜
海龜說：
「你瞎子嗎」
螃蟹回：
「不！我是螃蟹」''',
    '''為何灰姑娘的車不易刮傷？
因為她的車是難刮馬車''',
    '''開什麼品牌車子的人最有禮貌？
Nissan
因為他們常常Nissan往來''',
    '''哪一個字需要寫很久
朋
因為一寫就要寫兩個月''',
    '''為什麼橄欖樹不能種在一起？
為了避免群聚橄欖''',
    '''富士山到底在哪裡？
在-42與-44之間''',
    '''媽媽帶小明去看醫生，
出了診間後，
媽媽：「醫生怎麼說？」
小明：「Doctor」''',
  ];

  Set<String> favorites = {};
  int currentJokeIndex = 0;

  void _showNextJoke() {
    HapticFeedback.mediumImpact();
    setState(() {
      currentJokeIndex = (currentJokeIndex + 1) % jokes.length;
    });
  }

  void _toggleFavorite() {
    setState(() {
      final joke = jokes[currentJokeIndex];
      if (favorites.contains(joke)) {
        favorites.remove(joke);
      } else {
        favorites.add(joke);
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
    final currentJoke = jokes[currentJokeIndex];
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
                Container(
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
                      onPressed: _showNextJoke,
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
