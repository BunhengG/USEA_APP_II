// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:useaapp_version_2/GuestScreen/components/multi_Appbar.dart';
// import 'package:useaapp_version_2/theme/constants.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import '../model/video_model.dart';
// import 'custom_Playback_Speed.dart'; // Adjust import

// class Video_Display extends StatefulWidget {
//   final VDO_Class data;
//   final List<VDO_Class> vdo;

//   const Video_Display({Key? key, required this.data, required this.vdo})
//       : super(key: key);

//   @override
//   _Video_DisplayState createState() => _Video_DisplayState();
// }

// void _navigateBack(BuildContext context) {
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     if (Navigator.canPop(context)) {
//       Navigator.of(context).pop();
//     } else {
//       print('Cannot pop, navigator stack is empty or locked.');
//     }
//   });
// }

// class _Video_DisplayState extends State<Video_Display> {
//   late YoutubePlayerController _youtubeController;
//   late bool _isMuted = false;
//   late final ValueNotifier<bool> _isFullScreenNotifier =
//       ValueNotifier<bool>(false);

//   @override
//   void initState() {
//     super.initState();
//     _youtubeController = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId(widget.data.link)!,
//       flags: const YoutubePlayerFlags(
//         forceHD: true,
//         loop: true,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerBuilder(
//       player: YoutubePlayer(
//         controller: _youtubeController,
//         showVideoProgressIndicator: true,
//         bottomActions: [
//           Expanded(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   height: 0,
//                   child: const ProgressBar(
//                     isExpanded: false,
//                     colors: ProgressBarColors(
//                       playedColor: Colors.red,
//                       bufferedColor: Colors.grey,
//                       handleColor: Colors.red,
//                       backgroundColor: Colors.black,
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         const CurrentPosition(),
//                         const RemainingDuration(),
//                         IconButton(
//                           iconSize: 20,
//                           color: cl_ThirdColor,
//                           icon: _isMuted
//                               ? const Icon(Icons.volume_off)
//                               : const Icon(Icons.volume_up),
//                           onPressed: () {
//                             setState(() {
//                               _isMuted = !_isMuted;
//                               _isMuted
//                                   ? _youtubeController.mute()
//                                   : _youtubeController.unMute();
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         CustomPlaybackSpeedButton(
//                           controller: _youtubeController,
//                         ),
//                         IconButton(
//                           iconSize: 20,
//                           color: cl_ThirdColor,
//                           icon: _isFullScreenNotifier.value
//                               ? const Icon(Icons.fullscreen_exit)
//                               : const Icon(Icons.fullscreen),
//                           onPressed: () {
//                             _youtubeController.toggleFullScreenMode();
//                             _isFullScreenNotifier.value =
//                                 !_isFullScreenNotifier.value;
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       builder: (context, player) {
//         return Scaffold(
//           // backgroundColor: Colors.transparent,
//           appBar: MultiAppBar(
//             title: 'Video',
//             onBackButtonPressed: () {
//               if (Navigator.canPop(context)) {
//                 Navigator.of(context).pop();
//               }
//             },
//           ),
//           body: Stack(
//             children: [
//               Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(color: cl_ThirdColor),
//               ),
//               ListView(
//                 children: [
//                   player,
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       widget.data.title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: ft_Eng,
//                         color: cl_TextColor,
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   const Divider(
//                     thickness: 0.5,
//                     color: cl_PrimaryColor,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     width: double.infinity,
//                     child: Text(
//                       widget.data.caption,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: cl_TextColor,
//                         fontFamily: ft_Khmer_cont,
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _youtubeController.dispose();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }
// }