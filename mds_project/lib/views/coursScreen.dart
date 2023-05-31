import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import './mainScreen.Dart';

class coursScreen extends StatefulWidget {
  const coursScreen({super.key});

  @override
  coursScreenState createState() => coursScreenState();
}

class coursScreenState extends State<coursScreen> {
  late VideoPlayerController _controller;

  bool _isPlaying = false;

  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(minutes: 3), () {
      setState(() {
        _showButton = true;
      });
    });
    if (!kIsWeb) {
      _controller = VideoPlayerController.asset('assets/video/math.mp4')
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller.play();
      } else {
        _controller.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          (kIsWeb)
              ? Container(
                  margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  padding: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 2)),
                  ),
                  child: const Text(
                    "Lorem ipsum dolor sit amet, consecteturadipiscing elit, sed do eiusmod temporincididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquipex ea commodo consequat.Lorem ipsum dolor sit amet, consecteturadipiscing elit, sed do eiusmod temporincididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquipex ea commodo consequat.Lorem ipsum dolor sit amet, consecteturadipiscing elit, sed do eiusmod temporincididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquipex ea commodo consequat.Lorem ipsum dolor sit amet, consecteturadipiscing elit, sed do eiusmod temporincididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquipex ea commodo consequat.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Helvetica',
                        height: 1.3),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.fromLTRB(0, 200, 0, 100),
                  child: Center(
                    child: _controller.value.isInitialized
                        ? GestureDetector(
                            onTap: _togglePlayPause,
                            child: Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
          if (_showButton)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const mainScreen())); // action à effectuer lors du clic sur le bouton
              },
              child: const Text("Retour a l'écran principal"),
            ),
        ],
      ),
    );
  }
}
