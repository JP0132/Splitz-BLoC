import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/presentation/authentication/widgets/auth_button.dart';
import 'package:splitz_bloc/presentation/authentication/widgets/auth_field.dart';
import 'package:splitz_bloc/presentation/split/split_bloc.dart';
import 'package:splitz_bloc/presentation/split/split_event.dart';
import 'package:splitz_bloc/presentation/split/split_state.dart';
import 'package:splitz_bloc/presentation/split/widgets/CustomDropDown.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/constants/images.dart';
import 'package:splitz_bloc/utils/constants/values.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class CreateNewSplit extends StatefulWidget {
  const CreateNewSplit({super.key});

  @override
  State<CreateNewSplit> createState() => _CreateNewSplitState();
}

class _CreateNewSplitState extends State<CreateNewSplit> {
  final splitNameController = TextEditingController();
  String selectedCategory = "";
  String selectedColour = "";
  String selectedCurrency = "";
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
                  "Create a new split now!",
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
