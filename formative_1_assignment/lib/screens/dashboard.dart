import 'package:flutter/material.dart';
import 'apptheme.dart';
import 'team_members.dart';

class TaskStat {
  final String label;
  final int count;
  final Color color;
  const TaskStat(this.label, this.count, this.color);
}

const _stats = <TaskStat>[
  TaskStat('On track', 5, AppColors.green),
  TaskStat('At risk', 3, AppColors.amber),
  TaskStat('Overdue', 2, AppColors.coral),
  TaskStat('Completed', 2, AppColors.slate),
];

class ActivityItem {
  final TeamMember member;
  final String action;
  final String when;
  const ActivityItem(this.member, this.action, this.when);
}

final _activity = <ActivityItem>[
  ActivityItem(members[1], 'updated UI Design', '2 hours ago'),
  ActivityItem(members[2], 'started Local Storage', '5 hours ago'),
  ActivityItem(members[3], 'flagged Create Task Model', 'Yesterday'),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final total = _stats.fold<int>(0, (sum, s) => sum + s.count);

    return Scaffold(
      backgroundColor: AppColors.base,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: Text(
          'Dashboard',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Good morning, ${currentUser.name.split(' ').first}',
              style: AppText.head.copyWith(fontSize: 20)),
          const SizedBox(height: 4),
          Text("Here's what's happening with your project.",
              style: AppText.bodySoft.copyWith(fontSize: 13)),
          const SizedBox(height: 16),

          // Stat cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.2,
            children: [
              _StatCard(label: 'Total tasks', value: '$total', color: AppColors.primary),
              for (final s in _stats)
                _StatCard(label: s.label, value: '${s.count}', color: s.color),
            ],
          ),

          const SizedBox(height: 20),

          // Task overview donut + legend
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Task Overview', style: AppText.headSemi.copyWith(fontSize: 15)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(
                      width: 110,
                      height: 110,
                      child: CustomPaint(
                        painter: _DonutPainter(_stats, total),
                        child: Center(
                          child: Text('$total', style: AppText.head.copyWith(fontSize: 22)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final s in _stats) _LegendRow(stat: s),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text('Recent Activity', style: AppText.headSemi.copyWith(fontSize: 15)),
          const SizedBox(height: 10),
          for (final a in _activity) _ActivityRow(item: a),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: AppText.head.copyWith(fontSize: 20, color: color)),
          const SizedBox(height: 2),
          Text(label, style: AppText.bodySoft.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  final TaskStat stat;
  const _LegendRow({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: stat.color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Expanded(child: Text(stat.label, style: AppText.bodySoft.copyWith(fontSize: 13))),
          Text('${stat.count}', style: AppText.headSemi.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final ActivityItem item;
  const _ActivityRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: item.member.roleColor.tint, borderRadius: BorderRadius.circular(9)),
            alignment: Alignment.center,
            child: Text(item.member.initials,
                style: AppText.headSemi.copyWith(color: item.member.roleColor.color, fontSize: 12)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppText.body.copyWith(fontSize: 13, color: AppColors.ink),
                children: [
                  TextSpan(text: item.member.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: ' ${item.action}'),
                ],
              ),
            ),
          ),
          Text(item.when, style: AppText.bodySoft.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}

/// Simple donut chart drawn with arcs, no chart package required.
class _DonutPainter extends CustomPainter {
  final List<TaskStat> stats;
  final int total;
  _DonutPainter(this.stats, this.total);

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 16.0;
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    double startAngle = -1.5708; // -90 degrees, start at top
    for (final s in stats) {
      final sweep = total == 0 ? 0.0 : (s.count / total) * 6.28319;
      final paint = Paint()
        ..color = s.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect, startAngle, sweep, false, paint);
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) => false;
}