import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LeitnerApp());
}

Future<void> openExternalProfile(BuildContext context, String urlString) async {
  final uri = Uri.parse(urlString);
  final launched = await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Havolani ochib bo\'lmadi: $urlString')),
    );
  }
}

class LeitnerApp extends StatelessWidget {
  const LeitnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'So\'z Yodlash (Leitner)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3949AB),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F6FB),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A1B4B),
              Color(0xFF2E3192),
              Color(0xFF4A3AFF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                const Spacer(flex: 2),
                // Yuqori emblemasi va animatsiya
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 24 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.auto_stories_rounded,
                          size: 62,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 26,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.24),
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Assalomu alaykum!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Bizni tanlaganingiz uchun rahmat,\nsizga omad tilayman!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.5,
                                height: 1.45,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.92),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Boshlash tugmasi
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF2E3192),
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          icon: const Icon(Icons.rocket_launch_rounded, size: 22),
                          label: const Text(
                            'Boshlash',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 3),
                // Eng pastki qism: Created by Alliy va bosiladigan Telegram/Instagram
                Column(
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        // Telegram tugmasi
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => openExternalProfile(
                              context,
                              'https://t.me/marigolw',
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.35),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF229ED9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.send_rounded,
                                      size: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '@marigolw',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Instagram tugmasi
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => openExternalProfile(
                              context,
                              'https://instagram.com/alliy.772',
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.35),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFF58529),
                                          Color(0xFFDD2A7B),
                                          Color(0xFF8134AF),
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt_rounded,
                                      size: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '@alliy.772',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: 14,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Created by Alliy',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.85),
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
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

class WordItem {
  final String id;
  final String word;
  final String translation;
  int level;
  int correctCount;
  int chancesLeft;
  DateTime nextReview;

  WordItem({
    required this.id,
    required this.word,
    required this.translation,
    this.level = 1,
    this.correctCount = 0,
    this.chancesLeft = 2,
    required this.nextReview,
  });

  bool get isDue {
    if (level == 1) return true;
    return !nextReview.isAfter(DateTime.now());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'word': word,
        'translation': translation,
        'level': level,
        'correctCount': correctCount,
        'chancesLeft': chancesLeft,
        'nextReview': nextReview.toIso8601String(),
      };

  factory WordItem.fromJson(Map<String, dynamic> json) => WordItem(
        id: json['id'] as String,
        word: json['word'] as String,
        translation: json['translation'] as String,
        level: json['level'] as int,
        correctCount: (json['correctCount'] as int?) ?? 0,
        chancesLeft: (json['chancesLeft'] as int?) ?? 2,
        nextReview: DateTime.parse(json['nextReview'] as String),
      );
}

class SectionInfo {
  final int level;
  final String title;
  final String subtitle;
  final int days;
  final List<Color> gradient;
  final Color accentColor;
  final IconData icon;

  const SectionInfo({
    required this.level,
    required this.title,
    required this.subtitle,
    required this.days,
    required this.gradient,
    required this.accentColor,
    required this.icon,
  });
}

