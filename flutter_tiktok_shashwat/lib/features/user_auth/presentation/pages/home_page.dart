// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late VideoPlayerController controller;

//   @override
//   void initState() {
//     loadVideoPlayer();
//     super.initState();
//   }

//   loadVideoPlayer() {
//     controller = VideoPlayerController.asset('assets/videos/butterfly.mp4');
//     controller.addListener(() {
//       setState(() {});
//     });
//     controller.initialize().then((value) {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Likes, Comments, and Creator Text
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Likes 100k • Comments 10k',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   'Creator Name',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//           // Video Player
//           Expanded(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 if (controller.value.isInitialized)
//                   AspectRatio(
//                     aspectRatio: controller.value.aspectRatio,
//                     child: VideoPlayer(controller),
//                   ),
//                 if (!controller.value.isInitialized)
//                   CircularProgressIndicator(),
//                 GestureDetector(
//                   onTap: () {
//                     if (controller.value.isPlaying) {
//                       controller.pause();
//                     } else {
//                       controller.play();
//                     }
//                     setState(() {});
//                   },
//                 ),
//               ],
//             ),
//           ),
//           // Controls
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     if (controller.value.isPlaying) {
//                       controller.pause();
//                     } else {
//                       controller.play();
//                     }
//                     setState(() {});
//                   },
//                   icon: Icon(
//                     controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                     color: Colors.white,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     controller.seekTo(Duration(seconds: 0));
//                     setState(() {});
//                   },
//                   icon: Icon(
//                     Icons.stop,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController controller;
  bool isLiked = false;
  bool isDisliked = false;
  bool isCommentOpen = false;

  @override
  void initState() {
    super.initState();
    loadVideoPlayer();
  }

  loadVideoPlayer() async {
    controller = VideoPlayerController.asset('assets/videos/butterfly.mp4');
    await controller.initialize();
    controller.addListener(() {
      setState(() {});
    });
    controller.play(); // Start playing the video automatically
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video Player
          Expanded(
            child: controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
          // Controls
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                      color: isLiked ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                        isDisliked = false;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
                      color: isDisliked ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isDisliked = !isDisliked;
                        isLiked = false;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.comment, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        isCommentOpen = true;
                      });
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height / 2,
                          color: Colors.white,
                          child: Center(child: Text('Comments Section')),
                        ),
                      ).whenComplete(() {
                        setState(() {
                          isCommentOpen = false;
                        });
                      });
                    },
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
