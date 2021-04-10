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
      setUp(() async {
        Intl.defaultLocale = 'en_GB';
        await initializeDateFormatting(Intl.defaultLocale);
      });
      test('2021-04-10', () {
        expect(Format.date(DateTime(2021, 4, 10)), '10 Apr 2021');
      });
    });
  });
  group('dayOfWeek - GB Locale', () {
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('Saturday', () {
      expect(Format.dayOfWeek(DateTime(2021, 4, 10)), 'Sat');
    });
  });
  group('dayOfWeek - BS Locale', () {
    setUp(() async {
      Intl.defaultLocale = 'bs_BS';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('Subota', () {
      expect(Format.dayOfWeek(DateTime(2021, 4, 10)), 'sub');
    });
  });

  group('currency - US Locale', () {
    setUp(() async {
      Intl.defaultLocale = 'en_US';
    });
  test('positive', () {
      expect(Format.currency(10), '\$10');
    });
    test('zero', () {
      expect(Format.currency(0), '');
    });
    test('negative', () {
      expect(Format.currency(-5), '-\$5');
    });

  });
}
