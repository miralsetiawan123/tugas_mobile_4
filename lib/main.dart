import 'package:flutter/material.dart';

void main() => runApp(const NewsApp());

// Palet light blue
const Color kDark = Color.fromARGB(255, 176, 15, 182);
const Color kMain = Color.fromARGB(255, 163, 20, 20);
const Color kLight = Color(0xFFBFE3FF);
const Color kSoft = Color(0xFFEAF6FF);

class NewsItem {
  final String title;
  final String category;
  final IconData icon;
  final List<Color> gradient;
  final String summary;
  final String readTime;
  final List<String> paragraphs;

  const NewsItem({
    required this.title,
    required this.category,
    required this.icon,
    required this.gradient,
    required this.summary,
    required this.readTime,
    required this.paragraphs,
  });
}

const List<NewsItem> allNews = [
  NewsItem(
    title: 'Elon Musk: Sosok di Balik Tesla, SpaceX, dan Starlink',
    category: 'Teknologi',
    icon: Icons.rocket_launch_rounded,
    gradient: [Color(0xFF3B9AE1), Color(0xFF7CC4F5)],
    summary: 'Mengenal perusahaan-perusahaan teknologi yang dipimpin Elon Musk dan pengaruhnya bagi dunia.',
    readTime: '3 menit baca',
    paragraphs: [
      'Elon Musk dikenal sebagai pemimpin sejumlah perusahaan teknologi besar. Tesla berfokus pada kendaraan listrik, sedangkan SpaceX mengembangkan roket yang dapat dipakai ulang untuk menekan biaya penerbangan luar angkasa.',
      'Dari SpaceX lahir pula layanan internet satelit Starlink, yang kini juga tersedia di Indonesia dan membantu menjangkau daerah yang sulit dijangkau kabel atau menara seluler.',
      'Musk juga memimpin platform media sosial X. Pandangan publik terhadapnya beragam: pendukung memuji keberanian berinovasi, sementara kritikus menyoroti gaya kepemimpinan dan berbagai kontroversinya.',
      'Terlepas dari pro dan kontra, perusahaan-perusahaannya mendorong percepatan teknologi kendaraan listrik dan eksplorasi antariksa, dua bidang yang dampaknya terasa secara global.',
    ],
  ),
  NewsItem(
    title: 'Kebakaran Hutan dan Lahan di Kalimantan: Mengapa Terus Berulang?',
    category: 'Lingkungan',
    icon: Icons.local_fire_department_rounded,
    gradient: [Color(0xFF2E7FC4), Color(0xFF63B5EE)],
    summary: 'Musim kemarau, lahan gambut, dan pembukaan lahan menjadi faktor utama kebakaran di Kalimantan.',
    readTime: '4 menit baca',
    paragraphs: [
      'Kebakaran hutan dan lahan (karhutla) kerap terjadi di Kalimantan saat musim kemarau. Kondisi tanah yang kering membuat api mudah menyebar, terutama di lahan gambut yang menyimpan banyak bahan mudah terbakar.',
      'Api di lahan gambut sulit dipadamkan karena dapat membara di bawah permukaan. Kebakaran seperti ini menghasilkan asap pekat yang bertahan lama.',
      'Dampaknya luas: kualitas udara menurun, gangguan pernapasan (ISPA) meningkat, jarak pandang berkurang sehingga penerbangan dan transportasi terganggu, dan keanekaragaman hayati terancam.',
      'Upaya pencegahan mencakup patroli desa, pembasahan kembali lahan gambut, pemantauan titik panas lewat satelit, dan penegakan hukum terhadap pembakaran lahan yang disengaja. Masyarakat juga diimbau tidak membuka lahan dengan cara membakar.',
    ],
  ),
  NewsItem(
    title: 'Kelangkaan BBM di Indonesia: Penyebab dan Cara Menyikapinya',
    category: 'Energi',
    icon: Icons.local_gas_station_rounded,
    gradient: [Color(0xFF1F6FB5), Color(0xFF5AAFEA)],
    summary: 'Gangguan distribusi, cuaca, dan lonjakan permintaan bisa memicu antrean panjang di SPBU.',
    readTime: '3 menit baca',
    paragraphs: [
      'Kelangkaan bahan bakar minyak (BBM) di suatu daerah biasanya dipicu beberapa hal: gangguan distribusi, cuaca buruk yang menghambat pengiriman ke wilayah kepulauan, atau lonjakan permintaan yang tiba-tiba.',
      'Indonesia adalah negara kepulauan, sehingga rantai pasok BBM melibatkan kapal, truk tangki, dan depot di banyak titik. Hambatan di satu titik dapat berdampak pada antrean di SPBU sekitarnya.',
      'Akibatnya, antrean kendaraan memanjang, harga eceran di tingkat pengecer dapat naik, dan aktivitas ekonomi seperti angkutan barang ikut terganggu.',
      'Masyarakat disarankan membeli secukupnya, tidak melakukan pembelian panik (panic buying), dan memantau informasi resmi dari penyedia BBM serta pemerintah daerah.',
    ],
  ),
];

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita Biru',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kMain),
        scaffoldBackgroundColor: kSoft,
      ),
      home: const NewsScreen(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final ScrollController _controller = ScrollController();
  bool _showBackToTop = false;
  String _selected = 'Semua';

  final List<String> _categories = [
    'Semua',
    'Teknologi',
    'Lingkungan',
    'Energi',
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final show = _controller.hasClients && _controller.offset > 250;
    if (show != _showBackToTop) setState(() => _showBackToTop = show);
  }

  void _scrollToTop() {
    _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Pull-to-refresh (simulasi memuat ulang)
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Berita diperbarui'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = _selected == 'Semua'
        ? allNews
        : allNews.where((n) => n.category == _selected).toList();

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          _buildChips(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                controller: _controller,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: list.length,
                itemBuilder: (context, i) => _NewsCard(
                  item: list[i],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(item: list[i]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedScale(
        scale: _showBackToTop ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: _showBackToTop ? _scrollToTop : null,
          backgroundColor: kMain,
          foregroundColor: Colors.white,
          tooltip: 'Kembali ke atas',
          child: const Icon(Icons.keyboard_arrow_up_rounded, size: 30),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 18,
        20,
        24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kMain, kLight],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(200),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.newspaper_rounded, color: kDark, size: 30),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BERITA BIRU',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    color: kDark,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Kabar pilihan hari ini',
                  style: TextStyle(fontSize: 13, color: kDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChips() {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final c = _categories[i];
          final active = c == _selected;
          return ChoiceChip(
            label: Text(c),
            selected: active,
            onSelected: (_) => setState(() => _selected = c),
            selectedColor: kMain,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: active ? Colors.white : kDark,
              fontWeight: FontWeight.w600,
            ),
            side: BorderSide(color: kMain.withAlpha(80)),
            showCheckmark: false,
          );
        },
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final NewsItem item;
  final VoidCallback onTap;

  const _NewsCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: kMain.withAlpha(50),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: item.gradient,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -10,
                    bottom: -20,
                    child: Icon(
                      item.icon,
                      size: 140,
                      color: Colors.white.withAlpha(60),
                    ),
                  ),
                  Center(child: Icon(item.icon, size: 56, color: Colors.white)),
                  Positioned(
                    left: 14,
                    top: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(220),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item.category,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: kDark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.35,
                      fontWeight: FontWeight.w800,
                      color: kDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.summary,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13.5,
                      height: 1.5,
                      color: Color(0xFF4F6A85),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 15,
                        color: kMain,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        item.readTime,
                        style: const TextStyle(fontSize: 12, color: kMain),
                      ),
                      const Spacer(),
                      const Text(
                        'Baca selengkapnya',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: kMain,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: kMain,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final NewsItem item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 220,
            backgroundColor: kMain,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: item.gradient,
                  ),
                ),
                child: Center(
                  child: Icon(item.icon, size: 90, color: Colors.white),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: kLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.category,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: kDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 24,
                      height: 1.3,
                      fontWeight: FontWeight.w800,
                      color: kDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 16,
                        color: kMain,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.readTime,
                        style: const TextStyle(fontSize: 12, color: kMain),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  for (final p in item.paragraphs)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        p,
                        style: const TextStyle(
                          fontSize: 15.5,
                          height: 1.75,
                          color: Color(0xFF2B4560),
                        ),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: kLight.withAlpha(120),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline_rounded, color: kDark),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Konten contoh untuk keperluan tugas, bukan berita aktual.',
                            style: TextStyle(fontSize: 12.5, color: kDark),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
