// import 'package:flutter/material.dart';
// import 'package:e_stock/core/constants/app_color.dart';
//
// class SearchableProductDropdown extends StatefulWidget {
//   const SearchableProductDropdown({
//     super.key,
//     required this.products,
//     required this.onChanged,
//     this.hintText = 'Search or select product',
//   });
//
//   final List<String> products; // Products shown in the dropdown.
//   final ValueChanged<String?> onChanged; // Returns the selected product.
//   final String hintText; // Text shown before selecting a product.
//
//   @override
//   State<SearchableProductDropdown> createState() =>
//       _SearchableProductDropdownState();
// }
//
// class _SearchableProductDropdownState extends State<SearchableProductDropdown> {
//   final TextEditingController controller =
//       TextEditingController(); // Controls the search field text.
//
//   bool showDropdown = false; // Controls whether the product list is visible.
//   String? selectedProduct; // Stores the currently selected product.
//
//   @override
//   void dispose() {
//     controller
//         .dispose(); // Releases the text controller when the widget is removed.
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final search = controller.text
//         .toLowerCase(); // Gets the current search text.
//
//     final filteredProducts = widget.products
//         .where((product) => product.toLowerCase().contains(search))
//         .toList(); // Filters products according to the search text.
//
//     return Column(
//       children: [
//         // Search field used to search and open the dropdown.
//         TextField(
//           controller: controller,
//           readOnly: selectedProduct != null,
//
//           // Opens the product list when the field is tapped.
//           onTap: () {
//             setState(() {
//               showDropdown = true;
//             });
//           },
//
//           // Filters the products while the user types.
//           onChanged: (_) {
//             setState(() {
//               showDropdown = true;
//             });
//           },
//
//           decoration: InputDecoration(
//             hintText:
//                 selectedProduct ??
//                 widget.hintText, // Shows selected product or hint.
//             // Shows search icon before selection and check icon after selection.
//             prefixIcon: Icon(
//               selectedProduct == null ? Icons.search : Icons.check_circle,
//               color: selectedProduct == null
//                   ? AppColors.textMuted
//                   : Colors.green,
//             ),
//
//             // Contains the clear and dropdown buttons.
//             suffixIcon: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Clears the selected/search product.
//                 if (controller.text.isNotEmpty)
//                   IconButton(
//                     icon: const Icon(Icons.clear),
//                     onPressed: () {
//                       setState(() {
//                         selectedProduct = null;
//                         controller.clear();
//                         showDropdown = true;
//                       });
//
//                       widget.onChanged(null);
//                     },
//                   ),
//
//                 // Opens or closes the dropdown list.
//                 IconButton(
//                   icon: Icon(
//                     showDropdown
//                         ? Icons.keyboard_arrow_up
//                         : Icons.keyboard_arrow_down,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       showDropdown = !showDropdown;
//                     });
//                   },
//                 ),
//               ],
//             ),
//
//             filled: true,
//
//             // Gives the selected product a different background color.
//             fillColor: selectedProduct != null
//                 ? Colors.green.withOpacity(0.08)
//                 : AppColors.backgroundCanvas,
//
//             // Normal border of the search field.
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(
//                 color: selectedProduct != null
//                     ? Colors.green
//                     : AppColors.inputBorder,
//               ),
//             ),
//
//             // Border shown when the search field is focused.
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: AppColors.primaryBlue),
//             ),
//           ),
//         ),
//
//         // Shows the filtered product list when the dropdown is open.
//         if (showDropdown)
//           Container(
//             margin: const EdgeInsets.only(top: 6),
//
//             // Limits the dropdown height and allows it to scroll.
//             constraints: const BoxConstraints(maxHeight: 200),
//
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: AppColors.inputBorder),
//               borderRadius: BorderRadius.circular(8),
//             ),
//
//             // Displays the filtered products.
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: filteredProducts.length,
//
//               itemBuilder: (context, index) {
//                 final product =
//                     filteredProducts[index]; // Gets the current product.
//
//                 return ListTile(
//                   dense: true,
//
//                   // Product icon shown in each dropdown item.
//                   leading: const Icon(Icons.inventory_2_outlined),
//
//                   // Displays the product name.
//                   title: Text(product),
//
//                   // Selects the product when the user taps it.
//                   onTap: () {
//                     setState(() {
//                       selectedProduct = product;
//                       controller.text = product;
//                       showDropdown = false;
//                     });
//
//                     // Sends the selected product back to the parent screen.
//                     widget.onChanged(product);
//
//                     // Hides the keyboard after selection.
//                     FocusScope.of(context).unfocus();
//                   },
//                 );
//               },
//             ),
//           ),
//       ],
//     );
//   }
// }

