#!/bin/bash

# Test Runner Script for Product Browser App
# This script runs all tests and generates coverage reports

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║       Product Browser App - Comprehensive Test Suite            ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print section headers
print_header() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
}

# Function to print success messages
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Function to print error messages
print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Function to print info messages
print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Step 1: Get dependencies
print_header "Step 1: Getting Dependencies"
flutter pub get
print_success "Dependencies installed"

# Step 2: Build runner for code generation
print_header "Step 2: Running Code Generation"
dart run build_runner build --delete-conflicting-outputs
print_success "Code generation completed"

# Step 3: Run all tests
print_header "Step 3: Running All Tests"

print_info "Running Unit Tests..."
flutter test test/features/auth/domain/usecases/login_usecase_test.dart -v
flutter test test/features/chat/domain/usecases/send_message_usecase_test.dart -v
flutter test test/features/chat/domain/usecases/watch_messages_usecase_test.dart -v
print_success "Unit tests completed"

print_info "Running BLoC Tests..."
flutter test test/features/auth/bloc/auth_bloc_test.dart -v
flutter test test/features/chat/presentation/bloc/chat_bloc_test.dart -v
print_success "BLoC tests completed"

print_info "Running Widget Tests..."
flutter test test/features/auth/view/login_screen_widget_test.dart -v
flutter test test/features/chat/presentation/screens/chat_screen_widget_test.dart -v
print_success "Widget tests completed"

print_info "Running Integration Tests..."
flutter test test/integration_tests_helpers.dart -v
print_success "Integration tests completed"

# Step 4: Run complete test suite
print_header "Step 4: Running Complete Test Suite"
flutter test --coverage
print_success "Complete test suite executed"

# Step 5: Calculate coverage
print_header "Step 5: Coverage Report"
if [ -f "coverage/lcov.info" ]; then
    # Count lines
    TOTAL_LINES=$(wc -l < coverage/lcov.info)
    print_success "Coverage report generated (${TOTAL_LINES} lines)"

    # Display coverage summary
    if command -v lcov &> /dev/null; then
        print_info "Generating HTML coverage report..."
        genhtml coverage/lcov.info -o coverage/html
        print_success "HTML coverage report created at coverage/html/index.html"
    else
        print_info "Install 'lcov' to generate HTML coverage reports"
        print_info "  macOS: brew install lcov"
        print_info "  Linux: sudo apt-get install lcov"
    fi
else
    print_error "Coverage file not found"
fi

# Step 6: Summary
print_header "Test Summary"
echo ""
echo -e "${GREEN}✓ All tests completed successfully!${NC}"
echo ""
echo "Test Files Created:"
echo "  • test/features/auth/domain/usecases/login_usecase_test.dart"
echo "  • test/features/chat/domain/usecases/send_message_usecase_test.dart"
echo "  • test/features/chat/domain/usecases/watch_messages_usecase_test.dart"
echo "  • test/features/auth/bloc/auth_bloc_test.dart"
echo "  • test/features/chat/presentation/bloc/chat_bloc_test.dart"
echo "  • test/features/auth/view/login_screen_widget_test.dart"
echo "  • test/features/chat/presentation/screens/chat_screen_widget_test.dart"
echo ""

echo "Quick Commands:"
echo "  • Run all tests:              flutter test"
echo "  • Run with coverage:          flutter test --coverage"
echo "  • Run specific test file:     flutter test test/path/to/test_file.dart"
echo "  • Run tests matching pattern: flutter test -k 'pattern'"
echo "  • Run in verbose mode:        flutter test -v"
echo ""

echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo -e "${GREEN}Testing Complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════${NC}"