class CreatorFooter extends StatelessWidget {
  const CreatorFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome,
                size: 15,
                color: Colors.indigo.shade600,
              ),
              const SizedBox(width: 6),
              Text(
                'Created by Alliy',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey.shade800,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          Flexible(
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              alignment: WrapAlignment.end,
              children: [
                // Bosiladigan Telegram stikeri
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => openExternalProfile(
                      context,
                      'https://t.me/marigolw',
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF229ED9).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              const Color(0xFF229ED9).withValues(alpha: 0.35),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 17,
                            height: 17,
                            decoration: const BoxDecoration(
                              color: Color(0xFF229ED9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.send_rounded,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '@marigolw',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1779A8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Bosiladigan Instagram stikeri
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => openExternalProfile(
                      context,
                      'https://instagram.com/alliy.772',
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDD2A7B).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              const Color(0xFFDD2A7B).withValues(alpha: 0.35),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 17,
                            height: 17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFF58529),
                                  Color(0xFFDD2A7B),
                                  Color(0xFF8134AF),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 11,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '@alliy.772',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFB81D65),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WordItem> _words = [];
  bool _isLoading = true;

  final List<SectionInfo> _sections = const [
    SectionInfo(
      level: 1,
      title: '1-bo\'lim: Har kuni',
      subtitle: '3 marta to\'g\'ri topilguncha cheksiz mashq',
      days: 1,
      gradient: [Color(0xFF3949AB), Color(0xFF5E35B1)],
      accentColor: Color(0xFF3949AB),
      icon: Icons.bolt,
    ),
    SectionInfo(
      level: 2,
      title: '2-bo\'lim: 1 haftada',
      subtitle: 'Har 7 kunda • 2 ta imkoniyat',
      days: 7,
      gradient: [Color(0xFF00897B), Color(0xFF00ACC1)],
      accentColor: Color(0xFF00897B),
      icon: Icons.date_range,
    ),
    SectionInfo(
      level: 3,
      title: '3-bo\'lim: 2 haftada',
      subtitle: 'Har 14 kunda • 2 ta imkoniyat',
      days: 14,
      gradient: [Color(0xFFFB8C00), Color(0xFFF4511E)],
      accentColor: Color(0xFFEF6C00),
      icon: Icons.event_repeat,
    ),
    SectionInfo(
      level: 4,
      title: '4-bo\'lim: 1 oyda',
      subtitle: 'Har 30 kunda • 2 ta imkoniyat',
      days: 30,
      gradient: [Color(0xFF2E7D32), Color(0xFF43A047)],
      accentColor: Color(0xFF2E7D32),
      icon: Icons.verified,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  Future<void> _loadWords() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList('leitner_words') ?? [];
    setState(() {
      _words = rawList
          .map((item) =>
              WordItem.fromJson(jsonDecode(item) as Map<String, dynamic>))
          .toList();
      _isLoading = false;
    });
  }

  Future<void> _saveWords() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = _words.map((w) => jsonEncode(w.toJson())).toList();
    await prefs.setStringList('leitner_words', rawList);
    if (mounted) setState(() {});
  }

  void _showAddWordDialog() {
    final wordController = TextEditingController();
    final translationController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Yangi so\'z qo\'shish'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: wordController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'So\'z (masalan: der Apfel)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: translationController,
              decoration: const InputDecoration(
                labelText: 'Tarjimasi (masalan: olma)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Bekor qilish'),
          ),
          FilledButton(
            onPressed: () {
              final w = wordController.text.trim();
              final t = translationController.text.trim();
              if (w.isNotEmpty && t.isNotEmpty) {
                _words.add(
                  WordItem(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    word: w,
                    translation: t,
                    level: 1,
                    correctCount: 0,
                    chancesLeft: 2,
                    nextReview: DateTime.now(),
                  ),
                );
                _saveWords();
                Navigator.pop(ctx);
              }
            },
            child: const Text('Saqlash'),
          ),
        ],
      ),
    );
  }

  void _openSection(SectionInfo section) {
    final levelWords = _words.where((w) => w.level == section.level).toList();
    if (levelWords.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bu bo\'limda hozircha so\'z yo\'q.'),
        ),
      );
      return;
    }

    final dueWords = levelWords.where((w) => w.isDue).toList();
    if (dueWords.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Hali takrorlash vaqti kelmagan'),
          content: Text(
            'Ushbu bo\'limdagi ${levelWords.length} ta so\'zning keyingi takrorlash vaqti hali kelmadi. Shunga qaramay hozir mashq qilasizmi?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Keyinroq'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(ctx);
                _launchReview(section, levelWords);
              },
              child: const Text('Hozir mashq qilish'),
            ),
          ],
        ),
      );
      return;
    }

    _launchReview(section, dueWords);
  }

  void _launchReview(SectionInfo section, List<WordItem> sessionWords) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReviewScreen(
          section: section,
          sessionWords: sessionWords,
          allWords: _words,
          onUpdate: _saveWords,
        ),
      ),
    );
  }

  void _openAllWordsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AllWordsScreen(
          words: _words,
          onDelete: (id) {
            _words.removeWhere((w) => w.id == id);
            _saveWords();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'So\'z Yodlash',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Barcha so\'zlar',
            icon: const Icon(Icons.list_alt),
            onPressed: _openAllWordsScreen,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 84),
              itemCount: _sections.length,
              itemBuilder: (context, index) {
                final section = _sections[index];
                final totalCount =
                    _words.where((w) => w.level == section.level).length;
                final dueCount = _words
                    .where((w) => w.level == section.level && w.isDue)
                    .length;

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: section.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: section.accentColor.withValues(alpha: 0.28),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => _openSection(section),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                section.icon,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    section.title,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    section.subtitle,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          Colors.white.withValues(alpha: 0.9),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Jami so\'zlar: $totalCount ta',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Colors.white.withValues(alpha: 0.85),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (dueCount > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '$dueCount ta',
                                  style: TextStyle(
                                    color: section.accentColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            else
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddWordDialog,
        icon: const Icon(Icons.add),
        label: const Text('So\'z qo\'shish'),
      ),
      bottomNavigationBar: const CreatorFooter(),
    );
  }
}

