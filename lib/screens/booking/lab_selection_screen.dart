import 'package:flutter/material.dart';

class LabSelectionScreen extends StatelessWidget {
  const LabSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final serviceName = args['serviceName']!;
    // final serviceType = args['serviceType']!;

    final List<Map<String, String>> labs = [
      {'name': 'El mokhtabar', 'location': 'Nasr City'},
      {'name': 'Alpha Scan', 'location': 'Dokki'},
      {'name': 'Speed Lab', 'location': 'Heliopolis'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Lab for $serviceName'),
      ),
      body: ListView.builder(
        itemCount: labs.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final lab = labs[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              // leading: const Icon(Icons.medical_services, color: Color(0xFF0a66c2)),
              title: Text(lab['name']!),
              subtitle: Text(lab['location']!),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/payment',
                  arguments: {
                    'serviceName': serviceName,
                    'labName': lab['name']!,
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

