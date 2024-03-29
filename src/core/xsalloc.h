#ifndef __XSALLOC_H
#define __XSALLOC_H

#include "redis/zmalloc.h"

#define xs_malloc zmalloc
#define xs_calloc zcalloc
#define xs_realloc zrealloc
#define xs_free(p) do { zfree(p); p = NULL; } while (0)
#define xs_strdup zstrdup

#endif /* __XSALLOC_H */
