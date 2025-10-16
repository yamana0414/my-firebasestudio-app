import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _sendPasswordReset(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user?.email == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('メールアドレスを確認できませんでした')),
      );
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);
      // ログインユーザーでも再設定メールは送れる（プロバイダにより不可の場合あり）
      // UX的には「送信しました」の通知のみ
      // 実施後の画面遷移は不要
      // 送れない場合はエラーハンドリング
      // （ここではシンプルなトースト）
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('パスワード再設定メールを送信しました')),
      );
    } catch (_) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('送信に失敗しました')),
      );
    }
  }

  Future<void> _openPrivacy() async {
    final uri = Uri.parse('https://example.com/privacy');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const ListTile(
        title: Text('アカウント情報'),
        subtitle: Text('メールアドレスなど'),
        // onTap: () => Navigator.push(...), // 必要に応じて詳細画面を用意
      ),
      ListTile(
        title: const Text('パスワードの再設定'),
        onTap: () => _sendPasswordReset(context),
      ),
      const ListTile(
        title: Text('通知設定'),
        // onTap: () {},
      ),
      ListTile(
        title: const Text('プライバシーポリシー'),
        onTap: _openPrivacy,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemBuilder: (c, i) => items[i],
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemCount: items.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade700,
                    side: BorderSide(color: Colors.red.shade300),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('ログアウトしました')),
                    );
                  },
                  child: const Text('ログアウト'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}