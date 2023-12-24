import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spikeguard/shared/globals.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class AddressFormData {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController flatHouseBuildingController = TextEditingController();
  TextEditingController areaStreetVillageController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController townCityController = TextEditingController();
  TextEditingController deliveryInstructionsController =
      TextEditingController();

  String fullName = '';
  String mobileNumber = '';
  String flatHouseBuilding = '';
  String areaStreetVillage = '';
  String landmark = '';
  String pincode = '';
  String townCity = '';
  String selectedState = 'Select';
  bool makeDefaultAddress = false;
  String deliveryInstructions = '';

  bool isMandatory(String label) {
    // Add the labels of fields that you want to mark as mandatory
    final mandatoryFields = [
      'Full name (First and Last name)',
      'Mobile number',
      'Flat, House no., Building, etc.',
      'Area, Street, Sector, Village',
      'Landmark',
      'Pincode',
      'Town/City',
    ];
    return mandatoryFields.contains(label.trim());
  }
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final AddressFormData formData = AddressFormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.indigo],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _cancelAddressEntry,
            child: const Text(
              'CANCEL',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextInput(
                'Full name (First and Last name)', formData.fullNameController),
            _buildTextInput('Mobile number*', formData.mobileNumberController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
            _buildTextInput('Flat, House no., Building, etc.*',
                formData.flatHouseBuildingController),
            _buildTextInput('Area, Street, Sector, Village*',
                formData.areaStreetVillageController),
            _buildTextInput('Landmark*', formData.landmarkController),
            _buildTextInput('Pincode*', formData.pincodeController),
            _buildTextInput('Town/City*', formData.townCityController),
            _buildDropdownInput('State*', formData.selectedState),
            _buildCheckbox(
                'Make this my default address', formData.makeDefaultAddress),
            _buildTextInput('Delivery instructions (optional)',
                formData.deliveryInstructionsController,
                maxLines: 4),
            _buildUseThisAddressButton(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInput(String label, TextEditingController controller,
      {int maxLines = 1,
      TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter>? inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formData.isMandatory(label) ? '$label*' : label,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: controller,
            onChanged: (value) => _updateFormData(label, value),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDropdownInput(String label, String selectedValue) {
    final List<String> states = [
      'Select State',
      'Jammu and Kashmir',
      'Andhra Pradesh',
      'Arunachal Pradesh',
      'Assam',
      'Bihar',
      'Chhattisgarh',
      'Goa',
      'Gujarat',
      'Haryana',
      'Himachal Pradesh',
      'Jharkhand',
      'Karnataka',
      'Kerala',
      'Madhya Pradesh',
      'Maharashtra',
      'Manipur',
      'Meghalaya',
      'Mizoram',
      'Nagaland',
      'Odisha',
      'Punjab',
      'Rajasthan',
      'Sikkim',
      'Tamil Nadu',
      'Telangana',
      'Tripura',
      'Uttar Pradesh',
      'Uttarakhand',
      'West Bengal',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formData.isMandatory(label) ? '$label*' : label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: states.contains(selectedValue)
                    ? selectedValue
                    : 'Select State',
                onChanged: (newValue) {
                  setState(() {
                    formData.selectedState = newValue!;
                  });
                },
                items: states
                    .map<DropdownMenuItem<String>>(
                      (value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String label, bool isChecked) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                formData.makeDefaultAddress = value ?? false;
              });
            },
          ),
          Text(
            formData.isMandatory(label) ? '$label*' : label,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildUseThisAddressButton() {
    bool isButtonEnabled = _areMandatoryFieldsFilled();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: isButtonEnabled ? _useThisAddress : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.yellow,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          'Use This Address',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  bool _areMandatoryFieldsFilled() {

    return formData.fullName.isNotEmpty &&
        formData.mobileNumber.isNotEmpty &&
        formData.flatHouseBuilding.isNotEmpty &&
        formData.areaStreetVillage.isNotEmpty &&
        formData.landmark.isNotEmpty &&
        formData.pincode.isNotEmpty &&
        formData.townCity.isNotEmpty &&
        formData.selectedState != 'Select';
  }

  void _updateFormData(String label, String value) {
    setState(() {
      switch (label) {
        case 'Full name (First and Last name)':
          formData.fullName = value;
          break;
        case 'Mobile number*':
          formData.mobileNumber = value;
          break;
        case 'Flat, House no., Building, etc.*':
          formData.flatHouseBuilding = value;
          break;
        case 'Area, Street, Sector, Village*':
          formData.areaStreetVillage = value;
          break;
        case 'Landmark*':
          formData.landmark = value;
          break;
        case 'Pincode*':
          formData.pincode = value;
          break;
        case 'Town/City*':
          formData.townCity = value;
          break;
        case 'Delivery instructions (optional)':
          formData.deliveryInstructions = value;
          break;
      }
    });
  }

  void _cancelAddressEntry() {
    Navigator.pop(context);
  }

  void _useThisAddress() {
    // Create an Address object
    Address address = Address(
      fullName: formData.fullName,
      mobileNumber: formData.mobileNumber,
      flatHouseBuilding: formData.flatHouseBuilding,
      areaStreetVillage: formData.areaStreetVillage,
      landmark: formData.landmark,
      pincode: formData.pincode,
      townCity: formData.townCity,
      selectedState: formData.selectedState,
      makeDefaultAddress: formData.makeDefaultAddress,
      deliveryInstructions: formData.deliveryInstructions,
    );

    // Send the address back to the previous screen
    Navigator.pop(context, address);
  }
}
