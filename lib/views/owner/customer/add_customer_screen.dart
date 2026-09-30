  import 'package:e_stock/core/constants/app_color.dart';
  import 'package:e_stock/views/widget/custom_Textfield.dart';
  import 'package:e_stock/views/widget/custom_button.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';

  import '../../../model/customer_model.dart';
  import '../../../view_Model/customer_viewmodel.dart';

  class AddCustomerScreen extends StatefulWidget {
    final CustomerModel? customer;

    const AddCustomerScreen({super.key, this.customer});

    @override
    State<AddCustomerScreen> createState() => _AddCustomerScreenState();
  }

  class _AddCustomerScreenState extends State<AddCustomerScreen> {
    // Form key
    final _formKey = GlobalKey<FormState>();

    final customerNameController = TextEditingController();

    final customerPhoneController = TextEditingController();

    final customerAddressController = TextEditingController();

    @override
    void initState() {
      super.initState();

      // If customer is not null, we are editing
      if (widget.customer != null) {
        customerNameController.text = widget.customer!.name;

        customerPhoneController.text = widget.customer!.phone;

        customerAddressController.text = widget.customer!.address;
      }
    }

    @override
    void dispose() {
      customerNameController.dispose();
      customerPhoneController.dispose();
      customerAddressController.dispose();

      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      final screenWidth = MediaQuery.sizeOf(context).width;

      // Check whether this screen is being used for editing
      final bool isEditing = widget.customer != null;

      return Scaffold(
        backgroundColor: AppColors.backgroundCanvas,

        // ================= APP BAR =================
        appBar: AppBar(
          backgroundColor: AppColors.headerNavy,
          title: Text(
            isEditing ? 'Edit Customer' : 'Add Customer',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

        ),

        // ================= BODY =================
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),

          child: Form(
            key: _formKey,

            child: Column(
              children: [
                const SizedBox(height: 25),

                // ================= MAIN CONTAINER =================
                Container(
                  width: screenWidth - 20,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.inputBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ================= TITLE =================
                      const Text(
                        'CUSTOMER INFORMATION',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textLabels,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ================= NAME =================
                      const Text(
                        'CUSTOMER NAME',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textLabels,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextfield(
                        controller: customerNameController,
                        hintText: 'Enter customer name',

                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter customer name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      // ================= PHONE =================
                      const Text(
                        'PHONE NUMBER',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textLabels,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextfield(
                        keyboardtype: .number,
                        controller: customerPhoneController,
                        hintText: 'Enter phone number',
                        validator: (value) {

                          // Phone number is optional
                          if (value == null || value.trim().isEmpty) {
                            return null;
                          }

                          // If user entered something, it must contain numbers only
                          if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
                            return 'Phone number must contain numbers only';
                          }

                          // Check phone number length
                          if (value.trim().length < 10 ||
                              value.trim().length > 15) {
                            return 'Please enter a valid phone number';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      // ================= ADDRESS =================
                      const Text(
                        'ADDRESS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textLabels,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextfield(
                        controller: customerAddressController,
                        hintText: 'Enter customer address',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter customer address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      // ================= SAVE / UPDATE BUTTON =================
                      SizedBox(
                        width: double.infinity,
                        child: Consumer<CustomerViewModel>(
                          builder: (context, customerViewModel, child) {
                            return CustomButton(
                              title: customerViewModel.isLoading
                                  ? (isEditing
                                        ? 'Updating Customer...'
                                        : 'Adding Customer...')
                                  : (isEditing
                                        ? 'Update Customer'
                                        : 'Add Customer'),

                              onTap: () async {
                                if (customerViewModel.isLoading) {
                                  return;
                                }

                                // Validate form first
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                // Create customer object
                                final customer = CustomerModel(
                                  // Keep old ID when editing
                                  id:
                                      widget.customer?.id ??
                                      DateTime.now().millisecondsSinceEpoch
                                          .toString(),
                                  name: customerNameController.text.trim(),
                                  phone: customerPhoneController.text.trim(),
                                  address: customerAddressController.text.trim(),
                                );
                                bool success;

                                // ================= EDIT =================
                                if (isEditing) {
                                  success = await customerViewModel
                                      .updateCustomer(customer);
                                }
                                // ================= ADD =================
                                else {
                                  success = await customerViewModel.addCustomer(
                                    customer,
                                  );
                                }
                                if (!mounted) return;
                                if (success) {
                                  Navigator.pop(
                                    context,
                                    isEditing ? 'updated' : 'added',
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      );
    }
  }
