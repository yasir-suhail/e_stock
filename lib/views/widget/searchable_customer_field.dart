import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/model/customer_model.dart';
import 'package:e_stock/view_Model/customer_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchableCustomerField extends StatefulWidget {
  final CustomerModel? selectedCustomer;
  final Function(CustomerModel) onCustomerSelected;
  final VoidCallback onAddCustomer;

  const SearchableCustomerField({
    super.key,
    required this.selectedCustomer,
    required this.onCustomerSelected,
    required this.onAddCustomer,
  });

  @override
  State<SearchableCustomerField> createState() =>
      _SearchableCustomerFieldState();
}

class _SearchableCustomerFieldState extends State<SearchableCustomerField> {
  final TextEditingController customerController = TextEditingController();

  bool showCustomers = false;

  @override
  void initState() {
    super.initState();

    if (widget.selectedCustomer != null) {
      customerController.text = widget.selectedCustomer!.name;
    }
  }

  @override
  void dispose() {
    customerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customerViewModel = Provider.of<CustomerViewModel>(context);

    final customers = customerViewModel.displayCustomers;

    return TapRegion(
      onTapOutside: (event) {
        setState(() {
          showCustomers = false;
        });
      },

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CUSTOMER SEARCH FIELD
          TextField(
            controller: customerController,

            onTap: () {
              customerViewModel.searchCustomers(customerController.text);

              setState(() {
                showCustomers = true;
              });
            },

            onChanged: (value) {
              customerViewModel.searchCustomers(value);

              setState(() {
                showCustomers = true;
              });
            },

            decoration: InputDecoration(
              hintText: 'Search customer...',

              prefixIcon: Icon(
                Icons.person_outline,
                color: AppColors.textMuted,
              ),

              suffixIcon: IconButton(
                onPressed: widget.onAddCustomer,
                icon: Icon(Icons.add, color: AppColors.primaryBlue),
              ),

              filled: true,
              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.inputBorder),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.inputBorder),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.primaryBlue),
              ),
            ),
          ),

          // SEARCH RESULTS
          if (showCustomers)
            Container(
              margin: const EdgeInsets.only(top: 5),

              constraints: const BoxConstraints(maxHeight: 200),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.inputBorder),
              ),

              child: customers.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('No customers found'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,

                      itemCount: customers.length,

                      itemBuilder: (context, index) {
                        final customer = customers[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primaryBlue.withOpacity(
                              0.1,
                            ),

                            child: Icon(
                              Icons.person_outline,
                              color: AppColors.primaryBlue,
                            ),
                          ),

                          title: Text(customer.name),

                          subtitle: Text(customer.phone),

                          onTap: () {
                            widget.onCustomerSelected(customer);

                            customerController.text = customer.name;

                            setState(() {
                              showCustomers = false;
                            });
                          },
                        );
                      },
                    ),
            ),
        ],
      ),
    );
  }
}
