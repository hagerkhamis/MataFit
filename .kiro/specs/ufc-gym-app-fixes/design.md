# UFC Revolution Gym App - Design Document

## Architecture Overview

The UFC Revolution Gym app follows a feature-based architecture with clean architecture principles. Each feature is organized into data, domain, and presentation layers.

### Project Structure
```
lib/
├── Features/           # Feature modules
│   ├── auth/          # Authentication (login, register)
│   ├── news/          # News feed
│   ├── offers/        # Offers and promotions
│   ├── exercises/     # Exercise library
│   ├── subscribtions/ # Subscription management
│   ├── captains/      # Trainers/captains
│   ├── notification_view/
│   ├── inbody/        # Body composition tracking
│   └── personal_account/
├── core/              # Shared utilities
│   ├── utils/         # Network, constants, helpers
│   └── widgets/       # Reusable UI components
└── main.dart
```

## 1. Data Layer Fixes

### 1.1 Model Type Conversion Strategy

**Problem Analysis**:
The backend API returns numeric fields as JSON integers, but the Flutter models were defined with String types. Dart's JSON deserialization is strict about types and doesn't auto-convert.

**Design Decision**:
Implement explicit type conversion in `fromJson` methods rather than changing model field types to maintain consistency with existing codebase.

**Implementation Pattern**:
```dart
factory ModelName.fromJson(Map<String, dynamic> json) {
  return ModelName(
    id: json['id']?.toString() ?? '',
    numericField: json['numeric_field']?.toString() ?? '',
    // ... other fields
  );
}
```

**Rationale**:
- Minimal code changes required
- Maintains backward compatibility
- Handles null values gracefully with null-aware operators
- Provides default empty string fallback

**Affected Models**:
1. **News Model** (`lib/Features/news/data/models/news.dart`)
   - Field: `news_id`
   
2. **Offers Model** (`lib/Features/offers/data/models/my_messages_model/offers.dart`)
   - Field: `offer_id`
   
3. **Ads Model** (`lib/Features/app_home/data/models/ads_model/ads_model.dart`)
   - Field: `id`
   
4. **Exercise Model** (`lib/Features/exercises/data/models/my_messages_model/exercise.dart`)
   - Fields: `id`, `cat_id_fk`, `magmo3at`, `tkrar`, `rest_in_sec`
   
5. **ExerciseCat Model** (`lib/Features/exercises/data/models/my_messages_model/exercise_cat.dart`)
   - Field: `cat_id`
   
6. **Subscriptions Model** (`lib/Features/subscribtions/data/models/my_messages_model/subscribtions.dart`)
   - Fields: `type_id`, `branch_id_fk`, and all numeric subscription fields
   
7. **Captains Model** (`lib/Features/captains/data/models/captains.dart`)
   - Field: `id`
   
8. **Branches Model** (`lib/Features/auth/register/data/models/register_model/branches.dart`)
   - Fields: `branch_id`, `from_id`

### 1.2 Error Handling Enhancement

**Design Decision**: Add error state handling in dropdowns and list views to provide user feedback when API calls fail.

**Implementation**:
- Check for null or empty data states
- Display Arabic error messages
- Provide retry mechanisms where appropriate

## 2. UI/UX Improvements

### 2.1 Empty State Component Redesign

**Component**: `EmptyWidget` (`lib/core/widgets/empty_widget.dart`)

**Design Changes**:
- Add optional `imagePath` parameter to allow custom images
- Default to UFC logo for brand consistency
- Maintain existing text and layout structure

**Updated Signature**:
```dart
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
    required this.text,
    this.imagePath = 'assets/images/uf.png', // Default to UFC logo
  }) : super(key: key);

  final String text;
  final String imagePath;
}
```

**Usage Pattern**:
```dart
EmptyWidget(
  text: 'لا يوجد بيانات',
  imagePath: 'assets/images/uf.png',
)
```

**Affected Views**:
- News view body
- Exercises view body
- Subscriptions view body
- My Subscriptions view body
- Notifications view body
- Inbody view body

### 2.2 Color Scheme Consistency

**Component**: `CustomTabButton` (`lib/features/app_home/presentation/views/widgets/custom_tab_button.dart`)

