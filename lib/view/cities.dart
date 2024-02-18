import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cities_controller.dart';

class Cities extends StatelessWidget {
  static const String id = "webcities";

  const Cities({super.key});

  @override
  Widget build(BuildContext context) {
    final CitiesController controller = Get.put(CitiesController());

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller.searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query){
                controller.searchController;
              },
            ),
          ),
          Expanded(
            child: GetX<CitiesController>(
              builder: (controller) {

                if (controller.isLoading.value) {
                  return const CircularProgressIndicator();
                }

                final cities = controller.filteredCities.isEmpty ? controller.cities : controller.filteredCities;

                return ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    return Card(
                      child: SingleChildScrollView(
                        child: ListTile(
                          title: Text(city.name),
                          subtitle: Text('${city.country}, ${city.continent}'),
                          trailing: Text('${city.numberOfClients} clients'),
                          onTap: () {
                            controller.editCity(context, city);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                controller.addCity(context);
              },
              child: const Text('Add City'),
            ),
          ),
        ],
      ),
    );
  }
}
