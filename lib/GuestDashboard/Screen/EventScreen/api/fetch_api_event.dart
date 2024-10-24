import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api_domain.dart';
import '../model/eventModel.dart';

// Function to fetch all events data
Future<List<dynamic>> fetchEventsData() async {
  final apiUrl = ApiConfig.getEventDataUrl(Get.locale?.languageCode ?? 'kh');

  await Future.delayed(const Duration(milliseconds: 500));

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['event'] is List) {
      return data['event'] as List<dynamic>;
    } else {
      throw Exception('Unexpected data format');
    }
  } else {
    throw Exception('Failed to load events');
  }
}

//! Function to fetch current events
Future<List<Event>> fetchCurrentEvents() async {
  final events = await fetchEventsData();

  final currentEvents = (events).firstWhere(
    (event) =>
        event['event_name'] == 'ព្រឹត្តិការណ៍ថ្មីៗ' ||
        event['event_name'] == 'Current Events ',
    orElse: () => {'event_data': []},
  );
  final eventData = (currentEvents['event_data'] as List)
      .map((item) => Event.fromJson(item))
      .toList();
  return eventData;
}

//! Function to fetch past events
Future<List<Event>> fetchPastEvents() async {
  final events = await fetchEventsData();

  final pastEvents = (events).firstWhere(
    (event) =>
        event['event_name'] == 'ព្រឹត្តិការណ៍មុនៗ' ||
        event['event_name'] == 'Past Events',
    orElse: () => {'event_data': []},
  );
  final eventData = (pastEvents['event_data'] as List)
      .map((item) => Event.fromJson(item))
      .toList();
  return eventData;
}

//! Function to fetch upcoming events
Future<List<Event>> fetchUpcomingEvents() async {
  final events = await fetchEventsData();

  final upcomingEvents = (events).firstWhere(
    (event) =>
        event['event_name'] == 'ព្រឹត្តិការណ៍នាពេលខាងមុខ' ||
        event['event_name'] == 'Upcoming Events',
    orElse: () => {'event_data': []},
  );
  final eventData = (upcomingEvents['event_data'] as List)
      .map((item) => Event.fromJson(item))
      .toList();
  return eventData;
}
