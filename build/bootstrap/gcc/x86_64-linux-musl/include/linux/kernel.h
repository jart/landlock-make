#ifndef _LINUX_KERNEL_H
#define _LINUX_KERNEL_H

#ifdef __GLIBC__
#include <linux/sysinfo.h>
#endif

/*
 * 'kernel.h' contains some often-used function prototypes etc
 */
#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))


#endif /* _LINUX_KERNEL_H */
