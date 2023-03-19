import 'package:flutter/material.dart';
import 'package:omgnp/Data/Format.dart';

class DatePicker extends StatefulWidget {
  final Size size;
  final Function setDate;
  const DatePicker(this.size, this.setDate, {super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  bool hasDateInitialized = false;

  void setDate() async {
    final response = (await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime.now()))!;
      hasDateInitialized = true;
      widget.setDate(response);
      setState(() {
        dateTime = response;
      });
  }

  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setDate();
          },
          icon: const Icon(Icons.calendar_month),
        ),
        SizedBox(
          width: widget.size.width * 0.50,
          child: GestureDetector(
            onTap: () {
              setDate();
            },
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                labelText: hasDateInitialized ? Format.date(dateTime) : "Order date"
              ),
            ),
          ),
        ),
      ],
    );
  }
}