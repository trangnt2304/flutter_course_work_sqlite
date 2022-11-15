import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sql_course_work/data/model/travel_model.dart';
import 'package:intl/intl.dart';

class AddToDb extends StatelessWidget {
  const AddToDb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> _valueRadioSelected = ValueNotifier(0);

    final TextEditingController nameController = TextEditingController();
    final TextEditingController destinationController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    ValueNotifier<String> dateTime = ValueNotifier('dd/mm/yyyy');

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: const Color(0xff4C4646),
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context, null);
            return Future.value(false);
          },
          child: Container(
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
                    hintText: 'Name of the Trip',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFieldInputWidget(
                    title: 'Destination',
                    textEditingController: destinationController,
                    hintText: 'Destination',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ValueListenableBuilder<String>(
                      valueListenable: dateTime,
                      builder: (context, newValue, widget) {
                        return TextFieldInputWidget(
                          title: 'Date of the Trip',
                          isDateTime: true,
                          hintText: 'dd/mm/yyyy',
                          textEditingController: dateTime.value != 'dd/mm/yyyy'
                              ? TextEditingController(text: dateTime.value)
                              : TextEditingController(),
                          callBack: (String value) {
                            dateTime.value = value;
                          },
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Require Risks Assessment',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ValueListenableBuilder<int>(
                          valueListenable: _valueRadioSelected,
                          builder: (context, newValue, widget) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: 1,
                                          groupValue: _valueRadioSelected.value,
                                          onChanged: (index) {
                                            _valueRadioSelected.value = index!;
                                          }),
                                      const Expanded(child: Text('Yes'))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: 2,
                                          groupValue: _valueRadioSelected.value,
                                          onChanged: (index) {
                                            _valueRadioSelected.value = index!;
                                          }),
                                      const Expanded(child: Text('No'))
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                  TextFieldInputWidget(
                    title: 'Description',
                    textEditingController: descriptionController,
                    isDescription: true,
                    hintText: 'Description ...',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0xff0057D8),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(12)),
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            descriptionController.text.isNotEmpty &&
                            destinationController.text.isNotEmpty &&
                            dateTime.value != 'dd/mm/yyyy' &&
                            _valueRadioSelected.value != 3) {
                          _showAlertDialog(
                            context: context,
                            isSuccess: true,
                            title:
                                ' Name: ${nameController.text}\n Destination: ${destinationController.text}\n Date of the Trip: ${dateTime.value}\n Risk Assessment: ${_valueRadioSelected.value == 1 ? 'Yes' : 'No'}\n Description: ${descriptionController.text}',
                            travelModel: TravelModel(
                                name: nameController.text,
                                destination: destinationController.text,
                                dateTime: dateTime.value,
                                require: _valueRadioSelected.value == 1
                                    ? 'YES'
                                    : 'NO',
                                description: descriptionController.text),
                          );
                        } else {
                          _showAlertDialog(
                            context: context,
                            isSuccess: false,
                            title: 'You need to fill all required fields',
                            travelModel: null,
                          );
                        }
                      },
                      child: const Text(
                        'Add To Database',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _showAlertDialog({
    required BuildContext context,
    required bool isSuccess,
    required String title,
    required TravelModel? travelModel,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Text(title),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              if (isSuccess) {
                Navigator.pop(
                  context,
                  travelModel,
                );
              }
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
    this.isDescription = false,
    required this.hintText,
    this.callBack,
  }) : super(key: key);

  final String title;
  final String hintText;
  final TextEditingController? textEditingController;
  final bool isDateTime;
  final bool isDescription;
  final Function(String value)? callBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: title,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: !isDescription ? ' *' : '',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
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
                callBack!(DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(date.toString()))
                    .toString());
              }, onConfirm: (date) {
                callBack!(DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(date.toString()))
                    .toString());
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            }
          },
          child: TextField(
            maxLines: isDescription ? 3 : 1,
            enabled: isDateTime ? false : true,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.all(8),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Color(0xff4C9AFF)),
              ),
              border: InputBorder.none,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Colors.black),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
