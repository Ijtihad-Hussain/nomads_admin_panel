import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/statistics_controller.dart';

class WebStatistics extends GetView<StatisticsController> {
  static const String id = "webstatistics";

  const WebStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
              'Appointments: ${controller.appointments}',
              style: const TextStyle(fontSize: 20),
            )),
            const SizedBox(height: 20),
            Obx(() => Text(
              'Patients: ${controller.patients}',
              style: const TextStyle(fontSize: 20),
            )),
            const SizedBox(height: 20),
            Obx(() => Text(
              'Doctors: ${controller.doctors}',
              style: const TextStyle(fontSize: 20),
            )),
          ],
        ),
      ),
    );
  }
}
