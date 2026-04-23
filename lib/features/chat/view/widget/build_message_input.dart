import '../../../../core/imports/common_imports.dart';

Widget buildMessageInput(TextEditingController messageController) {
  return Container(
    padding: EdgeInsets.fromLTRB(16, 12, 16, 20.h),
    decoration: BoxDecoration(
      color: AppColors.scaffoldBackground,
      border: Border(top: BorderSide(color: const Color(0xFFE5E7EB))),
    ),
    child: Row(
      children: [
        const Icon(Icons.mic_none_outlined, color: Color(0xFF67707A), size: 24),
        AppSizes.w12,
        Expanded(
          child: Container(
            height: 44.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F4F8),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                AppSizes.w16,
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(
                        color: Color(0xFF67707A),
                        fontSize: 13.sp,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                const Icon(Icons.add, color: Color(0xFF67707A), size: 20),
                AppSizes.w12,
              ],
            ),
          ),
        ),
        AppSizes.w12,
        CircleAvatar(
          radius: 22.r,
          backgroundColor: const Color(0xFFFFD143),
          child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
        ),
      ],
    ),
  );
}
