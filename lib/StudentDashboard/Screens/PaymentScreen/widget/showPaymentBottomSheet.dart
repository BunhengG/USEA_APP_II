import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';

import '../../../../theme/text_style.dart';
import '../model/payment_model.dart';

void showPaymentDetailsBottomSheet(
    BuildContext context, List<PaymentClass> invoices, String year,
    {required Color backgroundColor}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(36),
        topRight: Radius.circular(36),
      ),
    ),
    builder: (BuildContext context) {
      return PaymentBottomSheet(invoices: invoices, year: year);
    },
  );
}

class PaymentBottomSheet extends StatefulWidget {
  final List<PaymentClass> invoices;
  final String year;

  const PaymentBottomSheet({
    super.key,
    required this.invoices,
    required this.year,
  });

  @override
  _PaymentBottomSheetState createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Height animation from 0 to full height
    _heightAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return FractionallySizedBox(
          heightFactor: 0.5.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Fixed Drag Handle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 36.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(rd_SmallRounded),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ឆ្នាំទី​ '.tr.toUpperCase() + widget.year,
                      style: getTitleLargePrimaryColorTextStyle().copyWith(
                        color: context.titlePrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1.h,
                color: cl_SecondaryColor,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(90.w),
                  children: [
                    TableRow(
                      children: [
                        _buildHeaderText(context, 'កាលបរិច្ឆេទ'),
                        _buildHeaderText(context, 'លេខវិក័យបត្រ'),
                        Container(
                          margin: EdgeInsets.only(left: 26.r),
                          child: _buildHeaderText(context, 'ទឹកប្រាក់បានបង់'),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16.r),
                          child: _buildHeaderText(context, 'ទឹកប្រាក់នៅសល់'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Ensure the ListView is scrollable within the available space
              Expanded(
                child: ListView.builder(
                  itemCount: widget.invoices.length,
                  itemBuilder: (context, index) {
                    PaymentClass invoice = widget.invoices[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
                              defaultColumnWidth: FixedColumnWidth(90.w),
                              children: [
                                TableRow(
                                  children: [
                                    _buildBodyText(
                                      context,
                                      invoice.paymentDate,
                                    ),
                                    _buildBodyText(
                                      context,
                                      invoice.invoiceNumber,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 26.r),
                                      child: _buildBodyText(
                                        context,
                                        '\$ ${invoice.amountPaid}',
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 16.r),
                                      child: _buildBodyText(
                                        context,
                                        '\$ ${invoice.remainingAmount}',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildHeaderText(BuildContext context, String text) {
  return Text(
    text.tr,
    style: getTitleSmallPrimaryColorTextStyle().copyWith(
      fontSize: 14.sp,
      color: context.subTitlePrimaryColor,
    ),
  );
}

Widget _buildBodyText(BuildContext context, String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 14.sp,
      color: context.subTitleColor,
    ),
  );
}
