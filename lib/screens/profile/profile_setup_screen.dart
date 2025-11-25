import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../widgets/common/custom_button.dart';
import '../../utils/images/image_helper.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  int _currentStep = 0;
  final int _totalSteps = 4;
  final _formKey = GlobalKey<FormState>();

  // Step 1: Basic Info
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // Step 2: Address & Contact
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  // Step 4: Interests
  final List<String> _availableInterests = [
    'Beaches',
    'Mountains',
    'Food & Dining',
    'Culture & History',
    'Adventure',
    'Luxury',
    'Nightlife',
    'Wellness',
  ];
  final Set<String> _selectedInterests = {};

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _countryController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Finish setup
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setup'),
        centerTitle: true,
        automaticallyImplyLeading: false, // Hide back button
      ),
      body: Column(
        children: [
          // Progress Indicator
          LinearProgressIndicator(
            value: (_currentStep + 1) / _totalSteps,
            backgroundColor: AppColors.lightGrey,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.secondary),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStepHeader(),
                    const SizedBox(height: 24),
                    _buildCurrentStep(),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildStepHeader() {
    String title = '';
    String subtitle = '';

    switch (_currentStep) {
      case 0:
        title = 'Basic Information';
        subtitle = 'Tell us a bit about yourself.';
        break;
      case 1:
        title = 'Address & Contact';
        subtitle = 'How can we reach you?';
        break;
      case 2:
        title = 'Profile Upload';
        subtitle = 'Add a photo to personalize your profile.';
        break;
      case 3:
        title = 'Interests';
        subtitle = 'Select topics you are interested in.';
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headline4.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style:
              AppTextStyles.bodyText1.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildAddressContactStep();
      case 2:
        return _buildProfileUploadStep();
      case 3:
        return _buildInterestsStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBasicInfoStep() {
    return Column(
      children: [
        TextFormField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _bioController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Bio (Optional)',
            hintText: 'Share something about your travel style...',
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressContactStep() {
    return Column(
      children: [
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            prefixIcon: Icon(Icons.phone_outlined),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _countryController,
          decoration: const InputDecoration(
            labelText: 'Country',
            prefixIcon: Icon(Icons.public),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _provinceController,
          decoration: const InputDecoration(
            labelText: 'Province',
            prefixIcon: Icon(Icons.map_outlined),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _cityController,
          decoration: const InputDecoration(
            labelText: 'City',
            prefixIcon: Icon(Icons.location_city),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _streetController,
          decoration: const InputDecoration(
            labelText: 'Street Address',
            prefixIcon: Icon(Icons.home_outlined),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _zipController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: 'ZIP / Postal Code',
            prefixIcon: Icon(Icons.local_post_office_outlined),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileUploadStep() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: ClipOval(
                  child: ImageHelper.loadImage(
                    ImageHelper.profilePlaceholder,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: () {
                      // Placeholder for image picker
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Image picker coming soon!')),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Upload a photo so hosts and other travelers can recognize you.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyText2
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestsStep() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: _availableInterests.map((interest) {
        final isSelected = _selectedInterests.contains(interest);
        return FilterChip(
          label: Text(interest),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedInterests.add(interest);
              } else {
                _selectedInterests.remove(interest);
              }
            });
          },
          selectedColor: AppColors.primary.withOpacity(0.2),
          checkmarkColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0) ...[
            Expanded(
              child: CustomButton(
                text: 'Back',
                type: ButtonType.outlined,
                onPressed: _prevStep,
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            flex: 2,
            child: CustomButton(
              text: _currentStep == _totalSteps - 1 ? 'Finish Setup' : 'Next',
              onPressed: _nextStep,
            ),
          ),
        ],
      ),
    );
  }
}
