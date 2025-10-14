import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('アイテムを見つける'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.go('/'), // ホーム画面に戻るように修正
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // 仮の画像
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // 仮の値札
                  Positioned(
                    top: size.height * 0.1,
                    left: size.width * 0.2,
                    child: _buildPriceTag(context, '¥8,000~¥9,000'),
                  ),
                  Positioned(
                    top: size.height * 0.2,
                    left: size.width * 0.5,
                    child: _buildPriceTag(context, '¥10,000~¥15,000'),
                  ),
                   Positioned(
                    top: size.height * 0.25,
                    left: size.width * 0.1,
                    child: _buildPriceTag(context, '¥1,000~¥2,000'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    '3個のアイテムを発見！',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      text: '推定総額 ',
                      style: theme.textTheme.headlineSmall,
                      children: <TextSpan>[
                        TextSpan(
                          text: '¥19,000~¥26,000',
                          style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                   const SizedBox(height: 8),
                  Text(
                    '値段の高いアイテムをタップして詳細を確認しよう。',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
       // TODO: ボトムナビゲーションの実装
    );
  }

  Widget _buildPriceTag(BuildContext context, String price) {
    return GestureDetector(
      onTap: () => context.go('/item/1'), // 仮のIDで遷移
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          price,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
