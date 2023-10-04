import 'package:kitx/Components/Message.dart';
import 'package:permission_handler/permission_handler.dart';

class Izinler
{
  static bool cameraIzin = false;
  static bool galeriIzin = false;
  static bool bildirimIzin = false;

  static allRequest() async
  {
    await [Permission.camera, Permission.microphone, Permission.location,].request();
  }

  static cameraRequest() async
  {
    cameraIzin = await answer(await Permission.camera.request());
  }

  static galeriRequest() async
  {
    galeriIzin = await answer(await Permission.mediaLibrary.request());
  }

  static bildirimRequest() async
  {
    bildirimIzin = await answer(await Permission.notification.request());
  }

  static Future<bool> answer(PermissionStatus status) async
  {
    if (status.isGranted) {
      return true;
    }
    else if (status.isDenied) {
      Message.show("İzin reddildi");
      return false;
    }
    else if (status.isPermanentlyDenied) {
      await Message.show("İzin kalıcı reddildi");
      openAppSettings();
      return false;
    }
    return false;
  }
}