import 'package:moneta/src/core/auth/constants/rest_constants.dart';

class GlobalConstant {
  static String urlBase = RestConstants.baseUrl;

  static String monetaEndpint = RestConstants.monetaEndpint;

  static String systemAccess = 'SystemAccess';

  //!SECTION Notifications - Seção das notificações
  static String urlNotificationList = 'Notification/PagedWithFilter';
  static String urlNotificationRead = 'Notification/MarkAsRead';
  static String urlNotificationReadAll = 'Notification/MarkAsReadList';

  //!SECTION Expense - Seção da tela de despesas administrativas
  static String urlAdminExpenseReportList = 'Report/Specific/Administrative';
  static String urlAdminExpenseList = 'Expense/Specific/Administrative';

  //!SECTION Expense - Seção da tela de despesas de obra
  static String urlWorkExpenseReportList = 'Report/Specific/Work';
  static String urlWorkExpenseList = 'Expense/Specific/Work';

  static String urlExpenseCRUD = 'Expense';

  //!SECTION Dropdown
  static String urlExpenseTypeByReportId =
      'ExpenseType/Specific/ExpenseTypeByReportId';
  static String urlRegisteredStretchByFilter = 'RegisteredStretch/Filter';
  static String urlTravelPolicyByFilter = 'TravelPolicy/Filter';

  //!SECTION Dropdown - Corpore RM
  static String urlTOTvsRMCosteCenterListByFilter =
      'RM/CostCenterByEmployee/Filter';
  static String urlTOTvsRMBudgetNatureListByFilter = 'RM/BudgetNature/Filter';
  static String urlTOTvsRMProjectList = 'RM/ProjectActive';
  static String urlTOTvsRMTaskBalanceListByFilter = 'RM/TaskBalance/Filter';

  //!SECTION Attachments
  static String urlGetAttachments = 'Attachment/Document';
  static String urlDeleteAttachments = 'Attachment';

  static String urlTextPolicyGeneratedLolicy = 'TextPolicy/GeneratePolicy';

  //!SECTION Glosa
  static String urlGetExpenseGlossed = 'Expense/ExpenseGlossed';
  static String urlPutExpenseForGlosed = 'Expense/ExpenseForGloss';
  static String urlPutEmployeeJustification = 'Expense/EmployeeJustification';
}
