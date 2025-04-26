import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  // خريطة الصور لكل تحليل
  static const Map<String, String> testImages = {
    'CBC':  'assets/images/CBC.jpg',
    'Pregnancy Test': 'assets/images/pregnancy-scan.jpg',
    'Urinalysis':  'assets/images/Urinalysis.jpg',
    'Stool Test':  'assets/images/stool-test.jpg',
    'X-ray':  'assets/images/x-ray.jpg',
    'CT Scan':  'assets/images/CT-scan.jpg',
    'MRI':  'assets/images/MRI.jpg',
    'Dexa Scan':  'assets/images/dexa-scan.jpg',
  };

  final List<Map<String, String>> medicalTests = const [
    {'name': 'CBC', 'price': '200 LE'},
    {'name': 'Pregnancy Test', 'price': '200 LE'},
    {'name': 'Urinalysis', 'price': '200 LE'},
    {'name': 'Stool Test', 'price': '200 LE'},
  ];

  final List<Map<String, String>> radiologyTests = const [
    {'name': 'X-ray', 'price': '200 LE'},
    {'name': 'CT Scan', 'price': '200 LE'},
    {'name': 'MRI', 'price': '200 LE'},
    {'name': 'Dexa Scan', 'price': '200 LE'},
  ];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>? ?? {'type': 'Medical Test'};
    final type = args['type']!;
    final items = type == 'Medical Test' ? medicalTests : radiologyTests;

    return Scaffold(
      appBar: AppBar(title: Text('Book $type')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final test = items[index];
          final imagePath = testImages[test['name']] ?? 'assets/images/placeholder.png';
          
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/labs',
                  arguments: {
                    'serviceName': test['name']!,
                    'serviceType': type,
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
              child: Row(  
                children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),),
                        child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => 
                          const Icon(Icons.medical_services, size: 40),
                      ),
                    ),


                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            test['name']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Price: ${test['price']}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 20),
],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}