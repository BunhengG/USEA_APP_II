import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomPlaybackSpeedButton extends StatefulWidget {
  final YoutubePlayerController controller;

  const CustomPlaybackSpeedButton({super.key, required this.controller});

  @override
  _CustomPlaybackSpeedButtonState createState() =>
      _CustomPlaybackSpeedButtonState();
}

class _CustomPlaybackSpeedButtonState extends State<CustomPlaybackSpeedButton> {
  double? currentSpeed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 20,
      color: Colors.white,
      icon: const Icon(
        Icons.speed,
      ),
      onPressed: () {
        showPlaybackSpeedMenu(context);
      },
    );
  }

  void showPlaybackSpeedMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(
          Offset.zero,
          ancestor: overlay,
        ),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final selectedSpeed = await showMenu<double>(
      context: context,
      position: position,
      items: const [
        PopupMenuItem(
          value: 0.25,
          child: Text('0.25x'),
        ),
        PopupMenuItem(
          value: 0.5,
          child: Text('0.5x'),
        ),
        PopupMenuItem(
          value: 1.0,
          child: Text('Normal'),
        ),
        PopupMenuItem(
          value: 1.25,
          child: Text('1.25x'),
        ),
        PopupMenuItem(
          value: 1.5,
          child: Text('1.5x'),
        ),
        PopupMenuItem(
          value: 2.0,
          child: Text('2.0x'),
        ),
      ],
    );

    if (selectedSpeed != null) {
      widget.controller.setPlaybackRate(selectedSpeed);
      setState(() {
        currentSpeed = selectedSpeed;
      });
    }
  }
}