**Design Change**:
- Replace hardcoded red color `Color.fromARGB(255, 252, 8, 8)` with `kPrimaryColor`
- Ensures brand consistency across all tab buttons
- `kPrimaryColor` is defined as yellow/gold in theme constants

### 2.3 Registration Screen Branding

**Component**: Register view body (`lib/Features/auth/register/presentation/views/widgets/register_view_body.dart`)

**Design Changes**:
- Remove white color filter from logo
- Use UFC logo asset directly: `assets/images/uf.png`
- Maintain logo size and positioning

**Before**:
```dart
Image.asset(
  AssetsData.logo,
  color: Colors.white,
)
```

**After**:
```dart
Image.asset('assets/images/uf.png')
```

## 3. Feature Implementations

### 3.1 Delete Account Feature

**Location**: Personal account screen (`lib/Features/personal_account/presentation/views/widgets/personal_account_screen_body.dart`)

**Design Components**:

1. **API Integration**:
   - Endpoint: `Api/delete_account`
   - Method: POST
   - Parameters: `mem_id`, `password`
   - Added to `NetworkApi` class

2. **UI Flow**:
   ```
   User taps "حذف الحساب" button
   → Dialog appears with UFC logo
   → User enters password
   → Validation checks
   → API call with loading state
   → Success: Clear Hive data + Navigate to login
   → Error: Show error message
   ```

3. **Dialog Design**:
   - UFC logo at top
   - Warning text in Arabic
   - Password input field
   - Delete button (red color for danger action)
   - Cancel button

4. **Security Considerations**:
   - Requires password confirmation
   - Clears all local Hive storage
   - Logs user out completely
   - Navigates to login screen with no back navigation

**Implementation Details**:
```dart
void _showDeleteAccountDialog(BuildContext context) {
  // Show dialog with password field
  // On confirm:
  //   1. Validate password not empty
  //   2. Call API with mem_id and password
  //   3. On success: Hive.box('employee').clear()
  //   4. Navigate to login screen
}
```

## 4. Build Configuration

### 4.1 Signing Configuration

**File**: `android/key.properties`

**Design Decision**: Use separate properties file for signing credentials to keep them out of version control and allow easy configuration changes.

**Configuration**:
```properties
storePassword=123456
keyPassword=123456
keyAlias=key0
storeFile=../../noamany.jks
```

**Gradle Integration** (`android/app/build.gradle`):
```groovy
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}
```

### 4.2 Package Name Migration

**Old Package**: `com.alatheer.noamany`  
**New Package**: `com.metacodex.UFCGym`

**Rationale**: Match Google Play Console requirements and proper branding.

**Updated Locations**:
1. `android/app/build.gradle`:
   - `applicationId "com.metacodex.UFCGym"`
   - `namespace "com.metacodex.UFCGym"`

2. All AndroidManifest.xml files:
   - `android/app/src/main/AndroidManifest.xml`
   - `android/app/src/debug/AndroidManifest.xml`
   - `android/app/src/profile/AndroidManifest.xml`

### 4.3 SDK Version Optimization

**Design Decision**: Reduce SDK versions from 36 to 34 for broader device compatibility while maintaining all required features.

**Configuration**:
```groovy
android {
    compileSdk 34
    
    defaultConfig {
        targetSdkVersion 34
        // ... other config
    }
}
```

**Rationale**:
- SDK 36 is very recent and limits device compatibility
- SDK 34 provides all needed features
- Broader market reach with older devices

### 4.4 Build Strategy

**Problem**: App Bundle builds fail due to Kotlin daemon cache corruption issues.

**Solution**: Use split APK builds instead.

**Build Command**:
```bash
flutter build apk --release --split-per-abi
```

**Output**:
- `app-armeabi-v7a-release.apk` - 32-bit ARM (most older devices)
- `app-arm64-v8a-release.apk` - 64-bit ARM (modern devices)
- `app-x86_64-release.apk` - x86 64-bit (emulators, some tablets)

**Advantages**:
- Smaller download sizes per device type
- Faster installation
- Optimized for specific architectures
- Workaround for Kotlin build issues

## 5. Code Generation

### 5.1 Hive Type Adapters

**Problem**: `build_runner` taking hours to complete code generation.

**Solution**: Manually create generated files with proper TypeAdapter implementations.

**Generated Files**:

