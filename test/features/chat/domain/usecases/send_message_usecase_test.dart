import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:product_browser_app/features/chat/domain/usecases/send_message_usecase.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late SendMessageUseCase useCase;
  late MockChatRepository mockRepository;

  setUp(() {
    mockRepository = MockChatRepository();
    useCase = SendMessageUseCase(mockRepository);
  });

  const testProductId = 'prod_123';
  const testUsername = 'testuser';
  const testText = 'Hello world';

  test('should call sendMessage on repository', () async {
    // Arrange
    when(
      () => mockRepository.sendMessage(
        productId: any(named: 'productId'),
        senderUsername: any(named: 'senderUsername'),
        text: any(named: 'text'),
      ),
    ).thenAnswer((_) async {});

    // Act
    await useCase(
      productId: testProductId,
      senderUsername: testUsername,
      text: testText,
    );

    // Assert
    verify(
      () => mockRepository.sendMessage(
        productId: testProductId,
        senderUsername: testUsername,
        text: testText,
      ),
    ).called(1);
  });
}
