import 'package:flutter/material.dart';

class Dataselection extends StatefulWidget {
  const Dataselection({super.key});

  @override
  State<Dataselection> createState() => _DataselectionState();
}

class _DataselectionState extends State<Dataselection> {
  var currentDate =DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          controller: TextEditingController(
            text: "${currentDate.toLocal()}".split(" ")[0]
          ),
            onTap: ()=>selectDate(context),
            readOnly: true,
            decoration: InputDecoration(
                labelText: "select date",
                suffixIcon: Icon(Icons.calendar_month)),
            ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2050));
    if (selectedDate != null && selectedDate != currentDate) {
      setState(() {
        currentDate = selectedDate;
        });
    }
    }
}
