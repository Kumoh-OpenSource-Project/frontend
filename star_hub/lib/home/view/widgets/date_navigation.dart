import 'package:flutter/material.dart';

class DateNavigation extends StatefulWidget {
  const DateNavigation({
    Key? key,
  }) : super(key: key);

  @override
  _DateNavigationState createState() => _DateNavigationState();
}

class _DateNavigationState extends State<DateNavigation> {
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
  }

  bool get isPreviousButtonEnabled {
    DateTime previousDate = currentDate.subtract(const Duration(days: 1));
    return previousDate
        .isAfter(DateTime.now().subtract(const Duration(days: 1)));
  }

  bool get isNextButtonEnabled {
    DateTime nextDate = currentDate.add(const Duration(days: 1));
    return nextDate.isBefore(DateTime.now().add(const Duration(days: 5)));
  }

  void goToPreviousDay() {
    setState(() {
      if (isPreviousButtonEnabled) {
        currentDate = currentDate.subtract(const Duration(days: 1));
      }
    });
  }

  void goToNextDay() {
    setState(() {
      if (isNextButtonEnabled) {
        currentDate = currentDate.add(const Duration(days: 1));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: isPreviousButtonEnabled ? goToPreviousDay : null,
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
            ),
            color: isPreviousButtonEnabled ? Colors.white : Colors.grey,
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  _getFormattedWeekday(currentDate),
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  '${currentDate.month}월 ${currentDate.day}일',
                  style: const TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: isNextButtonEnabled ? goToNextDay : null,
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
            color: isNextButtonEnabled ? Colors.white : Colors.grey,
          ),
        ],
      ),
    );
  }

  String _getFormattedWeekday(DateTime date) {
    const weekdays = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    return weekdays[date.weekday - 1];
  }
}
