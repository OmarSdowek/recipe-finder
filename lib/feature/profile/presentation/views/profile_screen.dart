import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/feature/auth/data/repo/auth_repo_impl.dart';
import 'package:food_app/feature/profile/presentation/manger/log_out_cubit/log_out_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/route/routes.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../auth/data/data_source/auth_remote_data_source_impl.dart';
import '../../../auth/domin/use_case/log_out_use_case.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final userName = user?.userMetadata?["name"] ?? "omar";
    final userEmail = user?.email ?? "No Email";

    return BlocProvider(
      create: (context) => LogOutCubit(
        LogOutUseCase(
          AuthRepoImpl(
            AuthRemoteDataSourceImpl(Supabase.instance.client),
          ),
        ),
      ),
      child: Scaffold(
        body: Column(
          children: [
            // ===== Profile Header =====
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      "https://www.freeiconspng.com/uploads/go-back--gallery-for--contact-person-icon-png-21.png",
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    userEmail,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Divider(),

            // ===== Sections =====
            Expanded(
              child: ListView(
                children: [
                  _buildSection("ACCOUNT", [
                    _buildItem("Edit Profile", Icons.edit),
                    _buildItem("Change Password", Icons.lock),
                    _buildItem("Notification Settings", Icons.notifications),
                  ]),
                  _buildSection("PREFERENCES", [
                    _buildItem(
                      "Dark Mode",
                      Icons.dark_mode,
                      trailing: Switch(
                        value: _isDarkMode,
                        onChanged: (val) {
                          setState(() {
                            _isDarkMode = val;
                          });
                        },
                      ),
                    ),
                    _buildItem("Language", Icons.language),
                  ]),
                  _buildSection("SUPPORT", [
                    _buildItem("Help Center", Icons.help),
                    _buildItem("Privacy Policy", Icons.privacy_tip),
                    _buildItem("Terms of Service", Icons.description),
                  ]),
                ],
              ),
            ),

            // ===== Logout Button =====
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<LogOutCubit, LogOutState>(
                listener: (context, state) {
                  if (state is LogOutSuccess) {
                    // استخدم addPostFrameCallback لتجنب تحديث الواجهة أثناء build
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushReplacementNamed(Routes.signIn);
                    });
                  } else if (state is LogOutError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: state is LogOutLoading ? "Logging out..." : "Log Out",
                    onPressed:  () => context.read<LogOutCubit>().logOut(),
                    backgroundColor: AppColors.gradientEnd,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        ...items,
        const Divider(),
      ],
    );
  }

  Widget _buildItem(String title, IconData icon, {Widget? trailing}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,
      onTap: () {},
    );
  }
}