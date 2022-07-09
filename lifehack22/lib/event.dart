class Event {

  final String eventId;
  final String imageUrl;
  final String title;
  final dynamic dateTime;
  final String location;
  final int quota;
  final String activityType;
  final String community;
  final String details;
  final String contactName;
  final String contactNumber;
  final String contactEmail;
  final String organiserUid;
  final dynamic participantsList;

  const Event({
    required this.eventId,
    required this.imageUrl,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.quota,
    required this.activityType,
    required this.community,
    required this.details,
    required this.contactName,
    required this.contactNumber,
    required this.contactEmail,
    required this.organiserUid,
    required this.participantsList,
  });

  int compareTo(Event event) {
    return event.dateTime.compareTo(event.dateTime);
  }
}
