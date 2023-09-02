import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/food_model.dart';
import 'package:frontend/src/features/core/models/macronutrient_model.dart';

class FoodListViewScreen extends StatefulWidget {
  const FoodListViewScreen({Key? key, required this.macronutrientsData})
      : super(key: key);
  final Macronutrient macronutrientsData;

  @override
  _FoodListViewScreenState createState() => _FoodListViewScreenState();
}

class _FoodListViewScreenState extends State<FoodListViewScreen> {
  TextEditingController searchController = TextEditingController();
  List<FoodModel> nutritionItems = [];
  List<FoodModel> selectedItems = [];
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    loadFoodData();
  }

  Future<void> loadFoodData() async {
    String jsonData = await rootBundle.loadString('json/food_data.json');
    data = jsonDecode(jsonData);

    setState(() {
      nutritionItems = data.map((item) => FoodModel.fromJson(item)).toList();
    });
  }

  void toggleItemSelection(int index) {
    setState(() {
      nutritionItems[index].isSelected = !nutritionItems[index].isSelected;

      if (nutritionItems[index].isSelected) {
        selectedItems.add(nutritionItems[index]);
      } else {
        selectedItems.remove(nutritionItems[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: const Text(
          "Food List",
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.all(10),
                  hintText: 'Search',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        setState(
                          () {
                            // Clear the search results
                            nutritionItems = data
                                .map((item) => FoodModel.fromJson(item))
                                .toList();
                          },
                        );
                      },
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      // Filter the nutritionItems based on the search query
                      nutritionItems = data
                          .map((item) => FoodModel.fromJson(item))
                          .where((item) => item.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    },
                  );
                },
                maxLines: 1,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: nutritionItems.length,
                itemBuilder: (context, index) {
                  final foodItem = nutritionItems[index];
                  return Column(
                    children: [
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 0.2,
                              offset: Offset(0.3, 0.5),
                              spreadRadius: 0.5,
                            )
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: ExactAssetImage(
                              foodItem.imageUrl,
                            ),
                            radius: 25,
                          ),
                          title: Text(foodItem.name),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Carbohydrates: ${foodItem.carbohydrates}g, '),
                                Text('Protein: ${foodItem.protein}g, '),
                                Text('Fat: ${foodItem.fat}g'),
                              ],
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              toggleItemSelection(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: foodItem.isSelected
                                    ? Colors.green
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: cSecondaryColor,
        onPressed: () {
          // Handle displaying selected items and grams needed
          displayFoodSize();
        },
        child: const Icon(
          Icons.check,
        ),
      ),
    );
  }

  void displayFoodSize() {
    final foodList = selectedItems.map((item) => item.name).toList();
    final carbohydrates = widget.macronutrientsData.macronutrientCarbohydrates;
    final protein = widget.macronutrientsData.macronutrientProtein;
    final fat = widget.macronutrientsData.macronutrientFat;

    List<double> sizes =
        calculateFoodSize(foodList, carbohydrates, protein, fat);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selected Items and Grams Needed'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < selectedItems.length; i++)
                ListTile(
                  title: Text(selectedItems[i].name),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Grams Needed: ${sizes[i].toStringAsFixed(2)} kg'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  List<double> calculateFoodSize(
      List<String> foodList, double carbohydrates, double protein, double fat) {
    final len = foodList.length;
    final ch = carbohydrates / len;
    final pr = protein / len;
    final fa = fat / len;
    final arr = <double>[];

    for (final foodItem in foodList) {
      for (final obj in data) {
        if (obj.containsKey("name") && obj["name"] == foodItem) {
          final gram1 = (ch / obj["carbohydrates"]) * 10;
          final gram2 = (pr / obj["protein"]) * 10;
          final gram3 = (fa / obj["fat"]) * 10;
          final gramsNeeded = (gram1 + gram2 + gram3) / 1000;

          if (obj["source"] == "source2") {
            arr.add(gramsNeeded);
          } else {
            arr.add(gramsNeeded * 0.1);
          }
        }
      }
    }
    return arr;
  }
}
