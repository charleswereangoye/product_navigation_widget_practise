import 'package:flutter/material.dart';
import 'apptheme.dart';
import 'profile.dart';

class TeamMember {
  final String initials;
  final String name;
  final String role;
  final RoleColor roleColor;

  const TeamMember({
    required this.initials,
    required this.name,
    required this.role,
    required this.roleColor,
  });
}

/// Public (no underscore) so dashboard.dart can reuse this same list
/// for stats and recent activity, instead of duplicating data.
const members = <TeamMember>[
  TeamMember(
    initials: 'JD',
    name: 'John Doe',
    role: 'Project Manager',
    roleColor: RoleColor.projectManager,
  ),
  TeamMember(
    initials: 'SL',
    name: 'Sarah Lee',
    role: 'UI/UX Designer',
    roleColor: RoleColor.designer,
  ),
  TeamMember(
    initials: 'MK',
    name: 'Michael Kim',
    role: 'Mobile Developer',
    roleColor: RoleColor.developer,
  ),
  TeamMember(
    initials: 'EW',
    name: 'Emily Wong',
    role: 'QA Tester',
    roleColor: RoleColor.qa,
  ),
  TeamMember(
    initials: 'DL',
    name: 'David Liu',
    role: 'Documentation',
    roleColor: RoleColor.docs,
  ),
];

/// The logged-in user, shown on the Profile tab by default.
final currentUser = members[0]; // John Doe

class TeamMembersScreen extends StatelessWidget {
  const TeamMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.base,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: Text(
          'Team Members',
          style: AppText.head.copyWith(color: Colors.white, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white.withValues(alpha: 0.18),
              child: Text(
                currentUser.initials,
                style: AppText.headSemi.copyWith(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 90),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 12),
                child: Text(
                  '${members.length} people on this project',
                  style: AppText.bodySoft.copyWith(fontSize: 12),
                ),
              ),
              for (final m in members) _MemberRow(member: m),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 20,
            child: FloatingActionButton(
              backgroundColor: AppColors.amber,
              elevation: 4,
              onPressed: () {
                // Hook up: open add-member flow
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  final TeamMember member;
  const _MemberRow({required this.member});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProfileScreen(member: member)),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border(left: BorderSide(color: member.roleColor.color, width: 4)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: member.roleColor.tint,
                  borderRadius: BorderRadius.circular(11),
                ),
                alignment: Alignment.center,
                child: Text(
                  member.initials,
                  style: AppText.headSemi.copyWith(color: member.roleColor.color, fontSize: 15),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(member.name, style: AppText.headSemi.copyWith(fontSize: 14.5)),
                    const SizedBox(height: 2),
                    Text(
                      member.role,
                      style: AppText.bodySoft.copyWith(
                        color: member.roleColor.color,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.inkSoft, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}