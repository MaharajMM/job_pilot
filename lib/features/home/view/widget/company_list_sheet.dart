import 'package:flutter/material.dart';

class CompaniesListSheet extends StatelessWidget {
  final List<MapEntry<String, int>> companies;
  final ScrollController scrollController;

  const CompaniesListSheet({
    super.key,
    required this.companies,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Companies'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      body: ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: companies.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final company = companies[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              child: Text(
                company.key.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(company.key),
            trailing: Chip(
              label: Text(
                '${company.value} ${company.value == 1 ? 'application' : 'applications'}',
              ),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          );
        },
      ),
    );
  }
}
