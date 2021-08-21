import 'package:ehire_app/scr/models/skills.dart';
import 'package:ehire_app/scr/styles/baseStyle.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:ehire_app/scr/widgets/filterChipWidget.dart';
import 'package:flutter/material.dart';

List<Skill> skill = [
  Skill(name: "Gardener"),
  Skill(name: "House Cleaner"),
  Skill(name: "Drain Pipe Cleaner"),
];

// bool _isSelected0 = false, _isSelected1 = false, _isSelected2 = false;

showDialogBox(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (_) => SimpleDialog(
            elevation: 2.0,
            backgroundColor: AppColors.disableButtonColor,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(BaseStyles.borderRadius - 10)),
            title: Text(
              'Create Invoice',
              style: TextStyles.buttonTextDark,
            ),
            children: [
              Container(
                // decoration: BoxDecoration(
                //     borderRadius:
                //         BorderRadius.circular(
                //             BaseStyles
                //                 .borderRadius)),
                height: MediaQuery.of(context).size.height * .7,
                width: MediaQuery.of(context).size.width * .9,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Select Services you want to offer:",
                            style: TextStyles.buttonTextDark,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .015,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Wrap(
                        spacing: 15.0,
                        runSpacing: 2.0,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Wrap(
                              spacing: 10.0,
                              runSpacing: 2.0,
                              children: [
                                FilterChipWidget(
                                  chipName: skill[0].name,
                                  isSelected: false,
                                  toggleChipState: (bool isSelectedValue) {
                                    // setState(() {
                                    //   _isSelected0 = isSelectedValue;
                                    // });
                                  },
                                ),
                                FilterChipWidget(
                                  chipName: skill[1].name,
                                  isSelected: false,
                                  toggleChipState: (isSelectedValue) {
                                    // setState(() {
                                    //   _isSelected1 = isSelectedValue;
                                    // });
                                  },
                                ),
                                FilterChipWidget(
                                  chipName: skill[2].name,
                                  isSelected: false,
                                  toggleChipState: (isSelectedValue) {
                                    // setState(() {
                                    //   _isSelected2 = isSelectedValue;
                                    // });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextField(
                              maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: "Give Description about yourself",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  "No of Hours",
                                  style: TextStyles.buttonTextDarkSmall,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  "USD/hr",
                                  style: TextStyles.buttonTextDarkSmall,
                                ),
                              ),
                            ],
                          ),
                          AppButton(
                            buttonText: "Request Payment",
                            buttonType: ButtonType.brownblack,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
}

showTermsAndConditionsBox(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (_) => SimpleDialog(
            elevation: 2.0,
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(BaseStyles.borderRadius - 10)),
            title: Text(
              'Terms and Conditons',
              style: TextStyles.buttonTextDark,
            ),
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * .7,
                  width: MediaQuery.of(context).size.width * .9,
                  child: ListView(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "1. This is First Term, The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. ",
                        maxLines: 5,
                        style: TextStyles.buttonTextDarkSmall,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "2. This is Second Term. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. ",
                        maxLines: 5,
                        style: TextStyles.buttonTextDarkSmall,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "3. This is Third Term. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. ",
                        maxLines: 5,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "4. This is Fourth Term. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. ",
                        maxLines: 5,
                        style: TextStyles.buttonTextDarkSmall,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "5. This is Fifth Term, The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. ",
                        maxLines: 5,
                        style: TextStyles.buttonTextDarkSmall,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "6. This is Sixth Term, The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. The Quick brown fox jumps over the lazy dog. ",
                        maxLines: 5,
                        style: TextStyles.buttonTextDarkSmall,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: AppButton(
                        buttonText: "Agree and Continue",
                        buttonType: ButtonType.brownblack,
                      ),
                    ),
                  ])),
            ],
          ));
}
