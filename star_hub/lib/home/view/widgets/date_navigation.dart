import 'package:flutter/material.dart';

class DateNavigation extends StatefulWidget {
  final DateTime currentDate;
  final Function(DateTime) onDateSelected;

  const DateNavigation({
    Key? key,
    required this.currentDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _DateNavigationState createState() => _DateNavigationState();
}

class _DateNavigationState extends State<DateNavigation> {
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = widget.currentDate;
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
    if (isPreviousButtonEnabled) {
      final previousDate = currentDate.subtract(const Duration(days: 1));
      setState(() {
        currentDate = previousDate;
      });
      widget.onDateSelected(previousDate);
    }
  }

  void goToNextDay() {
    if (isNextButtonEnabled) {
      final nextDate = currentDate.add(const Duration(days: 1));
      setState(() {
        currentDate = nextDate;
      });
      widget.onDateSelected(nextDate);
    }
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
          const SizedBox(width: 10),
          SizedBox(
            width: 130,
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
          const SizedBox(width: 10),
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
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[date.weekday - 1];
  }
}
