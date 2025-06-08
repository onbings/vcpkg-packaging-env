#include <iostream>
#include <vector>
// #include <bof2d/bof2d.h>
#include <bofdearimgui/bof_dearimgui.h>
#include <bofstd/bofcommandlineparser.h>
#include <bofwebrpc/bofwebserver.h>
#include <evs-hwfw-dis/dis_avahi_client.h>
#include <evs-hwfw-dis/dis_mdns.h>
#include <evs-hwfw-dis/dis_web_socket_server.h>

struct XTS_DIS_CLIENT_APP_PARAM {
  BOF::BOF_SOCKET_ADDRESS_COMPONENT DisServerEndpoint_X;

  XTS_DIS_CLIENT_APP_PARAM() { Reset(); }

  void Reset() { DisServerEndpoint_X.Reset(); }
};

static XTS_DIS_CLIENT_APP_PARAM S_XtsDisClientAppParam_X;

static std::vector<BOF::BOFPARAMETER> S_pCommandLineOption_X = {
    {nullptr, "DisServer",
     "Specifies the test server endpoint such as tcp://127.0.0.1:8080.", "", "",
     BOF::BOFPARAMETER_ARG_FLAG::CMDLINE_LONGOPT_NEED_ARG,
     BOF_PARAM_DEF_VARIABLE(S_XtsDisClientAppParam_X.DisServerEndpoint_X, IPV4,
                            0, 0)},
};

static std::unique_ptr<DIS::DisWebSocketServer> S_puDisWebSocketServer =
    nullptr;

static bool S_DefaultSignalHandler(uint32_t _Signal_U32) {
  S_puDisWebSocketServer.reset();
  BOF::Bof_Shutdown();
  exit(_Signal_U32);
  return true;
}

class ApeClientUi : public BOF::Bof_ImGui {
public:
  ApeClientUi(const BOF::BOF_IMGUI_PARAM &_rApeClientUiParam_X)
      : BOF::Bof_ImGui(_rApeClientUiParam_X) {}

  BOFERR V_ReadSettings() override { return BOF_ERR_NO_ERROR; }
  BOFERR V_SaveSettings() override { return BOF_ERR_NO_ERROR; }
  BOFERR V_RefreshGui() override { return BOF_ERR_NO_ERROR; }
};

int main(int, char **_pArgv_c) {
  BOF::BOFSTDPARAM StdParam_X;
  BOF::BofPath AppName(_pArgv_c[0]);
  BOF::BofCommandLineParser CmdLineParser;
  std::string Cwd_S, HelpString_S;

  printf("BofStd version %s\n", BOF::Bof_GetVersion().c_str());
  StdParam_X.SignalHandler = S_DefaultSignalHandler;
  BOF::Bof_Initialize(StdParam_X);

  CmdLineParser.BuildHelpString(S_pCommandLineOption_X,
                                AppName.FileNameWithoutExtension() + '\n',
                                HelpString_S);

  BOFWEBRPC::BOF_WEB_SOCKET_PARAM WebSocketParam_X;
  WebSocketParam_X.NbMaxOperationPending_U32 = 4;
  WebSocketParam_X.RxBufferSize_U32 = 0x100000;
  WebSocketParam_X.NbMaxBufferEntry_U32 = 128;
  WebSocketParam_X.OnMessage = nullptr;
  WebSocketParam_X.NbMaxClient_U32 = 8;
  WebSocketParam_X.ServerIp_X = BOF::BOF_SOCKET_ADDRESS(
      S_XtsDisClientAppParam_X.DisServerEndpoint_X.ToString(true, false, false,
                                                            true));
  WebSocketParam_X.WebSocketThreadParam_X.Name_S = "DisService";
  WebSocketParam_X.WebSocketThreadParam_X.ThreadSchedulerPolicy_E =
      BOF::BOF_THREAD_SCHEDULER_POLICY::BOF_THREAD_SCHEDULER_POLICY_OTHER;
  WebSocketParam_X.WebSocketThreadParam_X.ThreadPriority_E =
      BOF::BOF_THREAD_PRIORITY::BOF_THREAD_PRIORITY_000;
  S_puDisWebSocketServer =
      std::make_unique<DIS::DisWebSocketServer>(WebSocketParam_X);

  if (S_puDisWebSocketServer) {
    S_puDisWebSocketServer->Run();
    while (1) {
      std::this_thread::sleep_for(std::chrono::milliseconds(200));
    }
  }

  // printf("Bof2d  version %s\n", BOF2D::Bof_GetVersion().c_str());

  BOF::BOF_IMGUI_PARAM BofImGuiParaml_X;
  ApeClientUi *pApeClientUi = new ApeClientUi(BofImGuiParaml_X);
  delete pApeClientUi;

  BOFWEBRPC::BOF_WEB_SERVER_PARAM BofWebRpcParam_X;
  BOFWEBRPC::BofWebServer *pBofWebServer =
      new BOFWEBRPC::BofWebServer(nullptr, BofWebRpcParam_X);
  delete pBofWebServer;

  constexpr const char *AVAHI_UT_GROUP_NAME = "TheAvahiUtGroup";
  DIS::DIS_AVAHI_CLIENT_PARAM AvahiClientParam_X;
  AvahiClientParam_X.LoopTimeOutInMs_U32 = 1000;

  DIS::DisAvahiClient DisAvahiClient(AvahiClientParam_X);
  DisAvahiClient.Start();

  std::map<std::string, std::map<std::string, DIS::MDNS_SERVICE_RECORD>>
      MdnsServiceInfoCollection;

  std::unique_ptr<DIS::DisMdns> puDisMdns =
      std::make_unique<DIS::DisMdns>(nullptr);
  puDisMdns->SendMdnsServiceDiscovery(2000, "*", MdnsServiceInfoCollection);
  puDisMdns->SendMdnsServiceDiscovery(2000, "*os*", MdnsServiceInfoCollection);

  /*
  DIS::DIS_PARAM DisParam_X;
  DIS::Dis *pDis=new DIS::Dis(nullptr, DisParam_X);
  delete pDis;
*/
  BOF::Bof_Shutdown();

  return 0;
}
