import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddToDb extends StatelessWidget {
  const AddToDb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _value = 1;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController destinationController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: const Color(0xff4C4646),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                TextFieldInputWidget(
                  title: 'Name',
                  textEditingController: nameController,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFieldInputWidget(
                  title: 'Destination',
                  textEditingController: destinationController,
                ),
                const SizedBox(
                  height: 8,
                ),
                const TextFieldInputWidget(
                  title: '',
                  isDateTime: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Require Risks Assessment*'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: 'null',
                                  onChanged: (index) {}),
                              const Expanded(child: Text('Yes'))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: 'null',
                                  onChanged: (index) {}),
                              const Expanded(child: Text('No'))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TextFieldInputWidget(
                  title: 'Description',
                  textEditingController: descriptionController,
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff0057D8),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(12)),
                    onPressed: () => _showAlertDialog(context),
                    child: const Text(
                      'Add To Database',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: const Text('You need to fill all required fields'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class TextFieldInputWidget extends StatelessWidget {
  const TextFieldInputWidget({
    Key? key,
    required this.title,
    this.textEditingController,
    this.isDateTime = false,
  }) : super(key: key);

  final String title;
  final TextEditingController? textEditingController;
  final bool isDateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 4,
        ),
        InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            if (isDateTime) {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2018, 3, 5),
                  maxTime: DateTime(2024, 6, 7), onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                print('confirm $date');
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            }
          },
          child: TextField(
            enabled: isDateTime ? false : true,
            controller: textEditingController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1.5, color: Color(0xff4C9AFF)), //<-- SEE HERE
              ),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1.5, color: Colors.black), //<-- SEE HERE
              ),
              disabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1.5, color: Colors.black), //<-- SEE HERE
              ),
            ),
          ),
        ),
      ],
    );
  }
}
