class WorkingHours {
  String? id;
  bool? hour10am;
  bool? hour11am;
  bool? hour12pm;
  bool? hour1pm;
  bool? hour2pm;
  bool? hour3pm;
  bool? hour4pm;
  bool? hour5pm;
  bool? hour6pm;
  bool? hour7pm;

  WorkingHours({
    this.id,
    this.hour10am,
    this.hour11am,
    this.hour12pm,
    this.hour1pm,
    this.hour2pm,
    this.hour3pm,
    this.hour4pm,
    this.hour5pm,
    this.hour6pm,
    this.hour7pm,
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
