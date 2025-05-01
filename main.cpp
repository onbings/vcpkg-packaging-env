#include <iostream>
#include <bofstd/bofstd.h>
//#include <bof2d/bof2d.h>
#include <bofwebrpc/bofwebserver.h>
#include <bofdearimgui/bof_dearimgui.h>

class ApeClientUi : public BOF::Bof_ImGui
{
public:
  ApeClientUi(const BOF::BOF_IMGUI_PARAM &_rApeClientUiParam_X)
    : BOF::Bof_ImGui(_rApeClientUiParam_X)
  {
  }

  BOFERR V_ReadSettings() override { return BOF_ERR_NO_ERROR; }
  BOFERR V_SaveSettings() override { return BOF_ERR_NO_ERROR; }
  BOFERR V_RefreshGui() override { return BOF_ERR_NO_ERROR; }
};

int main(int, char**)
{
  printf("BofStd version %s\n", BOF::Bof_GetVersion().c_str());
  
  //printf("Bof2d  version %s\n", BOF2D::Bof_GetVersion().c_str());
  
  BOF::BOF_IMGUI_PARAM BofImGuiParaml_X;
  ApeClientUi *pApeClientUi=new ApeClientUi(BofImGuiParaml_X);
  delete pApeClientUi;
  
  BOFWEBRPC::BOF_WEB_SERVER_PARAM BofWebRpcParam_X;
  BOFWEBRPC::BofWebServer *pBofWebServer=new BOFWEBRPC::BofWebServer(nullptr, BofWebRpcParam_X);
  delete pBofWebServer;
  
  return 0;
}
