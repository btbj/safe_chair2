import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:safe_chair2/util/notification_manager.dart';
import 'package:safe_chair2/model/ChairState.dart';
// import 'package:safe_chair2/util/StoreManager.dart';
import 'package:rxdart/subjects.dart';
// import 'package:safe_chair2/util/LogManager.dart';

mixin BleMixin on ChangeNotifier {
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  FlutterBlue get flutterBlue => _flutterBlue;

  NotificationManager notificationManager = NotificationManager();
  ChairState _chairState;
  ChairState get chairState => _chairState;
  bool get connected => _chairState != null;

  final String targetUUIDString = '0000ffe1-0000-1000-8000-00805f9b34fb';
  BluetoothCharacteristic targetChar;

  StreamSubscription _scanSubscription;
  StreamSubscription get scanSubscription => _scanSubscription;
  final scanStateSubject = BehaviorSubject<bool>();
  // bool _scanning = false;
  // bool get scanning => _scanning;
  Map<DeviceIdentifier, ScanResult> _scanResults = Map();
  Map<DeviceIdentifier, ScanResult> get scanResults => _scanResults;

  StreamSubscription _stateSubscription;
  StreamSubscription get stateSubscription => _stateSubscription;
  final stateSubject = BehaviorSubject<BluetoothState>();
  BluetoothState _state = BluetoothState.unknown;
  BluetoothState get state => _state;

  BluetoothDevice _device;
  BluetoothDevice get device => this._device;
  StreamSubscription<BluetoothDeviceState> _deviceConnection;
  StreamSubscription<BluetoothDeviceState> _deviceStateSubscription;
  final deviceStateSubject = BehaviorSubject<BluetoothDeviceState>.seeded(
      BluetoothDeviceState.disconnected);

  List<BluetoothService> services = List();
  StreamSubscription<List<int>> valueChangedSubscriptions;
  List<int> _value = [];
  List<int> get value => _value;

  DateTime _connectedTime;
  String get connectedTime =>
      _connectedTime == null ? '--' : _connectedTime.toString();
  DateTime _disconnectedTime;
  String get disconnectedTime =>
      _disconnectedTime == null ? '--' : _disconnectedTime.toString();
  Timer _alertTimer;

  // LogManager _logManager = LogManager();

  Future refreshBleState() async {
    _state = await _flutterBlue.state;
    notifyListeners();
    return;
  }

  Future initBle() async {
    await this.notificationManager.init();
    // await this._logManager.init();
    await _flutterBlue.setUniqueId('welldon_safe_chair');

    _stateSubscription = _flutterBlue.onStateChanged().listen((s) async {
      _state = s;
      notifyListeners();
      if (s == BluetoothState.off) {
        await this.disconnect();
        print('close ble');
        this.stateSubject.add(s);
        notificationManager.show('蓝牙已关闭');
      }
    });

    var _currentState = await _flutterBlue.state;
    this._state = _currentState;
    this.stateSubject.add(_currentState);
    notifyListeners();

    return;
  }

  void disposeBle() {
    _stateSubscription?.cancel();
    _stateSubscription = null;
    stateSubject.close();
    _scanSubscription?.cancel();
    _scanSubscription = null;
    scanStateSubject.close();
    _deviceConnection?.cancel();
    _deviceConnection = null;
    deviceStateSubject.close();
  }

  void startScan() async {
    await stopScan();
    await this.disconnect();
    print('start scan');
    this._scanResults.clear();
    this.scanStateSubject.add(true);
    _scanSubscription =
        _flutterBlue.scan(timeout: Duration(seconds: 10)).listen((scanResult) {
      this._scanResults[scanResult.device.id] = scanResult;
      notifyListeners();
    }, onDone: stopScan);
    notifyListeners();
  }

  Future stopScan() async {
    print('stop scan');
    await _scanSubscription?.cancel();
    _scanSubscription = null;
    this.scanStateSubject.add(false);
    notifyListeners();
    return;
  }

  void connect(BluetoothDevice targetDevice) async {
    await this.stopScan();
    await _deviceStateSubscription?.cancel();
    _deviceStateSubscription = null;
    await _deviceConnection?.cancel();
    _deviceConnection = null;

    final currentDeviceState = await targetDevice.state;
    this.deviceStateSubject.add(currentDeviceState);
    notifyListeners();

    _deviceStateSubscription = targetDevice.onStateChanged().listen((s) async {
      this.deviceStateSubject.add(s);
      notifyListeners();
      if (s == BluetoothDeviceState.connected) {
        this._device = targetDevice;
        // await StoreManager.saveLastConnectedDevice(targetDevice);
        await this.scanServices(targetDevice);
        notifyListeners();

        await this.logTime();
        
        this.setTimer();
      }
      if (s == BluetoothDeviceState.disconnected) {
        // notificationManager.show('断开连接');
        // await Future.delayed(Duration(seconds: 30));
        // reconnect();
        this.connect(this._device);
      }
    });

    _deviceConnection = _flutterBlue.connect(targetDevice).listen(null);
  }

  Future logTime({bool disconnect = false}) async {
    final now = DateTime.now();
    // final millseconds = now.millisecondsSinceEpoch;
    if (!disconnect) {
      // await this._logManager.append('C:$millseconds');
      this._connectedTime = now;
    } else {
      // await this._logManager.append('D:$millseconds');
      this._disconnectedTime = now;
    }
    return;
  }

  void setTimer() async {
    await this.stopTimer();
    await this.notificationManager.schedule(id: 111, message: '断开连接', duration: Duration(seconds: 120));
    this._alertTimer = Timer(Duration(seconds: 120), () async {
      // this.notificationManager.show('断开连接');
      
      await this.logTime(disconnect: true);

      this.disconnect();
    });
  }

  Future stopTimer() async {
    await this.notificationManager.cancel(id: 111);
    this._alertTimer?.cancel();
    return;
  }


  Future disconnect() async {
    print('disconnect');
    await _deviceStateSubscription?.cancel();
    _deviceStateSubscription = null;
    await _deviceConnection?.cancel();
    _deviceConnection = null;
    await valueChangedSubscriptions?.cancel();
    valueChangedSubscriptions = null;
    // if (device != null) {
    //   notificationManager.show('断开连接');
    // }
    this._device = null;
    this.deviceStateSubject.add(BluetoothDeviceState.disconnected);
    notifyListeners();
    return;
  }

  Future scanServices(BluetoothDevice targetDevice) async {
    await valueChangedSubscriptions?.cancel();
    valueChangedSubscriptions = null;
    List<BluetoothService> services = await targetDevice.discoverServices();

    for (BluetoothService service in services) {
      List<BluetoothCharacteristic> chars = service.characteristics;
      for (BluetoothCharacteristic char in chars) {
        if (char.uuid.toString() == targetUUIDString) {
          this.targetChar = char;
          await targetDevice.setNotifyValue(char, true);
          valueChangedSubscriptions =
              targetDevice.onValueChanged(char).listen((value) {
            this._value = value;
            print('value is: $value');
            this._chairState = ChairState(value);

            // targetDevice.writeCharacteristic(char, [0xbb, 0x01]);
            notifyListeners();
          });
          // targetDevice.writeCharacteristic(char, [0xaa, 0x01, 0xbb, 0xbc]);
          // await Future.delayed(Duration(seconds: 3));
          targetDevice.writeCharacteristic(char, [0xaa, 0x01, 0xbb, 0xbc]);
        }
      }
    }

    return;
  }

  void scanToConnect(BluetoothDevice targetDevice) async {
    await stopScan();
    await this.disconnect();
    print('start scan');
    this._scanResults.clear();
    this.scanStateSubject.add(true);
    _scanSubscription =
        _flutterBlue.scan(timeout: Duration(seconds: 60)).listen((scanResult) {
      if (scanResult.device.id == targetDevice.id &&
          scanResult.advertisementData.connectable) {
        connect(scanResult.device);
        this.scanStateSubject.add(false);
      }
      notifyListeners();
    }, onDone: stopScan);
    notifyListeners();
  }
}
