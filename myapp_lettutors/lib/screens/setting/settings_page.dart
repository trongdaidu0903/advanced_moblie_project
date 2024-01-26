import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:myapp_lettutors/constants/routes.dart';
import 'package:myapp_lettutors/models/languages/lang_en.dart';
import 'package:myapp_lettutors/models/languages/lang_vi.dart';
import 'package:myapp_lettutors/providers/app_provider.dart';
import 'package:myapp_lettutors/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String chosenLanguage = 'English';

  void _loadLanguage(AppProvider appProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('language') ?? 'EN';
    if (lang == 'EN') {
      chosenLanguage = 'English';
      appProvider.setLanguage(English());
    } else {
      chosenLanguage = 'Tiếng Việt';
      appProvider.setLanguage(Vietnamese());
    }
  }

  void _updateLanguage(AppProvider appProvider, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value == 'English') {
      appProvider.language = English();
      await prefs.setString('language', 'EN');
    } else {
      appProvider.language = Vietnamese();
      await prefs.setString('language', 'VI');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final appProvider = context.watch<AppProvider>();
    final lang = appProvider.language;
    _loadLanguage(appProvider);
    _loadTheme(appProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => {Navigator.pushNamed(context, Routes.userProfile)},
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.manage_accounts,
                      size: 30,
                      color: Colors.blue[600],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      lang.account,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(lang.selectLanguage),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('English'),
                          onTap: () {
                            _updateLanguage(appProvider, 'English');
                            Navigator.pop(context); // Ẩn hộp thoại
                          },
                        ),
                        ListTile(
                          title: const Text('Tiếng Việt'),
                          onTap: () {
                            _updateLanguage(appProvider, 'Tiếng Việt');
                            Navigator.pop(context); // Ẩn hộp thoại
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.language,
                      size: 30,
                      color: Colors.blue[600],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      lang.language,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(lang.selectTheme),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(lang.lightTheme),
                          onTap: () {
                            _updateTheme(appProvider, 0);
                            AdaptiveTheme.of(context).setLight();
                            Navigator.pop(context); // Ẩn hộp thoại
                          },
                        ),
                        ListTile(
                          title: Text(lang.darkTheme),
                          onTap: () {
                            _updateTheme(appProvider, 1);
                            AdaptiveTheme.of(context).setDark();
                            Navigator.pop(context); // Ẩn hộp thoại
                          },
                        ),
                        ListTile(
                          title: Text(lang.systemDefault),
                          onTap: () {
                            _updateTheme(appProvider, 2);
                            Navigator.pop(context); // Ẩn hộp thoại
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.sunny,
                      size: 30,
                      color: Colors.blue[600],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      lang.selectTheme,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.becomeTutor),
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.assignment,
                      size: 30,
                      color: Colors.blue[600],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      lang.becomeTeacher,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () => {throw UnimplementedError()},
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.privacy_tip_outlined,
                      size: 30,
                      color: Colors.blue[600],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      lang.privatePolicy,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () => {throw UnimplementedError()},
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.privacy_tip_outlined,
                      size: 30,
                      color: Colors.blue[600],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      lang.termAndCondition,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Card(
            surfaceTintColor: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(
                    Icons.contact_mail_outlined,
                    size: 30,
                    color: Colors.blue[600],
                  ),
                  const SizedBox(width: 12),
                  Text(
                    lang.contact,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () => {throw UnimplementedError()},
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.contact_support_outlined,
                        size: 30, color: Colors.blue[600]),
                    const SizedBox(width: 12),
                    Text(
                      lang.guide,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () async {
              final result = await _showLogOutConfirmDialog(context);
              if (result) {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('refresh_token');
                authProvider.token = null;

                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.login,
                    (route) => false,
                  );
                }
              }
            },
            style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(44),
              backgroundColor: Colors.blue[600],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  lang.sighOut,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  void _updateTheme(AppProvider appProvider, int i) async {
    appProvider.setTheme(i);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', i);
  }

  void _loadTheme(AppProvider appProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getInt('theme') ?? 0;
    appProvider.setTheme(theme);
  }
}

Future<bool> _showLogOutConfirmDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('NO')),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('YES')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
