import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/constant/app_colors.dart';
import 'package:food_app/core/constant/app_text_style.dart';
import 'package:food_app/core/di/locator.dart';
import 'package:food_app/feature/favourite/presentation/manger/favourites_cubit.dart';
import 'package:food_app/feature/profile/presentation/manger/log_out_cubit/log_out_cubit.dart';
import 'package:food_app/feature/profile/presentation/manger/profile_cubit/profile_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/route/routes.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LogOutCubit>()),
        BlocProvider(create: (_) => getIt<ProfileCubit>()),
      ],
      child: const _ProfileBody(),
    );
  }
}

class _ProfileBody extends StatefulWidget {
  const _ProfileBody();

  @override
  State<_ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<_ProfileBody> {
  // ── helpers ──────────────────────────────────────────────────────────────

  void _showEditNameDialog(BuildContext context, String currentName) {
    final ctrl = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Edit Name'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter your name',
            prefixIcon: const Icon(Icons.person_outline),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gradientStart,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              final name = ctrl.text.trim();
              if (name.isNotEmpty) {
                context.read<ProfileCubit>().updateName(name);
                Navigator.pop(dialogCtx);
              }
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final newPassCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    bool obscure1 = true;
    bool obscure2 = true;

    showDialog(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newPassCtrl,
                obscureText: obscure1,
                decoration: InputDecoration(
                  hintText: 'New password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                        obscure1 ? Icons.visibility_off : Icons.visibility),
                    onPressed: () =>
                        setDialogState(() => obscure1 = !obscure1),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: confirmCtrl,
                obscureText: obscure2,
                decoration: InputDecoration(
                  hintText: 'Confirm password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                        obscure2 ? Icons.visibility_off : Icons.visibility),
                    onPressed: () =>
                        setDialogState(() => obscure2 = !obscure2),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gradientStart,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                if (newPassCtrl.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Password must be at least 6 characters'),
                    backgroundColor: AppColors.errorColor,
                  ));
                  return;
                }
                if (newPassCtrl.text != confirmCtrl.text) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Passwords do not match'),
                    backgroundColor: AppColors.errorColor,
                  ));
                  return;
                }
                context
                    .read<ProfileCubit>()
                    .changePassword(newPassCtrl.text.trim());
                Navigator.pop(dialogCtx);
              },
              child:
                  const Text('Update', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.successColor,
          ));
          setState(() {}); // refresh user data from Supabase
        }
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.errorColor,
          ));
        }
      },
      child: BlocListener<LogOutCubit, LogOutState>(
        listener: (context, state) {
          if (state is LogOutSuccess) {
            Navigator.of(context).pushReplacementNamed(Routes.signIn);
          }
          if (state is LogOutError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.errorColor,
            ));
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(child: _buildSections(context)),
                _buildLogoutButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── header ────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final userName = user?.userMetadata?['name'] ?? 'Chef';
    final userEmail = user?.email ?? '';
    final initials = userName.isNotEmpty ? userName[0].toUpperCase() : '?';

    final favCount = context.watch<FavouritesCubit>().favourites.length;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.customGradient,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        children: [
          // Avatar
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: Colors.white.withValues(alpha: 0.3),
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _showEditNameDialog(context, userName),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit,
                      size: 14, color: AppColors.gradientStart),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(userName,
              style: AppTextStyles.bold20black
                  .copyWith(color: Colors.white, fontSize: 22)),
          const SizedBox(height: 4),
          Text(userEmail,
              style: const TextStyle(color: Colors.white70, fontSize: 13)),

          const SizedBox(height: 20),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatChip(
                icon: Icons.favorite,
                label: '$favCount',
                sublabel: 'Favourites',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── sections ──────────────────────────────────────────────────────────────

  Widget _buildSections(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final userName = user?.userMetadata?['name'] ?? 'Chef';

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: [
        _SectionHeader(title: 'ACCOUNT'),
        _SettingsTile(
          icon: Icons.person_outline,
          iconColor: AppColors.gradientStart,
          title: 'Edit Profile',
          subtitle: 'Change your display name',
          onTap: () => _showEditNameDialog(context, userName),
        ),
        _SettingsTile(
          icon: Icons.lock_outline,
          iconColor: Colors.blue,
          title: 'Change Password',
          subtitle: 'Update your password',
          onTap: () => _showChangePasswordDialog(context),
        ),

        const SizedBox(height: 8),
        _SectionHeader(title: 'SUPPORT'),
        _SettingsTile(
          icon: Icons.help_outline,
          iconColor: Colors.orange,
          title: 'Help Center',
          subtitle: 'Get help with the app',
          onTap: () => _showInfoDialog(
            context,
            title: 'Help Center',
            content:
                'For support, contact us at support@recipefinder.com\n\nVersion 1.0.0',
          ),
        ),
        _SettingsTile(
          icon: Icons.privacy_tip_outlined,
          iconColor: Colors.purple,
          title: 'Privacy Policy',
          subtitle: 'How we handle your data',
          onTap: () => _showInfoDialog(
            context,
            title: 'Privacy Policy',
            content:
                'We respect your privacy. Your data is stored securely and never shared with third parties.',
          ),
        ),
        _SettingsTile(
          icon: Icons.description_outlined,
          iconColor: Colors.teal,
          title: 'Terms of Service',
          subtitle: 'Our terms and conditions',
          onTap: () => _showInfoDialog(
            context,
            title: 'Terms of Service',
            content:
                'By using Recipe Finder, you agree to use the app for personal, non-commercial purposes only.',
          ),
        ),

        const SizedBox(height: 8),
        _SectionHeader(title: 'APP'),
        _SettingsTile(
          icon: Icons.info_outline,
          iconColor: Colors.grey,
          title: 'App Version',
          subtitle: '1.0.0',
          onTap: null,
          showArrow: false,
        ),
      ],
    );
  }

  void _showInfoDialog(BuildContext context,
      {required String title, required String content}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text(content, style: const TextStyle(height: 1.6)),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gradientStart,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── logout button ─────────────────────────────────────────────────────────

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: BlocBuilder<LogOutCubit, LogOutState>(
        builder: (context, state) {
          final isLoading = state is LogOutLoading;
          return SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.errorColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed:
                  isLoading ? null : () => context.read<LogOutCubit>().logOut(),
              icon: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.errorColor),
                    )
                  : const Icon(Icons.logout, color: AppColors.errorColor),
              label: Text(
                isLoading ? 'Logging out...' : 'Log Out',
                style: const TextStyle(
                    color: AppColors.errorColor, fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── reusable widgets ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool showArrow;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 12)),
      trailing: showArrow
          ? const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey)
          : null,
      onTap: onTap,
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sublabel;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Text(sublabel,
                  style:
                      const TextStyle(color: Colors.white70, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}
