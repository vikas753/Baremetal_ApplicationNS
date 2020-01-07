/*
 * LTZVisor, a Lightweight TrustZone-assisted Hypervisor
 *
 * Copyright (c) TZVisor Project (www.tzvisor.org), 2017-
 *
 * Authors:
 *  Sandro Pinto <sandro@tzvisor.org>
 *  Jorge Pereira <jorgepereira89@gmail.com>
 *
 * This file is part of LTZVisor.
 *
 * LTZVisor is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2
 * as published by the Free Software Foundation, with a special   
 * exception described below.
 * 
 * Linking this code statically or dynamically with other modules 
 * is making a combined work based on this code. Thus, the terms 
 * and conditions of the GNU General Public License V2 cover the 
 * whole combination.
 *
 * As a special exception, the copyright holders of LTZVisor give  
 * you permission to link LTZVisor with independent modules to  
 * produce a statically linked executable, regardless of the license 
 * terms of these independent modules, and to copy and distribute  
 * the resulting executable under terms of your choice, provided that 
 * you also meet, for each linked independent module, the terms and 
 * conditions of the license of that module. An independent module  
 * is a module which is not derived from or based on LTZVisor.
 *
 * LTZVisor is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301 USA.
 *
 * [cpu_entry.S]
 *
 * This file contains ARMv7-A specific boot code.
 * 
 * (#) $id: cpu_entry.S 03-05-2015 s_pinto & j_pereira $
 * (#) $id: cpu_entry.S 16-09-2017 s_pinto (modified)$
*/

#include <cpu_defines.h>
#include <asm-offsets.h>
#include <platform_asm.h>

.text

.globl _reset_handler
_reset_handler:

	/** Handling VFP and NEON */
__init_vfp:
	/* FIX IT */
	

	/** Initializing C environment */
__init_c_env:
	bl	c_environment_init


	/**  Call Main */
__call_main:
//.globl cpu_init
	//bl	cpu_init				@@@ Jump to Operating System 'c' entry function
.globl ltzvisor_main
	bl	ltzvisor_main				@ Jump to LTZVisor entry function
	/* This point should never be reached */
	b	.


/**
 * Stuck other CPUs than CPU0
 *
 * @param
 *
 * @retval 
 */
__stuck_loop:
	b	__stuck_loop

/**
 * Get CPU id
 *
 * @param	
 *
 * @retval 	r0 - CPU id
 */
.global get_cpu_id
.func get_cpu_id
  @ uint32_t get_cpu_id(void)
get_cpu_id:
	mrc	p15, 0, r0, c0, c0, 5
	and	r0, r0, #0x03
	bx	lr
.endfunc

/**
 * Initializing C environment
 *
 * @param	
 *
 * @retval 	
 */
.globl c_environment_init
c_environment_init:
	/* bss initialization (zeros) */
	ldr	r1, =_SW_BSS_START
	ldr	r2, =_SW_BSS_END
	mov	r0, #0
2:
	cmp	r1, r2
	bgt	1f
	str	r0,	[r1], #4
	b	2b
1:
	mov		pc, lr

