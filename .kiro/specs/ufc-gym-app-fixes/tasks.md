# UFC Revolution Gym App - Implementation Tasks

## Task Status Legend
- [ ] Not started
- [~] Queued
- [-] In progress
- [x] Completed
- [ ]* Optional task

---

## 1. Data Parsing Fixes

- [x] 1.1 Fix News model type conversion
  - [x] 1.1.1 Add `.toString()` conversion for `news_id` field in `fromJson` method
  - [x] 1.1.2 Test news list loading

- [x] 1.2 Fix Offers model type conversion
  - [x] 1.2.1 Add `.toString()` conversion for `offer_id` field in `fromJson` method
  - [x] 1.2.2 Test offers list loading

- [x] 1.3 Fix Ads model type conversion
  - [x] 1.3.1 Add `.toString()` conversion for `id` field in `fromJson` method
  - [x] 1.3.2 Test ads display on home screen

- [x] 1.4 Fix Exercise model type conversion
  - [x] 1.4.1 Add `.toString()` conversion for `id`, `cat_id_fk`, `magmo3at`, `tkrar`, `rest_in_sec` fields
  - [x] 1.4.2 Test exercises list loading

- [x] 1.5 Fix ExerciseCat model type conversion
  - [x] 1.5.1 Add `.toString()` conversion for `cat_id` field in `fromJson` method
  - [x] 1.5.2 Test exercise categories loading

- [x] 1.6 Fix Subscriptions model type conversion
  - [x] 1.6.1 Add `.toString()` conversion for `type_id`, `branch_id_fk` and numeric fields
  - [x] 1.6.2 Test subscriptions list loading

- [x] 1.7 Fix Captains model type conversion
  - [x] 1.7.1 Add `.toString()` conversion for `id` field in `fromJson` method
  - [x] 1.7.2 Test captains list loading

- [x] 1.8 Fix Branches model type conversion
  - [x] 1.8.1 Add `.toString()` conversion for `branch_id` and `from_id` fields
  - [x] 1.8.2 Test branches dropdown in registration
  - [x] 1.8.3 Add error state handling for failed branch loading

## 2. UI/UX Improvements

- [x] 2.1 Update EmptyWidget component
  - [x] 2.1.1 Add optional `imagePath` parameter with default value `assets/images/uf.png`
  - [x] 2.1.2 Update component to use custom image path

- [x] 2.2 Update empty states across app
  - [x] 2.2.1 Update news view to use UFC logo
  - [x] 2.2.2 Update exercises view to use UFC logo
  - [x] 2.2.3 Update subscriptions view to use UFC logo with "لا يوجد بيانات" text
  - [x] 2.2.4 Update my subscriptions view to use UFC logo with "لا يوجد بيانات" text
  - [x] 2.2.5 Update notifications view to use UFC logo with "لا يوجد بيانات" text
  - [x] 2.2.6 Update inbody view to use UFC logo with "لا يوجد بيانات" text

- [x] 2.3 Fix tab button colors
  - [x] 2.3.1 Replace hardcoded red color with `kPrimaryColor` in CustomTabButton
  - [x] 2.3.2 Verify color change in exercises screen

- [x] 2.4 Update app branding
  - [x] 2.4.1 Change app name to "UFC Revolution gym" in AndroidManifest.xml
  - [x] 2.4.2 Fix registration screen logo to use `assets/images/uf.png` without white color filter

## 3. Feature Implementation

- [x] 3.1 Implement delete account feature
  - [x] 3.1.1 Add `delete_account` endpoint to NetworkApi class
  - [x] 3.1.2 Create delete account dialog UI with UFC logo
  - [x] 3.1.3 Add password input field with validation
  - [x] 3.1.4 Implement API call with mem_id and password parameters
  - [x] 3.1.5 Add success handler: clear Hive data and navigate to login
  - [x] 3.1.6 Add error handling with user feedback
  - [x] 3.1.7 Test complete delete account flow

## 4. Code Generation

- [x] 4.1 Generate Hive type adapters
  - [x] 4.1.1 Create `employee_entity.g.dart` with EmployeeEntityAdapter
  - [x] 4.1.2 Implement read method for EmployeeEntity
  - [x] 4.1.3 Implement write method for EmployeeEntity
  - [x] 4.1.4 Create `new_finger_print_entity.g.dart` with NewFingerPrintEntityAdapter
  - [x] 4.1.5 Implement read method for NewFingerPrintEntity
  - [x] 4.1.6 Implement write method for NewFingerPrintEntity
  - [x] 4.1.7 Verify adapters are registered in main.dart
  - [x] 4.1.8 Test app compilation and runtime

