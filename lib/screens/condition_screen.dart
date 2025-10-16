import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConditionScreen extends StatefulWidget {
  const ConditionScreen({super.key});

  @override
  State<ConditionScreen> createState() => _ConditionScreenState();
}

class _ConditionScreenState extends State<ConditionScreen> {
  int? _selectedIndex;
  final List<String> _conditions = [
    '新品・未使用',
    '未使用に近い',
    '目立った傷や汚れなし',
    'やや傷や汚れあり',
    '傷や汚れあり',
    '全体的に状態が悪い',
  ];

  void _onConditionSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isSelected = _selectedIndex != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('商品の状態'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '出品する商品の状態を選択してください。',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.5,
                ),
                itemCount: _conditions.length,
                itemBuilder: (context, index) {
                  final bool isCurrentlySelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () => _onConditionSelected(index),
                    child: Card(
                      elevation: 0,
                      color: isCurrentlySelected
                          ? theme.colorScheme.primary.withValues(alpha: 0.1)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isCurrentlySelected
                              ? theme.colorScheme.primary
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _conditions[index],
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: isCurrentlySelected ? FontWeight.bold : FontWeight.normal,
                            color: isCurrentlySelected ? theme.colorScheme.primary : theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSelected
                    ? () => context.go('/prepare')
                    : null,
                style: ElevatedButton.styleFrom(
                   backgroundColor: isSelected ? theme.colorScheme.primary : Colors.grey.shade300,
                ),
                child: const Text('選択する'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
