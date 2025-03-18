
import 'package:memory_notes_organizer/models/reminder.dart';

class Hourly  {
  bool everyHour = true;
  int hours;
  int minutes;

  Hourly(this.everyHour, this.hours, this.minutes);
}

class Daily  {
   bool every = true;
   int days;

   Daily(this.every, this.days);
}

class Weekly  {
   int weeks;
   bool sunday;
   bool monday;
   bool tuesday;
   bool wednesday;
   bool thursday;
   bool friday;
   bool saturday;

   Weekly(this.weeks, this.sunday, this.monday, this.tuesday, this.wednesday,
      this.thursday, this.friday, this.saturday);
}
class Monthly  {
   bool day = true;
   int days;
   int months;
   WeekNumber weekOfMonth = WeekNumber.first;
   DayOfWeek dayOfWeek = DayOfWeek.day;
   int everyMonth;

   Monthly(this.day, this.days, this.months, this.weekOfMonth, this.dayOfWeek,
      this.everyMonth);
}

class Yearly  {
   bool every = true;
   Months month;
   int monthDay;
   WeekNumber weekOfMonth;
   DayOfWeek dayOfWeek;

   Yearly(
      this.every, this.month, this.monthDay, this.weekOfMonth, this.dayOfWeek);
}
