export 'dart:async';

// External Packages
export 'package:dio/dio.dart';
export 'package:equatable/equatable.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:flutter/foundation.dart';
export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:get_it/get_it.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:product_browser_app/app_router.dart';
export 'package:product_browser_app/bottom_navigation_bar.dart';
// Core
export 'package:product_browser_app/core/constants/app_images.dart';
export 'package:product_browser_app/core/constants/app_sizes.dart';
export 'package:product_browser_app/core/constants/colors.dart';
export 'package:product_browser_app/core/constants/strings.dart';
export 'package:product_browser_app/core/errors/app_logger.dart';
export 'package:product_browser_app/core/extensions/context_extension.dart';
export 'package:product_browser_app/core/theme/app_theme.dart';
// Features: Auth
export 'package:product_browser_app/features/auth/bloc/auth_bloc.dart';
export 'package:product_browser_app/features/auth/bloc/auth_event.dart';
export 'package:product_browser_app/features/auth/bloc/auth_state.dart';
export 'package:product_browser_app/features/auth/data/firebase_auth_repository.dart';
export 'package:product_browser_app/features/auth/domain/entities/app_user.dart';
export 'package:product_browser_app/features/auth/domain/repositories/auth_repository.dart';
export 'package:product_browser_app/features/auth/domain/usecases/get_current_user_usecase.dart';
export 'package:product_browser_app/features/auth/domain/usecases/login_usecase.dart';
export 'package:product_browser_app/features/auth/domain/usecases/register_usecase.dart';
export 'package:product_browser_app/features/auth/domain/usecases/update_profile_usecase.dart';
export 'package:product_browser_app/features/auth/view/login/view/login_screen.dart';
export 'package:product_browser_app/features/auth/view/login/view/widget/app_logo.dart';
export 'package:product_browser_app/features/auth/view/login/view/widget/google_sign_in_button.dart';
export 'package:product_browser_app/features/auth/view/login/view/widget/login_form.dart';
export 'package:product_browser_app/features/auth/view/login/view/widget/register_footer.dart';
export 'package:product_browser_app/features/auth/view/login/view/widget/social_divider.dart';
export 'package:product_browser_app/features/auth/view/register/view/register_screen.dart';
// Features: Auth - Register Widgets
export 'package:product_browser_app/features/auth/view/register/view/widget/already_have_account_footer.dart';
export 'package:product_browser_app/features/auth/view/register/view/widget/register_button.dart';
export 'package:product_browser_app/features/auth/view/register/view/widget/register_form.dart';
export 'package:product_browser_app/features/auth/view/register/view/widget/register_header.dart';
export 'package:product_browser_app/features/auth/view/register/view/widget/register_security_footer.dart';
export 'package:product_browser_app/features/auth/view/register/view/widget/register_terms_and_conditions.dart';
// Features: Auth - Edit Profile
export 'package:product_browser_app/features/auth/view/edit_profile/edit_profile_screen.dart';
export 'package:product_browser_app/features/auth/view/edit_profile/view/widget/account_access_section.dart';
export 'package:product_browser_app/features/auth/view/edit_profile/view/widget/account_details_card.dart';
export 'package:product_browser_app/features/auth/view/edit_profile/view/widget/edit_profile_form.dart';
export 'package:product_browser_app/features/auth/view/edit_profile/view/widget/edit_profile_header.dart';
// Features: Cart
export 'package:product_browser_app/features/cart/bloc/cart_bloc.dart';
export 'package:product_browser_app/features/cart/bloc/cart_event.dart';
export 'package:product_browser_app/features/cart/bloc/cart_state.dart';
export 'package:product_browser_app/features/cart/data/cart_repository.dart';
export 'package:product_browser_app/features/cart/data/cart_web_services.dart';
export 'package:product_browser_app/features/cart/models/cart_item_model.dart';
export 'package:product_browser_app/features/cart/view/cart_screen.dart';
export 'package:product_browser_app/features/cart/view/widget/cart_item_card.dart';
export 'package:product_browser_app/features/cart/view/widget/checkout_bottom_bar.dart';
export 'package:product_browser_app/features/cart/view/widget/order_summary_section.dart';
export 'package:product_browser_app/features/cart/view/widget/promo_code_section.dart';
// Features: Category
export 'package:product_browser_app/features/category/bloc/category_bloc.dart';
export 'package:product_browser_app/features/category/bloc/category_event.dart';
export 'package:product_browser_app/features/category/bloc/category_state.dart';
export 'package:product_browser_app/features/category/data/category_repository.dart';
export 'package:product_browser_app/features/category/data/category_web_services.dart';
export 'package:product_browser_app/features/category/models/category_model.dart';
export 'package:product_browser_app/features/category/view/category_screen.dart';
export 'package:product_browser_app/features/category/view/widgets/category_grid.dart';
export 'package:product_browser_app/features/category/view/widgets/category_item.dart';
export 'package:product_browser_app/features/category/view/widgets/hero_section.dart';
export 'package:product_browser_app/features/category/view/widgets/promo_banner.dart';
// Features: Chat
export 'package:product_browser_app/features/chat/bloc/chat_bloc.dart';
export 'package:product_browser_app/features/chat/data/chat_web_service.dart';
// Features: Product
export 'package:product_browser_app/features/product/bloc/product_bloc.dart';
export 'package:product_browser_app/features/product/bloc/product_event.dart';
export 'package:product_browser_app/features/product/bloc/product_state.dart';
export 'package:product_browser_app/features/product/data/product_repository.dart';
export 'package:product_browser_app/features/product/data/product_web_services.dart';
export 'package:product_browser_app/features/product/models/product_model.dart';
export 'package:product_browser_app/features/product/view/product_screen.dart';
export 'package:product_browser_app/features/product/view/widget/list_header.dart';
export 'package:product_browser_app/features/product/view/widget/product_card.dart';
export 'package:product_browser_app/features/product/view/widget/product_grid.dart';
export 'package:product_browser_app/features/product/view/widget/search_and_filter_section.dart';
// Features: Product Detail
export 'package:product_browser_app/features/product_detail/bloc/product_detail_bloc.dart';
export 'package:product_browser_app/features/product_detail/bloc/product_detail_event.dart';
export 'package:product_browser_app/features/product_detail/bloc/product_detail_state.dart';
export 'package:product_browser_app/features/product_detail/data/product_detail_web_service.dart';
export 'package:product_browser_app/features/product_detail/models/product_detail_model.dart';
export 'package:product_browser_app/features/product_detail/view/product_detail_screen.dart';
export 'package:product_browser_app/features/product_detail/view/widget/build_error_widget.dart';
export 'package:product_browser_app/features/product_detail/view/widget/product_detail_body.dart';
export 'package:product_browser_app/main.dart';
export 'package:product_browser_app/widgets/custom_bottom_nav_item.dart';
// Shared Widgets
export 'package:product_browser_app/widgets/custom_text_field.dart';
export 'package:product_browser_app/widgets/primary_text.dart';
export 'package:shared_preferences/shared_preferences.dart';
