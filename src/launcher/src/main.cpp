#include "core/app_core.h"

int main(int argc, char **argv)
{
  core::AppCore app(argc, argv);
  return app.start();
}
