import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class Vision {
  Vision._();  // Private class constructor

  static final Vision instance = Vision._();

  FaceDetector faceDetector([FaceDetectorOptions? options]) {
    return FaceDetector(options: options ?? FaceDetectorOptions());
  }
}

