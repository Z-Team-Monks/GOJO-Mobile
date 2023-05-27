import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/screen/widgets/form_input_label.dart';

import '../../../data_layer/model/category.dart';
import '../../bloc/create_property/create_property_bloc.dart';

class CategorySelector extends StatefulWidget {
  final List<Category> categories;

  const CategorySelector({super.key, required this.categories});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormInputLabel(
              label: "Category",
              isRequired: true,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: state.selectedCategory,
                  underline: Container(),
                  isExpanded: true,
                  hint: Text(
                    "Pick a category",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withOpacity(0.7),
                        ),
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        context
                            .read<CreatePropertyBloc>()
                            .add(CategorySelected(value));
                      });
                    }
                  },
                  items: widget.categories
                      .map<DropdownMenuItem<String>>((Category value) {
                    return DropdownMenuItem<String>(
                      value: value.name,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
