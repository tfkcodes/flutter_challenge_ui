import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color bgColor = Color(0xFFF8F9FE);
const Color primaryColor = Color(0xFF2E303F);
const Color paidColor = Color(0xFF16A34A);
const Color unpaidColor = Color(0xFFF97316);
const Color btnColor = Color(0xFF1D1D1D);
const Color blueColor = Color(0xFF0646AA);

class RisitScreen extends StatefulWidget {
  const RisitScreen({super.key});

  @override
  State<RisitScreen> createState() => _RisitScreenState();
}

class _RisitScreenState extends State<RisitScreen> {
  final List<Transaction> _transactions = [
    Transaction(
      name: "You",
      status: "Paid",
      userIcon: CupertinoIcons.person_alt_circle_fill,
      statusIcon: CupertinoIcons.check_mark_circled_solid,
      iconColor: paidColor,
    ),
    Transaction(
      name: "Olabode",
      status: "Paid",
      userIcon: CupertinoIcons.person_alt_circle,
      statusIcon: CupertinoIcons.check_mark_circled_solid,
      iconColor: paidColor,
    ),
    Transaction(
      name: "Lukmon",
      status: "Paid",
      userIcon: CupertinoIcons.person_alt_circle,
      statusIcon: CupertinoIcons.check_mark_circled_solid,
      iconColor: paidColor,
    ),
    Transaction(
      name: "Hope",
      status: "Unpaid",
      userIcon: CupertinoIcons.person_alt_circle,
      statusIcon: Icons.access_time_filled_sharp,
      iconColor: unpaidColor,
    ),
    Transaction(
      name: "Dara",
      status: "Unpaid",
      userIcon: CupertinoIcons.person_alt_circle,
      statusIcon: Icons.access_time_filled_sharp,
      iconColor: unpaidColor,
    ),
  ];

