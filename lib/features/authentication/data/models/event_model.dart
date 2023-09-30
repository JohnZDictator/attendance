import 'package:intl/intl.dart';

import '../../../features.dart';

class EventModel extends Event {
  EventModel({
    required super.id,
    required super.name,
    required super.dateTime,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? 0,
      name: json['eventName'] ?? '',
      dateTime:
          DateFormat('dd/MM/yyyy').parse(json['dateStamp'] ?? DateTime.now()),
    );
  }
}
