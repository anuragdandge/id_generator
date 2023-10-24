class CreateEventModel {
  final String eventTitle;
  final String eventDescription;
  final String eventAddress;
  final String eventStartDate;
  final String eventEndDate;
  final String eventStartTime;
  final String eventEndTime;

  CreateEventModel({
    required this.eventTitle,
    required this.eventDescription,
    required this.eventAddress,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventStartTime,
    required this.eventEndTime,
  });
}
