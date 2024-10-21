import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/components/multi_Appbar.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../theme/text_style.dart';
import '../model/video_model.dart';
import 'custom_Playback_Speed.dart';

class VideoDisplay extends StatefulWidget {
  final VDO_Class data;
  final List<VDO_Class> vdo;

  const VideoDisplay({
    super.key,
    required this.data,
    required this.vdo,
  });

  @override
  _VideoDisplayState createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  late YoutubePlayerController _youtubeController;
  late int _currentVideoIndex;
  bool _isMuted = false;
  final ValueNotifier<bool> _isFullScreenNotifier = ValueNotifier<bool>(false);

  void _handleFullScreen() {
    if (_youtubeController.value.isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.leanBack,
      );
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  @override
  void initState() {
    super.initState();
    _currentVideoIndex = widget.vdo.indexOf(widget.data);
    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.data.link)!,
      flags: const YoutubePlayerFlags(
        forceHD: true,
        loop: true,
        disableDragSeek: true,
        autoPlay: true,
        enableCaption: true,
        controlsVisibleAtStart: true,
        hideControls: false,
      ),
    );
    _youtubeController.addListener(_handleFullScreen);
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        bottomActions: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProgressBar(
                  isExpanded: false,
                  colors: const ProgressBarColors(
                    playedColor: Colors.red,
                    bufferedColor: cl_ThirdColor,
                    handleColor: Colors.red,
                    backgroundColor: cl_ThirdColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CurrentPosition(),
                        RemainingDuration(),
                        IconButton(
                          iconSize: 20,
                          color: cl_ThirdColor,
                          icon: Icon(
                            _isMuted ? Icons.volume_off : Icons.volume_up,
                          ),
                          onPressed: () {
                            setState(() {
                              _isMuted = !_isMuted;
                              _isMuted
                                  ? _youtubeController.mute()
                                  : _youtubeController.unMute();
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomPlaybackSpeedButton(
                          controller: _youtubeController,
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _isFullScreenNotifier,
                          builder: (context, isFullScreen, child) {
                            return IconButton(
                              iconSize: 20,
                              color: cl_ThirdColor,
                              icon: Icon(
                                isFullScreen
                                    ? Icons.fullscreen_exit
                                    : Icons.fullscreen,
                              ),
                              onPressed: () {
                                _youtubeController.toggleFullScreenMode();
                                _isFullScreenNotifier.value =
                                    !_isFullScreenNotifier.value;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: MultiAppBar(
            title: 'វីដេអូ',
            onBackButtonPressed: () {
              Get.back();
            },
          ),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: u_BackgroundScaffold,
                ),
              ),
              ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  player,
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.vdo[_currentVideoIndex].title,
                      style: getTitleLargeTextStyle(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(rd_SmallRounded),
                        color: cl_SecondaryColor,
                      ),
                      child: Text(
                        widget.vdo[_currentVideoIndex].caption.isNotEmpty
                            ? widget.vdo[_currentVideoIndex].caption
                            : 'No caption available',
                        style: getBodyLargeTextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _youtubeController.removeListener(_handleFullScreen);
    _youtubeController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }
}
