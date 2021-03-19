import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void main() {
  return runApp(CalendarTimeline());
}

class CalendarTimeline extends StatefulWidget {
  @override
  BlackoutDates createState() => BlackoutDates();
}

class BlackoutDates extends State<CalendarTimeline> {
  DateRangePickerController _controller;
  List<String> _months;
  bool _selected;
  int _selectedIndex;

  @override
  void initState() {
    _controller = DateRangePickerController();
    _months = <String>[
      'JANUARY',
      'FEBRUARY',
      'MARCH',
      'APRIL',
      'MAY',
      'JUNE',
      'JULY',
      'AUGUST',
      'SEPTEMBER',
      'OCTOBER',
      'NOVEMBER',
      'DECEMBER'
    ];
    _selected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: Stack(
          children: [
              SizedBox(
                child: Container(
                  color: Color(0xFF192841),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _months.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selected = true;
                                _selectedIndex = index;
                                _controller.displayDate =
                                    DateTime(2021, _selectedIndex, 1, 9, 0, 0);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 15, top: 5),
                              height: 2,
                              color: Color(0xFF192841),
                              child: Column(
                                children: [
                                  Container(
                                      child: Text(_months[index],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: _selected &&
                                                      _selectedIndex == index
                                                  ? FontWeight.w900
                                                  : FontWeight.w400))),
                                ],
                              ),
                            ));
                      }),
                ),
              ),
            Card(
              margin: const EdgeInsets.fromLTRB(05, 40, 05, 500),
              child: SfDateRangePicker(
                backgroundColor: Color(0xFF192841),
                controller: _controller,
                selectionColor: Colors.red.shade400,
                view: DateRangePickerView.month,
                headerHeight: 0,
                cellBuilder: cellBuilder,
                monthViewSettings: DateRangePickerMonthViewSettings(
                    viewHeaderHeight: 0, numberOfWeeksInView: 1),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget cellBuilder(BuildContext context, DateRangePickerCellDetails details) {
    var IsSelected = _controller.selectedDate != null &&
        details.date.year == _controller.selectedDate.year &&
        details.date.month == _controller.selectedDate.month &&
        details.date.day == _controller.selectedDate.day;
    if (IsSelected) {
      return Column(
        children: [
          Container(
            child: Text(
              details.date.day.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
              child: Text(
            DateFormat('EEE').format((details.date)),
            style: TextStyle(color: Colors.white),
          )),
        ],
      );
    } else {
      return Container(
        child: Text(
          details.date.day.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.tealAccent),
        ),
      );
    }
  }
}
