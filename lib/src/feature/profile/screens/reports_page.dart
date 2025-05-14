import 'package:flutter/material.dart';
import 'package:quicklens/l10n/app_localizations.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quicklens/src/core/widgets/app/themes/colors.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<dynamic> monthlyStats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatsData();
  }

  Future<void> _loadStatsData() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/monthly_stats.json',
      );
      final jsonData = json.decode(jsonString);
      setState(() {
        monthlyStats = jsonData['stats'];
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    IconData icon;
    switch (stat['icon']) {
      case 'assignment':
        icon = Icons.assignment;
        break;
      case 'warning':
        icon = Icons.warning;
        break;
      case 'timer':
        icon = Icons.timer;
        break;
      default:
        icon = Icons.info;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.greenAccent),
        title: Text(stat['name']),
        subtitle: Text(stat['value']),
        trailing:
            stat['change'] != null
                ? Chip(
                  label: Text(stat['change']),
                  backgroundColor:
                      stat['change'].startsWith('+')
                          ? AppColors.successLight
                          : stat['change'].startsWith('-')
                          ? AppColors.errorLight
                          : AppColors.neutralLight,
                  labelStyle: TextStyle(
                    color:
                        stat['change'].startsWith('+')
                            ? AppColors.success
                            : stat['change'].startsWith('-')
                            ? AppColors.error
                            : AppColors.neutral,
                  ),
                )
                : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: monthlyStats.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n?.translate('appStatistics') ?? 'App Statistics'),
          bottom: TabBar(
            isScrollable: true,
            tabs:
                monthlyStats.map((month) => Tab(text: month['month'])).toList(),
          ),
        ),
        body: TabBarView(
          children:
              monthlyStats.map((month) {
                return ListView.builder(
                  itemCount: month['metrics'].length,
                  itemBuilder: (context, index) {
                    return _buildStatCard(month['metrics'][index]);
                  },
                );
              }).toList(),
        ),
      ),
    );
  }
}
