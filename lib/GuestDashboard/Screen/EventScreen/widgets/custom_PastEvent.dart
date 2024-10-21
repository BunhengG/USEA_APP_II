import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../../../theme/text_style.dart';
import '../api/fetch_api_event.dart';
import '../custom_EventDetailScreen.dart';
import '../model/eventModel.dart';
import 'custom_EventCard.dart';
import 'custom_EventShimmer.dart';

class PastEvent extends StatefulWidget {
  const PastEvent({super.key});

  @override
  PastEventState createState() => PastEventState();
}

class PastEventState extends State<PastEvent> {
  late Future<List<Event>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = fetchPastEvents();
  }

  void refreshEvents() {
    setState(() {
      futureEvents = fetchPastEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Text(
            'ព្រឹត្តិការណ៍មុនៗ'.tr,
            style:
                getTitleMediumTextStyle().copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: FutureBuilder<List<Event>>(
            future: futureEvents,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: EventCardShimmer(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No events found'));
              }

              final events = snapshot.data!;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 12.0),
                shrinkWrap: true,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        SwipeablePageRoute(
                          builder: (context) => EventDetailsPage(
                            imagePath: event.image,
                            title: event.title,
                            body: event.description,
                            eventDate: event.eventDate,
                            eventTime: event.time,
                          ),
                        ),
                      );
                    },
                    child: EventCard(
                      imagePath: event.image,
                      title: event.title,
                      body: event.description,
                      eventDate: event.eventDate,
                      eventTime: event.time,
                      bodyTextLimit: 80,
                      titleTextLimit: 30,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
