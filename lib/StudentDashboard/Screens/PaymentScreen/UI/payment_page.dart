import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/StudentDashboard/components/custom_Student_Multi_Appbar.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../../../../theme/theme_provider/theme_provider.dart';
import '../../../../theme/theme_provider/theme_utils.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';
import '../bloc/payment_state.dart';
import '../model/payment_model.dart';
import '../widget/payment_shimmer.dart';
import '../widget/showPaymentBottomSheet.dart';

const gradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  stops: [
    0.30,
    0.62,
    1.0,
  ],
  colors: [
    Color(0xFF2C55C1),
    Color(0xFF4C74BD),
    Color(0xFF002060),
  ],
);

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final colorMode = isDarkMode(context);
    return BlocProvider(
      create: (context) => PaymentBloc()..add(FetchPayments()),
      child: Scaffold(
        backgroundColor: cl_ThirdColor,
        appBar: StudentMultiAppBar(
          title: 'ការបង់ប្រាក់'.tr,
          onBackButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              color: colorMode ? cl_DefaultDark_Mode : cl_ThirdColor,
            ),
            BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                if (state is PaymentLoading) {
                  return const Center(child: PaymentShimmer());
                } else if (state is PaymentError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is PaymentLoaded) {
                  if (_isLoading) {
                    Future.delayed(
                      const Duration(milliseconds: 500),
                      () {
                        setState(
                          () {
                            _isLoading = false;
                          },
                        );
                      },
                    );
                    return const Center(child: PaymentShimmer());
                  }

                  return _buildPaymentList(
                    state.paymentData,
                    state.otherPaymentData,
                  );
                } else {
                  return const Center(child: Text('No payment data available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentList(
    List<PayStudy> paymentData,
    List<OtherPayment> otherPaymentData,
  ) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
            top: 16,
          ),
          child: Text(
            'ការបង់ថ្លៃឈ្នួលសិក្សា'.tr,
            style: getTitleLargePrimaryColorTextStyle().copyWith(
              fontSize: 20.sp,
              color: context.titlePrimaryColor,
            ),
          ),
        ),
        if (paymentData.isNotEmpty) _buildPayStudyRow(paymentData),
        Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
            top: 8,
          ),
          child: Text(
            'ការបង់ថ្លៃឈ្នួលដកលិខិតបញ្ជាក់ការសិក្សាផ្សេងៗ'.tr,
            style: getTitleLargePrimaryColorTextStyle().copyWith(
              fontSize: 20.sp,
              color: context.titlePrimaryColor,
            ),
          ),
        ),
        if (otherPaymentData.isNotEmpty)
          ...otherPaymentData.map((payment) => _buildOtherPaymentCard(payment)),
      ],
    );
  }

  Widget _buildPayStudyRow(List<PayStudy> paymentData) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children:
              paymentData.map((study) => _buildPayStudyCard(study)).toList(),
        ),
      ),
    );
  }

  Widget _buildPayStudyCard(PayStudy study) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [sd_BoxShadow],
        borderRadius: BorderRadius.circular(rd_MediumRounded),
        gradient: gradient,
      ),
      width: 340.w,
      height: 240.h,
      margin: EdgeInsets.only(right: 8.r),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ឆ្នាំទី​ '.tr.toUpperCase() + study.year,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Builder(
                  builder: (context) {
                    return InkWell(
                      onTap: () {
                        final backgroundColor =
                            context.read<ThemeProvider>().themeMode ==
                                    ThemeMode.dark
                                ? cl_Background_Modal_Mode
                                : cl_ThirdColor;
                        showPaymentDetailsBottomSheet(
                          context,
                          study.invoices,
                          study.year.toString(),
                          backgroundColor: backgroundColor,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(rd_LargeRounded),
                          color: Colors.white24,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                'ការបង់ថ្លៃឈ្នួលសិក្សា'.tr,
                style: getBodyMediumThirdColorTextStyle(),
              ),
            ),
            _buildRichText(
              'ទឹកប្រាក់ត្រូវបង់'.tr,
              ': \$ ${study.finalPrice}',
              valueFontSize: 18,
              valueFontWeight: FontWeight.w600,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRemainingAndPaidRow(study),
                _buildRichText(
                  'ទឹកប្រាក់បានបង់'.tr,
                  ': \$ ${study.paid}',
                  valueFontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemainingAndPaidRow(PayStudy study) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ទឹកប្រាក់នៅសល់'.tr.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: gradient,
          ),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Text(
            '\$ ${study.remaining}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherPaymentCard(OtherPayment payment) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [sd_BoxShadow],
        borderRadius: BorderRadius.circular(rd_MediumRounded),
        color: const Color(0xFF3961C7),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOtherPaymentText(
                  'ទឹកប្រាក់ត្រូវបង់'.tr, payment.moneyToPay),
              _buildOtherPaymentText('ទឹកប្រាក់បានបង់'.tr, payment.moneyPaid),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            color: context.secondaryColoDarkMode,
            thickness: 1,
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRichText(
                '${'លេខវិក័យបត្រ'.tr} : ',
                payment.paymentDate,
                valueFontWeight: FontWeight.normal,
                labelFontSize: 12,
                valueFontSize: 14,
              ),
              _buildRichText(
                '${'កាលបរិច្ឆេទ'.tr} : ',
                payment.invoiceNumber,
                valueFontWeight: FontWeight.normal,
                labelFontSize: 12,
                valueFontSize: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOtherPaymentText(String text, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          amount.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildRichText(
    String label,
    String valueText, {
    double labelFontSize = 14,
    double valueFontSize = 16,
    FontWeight labelFontWeight = FontWeight.normal,
    FontWeight valueFontWeight = FontWeight.w500,
  }) {
    return RichText(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontSize: labelFontSize.sp,
          color: Colors.white,
          fontWeight: labelFontWeight,
        ),
        children: [
          TextSpan(
            text: valueText,
            style: TextStyle(
              fontSize: valueFontSize.sp,
              color: Colors.white,
              fontWeight: valueFontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
