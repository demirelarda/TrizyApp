import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trizy_app/bloc/address/address_bloc.dart';
import 'package:trizy_app/bloc/address/address_event.dart';
import 'package:trizy_app/bloc/address/address_state.dart';
import 'package:trizy_app/theme/colors.dart';
import '../../components/app_bar_with_back_button.dart';
import '../../components/buttons/custom_button.dart';
import '../../components/textfields/custom_text_field.dart';
import '../../models/address/address.dart';
import '../../models/address/create_address_request.dart';

class AddressFormPage extends StatefulWidget {
  final Address? address;

  const AddressFormPage({super.key, this.address});

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  late final TextEditingController fullNameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController addressController;
  late final TextEditingController cityController;
  late final TextEditingController stateController;
  late final TextEditingController postalCodeController;
  late final TextEditingController countryController;

  late String addressType;
  late bool isDefault;

  @override
  void initState() {
    super.initState();

    fullNameController = TextEditingController(text: widget.address?.fullName ?? "");
    phoneNumberController = TextEditingController(text: widget.address?.phoneNumber ?? "");
    addressController = TextEditingController(text: widget.address?.address ?? "");
    cityController = TextEditingController(text: widget.address?.city ?? "");
    stateController = TextEditingController(text: widget.address?.state ?? "");
    postalCodeController = TextEditingController(text: widget.address?.postalCode ?? "");
    countryController = TextEditingController(text: widget.address?.country ?? "USA");
    addressType = widget.address?.addressType ?? "home";
    isDefault = widget.address?.isDefault ?? false;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
    super.dispose();
  }

  void _saveAddress(BuildContext context) {
    final fullName = fullNameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();
    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final state = stateController.text.trim();
    final postalCode = postalCodeController.text.trim();
    final country = countryController.text.trim();

    if (fullName.isEmpty ||
        phoneNumber.isEmpty ||
        address.isEmpty ||
        city.isEmpty ||
        state.isEmpty ||
        postalCode.isEmpty ||
        country.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required.")),
      );
      return;
    }

    final request = CreateAddressRequest(
      fullName: fullName,
      phoneNumber: phoneNumber,
      address: address,
      city: city,
      state: state,
      postalCode: postalCode,
      country: country,
      addressType: addressType,
      isDefault: isDefault,
    );

    final bloc = BlocProvider.of<AddressBloc>(context);

    if (widget.address == null) {
      bloc.add(CreateAddressEvent(request: request));
    } else {
      bloc.add(UpdateAddressEvent(
        request: request,
        addressId: widget.address!.id,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddressBloc(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarWithBackButton(
          onBackClicked: () => Navigator.of(context).pop(),
          title: widget.address != null ? "Update Address" : "Create Address",
        ),
        body: BlocConsumer<AddressBloc, AddressState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message ?? "Operation successful")),
              );
              Navigator.of(context).pop("success");
            } else if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? "An error occurred")),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state.isLoading;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: "Full name",
                      height: 50,
                      controller: fullNameController,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hintText: "Phone number",
                      height: 50,
                      keyboardType: TextInputType.phone,
                      controller: phoneNumberController,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hintText: "Street address",
                      height: 50,
                      controller: addressController,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hintText: "City",
                      height: 50,
                      controller: cityController,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hintText: "State",
                      height: 50,
                      controller: stateController,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hintText: "Postal code",
                      height: 50,
                      keyboardType: TextInputType.number,
                      controller: postalCodeController,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hintText: "Country",
                      height: 50,
                      controller: countryController,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: addressType,
                      dropdownColor: white,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: "home", child: Text("Home")),
                        DropdownMenuItem(value: "work", child: Text("Work")),
                        DropdownMenuItem(value: "other", child: Text("Other")),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            addressType = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: primaryLightColor,
                          value: isDefault,
                          onChanged: (value) {
                            setState(() {
                              isDefault = value ?? false;
                            });
                          },
                        ),
                        const Text("Set as default address"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      isLoading: isLoading,
                      text: widget.address != null ? "Update" : "Save",
                      textColor: Colors.white,
                      color: primaryLightColor,
                      onClick: isLoading ? () {} : () => _saveAddress(context),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}