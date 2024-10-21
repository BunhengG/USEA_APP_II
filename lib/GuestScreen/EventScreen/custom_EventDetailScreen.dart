import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../theme/constants.dart';
import '../../theme/text_style.dart';
import '../../theme/fullscreen_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventDetailsPage extends StatefulWidget {
  final String imagePath;
  final String title;
  final String body;
  final String eventDate;
  final String eventTime;

  const EventDetailsPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.body,
    required this.eventDate,
    required this.eventTime,
  });

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollOffsetNotifier =
      ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _scrollOffsetNotifier.dispose();
    super.dispose();
  }

  void _scrollListener() {
    _scrollOffsetNotifier.value = _scrollController.offset;
  }

  void _showImagePreview() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return StaticFullscreenImagePage(imageUrl: widget.imagePath);
        },
        transitionsBuilder: _buildPageTransition,
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventDate = widget.eventDate;
    final eventTime = widget.eventTime;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          _buildSliverAppBar(),
          _buildSliverList(eventDate, eventTime),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      pinned: true,
      backgroundColor: cl_ThirdColor,
      surfaceTintColor: cl_ThirdColor,
      elevation: 4.0,
      leading: _buildAppBarLeadingIcon(),
      flexibleSpace: FlexibleSpaceBar(
        background: GestureDetector(
          onTap: _showImagePreview,
          child: CachedNetworkImage(
            imageUrl: widget.imagePath,
            placeholder: (context, url) => Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/icon/loading_image.png',
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              fit: BoxFit.cover,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarLeadingIcon() {
    return ValueListenableBuilder<double>(
      valueListenable: _scrollOffsetNotifier,
      builder: (context, offset, child) {
        final color = offset > 90 ? cl_TextColor : cl_ThirdColor;
        final decoration = BoxDecoration(
          color: offset > 90 ? Colors.transparent : Colors.black26,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        );

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          decoration: decoration,
          child: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.angleLeft,
              size: 18,
              color: color,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        );
      },
    );
  }

  Widget _buildSliverList(String eventDate, String eventTime) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(widget.title),
                const SizedBox(height: 16.0),
                _buildBody(widget.body),
                const SizedBox(height: 16.0),
                _buildDateTimeRow(eventDate, eventTime),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getTitleLargePrimaryColorTextStyle(),
        ),
        const SizedBox(height: 16.0),
        Container(
          width: 160,
          color: cl_SecondaryColor,
          height: 3,
        ),
      ],
    );
  }

  Widget _buildBody(String body) {
    return Text(
      body,
      textAlign: TextAlign.justify,
      style: getBodyLargeTextStyle(),
    );
  }

  Widget _buildDateTimeRow(String date, String time) {
    return Row(
      children: [
        _buildDateTimeIcon(FontAwesomeIcons.solidCalendarDays, date),
        const SizedBox(width: 16.0),
        _buildDateTimeIcon(FontAwesomeIcons.solidClock, time),
      ],
    );
  }

  Widget _buildDateTimeIcon(IconData icon, String text) {
    return Row(
      children: [
        FaIcon(
          icon,
          color: cl_PlaceholderColor,
          size: 12.0,
        ),
        const SizedBox(width: 5.0),
        Text(
          text,
          style: getBodyMediumTextStyle().copyWith(
            color: cl_PlaceholderColor,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildPageTransition(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animation);
    final offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: Offset.zero,
    ).animate(animation);

    return ScaleTransition(
      scale: scaleAnimation,
      child: SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(
          opacity: scaleAnimation,
          child: child,
        ),
      ),
    );
  }
}
