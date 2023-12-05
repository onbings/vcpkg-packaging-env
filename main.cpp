#include <iostream>
#include <bofstd/bofstd.h>
#include <bof2d/bof2d.h>

int main(int, char**)
{
  printf("BofStd version %s\n", BOF::Bof_GetVersion().c_str());
  printf("Bof2d  version %s\n", BOF2D::Bof_GetVersion().c_str());
 
  return 0;
}
