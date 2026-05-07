import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../domain/entities/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              message.senderUsername,
              style: TextStyle(fontSize: 10.sp, color: AppColors.gray),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
            decoration: BoxDecoration(
              color: isMe ? AppColors.primary : Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
                bottomLeft: isMe ? Radius.circular(12.r) : Radius.circular(0),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12.r),
              ),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: isMe ? Colors.white : AppColors.textMain,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
