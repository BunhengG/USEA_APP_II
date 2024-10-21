import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../MajorScreens/details_screen.dart';

class CustomAccordion extends StatefulWidget {
  final String title;
  final ImageProvider icon;
  final List<dynamic> majors;
  final bool isExpanded;
  final VoidCallback onToggle;

  const CustomAccordion({
    super.key,
    required this.title,
    required this.icon,
    required this.majors,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  _CustomAccordionState createState() => _CustomAccordionState();
}

class _CustomAccordionState extends State<CustomAccordion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _heightAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    if (widget.isExpanded) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(CustomAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = widget.majors.length * 72.0;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: cl_SecondaryColor,
        borderRadius: BorderRadius.circular(rd_MediumRounded),
        boxShadow: const [sd_BoxShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //! Header
          GestureDetector(
            onTap: widget.onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                color: cl_SecondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(rd_MediumRounded),
                  topRight: const Radius.circular(rd_MediumRounded),
                  bottomLeft: widget.isExpanded
                      ? Radius.zero
                      : const Radius.circular(rd_MediumRounded),
                  bottomRight: widget.isExpanded
                      ? Radius.zero
                      : const Radius.circular(rd_MediumRounded),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    decoration: BoxDecoration(
                      color: cl_ThirdColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: widget.isExpanded
                            ? Radius.zero
                            : const Radius.circular(rd_MediumRounded),
                        topLeft: const Radius.circular(rd_MediumRounded),
                      ),
                    ),
                    child: Image(
                      image: widget.icon,
                      width: 46.0,
                      height: 46.0,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        widget.title,
                        style: getListTileTitle(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: cl_PrimaryColor,
                      borderRadius: BorderRadius.circular(rd_FullRounded),
                    ),
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(
                      widget.isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: cl_ThirdColor,
                      size: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //! body
          SizeTransition(
            sizeFactor: _heightAnimation,
            axisAlignment: 1.0,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 78,
                    //! Dynamically set height based on the number of children
                    height: totalHeight,
                    decoration: const BoxDecoration(
                      color: cl_ThirdColor, //? Sidebar color
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(rd_MediumRounded),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: widget.majors.map((major) {
                        final majorName = major['major_name'];
                        final degreeDetails = major['major_data'];
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                          title: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: cl_ThirdColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    majorName,
                                    style: getListTileBody(),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12.0,
                                  color: cl_TextColor,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              SwipeablePageRoute(
                                builder: (context) => DetailsScreen(
                                  title: majorName,
                                  degreeDetails: degreeDetails,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
