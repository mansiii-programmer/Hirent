import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController fullNameController = TextEditingController(text: 'mansi.awasthi222');
  final TextEditingController usernameController = TextEditingController(text: 'mansi.awasthi222');
  final TextEditingController emailController = TextEditingController(text: 'mansi.awasthi222@gmail.com');
  final TextEditingController phoneController = TextEditingController(text: '+91 9876543210');
  final TextEditingController locationController = TextEditingController(text: 'Mumbai, Maharashtra');
  final TextEditingController bioController = TextEditingController(text: 'I am a dedicated professional looking to provide quality services.');
  final TextEditingController taskPostedController = TextEditingController(text: '5');

  List<String> skills = ['Cleaning', 'Gardening', 'Pet Care'];
  List<String> interests = ['Photography', 'Cooking', 'Travel'];
  String selectedRole = 'Task Provider';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Save Changes', style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfilePictureSection(),
            const SizedBox(height: 20),
            _buildTextField('Full Name', fullNameController),
            _buildTextField('Username', usernameController),
            _buildTextField('Email', emailController),
            _buildTextField('Phone Number', phoneController),
            _buildTextField('Location', locationController),
            _buildDropdownField(),
            _buildMultilineField('Bio', bioController),
            _buildTextField('Tasks Posted', taskPostedController, enabled: false),
            _buildChipsSection('Skills', skills),
            _buildChipsSection('Interests', interests),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePictureSection() {
    return Center(
      child: Column(
        children: [
          const Text('Profile Picture', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.teal,
            child: const Icon(Icons.person, size: 40, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildMultilineField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedRole,
        items: ['Task Provider', 'Task Seeker']
            .map((role) => DropdownMenuItem(value: role, child: Text(role)))
            .toList(),
        onChanged: (value) {
          setState(() => selectedRole = value!);
        },
        decoration: InputDecoration(
          labelText: 'Role',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildChipsSection(String label, List<String> values) {
    final TextEditingController chipController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: values
              .map((value) => Chip(
                    label: Text(value),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () => setState(() => values.remove(value)),
                  ))
              .toList(),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: chipController,
                decoration: InputDecoration(
                  hintText: 'Add $label'.toLowerCase(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.blue),
              onPressed: () {
                if (chipController.text.trim().isNotEmpty) {
                  setState(() {
                    values.add(chipController.text.trim());
                    chipController.clear();
                  });
                }
              },
            )
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}