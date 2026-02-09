import 'package:flutter/material.dart';

void main() {
  runApp(const PasswordManagerApp());
}

class PasswordManagerApp extends StatelessWidget {
  const PasswordManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luxury Password Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4AF37), // Màu vàng Gold sang trọng
          brightness: Brightness.dark,
          primary: const Color(0xFFD4AF37),
          surface: const Color(0xFF1A1A1A),
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F0F0F),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFFD4AF37),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        cardTheme: CardThemeData( // Sửa lỗi CardTheme ở đây
          color: const Color(0xFF1E1E1E),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF333333), width: 0.5),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF252525),
          labelStyle: const TextStyle(color: Color(0xFFD4AF37)),
          prefixIconColor: const Color(0xFFD4AF37),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 1),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class PasswordEntry {
  final String appName;
  final String username;
  final String password;

  PasswordEntry({
    required this.appName,
    required this.username,
    required this.password,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PasswordEntry> _passwords = [];

  void _addPassword(String app, String user, String pass) {
    setState(() {
      _passwords.add(PasswordEntry(appName: app, username: user, password: pass));
    });
  }

  void _showAddDialog() {
    final appController = TextEditingController();
    final userController = TextEditingController();
    final passController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          border: Border(top: BorderSide(color: Color(0xFFD4AF37), width: 1)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 30,
          left: 24,
          right: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'THÊM BẢO MẬT MỚI',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4AF37),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: appController,
              decoration: const InputDecoration(
                labelText: 'Tên Ứng dụng',
                prefixIcon: Icon(Icons.apps),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: userController,
              decoration: const InputDecoration(
                labelText: 'Tên đăng nhập',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              onPressed: () {
                if (appController.text.isNotEmpty &&
                    userController.text.isNotEmpty &&
                    passController.text.isNotEmpty) {
                  _addPassword(
                    appController.text,
                    userController.text,
                    passController.text,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'LƯU TRỮ AN TOÀN',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GOLDEN VAULT'),
        actions: [
          IconButton(
            icon: const Icon(Icons.security, color: Color(0xFFD4AF37)),
            onPressed: () {},
          )
        ],
      ),
      body: _passwords.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shield_rounded, size: 100, color: Color(0xFF1E1E1E)),
                  const SizedBox(height: 20),
                  Text(
                    'Két sắt hiện đang trống',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16, letterSpacing: 1.1),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _passwords.length,
              itemBuilder: (context, index) {
                final item = _passwords[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: const Color(0xFFD4AF37), width: 0.5),
                        ),
                        child: const Icon(Icons.vpn_key_rounded, color: Color(0xFFD4AF37)),
                      ),
                      title: Text(
                        item.appName.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFFD4AF37),
                          letterSpacing: 1.2,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.person, size: 14, color: Colors.grey),
                              const SizedBox(width: 5),
                              Text(item.username, style: const TextStyle(color: Colors.white70)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Row(
                            children: [
                              Icon(Icons.circle, size: 8, color: Colors.grey),
                              Icon(Icons.circle, size: 8, color: Colors.grey),
                              Icon(Icons.circle, size: 8, color: Colors.grey),
                              Icon(Icons.circle, size: 8, color: Colors.grey),
                              Icon(Icons.circle, size: 8, color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.copy_rounded, color: Colors.grey),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Đã sao chép mật khẩu vào bộ nhớ tạm'),
                              backgroundColor: Color(0xFF1E1E1E),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        backgroundColor: const Color(0xFFD4AF37),
        foregroundColor: Colors.black,
        elevation: 10,
        icon: const Icon(Icons.add, fontWeight: FontWeight.bold),
        label: const Text('THÊM MỚI', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
