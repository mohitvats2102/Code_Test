import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/services/auth_form.dart'
    show EmailFieldValidator, PasswordFieldValidator;

void main() {
  test('Empty e-mail returns String', () {
    String? res = EmailFieldValidator.validate('');
    expect(res, 'Please enter a valid e-mail address');
  });

  test('E-mail without @ returns String', () {
    String? res = EmailFieldValidator.validate('test.com');
    expect(res, 'Please enter a valid e-mail address');
  });

  test('Right e-main return null', () {
    String? res = EmailFieldValidator.validate('test@test.com');
    expect(res, null);
  });

  test('Empty password return string', () {
    String? res = PasswordFieldValidator.validate('');
    expect(res, 'Password must be 8 characters long');
  });

  test('Small password return string', () {
    String? res = PasswordFieldValidator.validate('1234567');
    expect(res, 'Password must be 8 characters long');
  });

  test('Complete password return null', () {
    String? res = PasswordFieldValidator.validate('12345678');
    expect(res, null);
  });
}