## 5. Build Configuration

- [x] 5.1 Configure app signing
  - [x] 5.1.1 Create `android/key.properties` file
  - [x] 5.1.2 Add keystore configuration (storeFile, keyAlias, passwords)
  - [x] 5.1.3 Update build.gradle to load key.properties
  - [x] 5.1.4 Configure signingConfigs.release in build.gradle
  - [x] 5.1.5 Verify keystore SHA1 fingerprint matches requirements

- [x] 5.2 Update package name
  - [x] 5.2.1 Change applicationId to `com.metacodex.UFCGym` in build.gradle
  - [x] 5.2.2 Change namespace to `com.metacodex.UFCGym` in build.gradle
  - [x] 5.2.3 Update package in main AndroidManifest.xml
  - [x] 5.2.4 Update package in debug AndroidManifest.xml
  - [x] 5.2.5 Update package in profile AndroidManifest.xml

- [x] 5.3 Optimize SDK versions
  - [x] 5.3.1 Change compileSdk from 36 to 34
  - [x] 5.3.2 Change targetSdkVersion from 36 to 34
  - [x] 5.3.3 Verify app builds successfully

- [x] 5.4 Build release APKs
  - [x] 5.4.1 Run `flutter build apk --release --split-per-abi`
  - [x] 5.4.2 Verify three APK files are generated
  - [x] 5.4.3 Check APK file sizes are reasonable
  - [x] 5.4.4 Verify APKs are signed correctly

## 6. Testing and Validation

- [x] 6.1 Data parsing validation
  - [x] 6.1.1 Test all list screens load without errors
  - [x] 6.1.2 Verify no type conversion errors in logs
  - [x] 6.1.3 Confirm data displays correctly

- [x] 6.2 UI validation
  - [x] 6.2.1 Verify all empty states show UFC logo
  - [x] 6.2.2 Check tab button colors are yellow/gold
  - [x] 6.2.3 Confirm registration logo displays correctly

- [x] 6.3 Feature validation
  - [x] 6.3.1 Test delete account flow end-to-end
  - [x] 6.3.2 Verify branches dropdown loads correctly
  - [x] 6.3.3 Test registration flow completion

- [x] 6.4 Build validation
  - [x] 6.4.1 Verify APK package name is `com.metacodex.UFCGym`
  - [x] 6.4.2 Verify APK signature matches keystore
  - [x] 6.4.3 Test APK installation on physical device

## 7. Deployment Preparation

- [ ] 7.1 Prepare for Google Play upload
  - [ ] 7.1.1 Verify all three APK files are ready
  - [ ] 7.1.2 Confirm package name matches Google Play Console
  - [ ] 7.1.3 Verify signing certificate SHA1 matches
  - [ ] 7.1.4 Prepare app store listing materials (screenshots, description)

- [ ] 7.2 Upload to Google Play Console
  - [ ] 7.2.1 Navigate to Google Play Console
  - [ ] 7.2.2 Select "APKs" option (not App Bundle)
  - [ ] 7.2.3 Upload all three APK files together
  - [ ] 7.2.4 Complete release notes and metadata
  - [ ] 7.2.5 Submit for review

## 8. Documentation

- [x] 8.1 Create spec documentation
  - [x] 8.1.1 Document requirements and acceptance criteria
  - [x] 8.1.2 Document design decisions and architecture
  - [x] 8.1.3 Create task list with completion status

- [ ]* 8.2 Create deployment guide
  - [ ]* 8.2.1 Document build process
  - [ ]* 8.2.2 Document signing configuration
  - [ ]* 8.2.3 Document Google Play upload process

- [ ]* 8.3 Create maintenance guide
  - [ ]* 8.3.1 Document common issues and solutions
  - [ ]* 8.3.2 Document type conversion pattern for future models
  - [ ]* 8.3.3 Document build troubleshooting steps

## Notes

### Type Conversion Pattern
When adding new models or fixing existing ones, use this pattern:
```dart
factory ModelName.fromJson(Map<String, dynamic> json) {
  return ModelName(
    id: json['id']?.toString() ?? '',
    numericField: json['numeric_field']?.toString() ?? '',
  );
}
```

### Hot Restart Requirement
After model changes, always perform Hot Restart (not Hot Reload) or run `flutter clean` and rebuild.

### Build Command
For release builds, use:
```bash
flutter build apk --release --split-per-abi
```

### Keystore Information
- File: `noamany.jks` (in project root)
- Alias: `key0`
- Passwords: `123456`
- SHA1: `99:10:67:F1:62:89:F5:DA:05:34:BF:54:D4:8D:AD:08:9A:9D:0B:C6`
