import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  Interpreter? _interpreter;
  List<String> _labels = [];
  bool _isInitialized = false;
  bool _isProcessing = false;
  String _predictionLabel = '...';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await requestCameraPermission();
    await _loadModel();
    await _initializeCamera();
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.request();
    if (!status.isGranted) {
      print("Camera permission denied");
    }
  }

  Future<void> _loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/model.tflite');
    final labelData = await rootBundle.loadString('assets/labels.txt');
    _labels = LineSplitter.split(labelData).toList();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
    setState(() {
      _isInitialized = true;
    });

    _cameraController.startImageStream((CameraImage image) {
      if (!_isProcessing) {
        _isProcessing = true;
        _classifyCameraImage(image);
      }
    });
  }

  Future<void> _classifyCameraImage(CameraImage image) async {
    try {
      var input = _convertYUV420ToRGB(
        image,
      ); // returns Float32 input of shape [1, 224, 224, 3]
      var output = List.filled(
        _labels.length,
        0.0,
      ).reshape([1, _labels.length]);

      _interpreter?.run(input, output);

      int maxIndex = 0;
      double maxConfidence = 0.0;

      for (int i = 0; i < output[0].length; i++) {
        if (output[0][i] > maxConfidence) {
          maxConfidence = output[0][i];
          maxIndex = i;
        }
      }

      setState(() {
        _predictionLabel = _labels[maxIndex];
      });
    } catch (e) {
      print('Error during classification: $e');
    } finally {
      _isProcessing = false;
    }
  }

  /// NOTE: This function is a placeholder that returns a dummy zero input.
  /// You must implement proper conversion from YUV420 to RGB and resize it to 224x224.
  List<List<List<List<double>>>> _convertYUV420ToRGB(CameraImage image) {
    // Placeholder input with zeros for a model expecting input shape [1, 224, 224, 3]
    return List.generate(
      1,
      (_) => List.generate(
        224,
        (_) => List.generate(224, (_) => List.generate(3, (_) => 0.0)),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("QuickLens")),
      body: Stack(
        children: [
          CameraPreview(_cameraController),
          Positioned(
            bottom: 50,
            left: 20,
            child: Text(
              'Prediction: $_predictionLabel',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
