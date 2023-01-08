#include <iostream>
//#if 1
#include <bofstd/bofstd.h>
#include <bofstd/boffs.h>
#include <bofstd/bof2d.h>
//#else
#include <bof2d/bof2d_convert.h>
//#endif

int main(int, char**)
{
//#if 1	
  intptr_t Io;
  BOFERR Sts_E;
  BOF::BOF_FILE_FOUND b;
  BOF::BofMediaDetector MediaDetector;
  std::string Result_S;
  
  b.Reset();
  Sts_E = BOF::Bof_OpenFile("dontexist.txt", true, Io);
  printf("Bof_OpenFile rts %d\n", Sts_E);

  std::cout << "Hello world " << BOF::Bof_GetVersion() << std::endl;
  Sts_E = MediaDetector.ParseFile("dontexist.txt", BOF::BofMediaDetector::ResultFormat::Text, Result_S);
  std::cout << "MediaDetector.ParseFile " << BOF::Bof_ErrorCode(Sts_E) << std::endl;
//#else  
  uint8_t r_U8, g_U8, b_U8;
 BOF2D::Bof_YuvToRgbReference(16, 32, 64, &r_U8, &g_U8, b_U8);
//#endif
 
  return 0;
}
