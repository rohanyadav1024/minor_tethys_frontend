class Endpoints {
  static const login = 'login';
  static const otp = 'otp/send';

  static const owner = 'owner/';
  static const create = 'create';

  static const getEmpRequests = "requests/";
  static const acceptEmpReq = "requests/permit";
  static const denyEmpReq = "requests/delete";

  static const employee = 'employees/';

  static const getItemsList = 'material/';

  static const getProductsList = 'products/';

  static const getPmInventory = 'pmanager/';
  static const sendRequestforItems = 'pmanager/create';
  static const getReqListForPmngr = 'pmanager/id';
  static const returnMaterial = 'pmanager/return/create';
  static const getReturnsForPmngr = 'pmanager/return/id';
  static const postHandover = 'pmanager/create/product';
  static const getHandoversForPmngr = 'pmanager/handover/id';
  static const markComplete = 'pmanager/complete/req';
  static const updateConsumption = 'pmanager/update';

  static const getInventory = 'smanager/';
  static const getReqListForSmngr = 'smanager/reqs';
  static const issueSlot = 'smanager/reqs/issue/slot';
  static const issueRequesitions = 'smanager/reqs/issue/req';
  static const denyRequest = 'smanager/reqs/deny/slot';
  static const getReturnsList = 'smanager/return/reqs';
  static const approveReturn = 'smanager/return/reqs/allow';
  static const denyReturns = 'smanager/return/reqs/deny';
  static const sendOrder = 'smanager/orders/create';
  static const sendConsignment = 'smanager/consignments/create';
  static const getHandoversListForSmngr = 'smanager/handovers';
  static const approveHandovers = 'smanager/handovers/recieve/batch';

  static const getOrderList = 'gkeep/';
  static const verifyOrders = 'gkeep/orders/check';
  static const getConsignmentList = 'gkeep/consignments';

  static const requestsArchived = 'history/reqs';
  static const returnsArchived = 'history/returns';
}
