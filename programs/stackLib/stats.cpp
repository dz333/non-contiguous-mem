#include "stats.h"

static char *
print_int (int val, char *buf, int buflen, size_t *print_len)
{
  int is_negative;
  int i;
  unsigned int uval;

  uval = (unsigned int) val;
  if (val >= 0)
    is_negative = 0;
  else
    {
      is_negative = 1;
      uval = - uval;
    }

  i = buflen;
    do
      {
	--i;
	buf[i] = '0' + (uval % 10);
	uval /= 10;
      }
    while (uval != 0 && i > 0);

    if (is_negative)
      {
	if (i > 0)
	  --i;
	buf[i] = '-';
      }

    *print_len = buflen - i;
    return buf + i;
}


void printAlloc(int didAlloc) {
  static const char msg[] = "Alloc bytes: ";
  size_t len = sizeof msg - 1;
  char buf[24];
  static const char nl[] = "\n";
  struct iovec iov[3];
  union { char *p; const char *cp; } myvar;

  myvar.cp = msg;
  iov[0].iov_base = myvar.p;
  iov[0].iov_len = len;
  /* We can't call strerror, because it may try to translate the error
     message, and that would use too much stack space.  */
  iov[1].iov_base = print_int (didAlloc, buf, sizeof buf, &iov[1].iov_len);
  myvar.cp = &nl[0];
  iov[2].iov_base = myvar.p;
  iov[2].iov_len = sizeof nl - 1;
  /* FIXME: On systems without writev we need to issue three write
     calls, or punt on printing errno.  For now this is irrelevant
     since stack splitting only works on GNU/Linux anyhow.  */
  writev (2, iov, 3);
}


int main(int argc, char **argv) {
  printAlloc(3);
  return 0;
}
