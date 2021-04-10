import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:multi_login_flutter/app/home/job_entries/format.dart';

void main() {
  group('hours', () {
    test('positive', () {
      expect(Format.hours(10), '10h');
    });
    test('zero', () {
      expect(Format.hours(0), '0h');
    });
    test('negative', () {
      expect(Format.hours(-5), '0h');
    });
    test('decimal', () {
      expect(Format.hours(10.5), '10.5h');
    });

    group('date - GB Locale', () {
      setUp(()async {
        Intl.defaultLocale = 'en_GB';
      var bb = await initializeDateFormatting(Intl.defaultLocale);
      });
      test('2021-04-10', () {
        expect(Format.date(DateTime(2021, 4, 10)), '10 Apr 2021');
      });
    });
  });
}
