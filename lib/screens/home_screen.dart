
import 'package:flutter/material.dart';
import 'preview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textController = TextEditingController();
  double fontSize = 16;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> openPreview() async {
    // Отримуємо результат після закриття другого екрана.
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(
          text: textController.text,
          fontSize: fontSize,
        ),
      ),
    );

    if (!mounted) return;

    String message;

    if (result == 'ok') {
      message = 'Cool!';
    } else if (result == 'cancel') {
      message = 'Let’s try something else';
    } else {
      message = "Don't know what to say";
    }

    // Робот з'являється лише в діалоговому вікні.
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFFFFF7FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/robot.png',
              width: 60,
              height: 60,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text previewer',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'Text',
                  helperText: 'Enter some text',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('Font size: ${fontSize.round()}'),
                  Expanded(
                    child: Slider(
                      value: fontSize,
                      min: 8,
                      max: 100,
                      divisions: 92,
                      activeColor: const Color(0xFF66508A),
                      onChanged: (value) {
                        setState(() {
                          fontSize = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: openPreview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF66508A),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Preview'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
