import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:image/image.dart' as img;

class ImageStreamCubit extends Cubit<List<Uint8List>> {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;

  ImageStreamCubit() : super([]);

  void connect(int glassesNumber) {
    _channel = IOWebSocketChannel.connect(
        'ws://192.168.1.7:8004/analysis-image/$glassesNumber');
    _channel!.stream.listen((data) {
      emit([...state, data]);
    });
  }

  Future<void> sendImage(Uint8List bytes) async {
    String imageData = base64Encode(bytes);
    _channel!.sink.add(imageData);
  }

  void startSendingImages(Stream<Uint8List> imageStream) {
    _subscription = imageStream.listen((image) {
      sendImage(image);
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _channel?.sink.close();
    return super.close();
  }
}

class CameraApp extends StatefulWidget {
  const CameraApp({
    super.key,
    required this.glassesNumber,
  });
  final int glassesNumber;
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras;

  late ImageStreamCubit _imageStreamCubit;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _imageStreamCubit = ImageStreamCubit()..connect(widget.glassesNumber);

    Future.delayed(const Duration(milliseconds: 500), () {
      _startSendingImages();
    });
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras[1],
      ResolutionPreset.low,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  Stream<Uint8List> _createImageStream() async* {
    while (true) {
      await _initializeControllerFuture;
      if (_controller.value.isInitialized) {
        XFile image = await _controller.takePicture();
        Uint8List bytes = await image.readAsBytes();
        img.Image originalImage = img.decodeImage(bytes)!;
        img.Image rotatedImage = img.copyRotate(originalImage, angle: 360);
        Uint8List rotatedBytes = Uint8List.fromList(img.encodeJpg(rotatedImage));
        yield rotatedBytes;
      }
    }
  }

  void _startSendingImages() {
    _imageStreamCubit.startSendingImages(_createImageStream());
  }

  @override
  void dispose() {
    _controller.dispose();
    _imageStreamCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _imageStreamCubit,
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Buy it Now',
          style: TextStyle(
            fontFamily: GoogleFonts.chewy().fontFamily
          ),
          ),
        ),
        body: BlocBuilder<ImageStreamCubit, List<Uint8List>>(
          builder: (context, images) {
            if (images.isNotEmpty) {
              return SizedBox.expand(
                child: Image.memory(
                  images.last,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
