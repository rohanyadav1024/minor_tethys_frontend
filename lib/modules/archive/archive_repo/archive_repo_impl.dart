import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/archive/archive_models/returns_archived_model.dart';
import 'package:tethys/modules/archive/archive_repo/archive_repo.dart';
import 'package:tethys/modules/archive/archive_models/requests_archived_model.dart';

class ArchiveRepoImpl extends ArchiveRepo {
  ApiService apiService = ApiService();

  @override
  Future<RequestsArchivedModel> getArchivedRequest(Map data) async {
    return requestsArchivedModelFromJson(
      await apiService.post(Endpoints.requestsArchived, data),
    );
  }

  @override
  Future<ReturnsArchivedModel> getArchivedReturn(Map data) async {
    return returnsArchivedModelFromJson(
      await apiService.post(Endpoints.returnsArchived, data),
    );
  }
}
