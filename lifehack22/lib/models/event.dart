class Event {

  final String eventId;
  final String imageUrl;
  final String title;
  final dynamic dateTime;
  final String region;
  final dynamic quota;
  final String activityType;
  final String community;
  final String details;
  final String organiserUid;
  final dynamic participantsList;

  const Event({
    required this.eventId,
    required this.imageUrl,
    required this.title,
    required this.dateTime,
    required this.region,
    required this.quota,
    required this.activityType,
    required this.community,
    required this.details,
    required this.organiserUid,
    required this.participantsList,
  });

  int compareTo(Event event) {
    return event.dateTime.compareTo(event.dateTime);
  }
}
