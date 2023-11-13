import 'package:flutter/material.dart';
import 'package:vorkautus/dto/ExerciseTemplateDTO.dart';
import '../globals.dart' as globals;

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  List<ExerciseTemplateDTO> exercises = [];
  List<ExerciseTemplateDTO> resultExercises = [];
  TextEditingController searchEditingController = TextEditingController();
  TextEditingController? nameTextFieldController;

  void _loadExercises() async {
    await globals.repository.loadDataFromJson();
    setState(() {
      exercises = globals.repository.getExerciseTemplatesFromJson();
      resultExercises = exercises;
    });
  }

  void filterSearchResults(String query) {
    setState(() {
      resultExercises = exercises
          .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _openPromptForName(ExerciseTemplateDTO ex, Function onConfirm) async {
    nameTextFieldController ??= TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        nameTextFieldController?.text = ex.name;
        return AlertDialog(
          title: const Text('Enter exercise name'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: nameTextFieldController,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (String value) {
                    ex.name = value;
                  },
                  decoration: const InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(fontSize: 13)),
                  keyboardType: TextInputType.text,
                )
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('CONFIRM'),
              onPressed: () {
                onConfirm(ex);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onEditExercisePressed(ExerciseTemplateDTO ex) {
    _openPromptForName(ex, _saveExercise);
  }

  Future<void> _onDeleteExercisePressed(ExerciseTemplateDTO ex) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete the exercise?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                globals.repository.removeObject(ex);
                _loadExercises();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onNewExercisePressed() {
    _openPromptForName(ExerciseTemplateDTO('', ''), _saveExercise);
  }

  void _saveExercise(ExerciseTemplateDTO ex) {
    globals.repository.saveObject(ex);
    _loadExercises();
  }

  @override
  void initState() {
    _loadExercises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Exercises',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
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
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 45,
                  child: SearchBar(
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      controller: searchEditingController,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      leading: const Icon(Icons.search, size: 20),
                      hintText: "Search..."),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 70),
                  itemCount: resultExercises.length,
                  itemBuilder: (_, index) {
                    final ExerciseTemplateDTO exercise = resultExercises[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: ListTile(
                                    title: Text(
                                  exercise.name,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: const TextStyle(fontSize: 16),
                                )),
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          _onEditExercisePressed(exercise),
                                      icon: const Icon(Icons.edit),
                                      iconSize: 18,
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          _onDeleteExercisePressed(exercise),
                                      icon: const Icon(Icons.delete_forever),
                                      iconSize: 18,
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
        ));
  }
}
