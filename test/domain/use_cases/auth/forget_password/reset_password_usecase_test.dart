
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/repo_contract/auth/forget_password_repo/reset_password_repo.dart';
import 'package:tracking_app/domain/use_cases/auth/forget_password/reset_password_usecase.dart';

import 'reset_password_usecase_test.mocks.dart';

@GenerateMocks([ResetpasswordRepo])
void main() {

  provideDummy<ApiResult<bool>>(SuccessApiResult(false));
  provideDummy<ApiResult<bool>>(ErrorApiResult(Exception("Dummy error")));

  late ResetpasswordUsecase resetPasswordUseCase;
  late MockResetpasswordRepo mockResetpasswordRepo;

  setUp(() {
    mockResetpasswordRepo = MockResetpasswordRepo();
    resetPasswordUseCase = ResetpasswordUsecase(repo: mockResetpasswordRepo);
  });

  group('ResetPasswordUseCase Tests', () {
    const String testEmail = 'ayaallahemara@gmail.com';
    const String testPassword = 'Aya@1234';

    test('should return SuccessApiResult when password reset is successful', () async {
      // Arrange
      when(mockResetpasswordRepo.resetPassword(email: testEmail, password: testPassword))
          .thenAnswer((_) async => SuccessApiResult(true));

      // Act
      final result = await resetPasswordUseCase.invoke(email: testEmail, password: testPassword);

      // Assert
      expect(result, isA<SuccessApiResult<bool>>());
      expect((result as SuccessApiResult).data, true);
      verify(mockResetpasswordRepo.resetPassword(email: testEmail, password: testPassword)).called(1);
      verifyNoMoreInteractions(mockResetpasswordRepo);
    });

    test('should return ErrorApiResult when password reset fails', () async {
      // Arrange
      final error = Exception('Password reset failed');
      when(mockResetpasswordRepo.resetPassword(email: testEmail, password: testPassword))
          .thenAnswer((_) async => ErrorApiResult(error));

      // Act
      final result = await resetPasswordUseCase.invoke(email: testEmail, password: testPassword);

      // Assert
      expect(result, isA<ErrorApiResult<bool>>());
      expect((result as ErrorApiResult).exception.toString(), contains('Password reset failed'));
      verify(mockResetpasswordRepo.resetPassword(email: testEmail, password: testPassword)).called(1);
      verifyNoMoreInteractions(mockResetpasswordRepo);
    });
  });
}
