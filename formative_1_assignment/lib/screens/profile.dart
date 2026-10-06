import 'package:flutter/material.dart';
import 'apptheme.dart';
import 'team_members.dart';

class ProfileScreen extends StatelessWidget {
  final TeamMember member;

  const ProfileScreen({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.base,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Profile',
          style: AppText.head.copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _Hero(member: member),
          const _StatsRow(),
          _MenuGroup(
            title: 'Account',
            items: const [
              _MenuEntry(icon: Icons.edit_outlined, label: 'Edit profile'),
              _MenuEntry(icon: Icons.settings_outlined, label: 'App settings'),
              _MenuEntry(icon: Icons.info_outline, label: 'About'),
            ],
          ),
          _MenuGroup(
            title: 'Session',
            items: const [
              _MenuEntry(
                icon: Icons.logout,
                label: 'Sign out',
                danger: true,
                showChevron: false,
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final TeamMember member;
  const _Hero({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: 26),
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: member.roleColor.color,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              member.initials,
              style: AppText.head.copyWith(color: Colors.white, fontSize: 26),
            ),
          ),
          const SizedBox(height: 12),
          Text(member.name, style: AppText.head.copyWith(fontSize: 18)),
          const SizedBox(height: 3),
          Text(
            member.role,
            style: AppText.bodySoft.copyWith(
              color: member.roleColor.color,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    Widget stat(String num, String label) => Column(
          children: [
            Text(num, style: AppText.head.copyWith(color: AppColors.primary, fontSize: 17)),
            const SizedBox(height: 2),
            Text(label, style: AppText.bodySoft.copyWith(fontSize: 11)),
          ],
        );

    return Container(
      padding: const EdgeInsets.only(bottom: 16, top: 4),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          stat('12', 'Tasks'),
          const SizedBox(width: 26),
          stat('5', 'On track'),
          const SizedBox(width: 26),
          stat('4', 'Teammates led'),
        ],
      ),
    );
  }
}

class _MenuEntry {
  final IconData icon;
  final String label;
  final bool danger;
  final bool showChevron;

  const _MenuEntry({
    required this.icon,
    required this.label,
    this.danger = false,
    this.showChevron = true,
  });
}

class _MenuGroup extends StatelessWidget {
  final String title;
  final List<_MenuEntry> items;
  const _MenuGroup({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              title,
              style: AppText.headSemi.copyWith(fontSize: 12, color: AppColors.inkSoft),
            ),
          ),
          for (final e in items) _MenuRow(entry: e),
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final _MenuEntry entry;
  const _MenuRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    final accent = entry.danger ? AppColors.coral : AppColors.primary;
    final tint = entry.danger ? AppColors.coralTint : AppColors.primaryTint;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(9)),
            alignment: Alignment.center,
            child: Icon(entry.icon, size: 17, color: accent),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Text(
              entry.label,
              style: AppText.body.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: entry.danger ? AppColors.coral : AppColors.ink,
              ),
            ),
          ),
          if (entry.showChevron) Icon(Icons.chevron_right, size: 18, color: AppColors.inkSoft),
        ],
      ),
    );
  }
}