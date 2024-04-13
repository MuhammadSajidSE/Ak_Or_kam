import 'package:bluetooth/InsertDataPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

// Import the file where InsertDataPage is defined

class BleController extends GetxController {
  FlutterBlue ble = FlutterBlue.instance;

  Stream<List<ScanResult>> get scanResults => ble.scanResults;

  Future<void> scanDevices() async {
    try {
      if (await Permission.bluetoothScan.request().isGranted &&
          await Permission.bluetoothConnect.request().isGranted) {
        await ble.startScan(timeout: Duration(seconds: 10));
      }
    } catch (e) {
      print("Error starting scan: $e");
    }
  }

  Future<void> connectToDevice(
      BluetoothDevice device, BuildContext context) async {
    try {
      await device.connect(timeout: Duration(seconds: 15));

      device.state.listen((isConnected) {
        if (BluetoothDeviceState.connecting == isConnected) {
          print("Device connecting to ${device.name}");
        } else if (BluetoothDeviceState.connected == isConnected) {
          print("Device connected to ${device.name}");
          // Show a snackbar for successful connection
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Device connected successfully'),
            ),
          );
          // Navigate to the InsertDataPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InsertDataPage()),
          );
        } else {
          print("Device Disconnected");
        }
      });
    } catch (e) {
      print("Error connecting to device: $e");
    }
  }
}
