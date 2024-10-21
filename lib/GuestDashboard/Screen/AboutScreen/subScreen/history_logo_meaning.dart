import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import '../../../../theme/localString/Data/dummy_data.dart';
import '../../../../theme/text_style.dart';
import '../../../../components/circularProgressIndicator.dart';
import '../../../../theme/fullscreen_image.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  void preloadImages(List<String> urls, BuildContext context) {
    for (var url in urls) {
      precacheImage(NetworkImage(url), context);
    }
  }

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollOffsetNotifier =
      ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    _scrollOffsetNotifier.value = _scrollController.offset;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _scrollOffsetNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cl_ThirdColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildSliverAppBar(),
          _buildSliverList(),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      pinned: true,
      backgroundColor: cl_ThirdColor,
      surfaceTintColor: cl_ThirdColor,
      elevation: 4.0,
      leading: _buildAnimatedLeadingIcon(),
      flexibleSpace: _buildFlexibleSpace(),
    );
  }

  Widget _buildAnimatedLeadingIcon() {
    return ValueListenableBuilder<double>(
      valueListenable: _scrollOffsetNotifier,
      builder: (context, offset, child) {
        final color = offset > 95 ? cl_TextColor : cl_ThirdColor;
        final decoration = _buildIconDecoration(offset);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          decoration: decoration,
          child: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.xmark,
              size: 18,
              color: color,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        );
      },
    );
  }

  BoxDecoration _buildIconDecoration(double offset) {
    return BoxDecoration(
      color: offset > 95 ? Colors.transparent : Colors.black38,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildFlexibleSpace() {
    return FlexibleSpaceBar(
      background: GestureDetector(
        onTap: _navigateToFullscreenImage,
        child: CachedNetworkImage(
          imageUrl:
              'https://drive.google.com/uc?export=view&id=1uRacfJ2QC7rbr8n9kZNaQ9Mf2uT7aRz7',
          width: double.infinity,
          height: 250.0,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const CircularProgressIndicatorWidget(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  void _navigateToFullscreenImage() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return _buildFullscreenImageTransition(animation);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return _buildTransition(animation, child);
        },
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  Widget _buildFullscreenImageTransition(Animation<double> animation) {
    final screenSize = MediaQuery.of(context).size;
    final centerOffset = Offset(screenSize.width / 2, screenSize.height / 2);

    final scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeOut),
    );

    final offsetAnimation = Tween<Offset>(
      begin: Offset(
        (centerOffset.dx - 0) / screenSize.width,
        (centerOffset.dy - 0) / screenSize.height,
      ),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeOut),
    );

    return ScaleTransition(
      scale: scaleAnimation,
      child: SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(
          opacity: scaleAnimation,
          child: const StaticFullscreenImagePage(
            imageUrl:
                'https://drive.google.com/uc?export=view&id=1uRacfJ2QC7rbr8n9kZNaQ9Mf2uT7aRz7',
          ),
        ),
      ),
    );
  }

  Widget _buildTransition(Animation<double> animation, Widget child) {
    final scaleTransition =
        Tween<double>(begin: 0.8, end: 1.0).animate(animation);
    final offsetTransition =
        Tween<Offset>(begin: const Offset(0.0, 0.0), end: Offset.zero)
            .animate(animation);

    return ScaleTransition(
      scale: scaleTransition,
      child: SlideTransition(
        position: offsetTransition,
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }

  SliverList _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final item = historyWithTextList[index];
          return _buildHistoryItem(item);
        },
        childCount: historyWithTextList.length,
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildHistoryTitle(item['title']),
          _buildTitleUnderline(),
          const SizedBox(height: 10.0),
          _buildHistoryDescription(item['description']),
          const SizedBox(height: 24.0),
          const HistoryLogo(),
          ..._buildTextList(item['textList']),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildHistoryTitle(String? title) {
    return Text(
      'ប្រវត្តិ និងអត្ថន័យរបស់និមិត្តសញ្ញា'.tr,
      style: getTitleLargePrimaryColorTextStyle().copyWith(fontSize: 24),
    );
  }

  Widget _buildTitleUnderline() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 3,
      width: 150,
      decoration: const BoxDecoration(
        color: cl_SecondaryColor,
      ),
    );
  }

  Widget _buildHistoryDescription(String? description) {
    return Text(
      description ?? '',
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 13,
        height: 1.5,
        color: cl_TextColor,
        fontFamily: ft_Eng,
      ),
    );
  }

  List<Widget> _buildTextList(List<String>? textList) {
    return textList?.map((text) => _buildTextListItem(text)).toList() ?? [];
  }

  Widget _buildTextListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 10.0,
            backgroundColor: cl_ThirdColor,
            child: FaIcon(
              FontAwesomeIcons.solidCircle,
              color: cl_TextColor,
              size: 10,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 12.0,
                color: cl_TextColor,
                fontFamily: ft_Eng,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryLogo extends StatelessWidget {
  const HistoryLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogo(
            'https://drive.google.com/uc?export=view&id=1lUnsq0rYN5JX_tfPvdrIwZFk3KiMLzlu',
          ),
          const SizedBox(width: 8),
          _buildLogo(
            'https://drive.google.com/uc?export=view&id=1RM5kJAX9H-Jv0oif2h2cyVpqMHAyoJVU',
          ),
          const SizedBox(width: 8),
          _buildLogo(
            'https://drive.google.com/uc?export=view&id=1ehtnWf5UDruhl3s1sN9McmOFqYTurmu6',
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(String assetPath) {
    return CachedNetworkImage(
      imageUrl: assetPath,
      width: 90,
      fit: BoxFit.cover,
      placeholder: (context, url) => const CircularProgressIndicatorWidget(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
