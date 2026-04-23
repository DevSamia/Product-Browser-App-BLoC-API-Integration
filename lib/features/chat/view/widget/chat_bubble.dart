import '../../../../core/imports/common_imports.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String time;
  final bool showAvatar;

  const ChatBubble({
    super.key,
    required this.isMe,
    required this.message,
    required this.time,
    this.showAvatar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            SizedBox(
              width: 30,
              child: showAvatar
                  ? const CircleAvatar(
                      radius: 14,
                      backgroundImage: AssetImage(
                        'assets/images/user_image.png',
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            AppSizes.w8,
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.primary : const Color(0xFFF1F4F8),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                      bottomLeft: Radius.circular(isMe ? 15 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 15),
                    ),
                  ),
                  child: PrimaryText(
                    message,
                    fontSize: 13.sp,
                    color: isMe ? Colors.white : Colors.black87,
                  ),
                ),
                AppSizes.h4,
                PrimaryText(time, fontSize: 10.sp, color: Colors.grey),
              ],
            ),
          ),
          if (isMe) AppSizes.w30,
        ],
      ),
    );
  }
}
