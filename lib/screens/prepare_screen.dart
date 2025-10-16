import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class PrepareScreen extends StatelessWidget {
  const PrepareScreen({super.key});

  void _showCopyFailureDialog(BuildContext context, String failedText) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withValues(alpha: 0.1),
                ),
                child: const Icon(Icons.error_outline, color: Colors.red, size: 40),
              ),
              const SizedBox(height: 24),
              Text(
                'クリップボードへのコピーに失敗しました',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'コピーできなかったコードは以下です。',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Container(
                 padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Text(
                    failedText,
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
               Text(
                '差し支えなければ、コードをコピーできなかった理由を教えていただけますか？',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'フィードバックを入力...',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                   enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('フィードバックを送信しました。'),
                       behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text('フィードバックを送信'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const String generatedDescription =
        '【商品説明】\n・スタークス社製のモダンなチェストです。\n・どんなお部屋にも合わせやすいミニマルなデザインが特徴です。\n・目立った傷や汚れはなく、状態は良好です。\n\n【サイズ】\n幅: 80cm\n奥行: 40cm\n高さ: 90cm\n\n#チェスト #収納家具 #モダン #スタークス';

    return Scaffold(
      appBar: AppBar(
        title: const Text('出品準備'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // 仮の画像
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '出品準備完了！',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'こちらの説明文をコピーして、\nフリマアプリに自動遷移します。',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                generatedDescription,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                try {
                  // コピー成功の処理
                  await Clipboard.setData(const ClipboardData(text: generatedDescription));
                  if (!context.mounted) {
                    return;
                  }
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text('コピーしました！'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                   // TODO: フリマアプリへの遷移処理を実装

                } catch (e) {
                  // コピー失敗の処理
                  if (!context.mounted) {
                    return;
                  }
                  _showCopyFailureDialog(context, '1234567890'); // 仮の失敗コード
                }
              },
              child: const Text('コピーして遷移'),
            ),
          ],
        ),
      ),
    );
  }
}