  final List<ProgressIcon> _progressIcons = [
    ProgressIcon(color: paidColor, icon: Icons.check_circle),
    ProgressIcon(color: paidColor, icon: Icons.check_circle),
    ProgressIcon(color: paidColor, icon: Icons.check_circle),
    ProgressIcon(color: primaryColor),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: const _BottomPaymentSection(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: _buildBackButton(),
      centerTitle: true,
      title: const Text(
        "Payment Status",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      actions: [_buildShareButton()],
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 35,
        backgroundColor: bgColor,
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildShareButton() {
    return IconButton(
      icon: const Icon(Icons.ios_share_rounded, color: Colors.black87),
      onPressed: () {},
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Stack(
        fit: StackFit.loose,
        children: [
          _buildBackgroundGradient(),
          _buildTopShadow(),
          _buildInvoiceCard(),
        ],
      ),
    );
  }

  Widget _buildBackgroundGradient() {
    return Positioned(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [btnColor, primaryColor],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopShadow() {
    return Positioned(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.black.withOpacity(0.1)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: ClipPath(
        clipper: InvoiceClipper(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.1],
              colors: [Colors.black, Colors.white],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 0.6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 5),
                const DottedLine(),
                const SizedBox(height: 5),
                _buildInvoiceTitle(),
                const SizedBox(height: 5),
                const DottedLine(),
                const SizedBox(height: 5),
                _buildAmountSection(),
                _buildTransactionList(),
                _buildPaymentStatusSection(),
                _buildProgressIndicator(),
                const SizedBox(height: 10),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceTitle() {
    return const Text(
      "Trip Invoice - Japan Summer 2025",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
    );
  }

  Widget _buildAmountSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
            ),
            Text(
              "\$30,000",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Per Person",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            Text("\$6,000", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactionList() {
    return Column(
      children: _transactions
          .map((transaction) => _buildTransactionRow(transaction))
          .toList(),
    );
  }

  Widget _buildTransactionRow(Transaction transaction) {
    return Column(
      children: [
        Divider(color: primaryColor.withOpacity(0.1)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildUserInfo(transaction),
            _buildStatusBadge(transaction),
          ],
        ),
      ],
    );
  }

  Widget _buildUserInfo(Transaction transaction) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: bgColor,
            border: const Border.fromBorderSide(BorderSide(width: 0.1)),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Center(child: Icon(transaction.userIcon)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            transaction.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(Transaction transaction) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        border: const Border.fromBorderSide(BorderSide(width: 0.1)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Icon(
              transaction.statusIcon,
              color: transaction.iconColor,
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(transaction.status, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentStatusSection() {
    return Column(
      children: [
        Divider(color: primaryColor.withOpacity(0.1)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Payment status"),
            Container(
              height: 40,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "UNPAID",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          _buildProgressBar(),
          _buildProgressIcons(),
          _buildPaintIcon(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            height: 12,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIcons() {
    return Positioned(
      top: 0,
      left: 0,
      right: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _progressIcons
            .map((icon) => _buildProgressIcon(icon))
            .toList(),
      ),
    );
  }

  Widget _buildProgressIcon(ProgressIcon progressIcon) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: progressIcon.icon != null ? bgColor : primaryColor,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Center(
        child: Icon(progressIcon.icon, color: progressIcon.color, size: 20),
      ),
    );
  }

  Widget _buildPaintIcon() {
    return Positioned(
      right: 0,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Center(
          child: Transform.rotate(
            angle: 90,
            child: Icon(
              CupertinoIcons.paintbrush,
              color: primaryColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton("Send Reminder", primaryColor, bgColor),
        _buildButton("Download Invoice", bgColor, primaryColor),
      ],
    );
  }

  Widget _buildButton(String text, Color backgroundColor, Color textColor) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: backgroundColor,
        boxShadow: backgroundColor == bgColor
            ? [
                BoxShadow(
                  color: primaryColor.withOpacity(0.2),
                  spreadRadius: 0.2,
                  blurRadius: 5,
                  offset: const Offset(0, 0.3),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _BottomPaymentSection extends StatefulWidget {
  const _BottomPaymentSection({super.key});

  @override
  State<_BottomPaymentSection> createState() => __BottomPaymentSectionState();
}

class __BottomPaymentSectionState extends State<_BottomPaymentSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Divider(color: primaryColor.withOpacity(0.1)),
            _buildPaymentMethodRow(),
            const SizedBox(height: 10),
            _buildPayButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Payment Method", style: TextStyle(fontSize: 14)),
        Row(
          children: [
            const Text("Visa Ending 2986", style: TextStyle(fontSize: 14)),
            const SizedBox(width: 8),
            Container(
              height: 30,
              width: 40,
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPayButton() {
    return Container(
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 45,
      child: const Center(
        child: Text("Pay Now", style: TextStyle(color: bgColor)),
      ),
    );
  }
}

class DottedLine extends StatefulWidget {
  const DottedLine({Key? key, this.height = 1, this.color = Colors.black})
    : super(key: key);

  final double height;
  final Color color;

  @override
  State<DottedLine> createState() => _DottedLineState();
}

class _DottedLineState extends State<DottedLine> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = widget.height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();

        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: widget.color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

class Transaction {
  final String name;
  final String status;
  final IconData userIcon;
  final IconData statusIcon;
  final Color iconColor;

  const Transaction({
    required this.name,
    required this.status,
    required this.userIcon,
    required this.statusIcon,
    required this.iconColor,
  });
}

class ProgressIcon {
  final Color color;
  final IconData? icon;

  const ProgressIcon({required this.color, this.icon});
}

class InvoiceClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const double dotRadius = 5;
    const double spacing = 15;

    path.moveTo(0, 0);
    path.lineTo(0, size.height - dotRadius * 2);

    double x = 0;
    while (x < size.width) {
      path.arcToPoint(
        Offset(x + spacing / 2, size.height),
        radius: const Radius.circular(dotRadius),
        clockwise: false,
      );
      path.arcToPoint(
        Offset(x + spacing, size.height - dotRadius * 3),
        radius: const Radius.circular(dotRadius),
        clockwise: false,
      );
      x += spacing;
    }
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
