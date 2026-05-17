import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:product_browser_app/features/chat/domain/usecases/send_message_usecase.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late MockChatRepository mockRepo;
  late SendMessageUseCase useCase;

  setUp(() {
    mockRepo = MockChatRepository();
    useCase = SendMessageUseCase(mockRepo);
  });

  group('SendMessageUseCase - TDD Bug #1', () {
    test(
      'يجب أن يرمي استثناء إذا كان النص فارغاً (Validation Check)',
      () async {
        const productId = '123';
        const sender = 'user_1';
        const emptyText = '';

        expect(
          () => useCase.call(
            productId: productId,
            senderUsername: sender,
            text: emptyText,
          ),
          throwsA(isA<Exception>()),
        );

        verifyNever(
          () => mockRepo.sendMessage(
            productId: any(named: 'productId'),
            senderUsername: any(named: 'senderUsername'),
            text: any(named: 'text'),
          ),
        );
      },
    );
    test('Failing: Should allow empty text (Old Buggy Code)', () async {
      // هذا الاختبار كان ينجح في الكود القديم ولكنه "خاطئ" منطقياً
      await useCase.call(productId: 'id', text: '', senderUsername: 'sender');
      verify(
        () => mockRepo.sendMessage(
          productId: any(),
          text: '',
          senderUsername: any(),
        ),
      ).called(1);
    });

    test('Passing: Should throw Exception if text is empty', () async {
      // نحن نتوقع (expect) أن استدعاء الدالة سيرمي Exception
      expect(
        () =>
            useCase.call(productId: '123', senderUsername: 'user_1', text: ''),
        throwsA(isA<Exception>()),
      );

      // ونؤكد أن الـ Repository لم يتم استدعاؤه أبداً
      verifyNever(
        () => mockRepo.sendMessage(
          productId: any(named: 'productId'),
          senderUsername: any(named: 'senderUsername'),
          text: any(named: 'text'),
        ),
      );
    });
  });
}