1. **EmployeeEntityAdapter** (`lib/Features/auth/login/domain/entities/employee_entity.g.dart`):
```dart
class EmployeeEntityAdapter extends TypeAdapter<EmployeeEntity> {
  @override
  final int typeId = 0;

  @override
  EmployeeEntity read(BinaryReader reader) {
    return EmployeeEntity(
      memId: reader.readString(),
      // ... read all fields
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeEntity obj) {
    writer.writeString(obj.memId);
    // ... write all fields
  }
}
```

2. **NewFingerPrintEntityAdapter** (`lib/features/new_bsama_add_Fingerprint/domain/entities/new_finger_print_entity.g.dart`):
```dart
class NewFingerPrintEntityAdapter extends TypeAdapter<NewFingerPrintEntity> {
  @override
  final int typeId = 1;

  @override
  NewFingerPrintEntity read(BinaryReader reader) {
    return NewFingerPrintEntity(
      id: reader.readString(),
      // ... read all fields
    );
  }

  @override
  void write(BinaryWriter writer, NewFingerPrintEntity obj) {
    writer.writeString(obj.id);
    // ... write all fields
  }
}
```

**Design Considerations**:
- Each adapter has unique `typeId`
- Proper `part of` directive to link with main entity file
- Read/write methods match entity field types
- Registered in `main.dart` before Hive initialization

## 6. Testing Strategy

### 6.1 Manual Testing Checklist

**Data Parsing**:
- Verify all list screens load data correctly
- Check that IDs display properly
- Confirm no null data errors in logs

**UI/UX**:
- Verify empty states show UFC logo
- Check tab button colors are yellow/gold
- Confirm registration logo displays correctly

**Features**:
- Test delete account flow end-to-end
- Verify branches dropdown loads
- Check all navigation flows

**Build**:
- Install APKs on physical devices
- Verify app signature
- Test on different Android versions

### 6.2 Regression Testing

After any model changes:
1. Perform Hot Restart (not Hot Reload)
2. Or run `flutter clean` and rebuild
3. Verify affected screens load correctly

## 7. Deployment

### 7.1 Google Play Console Upload

**Recommended Approach**: Upload split APKs

**Steps**:
1. Navigate to Google Play Console
2. Select "APKs" option (not App Bundle)
3. Upload all 3 APK files together:
   - `app-armeabi-v7a-release.apk`
   - `app-arm64-v8a-release.apk`
   - `app-x86_64-release.apk`
4. Verify package name matches: `com.metacodex.UFCGym`
5. Verify signing certificate SHA1 matches keystore

**Alternative**: If App Bundle is required, investigate Kotlin version compatibility or build on different machine.

## 8. Future Considerations

### 8.1 Potential Improvements

1. **Type Safety**: Consider migrating models to use proper numeric types and handle conversion at API boundary layer

2. **Build Optimization**: Investigate Kotlin daemon issues for App Bundle support

3. **Error Handling**: Implement global error handling strategy with user-friendly messages

4. **Offline Support**: Enhance local caching for better offline experience

5. **Testing**: Add automated tests for critical flows (login, registration, data parsing)

### 8.2 Technical Debt

1. Mixed case in feature folder names (`Features` vs `features`)
2. Some hardcoded strings that should be in localization files
3. Build runner performance issues
4. Kotlin version compatibility concerns

## Correctness Properties

### P1: Data Integrity
**Property**: All API responses with numeric IDs must parse successfully into model objects without type errors.

**Validation**: No parsing exceptions in logs when loading any list screen.

### P2: UI Consistency
**Property**: All empty states must display the UFC logo (`assets/images/uf.png`).

**Validation**: Visual inspection of all empty state screens.

### P3: Build Reproducibility
**Property**: Release builds must produce signed APKs with correct package name and signature.

**Validation**: 
- APK package name = `com.metacodex.UFCGym`
- APK signature SHA1 = `99:10:67:F1:62:89:F5:DA:05:34:BF:54:D4:8D:AD:08:9A:9D:0B:C6`

### P4: Account Deletion Safety
**Property**: Delete account must require password confirmation and completely clear local data.

**Validation**:
- Cannot delete without password
- After deletion, Hive storage is empty
- User redirected to login screen
- No way to navigate back to authenticated screens