import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/model/product_model.dart';
import 'package:flutter/material.dart';

class SearchableProductDropdown extends StatefulWidget {
  const SearchableProductDropdown({
    super.key,
    required this.products,
    required this.onChanged,
    this.hintText = 'Search or select product',
    this.focusedColor,
  });

  final List<ProductModel> products;
  final ValueChanged<ProductModel?> onChanged;
  final String hintText;
  // Color of the border when the search field is focused final Color? focusedColor;
  final Color? focusedColor;
  @override
  State<SearchableProductDropdown> createState() =>
      _SearchableProductDropdownState();
}

class _SearchableProductDropdownState extends State<SearchableProductDropdown> {
  final TextEditingController controller = TextEditingController();

  bool showDropdown = false;
  ProductModel? selectedProduct;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final search = controller.text.trim().toLowerCase();

    final filteredProducts = widget.products.where((product) {
      final name = '${product.productName} ${product.packaging}'.toLowerCase();

      return name.contains(search);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Search / selected product field
        TextField(
          controller: controller,
          readOnly: selectedProduct != null,
          onTap: () {
            if (selectedProduct == null) {
              setState(() {
                showDropdown = true;
              });
            }
          },
          onChanged: (_) {
            setState(() {
              showDropdown = true;
            });
          },
          decoration: InputDecoration(
            hintText: selectedProduct == null
                ? widget.hintText
                : '${selectedProduct!.productName} '
                      '${selectedProduct!.packaging}',

            prefixIcon: Icon(
              selectedProduct == null ? Icons.search : Icons.check_circle,
              color: selectedProduct == null
                  ? AppColors.textMuted
                  : Colors.green,
            ),

            // Clear selected product
            suffixIcon: selectedProduct != null
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        selectedProduct = null;
                        controller.clear();
                        showDropdown = true;
                      });

                      widget.onChanged(null);
                    },
                  )
                : IconButton(
                    icon: Icon(
                      showDropdown
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                    onPressed: () {
                      setState(() {
                        showDropdown = !showDropdown;
                      });
                    },
                  ),

            filled: true,
            fillColor: AppColors.backgroundCanvas,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: selectedProduct != null
                    ? Colors.green
                    : AppColors.inputBorder,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide( color: widget.focusedColor ?? AppColors.primaryBlue, ),
            ),
          ),
        ),

        // Product list
        if (showDropdown)
          Container(
            margin: const EdgeInsets.only(top: 6),
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.inputBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: filteredProducts.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'No products found',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      final productName =
                          '${product.productName} '
                          '${product.packaging}';

                      final isSelected = selectedProduct?.id == product.id;

                      return ListTile(
                        dense: true,
                        // leading: Icon(
                        //   isSelected
                        //       ? Icons.check_circle
                        //       : Icons.inventory_2_outlined,
                        //   color: isSelected
                        //       ? Colors.green
                        //       : AppColors.primaryBlue,
                        // ),
                        title: Text(productName),

                        // Select product
                        onTap: () {
                          setState(() {
                            selectedProduct = product;
                            controller.text = productName;
                            showDropdown = false;
                          });

                          widget.onChanged(product);

                          FocusScope.of(context).unfocus();
                        },
                      );
                    },
                  ),
          ),
      ],
    );
  }
}
