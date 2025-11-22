import 'package:flutter/material.dart';
import 'reports_statistics.dart';


class ReportsDatePickerScreen extends StatefulWidget {
  const ReportsDatePickerScreen({super.key});

  @override
  State<ReportsDatePickerScreen> createState() => _ReportsDatePickerScreenState();
}

class _ReportsDatePickerScreenState extends State<ReportsDatePickerScreen> {
  DateTime startDate = DateTime(2024, 7, 6);
  DateTime endDate = DateTime(2024, 7, 14);
  DateTime? focusedDate;
  bool isSelectingStart = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Tìm kiếm ngày báo cáo"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Date Input Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nhập ngày",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateField(
                          label: "Ngày bắt đầu",
                          date: startDate,
                          isSelected: isSelectingStart,
                          onTap: () {
                            setState(() {
                              isSelectingStart = true;
                              focusedDate = startDate;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDateField(
                          label: "Ngày kết thúc",
                          date: endDate,
                          isSelected: !isSelectingStart,
                          onTap: () {
                            setState(() {
                              isSelectingStart = false;
                              focusedDate = endDate;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Calendar
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildCustomCalendar(),
            ),
          ),

          // Bottom buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Xóa",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Hủy",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReportsStatisticScreen(
                          startDate: startDate,
                          endDate: endDate,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Confirm button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReportsStatisticScreen(
                        startDate: startDate,
                        endDate: endDate,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "XÁC NHẬN NGÀY",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime date,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomCalendar() {
    final currentMonth = focusedDate ?? startDate;
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday % 7;

    return Column(
      children: [
        // Month selector
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: _getMonthName(currentMonth.month),
                underline: const SizedBox(),
                items: _months.map((month) {
                  return DropdownMenuItem(
                    value: month,
                    child: Text(month),
                  );
                }).toList(),
                onChanged: (value) {
                  // Handle month change
                },
              ),
              DropdownButton<int>(
                value: currentMonth.year,
                underline: const SizedBox(),
                items: List.generate(11, (i) => 2020 + i).map((year) {
                  return DropdownMenuItem(
                    value: year,
                    child: Text(year.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  // Handle year change
                },
              ),
            ],
          ),
        ),

        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
              .map((day) => SizedBox(
            width: 40,
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ))
              .toList(),
        ),

        const SizedBox(height: 8),

        // Calendar grid
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              final dayOffset = index - firstWeekday;

              if (dayOffset < 0 || dayOffset >= daysInMonth) {
                // Days from previous/next month
                final displayDay = dayOffset < 0
                    ? DateTime(currentMonth.year, currentMonth.month, 0).day + dayOffset + 1
                    : dayOffset - daysInMonth + 1;
                return Center(
                  child: Text(
                    displayDay.toString(),
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                );
              }

              final day = dayOffset + 1;
              final date = DateTime(currentMonth.year, currentMonth.month, day);
              final isStart = date.day == startDate.day &&
                  date.month == startDate.month &&
                  date.year == startDate.year;
              final isEnd = date.day == endDate.day &&
                  date.month == endDate.month &&
                  date.year == endDate.year;
              final isInRange = date.isAfter(startDate.subtract(const Duration(days: 1))) &&
                  date.isBefore(endDate.add(const Duration(days: 1)));

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelectingStart) {
                      startDate = date;
                      if (endDate.isBefore(startDate)) {
                        endDate = startDate.add(const Duration(days: 7));
                      }
                    } else {
                      if (date.isAfter(startDate) || date.isAtSameMomentAs(startDate)) {
                        endDate = date;
                      }
                    }
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isStart || isEnd
                        ? const Color(0xFF1B5E20)
                        : isInRange
                        ? Colors.green.shade50
                        : null,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      day.toString(),
                      style: TextStyle(
                        color: isStart || isEnd
                            ? Colors.white
                            : isInRange
                            ? const Color(0xFF1B5E20)
                            : Colors.black,
                        fontWeight: isStart || isEnd ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    return _months[month - 1];
  }

  final List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
}