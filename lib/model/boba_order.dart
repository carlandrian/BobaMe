/*
  BobaOrder will be historically saved in the backend, using the BobaOrder's id, a new record will be
  inserted in every order status step (see order statuses for orderStatus field).
 */

class BobaOrder {
  String id;
  String bobaProductId;
  String bobaProductName;
  String customerInfoId;
  String iceLevelId;
  String iceLevelName;
  String milkTypeId;
  String milkTypeName;
  DateTime orderStatusStartDateTime;    // Start date time of order status
  DateTime orderStatusEndDateTime;      // End date time of order status
  String orderStatus;                   // Order statuses (Pending, Received, In-progress, Pick-up/Delivery, Picked-up/Delivered, Done)
  String paymentStatus;                 // Paid / Unpaid
  String paymentStatusDateTime;
  String paymentType;                   // Cash / Credit
  String sweetnessLevelName;
  String sweetnessLevelId;
  String toppingsId;
  String toppingsName;
  int orderCount;
}