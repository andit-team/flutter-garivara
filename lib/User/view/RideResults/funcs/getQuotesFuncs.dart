import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FuncGetQuotes{
  static chooseJourneyDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100)
    );
    if (picked != null) {
      return DateFormat('yyyy-MM-dd').format(picked);
    }else{
      return DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
  }

  static choosePickUpTime(BuildContext context) async{
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    if (picked != null) {
      return picked.format(context);
    }else{
      return TimeOfDay.now().format(context);
    }
  }
}