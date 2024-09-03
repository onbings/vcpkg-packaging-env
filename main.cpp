#include <iostream>
#include <bofstd/bofstd.h>
#include <bofdearimgui/bof_dearimgui.h>
#include <bofwebrpc/bofwebrpc.h>

int main(int, char**)
{
  printf("BofStd version %s\n", BOF::Bof_GetVersion().c_str());
 
  return 0;
}
