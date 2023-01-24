/* This is free and unencumbered software released into the public domain. */

import 'package:flutter/material.dart';
//import 'package:model_viewer/model_viewer.dart';

void main() => runApp(MyApp2());

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Model Viewer")),
        /*  body: ModelViewer(
          backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
          //src: 'assets/testv2.glb', // a bundled asset file
          alt: "A 3D model of an astronaut",
          ar: true,
          //arModes: ['scene-viewer', 'webxr', 'quick-look'],
          autoRotate: true,
          autoPlay: true,
          src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
          cameraControls: true,
          //  iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
          // disableZoom: true,
        ), */
      ),
    );
  }
}
