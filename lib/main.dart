import 'package:flutter/material.dart';

void main() {
  runApp(const GoldenSpinApp());
}

class GoldenSpinApp extends StatelessWidget {
  const GoldenSpinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Golden Spin',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<int> history = [];
  final List<int> counts = List.filled(37, 0);

  void addNumber(int n) {
    setState(() {
      history.insert(0, n);
      counts[n]++;
    });
  }

  List<int> ranked() {
    final r = List.generate(37, (i) => i);
    r.sort((a, b) => counts[b].compareTo(counts[a]));
    return r;
  }

  @override
  Widget build(BuildContext context) {
    final r = ranked();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GOLDEN SPIN AI'),
        backgroundColor: Colors.black,
        foregroundColor: const Color(0xFFD4AF37),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(
                  'Son Çıkan: ${history.isEmpty ? "-" : history.first}',
                ),
                subtitle: Text(
                  history.take(10).join(' - '),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('🔥 Sıcak: ${r.take(4).join(", ")}'),
                    Text('❄️ Soğuk: ${r.reversed.take(4).join(", ")}'),
                    Text(
                      history.length < 5
                          ? '🤖 AI: Veri bekleniyor...'
                          : '🤖 AI: ${r.first} ve çevresi aktif olabilir',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 6,
                children: List.generate(37, (i) {
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4AF37),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () => addNumber(i),
                      child: Text('$i'),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
