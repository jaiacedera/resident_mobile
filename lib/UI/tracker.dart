import 'package:flutter/material.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color themeBlue = Color(0xFF274C77);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: themeBlue, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Tracking",
          style: TextStyle(color: themeBlue, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            
            // 1. REPORT TRACKING ACCORDION
            _buildTrackingAccordion("Report Tracking", themeBlue),
            
            const SizedBox(height: 15),

            // 2. REQUEST TRACKING ACCORDION (Expanded in your design)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: const Text(
                  "Request Tracking",
                  style: TextStyle(color: themeBlue, fontWeight: FontWeight.bold),
                ),
                shape: const Border(), // Removes default border
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Text(
                      "Request ID: #20-6146",
                      style: TextStyle(color: themeBlue, fontWeight: FontWeight.w500),
                    ),
                  ),
                  
                  // TIMELINE SECTION
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 20, bottom: 30),
                    child: Column(
                      children: [
                        _buildTimelineStep(
                          "Submitted Request", "10-24-2025", true, true, themeBlue),
                        _buildTimelineStep(
                          "Processing Request", "10-26-2025", true, true, themeBlue),
                        _buildTimelineStep(
                          "Under Review", "10-27-2025", false, false, themeBlue),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for the outer accordion boxes
  Widget _buildTrackingAccordion(String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDF2F7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.keyboard_arrow_down, color: color),
      ),
    );
  }

  // Helper for the vertical timeline steps
  Widget _buildTimelineStep(String title, String date, bool isDone, bool showLine, Color color) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isDone ? color : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: isDone 
                  ? const Icon(Icons.check, color: Colors.white, size: 18) 
                  : null,
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color, 
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                date,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 30), // Spacing between steps
            ],
          ),
        ],
      ),
    );
  }
}