#include <linux/kernel.h>     
#include <linux/sched.h>
#include <linux/module.h>   
#include <linux/syscalls.h>      
#include <linux/types.h>
#include <linux/jiffies.h>
#include <linux/pid.h>

// variable to reference sys_call_table
unsigned long **sys_call_table;

// target syscall
asmlinkage int (*ref_sys_custom_syscall)(pid_t pid);

asmlinkage int get_cpu_time(pid_t pid)
{
        printk(KERN_DEBUG "Hokked Success, Input PID: %d\n", pid);
            return 0;
}

// Do not edit bellow

static unsigned long **acquire_sys_call_table(void) 
{
        unsigned long int offset = PAGE_OFFSET;
            unsigned long **sct;
                
                while (offset < ULLONG_MAX) {
                            sct = (unsigned long **)offset;

                                    if (sct[__NR_close] == (unsigned long *) sys_close)
                                                    return sct; // end of sys_call_table

                                            offset += sizeof(void *);
                                                }

                    return NULL;
}

static void disable_page_protection(void)
{
        unsigned long value;
            asm volatile("mov %%cr0, %0" : "=r" (value));

                if (!(value & 0x00010000))
                            return;

                    asm volatile("mov %0, %%cr0" : : "r" (value & ~0x00010000));
}

static void enable_page_protection(void)
{
        unsigned long value;
            asm volatile("mov %%cr0, %0" : "=r" (value));

                if ((value & 0x00010000))
                            return;

                    asm volatile("mov %0, %%cr0" : : "r" (value | 0x00010000));
}


// initialize function
int __init init_syscall_wrapper(void){  

        if (!(sys_call_table = acquire_sys_call_table()))
                    return -1;

            disable_page_protection();
                ref_sys_custom_syscall = (void *)sys_call_table[__NR_custom_syscall];
                    sys_call_table[__NR_custom_syscall] = (unsigned long *)get_cpu_time;
                        enable_page_protection();
                            return 0;
}

// cleanup function
void __exit exit_syscall_wrapper(void){
        if (!sys_call_table)
                    return;

            disable_page_protection();
                sys_call_table[__NR_custom_syscall] = (unsigned long *)ref_sys_custom_syscall;
                    enable_page_protection();

}


module_init(init_syscall_wrapper);
module_exit(exit_syscall_wrapper);
MODULE_LICENSE("GPL");

