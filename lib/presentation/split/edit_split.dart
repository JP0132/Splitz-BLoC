import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/presentation/authentication/widgets/auth_button.dart';
import 'package:splitz_bloc/presentation/authentication/widgets/auth_field.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_state.dart';
import 'package:splitz_bloc/presentation/split/widgets/custom_dropdown.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/constants/images.dart';
import 'package:splitz_bloc/utils/constants/values.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class EditSplit extends StatefulWidget {
  final SplitModel splitDetails;
  const EditSplit({super.key, required this.splitDetails});

  @override
  State<EditSplit> createState() => _EditSplitState();
}

class _EditSplitState extends State<EditSplit> {
  late TextEditingController splitNameController;
  String selectedCategory = "";
  String selectedColour = "";
  String selectedCurrency = "";

  @override
  void initState() {
    splitNameController = TextEditingController(text: widget.splitDetails.name);

    selectedCategory = widget.splitDetails.category;
    selectedColour = widget.splitDetails.colour;
    selectedCurrency = widget.splitDetails.currency;

    super.initState();
  }

  @override
  void dispose() {
    splitNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Helperfunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    image: AssetImage(
                  isDark
                      ? CustomImages.darkThemeLogo
                      : CustomImages.lightThemeLogo,
                )),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Edit your split details!",
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
            Form(
                child: Column(
              children: [
                AuthField(
                  hintText: "Split Name",
                  controller: splitNameController,
                ),
                const SizedBox(
                  height: 16,
                ),
                Customdropdown(
                  dropListName: "Category",
                  selectedValue: selectedCategory,
                  values: CustomValues.categories,
                  onValueChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Customdropdown(
                  dropListName: "Colour",
                  selectedValue: selectedColour,
                  values: CustomValues.colours,
                  onValueChanged: (value) {
                    setState(() {
                      selectedColour = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Customdropdown(
                  dropListName: "Currency",
                  selectedValue: selectedCurrency,
                  values: CustomValues.currencies,
                  onValueChanged: (value) {
                    setState(() {
                      selectedCurrency = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                BlocConsumer<SplitBloc, SplitState>(
                  listener: (context, state) {
                    if (state is SplitSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Split created successfully!'),
                        backgroundColor: CustomColours.darkSuccess,
                      ));
                      Navigator.popAndPushNamed(context, "/home");
                    } else if (state is SplitFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Failed to create split: ${state.message}'),
                        backgroundColor: CustomColours.darkError,
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is SplitLoading) {
                      return const CircularProgressIndicator();
                    }
                    return AuthButton(
                      text: "Create Split",
                      operation: () {
                        final name = splitNameController.text;
                        if (name.isNotEmpty &&
                            selectedColour != "" &&
                            selectedCategory != "" &&
                            selectedCurrency != "") {
                          context.read<SplitBloc>().add(CreateSplitRequested(
                                name: name,
                                category: selectedCategory,
                                colour: selectedColour,
                                currency: selectedCurrency,
                              ));
                          selectedCategory = "";
                          selectedColour = "";
                          selectedCurrency = "";
                          splitNameController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: CustomColours.darkError,
                                content: Text('Please fill in all fields')),
                          );
                        }
                      },
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blue.shade900],
                      ),
                    );
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
