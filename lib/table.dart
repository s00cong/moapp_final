import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({Key? key}) : super(key: key);

  @override
  State<TableCalendarScreen> createState() => _TableCalendarScreenState();
}
class Event {
  String title;
  bool complete;
  Event(this.title, this.complete);

  @override
  String toString() => title;
}
Map<DateTime,dynamic> eventSource = {
  DateTime.utc(2022,11,3) : [Event('5분 기도하기',false),Event('교회 가서 인증샷 찍기',true),Event('QT하기',true),Event('셀 모임하기',false),],
  DateTime.utc(2022,12,5) : [Event('5분 기도하기',false),Event('치킨 먹기',true),Event('QT하기',true),Event('셀 모임하기',false),],
  DateTime.utc(2022,12,28) : [Event('5분 기도하기',false),Event('자기 셀카 올리기',true),Event('QT하기',false),Event('셀 모임하기',false),],
  DateTime.utc(2023,1,11) : [Event('5분 기도하기',false),Event('가족과 저녁식사 하기',true),Event('QT하기',true)],
  DateTime.utc(2023,1,13) : [Event('5분 기도하기',false),Event('교회 가서 인증샷 찍기',true),Event('QT하기',false),Event('셀 모임하기',false),],
  DateTime.utc(2023,1,15) : [Event('5분 기도하기',false),Event('치킨 먹기',false),Event('QT하기',true),Event('셀 모임하기',false),],
  DateTime.utc(2023,1,18) : [Event('5분 기도하기',false),Event('자기 셀카 올리기',true),Event('QT하기',false),Event('셀 모임하기',false),],
  DateTime.utc(2023,1,20) : [Event('5분 기도하기',true),Event('자기 셀카 올리기',true),Event('QT하기',true),Event('셀 모임하기',true),],
  DateTime.utc(2023,1,21) : [Event('5분 기도하기',false),Event('가족과 저녁식사 하기',true),Event('QT하기',false)]
};

class _TableCalendarScreenState extends State<TableCalendarScreen> {
  final events = LinkedHashMap(
    equals: isSameDay,
  )..addAll(eventSource);

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  // Map<DateTime, List<Event>> events = {
  //   DateTime.utc(2022,12,13) : [ Event('title'), Event('title2') ],
  //   DateTime.utc(2022,7,14) : [ Event('title3') ],
  // };

  // List<Event> _getEventsForDay(DateTime day) {
  //   return events[day] ?? [];
  // }

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
      ListView(
        children: [
          TableCalendar(

            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: focusedDay,

            headerStyle: const HeaderStyle(
              titleCentered: false,

            ),

            calendarStyle: const CalendarStyle(
              markerSize: 10.0,
              markerDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle
              ),
            ),
            eventLoader: _getEventsForDay,

            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              // 선택된 날짜의 상태를 갱신합니다.
              setState((){
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (DateTime day) {
              // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
              return isSameDay(selectedDay, day);
            },
          ),


        ],
      )


    );
  }
}
// class Event {
//   String title;
//
//   Event(this.title);
// }