import 'package:flutter/material.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() =>
      _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
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

  void _onNewExercisePressed() {
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
          'Exercises',
          style: TextStyle(
            fontWeight: FontWeight.w500
          )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.only(left: 32, right: 32),
        width: double.infinity,
        height: 30,
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 102, 147, 58),
          onPressed: _onNewExercisePressed,
          child: const Icon(
                  Icons.add, 
                  color: Colors.white
                 ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
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