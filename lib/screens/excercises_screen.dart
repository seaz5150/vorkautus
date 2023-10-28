import 'package:flutter/material.dart';

class ExcercisesScreen extends StatefulWidget {
  const ExcercisesScreen({super.key});

  @override
  State<ExcercisesScreen> createState() =>
      _ExcercisesScreenState();
}

class _ExcercisesScreenState extends State<ExcercisesScreen> {
  final List<String> demoExcercises = <String>['Exercise 1', 'Exercise 2', 'Exercise 3'];
  List<String> resultExcercises = [];
  TextEditingController searchEditingController = TextEditingController();

  void filterSearchResults(String query) {
    setState(() {
      resultExcercises = demoExcercises
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onEditExercisePressed(int index) {
    // setState(() {

    // });
  }

    void _onDeleteExercisePressed(int index) {
    // setState(() {

    // });
  }

  @override
  void initState() {
    resultExcercises = demoExcercises;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Excercises',
          style: TextStyle(
            fontWeight: FontWeight.w500
          )
        ),
    ),
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: searchEditingController,
                padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                leading: const Icon(
                  Icons.search,
                  size: 20
                ),
                hintText: "Search..."
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8),
              itemCount: resultExcercises.length,
              itemBuilder: (_, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(resultExcercises[index])
                            ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () => _onEditExercisePressed(index),
                                icon: const Icon(Icons.edit),
                                iconSize: 20,
                                ),
                              IconButton(
                                onPressed: () => _onDeleteExercisePressed(index),
                                icon: const Icon(Icons.delete_forever),
                                iconSize: 20,
                                ),
                            ],
                          ),
                        )
                      ]),
                  ),
                );
            }),
          ),
        ],
      )
    );
  }
}