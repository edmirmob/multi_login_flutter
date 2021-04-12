import 'package:flutter_test/flutter_test.dart';
import 'package:multi_login_flutter/app/home/models.dart/job.dart';

void main() {
  group('fromMap', () {
    test('null data', () {
      final job = Job.fromMap(null, 'abc');
      expect(job, null);
    });
    test('job with all properties', () {
      final job = Job.fromMap({'name': 'Bloging', 'ratePerHour': 10}, 'abc');
      // expect(job.name, 'Bloging');
      // expect(job.ratePerHour, 10);
      // expect(job.id, 'abc');
      expect(job, Job(id: 'abc', name: 'Bloging', ratePerHour: 10));
    });

    test('missing name properties', () {
      final job = Job.fromMap({'ratePerHour': 10}, 'abc');

      expect(job, null);
    });
  });
  group('toMap', () {
    test('validName, ratePerHour', () {
      final job = Job(id: 'abc', name: 'Bloging', ratePerHour: 10);
      expect(job.toMap(), {
        'name': 'Bloging',
        'ratePerHour': 10,
      });
    });
  });
}
