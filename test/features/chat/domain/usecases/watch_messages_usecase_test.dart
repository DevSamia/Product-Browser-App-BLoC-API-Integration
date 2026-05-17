import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/chat/domain/entities/message.dart';
import 'package:product_browser_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:product_browser_app/features/chat/domain/usecases/watch_messages_usecase.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late WatchMessagesUseCase useCase;
  late MockChatRepository mockRepository;

  setUp(() {
    mockRepository = MockChatRepository();
    useCase = WatchMessagesUseCase(mockRepository);
  });

  test('يجب أن يمرر productId الصحيح إلى المستودع', () {
    const tProductId = 'apple_iphone_15';

    when(
      () => mockRepository.watchMessages(any()),
    ).thenAnswer((_) => const Stream.empty());

    useCase.call(tProductId);
    verify(() => mockRepository.watchMessages(tProductId)).called(1);
  });

  setUp(() {
    mockRepository = MockChatRepository();
    useCase = WatchMessagesUseCase(mockRepository);
  });

  const testId = 'prod_1';
  final testMessages = [
    Message(
      id: '1',
      productId: testId,
      senderUsername: 'u1',
      text: 'hi',
      createdAt: DateTime.now(),
    ),
  ];

  test('should emit stream of messages from repository', () async {
    // Arrange
    when(
      () => mockRepository.watchMessages(testId),
    ).thenAnswer((_) => Stream.value(testMessages));

    // Act
    final result = useCase(testId);

    // Assert
    expect(result, emits(testMessages));
    verify(() => mockRepository.watchMessages(testId)).called(1);
  });
}
