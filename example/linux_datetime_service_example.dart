import 'package:linux_datetime_service/linux_datetime.dart';

void main() async {
  final dateTimeService = DateTimeService();
  await dateTimeService.init();
  print(dateTimeService.dateTime);
  print(dateTimeService.timezone);
  await dateTimeService.dispose();
}
