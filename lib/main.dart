import 'package:flutter/material.dart';
import 'package:sql_course_work/controller/main_controller.dart';
import 'package:sql_course_work/data/database/travel_database.dart';
import 'package:sql_course_work/data/model/travel_model.dart';
import 'package:sql_course_work/data/service/travel_service.dart';
import 'package:sql_course_work/data/travel_repository.dart';
import 'package:sql_course_work/presentation/add_to_db_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TravelDatabase.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

MainController mainController =
    MainController(TravelRepositoryImplement(TravelService()));

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController textEditingController = TextEditingController();
  ValueNotifier<List<TravelModel>> listTravelModel =
      ValueNotifier(<TravelModel>[]);

  @override
  void initState() {
    super.initState();
    onInit();
  }

  Future<void> onInit() async {
    await mainController.getAllTravelInfor();
    listTravelModel.value = mainController.listTravel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Trips'),
        backgroundColor: const Color(0xff4C4646),
      ),
      body: ValueListenableBuilder<List<TravelModel>>(
          valueListenable: listTravelModel,
          builder: (context, newValue, widget) {
            return ListView.builder(
                itemCount: listTravelModel.value.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    padding: const EdgeInsets.all(4).copyWith(left: 8),
                    margin: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Table(
                            border: TableBorder.all(color: Colors.transparent),
                            children: [
                              TableRow(children: [
                                Container(
                                  height: 24,
                                  alignment: Alignment.centerLeft,
                                  child:
                                      Text(listTravelModel.value[index].name),
                                ),
                                Container(
                                  height: 24,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      listTravelModel.value[index].destination),
                                ),
                              ]),
                              TableRow(children: [
                                Container(
                                  height: 24,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      listTravelModel.value[index].dateTime),
                                ),
                                Container(
                                  height: 24,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Require Assessment: ${listTravelModel.value[index].require}'),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff4C4646),
        onPressed: () async {
          TravelModel? travelModel = await Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddToDb()));
          print('Dong 30: ${travelModel.toString()}');
          if (travelModel?.dateTime.isNotEmpty == true) {
            listTravelModel.value = await mainController.insertTravel(
              travelModel!,
            );
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
