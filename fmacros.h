#ifndef __HIREDIS_FMACRO_H
#define __HIREDIS_FMACRO_H

#if !defined(_BSD_SOURCE)
#define _BSD_SOURCE
#endif

#if defined(__sun__)
#elif defined(__linux__)
#define _XOPEN_SOURCE 600
#else
#define _XOPEN_SOURCE
#endif

#endif
