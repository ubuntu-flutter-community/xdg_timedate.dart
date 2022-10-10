## Linux Datetime

This service exposes the `org.freedesktop.timedate1` dbus interface as a reusable, stream-conglomerate.
This is useful when you want to modify the datetime and timezone of your linux system and want to listen to these changes at the same time.

```dart
class DateTimeModel extends SafeChangeNotifier {
  final LinuxDateTime _dateTimeService;
  StreamSubscription<String?>? _timezoneSub;
  StreamSubscription<bool?>? _ntpSyncSub;
  Timer? _fetchDateTimeTimer;
  DateTime? _dateTime;

  DateTimeModel({
    required LinuxDateTime dateTimeService,
  });

  Future<void> init() {
    return _dateTimeService.init().then((_) async {
      _timezoneSub = _dateTimeService.timezoneChanged.listen((_) {
        notifyListeners();
      });
      _ntpSyncSub = _dateTimeService.ntpChanged.listen((_) {
        notifyListeners();
      });
      _dateTime = await _dateTimeService.getDateTime();
      notifyListeners();

      _fetchDateTimeTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          _dateTime = await _dateTimeService.getDateTime();
          notifyListeners();
        },
      );
    });
  }
}
```