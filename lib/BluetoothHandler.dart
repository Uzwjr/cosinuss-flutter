import 'dart:typed_data';

import 'package:flutter_blue/flutter_blue.dart';

class BluetoothHandler {
  String _connectionStatus = "Disconnected";
  String _heartRate = "- bpm";
  String _bodyTemperature = '- °C';

  bool _isConnected = false;
  bool earConnectFound = false;

  void updateHeartRate(rawData) {
    Uint8List bytes = Uint8List.fromList(rawData);

    // based on GATT standard
    var bpm = bytes[1];
    if (!((bytes[0] & 0x01) == 0)) {
      bpm = (((bpm >> 8) & 0xFF) | ((bpm << 8) & 0xFF00));
    }

    var bpmLabel = "- bpm";
    if (bpm != 0) {
      bpmLabel = bpm.toString() + " bpm";
    }

    //setState(() {
      _heartRate = bpmLabel;
   // });
  }

  void updateBodyTemperature(rawData) {
    var flag = rawData[0];

    // based on GATT standard
    double temperature = twosComplimentOfNegativeMantissa(
            ((rawData[3] << 16) | (rawData[2] << 8) | rawData[1]) & 16777215) /
        100.0;
    if ((flag & 1) != 0) {
      temperature = ((98.6 * temperature) - 32.0) *
          (5.0 / 9.0); // convert Fahrenheit to Celsius
    }

    //setState(() {
      _bodyTemperature = temperature.toString() + " °C"; // todo update body temp
    //});
  }

  int twosComplimentOfNegativeMantissa(int mantissa) {
    if ((4194304 & mantissa) != 0) {
      return (((mantissa ^ -1) & 16777215) + 1) * -1;
    }

    return mantissa;
  }

  void _connect() {
    FlutterBlue flutterBlue = FlutterBlue.instance;

    // start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) async {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name == "earconnect" && !earConnectFound) {
          earConnectFound =
              true; // avoid multiple connects attempts to same device

          await flutterBlue.stopScan();

          r.device.state.listen((state) {
            // listen for connection state changes
           // setState(() {
              _isConnected = state == BluetoothDeviceState.connected;
              _connectionStatus = (_isConnected) ? "Connected" : "Disconnected";
           // });
          });

          await r.device.connect();

          var services = await r.device.discoverServices();

          for (var service in services) {
            // iterate over services
            for (var characteristic in service.characteristics) {
              // iterate over characterstics
              switch (characteristic.uuid.toString()) {
                /*  case "0000a001-1212-efde-1523-785feabcd123":
                  print("Starting sampling ...");
                  await characteristic.write([0x32, 0x31, 0x39, 0x32, 0x37, 0x34, 0x31, 0x30, 0x35, 0x39, 0x35, 0x35, 0x30, 0x32, 0x34, 0x35]);
                  await Future.delayed(new Duration(seconds: 2)); // short delay before next bluetooth operation otherwise BLE crashes
                  characteristic.value.listen((rawData) => {
                    updateAccelerometer(rawData),
                    updatePPGRaw(rawData)
                  });
                  await characteristic.setNotifyValue(true);
                  await Future.delayed(new Duration(seconds: 2));
                  break;
              */
                case "00002a37-0000-1000-8000-00805f9b34fb":
                  characteristic.value
                      .listen((rawData) => {updateHeartRate(rawData)});
                  await characteristic.setNotifyValue(true);
                  await Future.delayed(new Duration(
                      seconds:
                          2)); // short delay before next bluetooth operation otherwise BLE crashes
                  break;

                case "00002a1c-0000-1000-8000-00805f9b34fb":
                  characteristic.value
                      .listen((rawData) => {updateBodyTemperature(rawData)});
                  await characteristic.setNotifyValue(true);
                  await Future.delayed(new Duration(
                      seconds:
                          2)); // short delay before next bluetooth operation otherwise BLE crashes
                  break;
              }
            }
          }
        }
      }
    });
  }
}
