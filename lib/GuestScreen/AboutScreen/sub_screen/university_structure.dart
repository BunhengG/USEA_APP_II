import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import '../../../theme/text_style.dart';
import '../../components/circularProgressIndicator.dart';
import '../../../theme/fullscreen_image.dart'; // Import your fullscreen image widget
import '../../../localString/Data/dummy_data.dart';

class StructureScreen extends StatefulWidget {
  const StructureScreen({super.key});

  void preloadImages(List<String> urls, BuildContext context) {
    for (var url in urls) {
      precacheImage(NetworkImage(url), context);
    }
  }

  @override
  _StructureScreenState createState() => _StructureScreenState();
}

class _StructureScreenState extends State<StructureScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollOffsetNotifier =
      ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollOffsetNotifier.value = _scrollController.offset;
    });
  }

  @override
  void dispose() {
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
          _buildSliverAppBar(context),
          _buildContentList(),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      pinned: true,
      backgroundColor: cl_ThirdColor,
      elevation: 4.0,
      leading: ValueListenableBuilder<double>(
        valueListenable: _scrollOffsetNotifier,
        builder: (context, offset, child) {
          return _buildLeadingIcon(context, offset);
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: GestureDetector(
          onTap: () => _navigateToFullscreenImage(context),
          child: CachedNetworkImage(
            imageUrl:
                'https://drive.google.com/uc?export=view&id=1X7tBqx5Ih5v7GtVig8j88AYeMBPJPxnt',
            width: double.infinity,
            height: 250.0,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const CircularProgressIndicatorWidget(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon(BuildContext context, double offset) {
    final bool isScrolled = offset > 95;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: isScrolled ? Colors.transparent : Colors.black38,
        shape: BoxShape.circle,
        boxShadow: isScrolled
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: IconButton(
        icon: FaIcon(
          FontAwesomeIcons.xmark,
          size: 18,
          color: isScrolled ? cl_TextColor : cl_ThirdColor,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  SliverList _buildContentList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = useaStructure[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  // item['title'] ?? '',
                  'រចនាសម្ព័ន្ធរបស់សាកលវិទ្យាល័យ'.tr,
                  style: getTitleLargePrimaryColorTextStyle()
                      .copyWith(fontSize: 24),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  height: 3,
                  width: 150,
                  color: cl_SecondaryColor,
                ),
                const SizedBox(height: 10.0),
                Text(
                  item['description'] ?? '',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: cl_TextColor,
                    fontFamily: ft_Eng,
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          );
        },
        childCount: useaStructure.length,
      ),
    );
  }

  void _navigateToFullscreenImage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ScaleTransition(
          scale: animation,
          child: const StaticFullscreenImagePage(
            imageUrl:
                'https://drive.google.com/uc?export=view&id=1X7tBqx5Ih5v7GtVig8j88AYeMBPJPxnt',
          ),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}
