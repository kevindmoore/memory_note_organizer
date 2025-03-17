import 'package:note_master/models/time.dart';

enum RecurType {
  hourly,
  daily,
  weekly,
  monthly,
  yearly
}
enum WeekNumber {
  first,
  second,
  third,
  fourth,
  last
}
enum DayOfWeek {
  day,
  weekday,
  weekend,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}
enum Months {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december
}

enum EndType {
  noEnd,
  endByDate,
  occurs
}

 class Reminder {
    bool active = false;
    DateTime startDate;
    DateTime time;
    DateTime endDate;
    bool recurrence = false;
    RecurType recurType;
    EndType endType;
    int occurs;
    Hourly hourly;
    Daily daily;
    Weekly weekly;
    Monthly monthly;
    Yearly yearly;

    Reminder(this.active, this.startDate, this.time, this.endDate,
        this.recurrence, this.recurType, this.endType, this.occurs, this.hourly,
        this.daily, this.weekly, this.monthly, this.yearly);

 }
