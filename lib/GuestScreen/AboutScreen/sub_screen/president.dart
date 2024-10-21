import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import '../../../theme/text_style.dart';
import '../../components/circularProgressIndicator.dart';
import '../../../theme/fullscreen_image.dart';
import '../../../localString/Data/dummy_data.dart';

class PresidentMessageScreen extends StatefulWidget {
  const PresidentMessageScreen({super.key});

  void preloadImages(List<String> urls, BuildContext context) {
    for (var url in urls) {
      precacheImage(NetworkImage(url), context);
    }
  }

  @override
  _PresidentMessageScreenState createState() => _PresidentMessageScreenState();
}

class _PresidentMessageScreenState extends State<PresidentMessageScreen> {
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
              'https://drive.google.com/uc?export=view&id=15-dCtzwMrvlrMvTw9aFYIV8B0f7a1Ref',
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
      MaterialPageRoute(
        builder: (context) => const StaticFullscreenImagePage(
          imageUrl:
              'https://drive.google.com/uc?export=view&id=15-dCtzwMrvlrMvTw9aFYIV8B0f7a1Ref',
        ),
      ),
    );
  }

  SliverList _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final item = useaPresident[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Title
                Text(
                  'សាររបស់សាកលវិទ្យាធិការ'.tr,
                  style: getTitleLargePrimaryColorTextStyle()
                      .copyWith(fontSize: 24),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  height: 3,
                  width: 150,
                  decoration: const BoxDecoration(
                    color: cl_SecondaryColor,
                  ),
                ),
                const SizedBox(height: 10.0),
                // Description
                ...(item['description'] as List<String>)
                    .map(
                      (desc) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          desc,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: cl_TextColor,
                            fontFamily: ft_Eng,
                          ),
                        ),
                      ),
                    )
                    ,
                const SizedBox(height: 16.0),
              ],
            ),
          );
        },
        childCount: useaPresident.length,
      ),
    );
  }
}
