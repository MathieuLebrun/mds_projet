import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:video_player/video_player.dart';

class coursScreen extends StatefulWidget {
  coursScreen();

  @override
  _coursScreenState createState() => _coursScreenState();
}

class _coursScreenState extends State<coursScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(minutes: 3), () {
      setState(() {
        _showButton = true;
      });
    });

    _controller = VideoPlayerController.asset('assets/video/math.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
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
      appBar: AppBar(
        title: Text('Cours de drill UK 2022'),
      ),
      body: Column(
        children: [
          Center(
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
                : SizedBox(),
          ),
          if (_showButton)
            ElevatedButton(
              onPressed: () {
                /*
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryPage(
                            category: categories
                                .first)));  */ // action à effectuer lors du clic sur le bouton
              },
              child: Text("Passer à l'exercice"),
            ),
          SizedBox(
            width: 500,
            height: 396,
            child: ModelViewer(
              // backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
              src: 'assets/clavier.gltf', // a bundled asset file
              alt: "A 3D model of an astronaut",
              ar: true,
              //arModes: ['scene-viewer', 'webxr', 'quick-look'],
              autoRotate: true,
              autoPlay: true,
              // src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
              cameraControls: true,
              //  iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
              // disableZoom: true,
            ),
          ),
        ],
      ),
    );
  }
}
