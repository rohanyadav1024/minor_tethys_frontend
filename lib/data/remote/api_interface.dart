abstract class ApiInterface {
  static const baseUrl = "https://web-production-2a3d.up.railway.app/";

  Future post(url, data);
  Future delete(url, data);
  Future put(url, data);
  Future get(url);
}
