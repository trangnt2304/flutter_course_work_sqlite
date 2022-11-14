import 'package:flutter/material.dart';
import 'package:sql_course_work/presentation/add_to_db_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ImageDatabase.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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

// MainController mainController =
// MainController(ImageRepositoryImplement(ImageService()));

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController textEditingController = TextEditingController();

  // CarouselController carouselController = CarouselController();
  // ValueNotifier<List<ImageUrl>> listImageUrl = ValueNotifier(<ImageUrl>[]);

  @override
  void initState() {
    super.initState();
    // mainController.getAllImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo SQLite'),
        backgroundColor: const Color(0xff4C4646),
      ),
      body: ListView.builder(
          itemCount: 2,
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
                            child: Text('4'),
                            height: 24,
                            alignment: Alignment.centerLeft,
                          ),
                          Container(
                            child: Text('5'),
                            height: 24,
                            alignment: Alignment.centerLeft,
                          ),
                        ]),
                        TableRow(children: [
                          Container(
                            child: Text('4'),
                            height: 24,
                            alignment: Alignment.centerLeft,
                          ),
                          Container(
                            child: Text('5'),
                            height: 24,
                            alignment: Alignment.centerLeft,
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddToDb()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
