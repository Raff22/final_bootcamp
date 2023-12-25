class WorkingHours {
  final String id;
  final bool hour10am;
  final bool hour11am;
  final bool hour12pm;
  final bool hour1pm;
  final bool hour2pm;
  final bool hour3pm;
  final bool hour4pm;
  final bool hour5pm;
  final bool hour6pm;
  final bool hour7pm;

  WorkingHours({
    required this.id,
    required this.hour10am,
    required this.hour11am,
    required this.hour12pm,
    required this.hour1pm,
    required this.hour2pm,
    required this.hour3pm,
    required this.hour4pm,
    required this.hour5pm,
    required this.hour6pm,
    required this.hour7pm,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> jsonData) {
    return WorkingHours(
      id: jsonData['id'],
      hour10am: jsonData['10am'],
      hour11am: jsonData['11am'],
      hour12pm: jsonData['12pm'],
      hour1pm: jsonData['1pm'],
      hour2pm: jsonData['2pm'],
      hour3pm: jsonData['3pm'],
      hour4pm: jsonData['4pm'],
      hour5pm: jsonData['5pm'],
      hour6pm: jsonData['6pm'],
      hour7pm: jsonData['7pm'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      '10am': hour10am,
      '11am': hour11am,
      '12pm': hour12pm,
      '1pm': hour1pm,
      '2pm': hour2pm,
      '3pm': hour3pm,
      '4pm': hour4pm,
      '5pm': hour5pm,
      '6pm': hour6pm,
      '7pm': hour7pm,
    };
  }
}
