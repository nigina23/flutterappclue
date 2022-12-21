import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    getDataFromFirebase();
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    super.dispose();
    sendDataToFirebase();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
      _focusedDay.value = focusedDay;
    });
  }
  Future getDataFromFirebase() async{
    List<dynamic> dates = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          dates = data['selectedDates'];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
    for (var element in dates) {
      var day = element as Timestamp;
      _selectedDays.add(day.toDate());}

  }
  Future sendDataToFirebase() async {
    List<dynamic> dates = [];
    final usersRef = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email);
    for (var element in _selectedDays) {
      dates.add(element);
    }
    final selectedDates = {"selectedDates": dates};
    await usersRef.set(selectedDates,SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Periode Tracken'),
      ),
      body: TableCalendar<Event>(
        headerVisible: true,
        headerStyle: const HeaderStyle(formatButtonVisible: false),
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay.value,
        selectedDayPredicate: (day) => _selectedDays.contains(day),
        calendarFormat: _calendarFormat,
        onDaySelected: _onDaySelected,
        shouldFillViewport: true,
        onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() => _calendarFormat = format);
          }
        },
        calendarStyle: const CalendarStyle(
            selectedDecoration:
            BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            todayDecoration: BoxDecoration(color: Color(0xFFB0C4DE), shape: BoxShape.circle)),
      ),
    );
  }
}