class ReviewScreen extends StatefulWidget {
  final SectionInfo section;
  final List<WordItem> sessionWords;
  final List<WordItem> allWords;
  final Future<void> Function() onUpdate;

  const ReviewScreen({
    super.key,
    required this.section,
    required this.sessionWords,
    required this.allWords,
    required this.onUpdate,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final Random _random = Random();
  late List<WordItem> _queue;
  bool _revealAfterCheck = false;
  bool _useTypingMode = true;
  bool _isChecking = false;
  String? _selectedOption;
  bool? _lastAnswerCorrect;
  String? _statusBanner;
  Color _statusBannerColor = Colors.indigo;
  List<String> _currentOptions = [];
  final TextEditingController _typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _queue = List<WordItem>.from(widget.sessionWords)..shuffle(_random);
    _prepareCurrentCard();
  }

  @override
  void dispose() {
    _typeController.dispose();
    super.dispose();
  }

  int _daysForLevel(int level) {
    switch (level) {
      case 1:
        return 1;
      case 2:
        return 7;
      case 3:
        return 14;
      default:
        return 30;
    }
  }

  void _prepareCurrentCard() {
    _revealAfterCheck = false;
    _isChecking = false;
    _selectedOption = null;
    _lastAnswerCorrect = null;
    _statusBanner = null;
    _typeController.clear();

    if (_queue.isEmpty) return;

    final current = _queue.first;
    final otherTranslations = widget.allWords
        .where((w) =>
            w.id != current.id &&
            w.translation.toLowerCase() != current.translation.toLowerCase())
        .map((w) => w.translation)
        .toSet()
        .toList()
      ..shuffle(_random);

    final options = <String>[current.translation];
    options.addAll(otherTranslations.take(3));
    options.shuffle(_random);
    _currentOptions = options;
  }

  void _reinsertNonConsecutive(WordItem word) {
    if (_queue.isEmpty) {
      _queue.add(word);
    } else {
      final insertIndex = 1 + _random.nextInt(_queue.length);
      _queue.insert(insertIndex, word);
    }
  }

  Future<void> _submitAnswer(bool isCorrect, {String? chosenOption}) async {
    if (_isChecking || _queue.isEmpty) return;

    final currentWord = _queue.removeAt(0);
    String? bannerText;
    Color bannerColor = Colors.green.shade700;

    if (isCorrect) {
      currentWord.correctCount += 1;
      if (currentWord.correctCount >= 3) {
        final oldLevel = currentWord.level;
        final nextLevel = oldLevel < 4 ? oldLevel + 1 : 4;
        currentWord.level = nextLevel;
        currentWord.correctCount = 0;
        currentWord.chancesLeft = 2;
        currentWord.nextReview =
            DateTime.now().add(Duration(days: _daysForLevel(nextLevel)));

        bannerText = oldLevel < 4
            ? 'To\'g\'ri (3/3)! So\'z $nextLevel-bo\'limga o\'tdi!'
            : 'To\'g\'ri (3/3)! 1 oylik mustahkamlash yakunlandi!';
        bannerColor = Colors.green.shade700;
      } else {
        _reinsertNonConsecutive(currentWord);
        bannerText =
            'To\'g\'ri (${currentWord.correctCount}/3)! Yana ${3 - currentWord.correctCount} marta qoldi.';
        bannerColor = Colors.teal.shade700;
      }
    } else {
      currentWord.correctCount = 0;

      if (currentWord.level == 1) {
        currentWord.nextReview = DateTime.now();
        _reinsertNonConsecutive(currentWord);
        bannerText =
            'Noto\'g\'ri! To\'g\'ri javob: "${currentWord.translation}" (0/3)';
        bannerColor = Colors.red.shade700;
      } else {
        currentWord.chancesLeft -= 1;

        if (currentWord.chancesLeft > 0) {
          _reinsertNonConsecutive(currentWord);
          bannerText =
              'Noto\'g\'ri! To\'g\'ri javob: "${currentWord.translation}". Yana ${currentWord.chancesLeft} ta imkon qoldi.';
          bannerColor = Colors.orange.shade800;
        } else {
          currentWord.level = currentWord.level - 1;
          currentWord.chancesLeft = 2;
          currentWord.correctCount = 0;
          currentWord.nextReview = DateTime.now();

          bannerText =
              'Noto\'g\'ri! To\'g\'ri javob: "${currentWord.translation}". So\'z ${currentWord.level}-bo\'limga siljidi.';
          bannerColor = Colors.red.shade700;
        }
      }
    }

    setState(() {
      _isChecking = true;
      _selectedOption = chosenOption;
      _lastAnswerCorrect = isCorrect;
      _revealAfterCheck = true;
      _statusBanner = bannerText;
      _statusBannerColor = bannerColor;
    });

    await widget.onUpdate();
    await Future.delayed(Duration(milliseconds: isCorrect ? 1000 : 2000));
    if (!mounted) return;

    setState(() {
      _prepareCurrentCard();
    });
  }

  void _checkTypedAnswer() {
    if (_queue.isEmpty) return;
    final userInput = _typeController.text.trim().toLowerCase();
    if (userInput.isEmpty) return;
    final expected = _queue.first.translation.trim().toLowerCase();
    _submitAnswer(userInput == expected);
  }

  @override
  Widget build(BuildContext context) {
    final isFinished = _queue.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.section.title),
        actions: [
          if (!isFinished && widget.allWords.length >= 2)
            IconButton(
              tooltip: _useTypingMode
                  ? 'Variant tanlash rejimiga o\'tish'
                  : 'Yozib topish rejimiga o\'tish',
              icon: Icon(_useTypingMode ? Icons.grid_view : Icons.keyboard),
              onPressed: () {
                setState(() {
                  _useTypingMode = !_useTypingMode;
                });
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: isFinished
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.celebration,
                        size: 76, color: Colors.green),
                    const SizedBox(height: 16),
                    const Text(
                      'Ushbu bo\'limdagi mashg\'ulot yakunlandi!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Bosh sahifaga qaytish'),
                    ),
                  ],
                ),
              )
            : Builder(
                builder: (context) {
                  final current = _queue.first;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Bosqich: ',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              ...List.generate(3, (i) {
                                final filled = i < current.correctCount;
                                return Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Icon(
                                    filled
                                        ? Icons.check_circle
                                        : Icons.radio_button_unchecked,
                                    size: 19,
                                    color: filled
                                        ? Colors.green.shade600
                                        : Colors.grey.shade400,
                                  ),
                                );
                              }),
                              Text(
                                ' (${current.correctCount}/3)',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if (current.level > 1)
                            Row(
                              children: [
                                const Text(
                                  'Imkon: ',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                ...List.generate(2, (i) {
                                  final hasChance = i < current.chancesLeft;
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Icon(
                                      hasChance
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 20,
                                      color: hasChance
                                          ? Colors.red.shade600
                                          : Colors.grey.shade400,
                                    ),
                                  );
                                }),
                              ],
                            )
                          else
                            Text(
                              'Navbatda: ${_queue.length}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (_statusBanner != null)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: _statusBannerColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _statusBanner!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.5,
                            ),
                          ),
                        ),
                      Expanded(
                        flex: 5,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: _revealAfterCheck
                                  ? [
                                      const Color(0xFF1E293B),
                                      const Color(0xFF334155),
                                    ]
                                  : widget.section.gradient,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: widget.section.accentColor
                                    .withValues(alpha: 0.3),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                current.word,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              if (_revealAfterCheck) ...[
                                const SizedBox(height: 18),
                                Divider(
                                    color: Colors.white.withValues(alpha: 0.3)),
                                const SizedBox(height: 12),
                                Text(
                                  'To\'g\'ri javob:',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withValues(alpha: 0.75),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  current.translation,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: _lastAnswerCorrect == true
                                        ? const Color(0xFF86EFAC)
                                        : const Color(0xFFFDE047),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        flex: 5,
                        child: _useTypingMode
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller: _typeController,
                                    autofocus: true,
                                    enabled: !_isChecking,
                                    onSubmitted: (_) => _checkTypedAnswer(),
                                    decoration: InputDecoration(
                                      labelText: 'Tarjimasini yozing...',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: _isChecking
                                              ? null
                                              : () => _submitAnswer(false),
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14),
                                          ),
                                          child: const Text('Bilmadim'),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: FilledButton(
                                          onPressed: _isChecking
                                              ? null
                                              : _checkTypedAnswer,
                                          style: FilledButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14),
                                          ),
                                          child: const Text('Tekshirish'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'To\'g\'ri tarjimani tanlang:',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ..._currentOptions.map((option) {
                                    final isCorrectOption =
                                        option == current.translation;
                                    final isSelected =
                                        option == _selectedOption;

                                    Color bgColor = Colors.white;
                                    Color fgColor = Colors.black87;
                                    Color borderColor = Colors.grey.shade300;

                                    if (_isChecking) {
                                      if (isCorrectOption) {
                                        bgColor = Colors.green.shade600;
                                        fgColor = Colors.white;
                                        borderColor = Colors.green.shade600;
                                      } else if (isSelected &&
                                          _lastAnswerCorrect == false) {
                                        bgColor = Colors.red.shade600;
                                        fgColor = Colors.white;
                                        borderColor = Colors.red.shade600;
                                      }
                                    }

                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: bgColor,
                                          foregroundColor: fgColor,
                                          side: BorderSide(
                                              color: borderColor, width: 1.5),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14, horizontal: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                        ),
                                        onPressed: _isChecking
                                            ? null
                                            : () => _submitAnswer(
                                                  isCorrectOption,
                                                  chosenOption: option,
                                                ),
                                        child: Text(
                                          option,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                      ),
                    ],
                  );
                },
              ),
      ),
      bottomNavigationBar: const CreatorFooter(),
    );
  }
}

class AllWordsScreen extends StatefulWidget {
  final List<WordItem> words;
  final void Function(String id) onDelete;

  const AllWordsScreen({
    super.key,
    required this.words,
    required this.onDelete,
  });

  @override
  State<AllWordsScreen> createState() => _AllWordsScreenState();
}

class _AllWordsScreenState extends State<AllWordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcha so\'zlar')),
      body: widget.words.isEmpty
          ? const Center(child: Text('Hozircha birorta ham so\'z qo\'shilmagan.'))
          : ListView.separated(
              itemCount: widget.words.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = widget.words[index];
                final chanceInfo = item.level > 1
                    ? ' • Imkoniyat: ${item.chancesLeft}/2'
                    : '';
                return ListTile(
                  title: Text(
                    item.word,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${item.translation} • ${item.level}-bo\'lim (${item.correctCount}/3)$chanceInfo',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      widget.onDelete(item.id);
                      setState(() {});
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: const CreatorFooter(),
    );
  }
}