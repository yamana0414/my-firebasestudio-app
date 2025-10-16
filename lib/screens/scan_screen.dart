import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ScanScreen extends StatelessWidget {
  final XFile? imageFile;

  const ScanScreen({super.key, this.imageFile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget imageWidget;
    if (imageFile != null) {
      if (kIsWeb) {
        imageWidget = Image.network(
          imageFile!.path,
          fit: BoxFit.cover,
        );
      } else {
        imageWidget = Image.file(
          File(imageFile!.path),
          fit: BoxFit.cover,
        );
      }
    } else {
      imageWidget = Image.network(
        'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        fit: BoxFit.cover,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('写真の確認'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/'),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: imageWidget,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 32.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => context.go('/'), // ホーム画面に戻るように修正
                    style: TextButton.styleFrom(
                      foregroundColor: theme.textTheme.bodyLarge?.color,
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('やり直す'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.go('/analysis'),
                    child: const Text('完了'),
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
