enum CameraTake { front, back, face }

extension CameraExt on CameraTake {
  String get content {
    switch (this) {
      case CameraTake.front:
        return "Mặt trước CMND/CCCD";
      case CameraTake.back:
        return "Mặt sau CMND/CCCD";
      case CameraTake.face:
        return "Xác thực khuôn mặt";
    }
  }
}
