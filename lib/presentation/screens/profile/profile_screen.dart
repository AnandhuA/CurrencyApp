import 'package:currency_rate_calculator/domain/repository/recent_pairs_repository.dart';
import 'package:currency_rate_calculator/domain/repository/user_prefs_repo.dart';
import 'package:currency_rate_calculator/presentation/screens/authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: user == null
          ? const Center(child: Text("No user logged in"))
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Profile avatar
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    user.displayName ?? "No Name",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Email (from Firebase)
                  Text(
                    user.email ?? "No Email",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  const Divider(),

                  // Details
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text("Username"),
                    subtitle: Text(user.displayName ?? "Not set"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: const Text("Email"),
                    subtitle: Text(user.email ?? "Not available"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text("Logout"),
                    onTap: () async {
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Confirm Logout"),
                          content: const Text(
                            "Are you sure you want to log out?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Logout",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (shouldLogout == true) {
                        await FirebaseAuth.instance.signOut();
                        await UserPrefsRepo.logout();
                        await RecentPairsRepository().clearRecentPairs();
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
