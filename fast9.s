
.data
	.balign 4 
	output:	
		.asciz " %08x %08x \n"
	output2:	
		.asciz "was "
	output3:	
		.asciz "here\n"
	output4:	
		.asciz "%d\n"
	output5:	
		.asciz "kps: %08x %08x "
	output6:	
		.asciz "\n"
	output7:	
		.asciz "R1 was  %d %d\n"
	img .req r0
	kps .req r1
	kps_cnt .req r6
	result .req r8
	res .req r9
	const4 .req r11
	kps_const .req r12
	const2 .req r3
	cntx .req r2
	cnty .req r4
	const1 .req r5
	const0 .req r10

.text
.global     fast9_asm
.type	fast9_asm, %function
fast9_asm:
	push {r0-r12,lr}
	mov const2,#200
	add const2,const2,#110
	add img,img,#960
	add img,img,#3
	ldrh kps_const,[r2,#2]
	ldrh cnty,[r2]
	sub cnty,#6
	push {r0-r12}
	ldr r0,adress_output7
	mov r1,cnty
	mov r2,kps_const
	bl printf
	pop {r0-r12}
	//movw cnty, #234
	mov kps_cnt,#0
	start2:
		
		movw cntx,#19
		start:

			vld1.8 {q7}, [img] //#center
			mov const0,#255
			//strb const0,[img]
				//mov const0,#27
				//ldr result,[img]
				//cmp result,const0
				//bne end
			

			/*mov const0,#0
			VDUP.u8 q12,const0 //output register set to zero
			VDUP.u8 q13,const0 //output register set to zero
			VDUP.u8 q14,const0 //output register set to zero
			VDUP.u8 q15,const0 //output register set to zero*/

			mov const0,#8
			VDUP.8 q2,const0
			VADD.I8 q1,q7,q2 //create uper boundary 			
			VSUB.I8 q0,q7,q2 //create lower boundary
			
			VCLT.U8 q8, q0, q7 //if center was lower then 8 we set it to zero
			VAND.U8 q0,q8,q0

			VCLT.U8 q8,q1,q7 //if center was higher then 247 we set it to 255
			VORR.U8 q1,q8,q1


			sub img,img,#960
			mov const0,#128
			VDUP.8 q2,const0	
			vld1.8 {q3}, [img] //0
			VCGT.U8 q4 , q3,q1
			VAND.U8 q15 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q14 , q2,q3
			//VORR.U8 q14,q5,q14
			//VORR.U8 q15,q6,q15

			add img,img,#1
			mov const0,#64
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //1
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q14,q5,q14
			VORR.U8 q15,q6,q15

			add img,img,#1920
			mov const0,#1
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //7
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q14,q5,q14
			VORR.U8 q15,q6,q15

			sub img,img,#1
			mov const0,#128
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //8
			VCGT.U8 q4 , q3,q1
			VAND.U8 q13 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q12 , q2,q3
			//VORR.U8 q12,q5,q12
			//VORR.U8 q13,q6,q13

			sub img,img,#1
			mov const0,#64
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //9
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q12,q5,q12
			VORR.U8 q13,q6,q13

			sub img,img,#1920
			mov const0,#1
			VDUP.8 q2,const0			
			vld1.8 	{q3}, [img] //15
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q12,q5,q12
			VORR.U8 q13,q6,q13

			add img,img,#320
			sub img,img,#1
			mov const0,#2
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //14
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q12,q5,q12
			VORR.U8 q13,q6,q13

			add img,img,#4
			mov const0,#32
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //2
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q14,q5,q14
			VORR.U8 q15,q6,q15

			add img,img,#1280
			mov const0,#2
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //6
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q14,q5,q14
			VORR.U8 q15,q6,q15


			sub img,img,#4
			mov const0,#32
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //10
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q12,q5,q12
			VORR.U8 q13,q6,q13

			sub img,img,#960
			sub img,img,#1
			mov const0,#4
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //13
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q12,q5,q12
			VORR.U8 q13,q6,q13

			add img,img,#6
			mov const0,#16
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //3
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q14,q5,q14
			VORR.U8 q15,q6,q15

			add img,img,#320
			mov const0,#8
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //4
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q14,q5,q14
			VORR.U8 q15,q6,q15

			add img,img,#320
			mov const0,#4
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //5
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q14,q5,q14
			VORR.U8 q15,q6,q15

			sub img,img,#6
			mov const0,#16
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //11
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q12,q5,q12
			VORR.U8 q13,q6,q13


			sub img,img,#320
			mov const0,#8
			VDUP.8 q2,const0
			vld1.8 {q3}, [img] //12
			VCGT.U8 q4 , q3,q1
			VAND.U8 q6 , q2,q4
			VCLT.U8 q3 , q3,q0
			VAND.U8 q5 , q2,q3
			VORR.U8 q12,q5,q12
			VORR.U8 q13,q6,q13

			vcnt.u8 q0,q12				//check lower constraint
			vcnt.u8 q3,q14
			VADD.u8 q2,q0,q3

			vcnt.u8 q0,q13				//check higher constraint
			vcnt.u8 q3,q15
			VADD.u8 q3,q0,q3
			
			mov const0,#8				//build constraint mask
			vdup.u8 q1,const0        
			vcgt.u8 q2,q2,q1
			vcgt.u8 q3,q3,q1

			vand.u8 q12,q12,q2
			vand.u8 q14,q14,q2

			vand.u8 q13,q13,q3
			vand.u8 q15,q15,q3

			vorr.u8 q15,q14,q15        
			vorr.u8 q13,q12,q13

            vorr.u8 q2,q3
            vzip.u8 q13,q15

            mov const1,#0
            VDUP.U8 q7,const1
            VMOV.U32 const0,d4[0]
            cmp const0,#0
            beq notA0
            
            vmovl.u16 q11,d26
            vshr.u32 q10,q11,#16
            vorr.u32 q11,q10,q11
            VSHr.U32 q1,q11,#1
			VAND.U32 q0,q1,q11
			VSHr.U32 q1,q0,#2			
			VAND.U32 q0,q1,q0
			VSHr.U32 q1,q0,#4
			VAND.U32 q0,q0,q1
			VSHR.U32 q1,q0,#1
			VAND.U32 q3,q0,q1
			VCGT.U32 q3,q3,q7
			bal yesA0
            notA0:
            vdup.U32 q3,const0
            yesA0:

            vdup.u32 q8,const1// debug
			VMOV.U32 const0,d4[1]
            cmp const0,#0
            beq notA1
            
            vmovl.u16 q11,d27
            vshl.u32 q10,q11,#16
            vorr.u32 q11,q10,q11
            VSHr.U32 q1,q11,#1
            VAND.U32 q0,q1,q11
			VSHR.U32 q1,q0,#2			
			VAND.U32 q0,q1,q0
			VSHR.U32 q1,q0,#4
			VAND.U32 q0,q0,q1
			VSHR.U32 q1,q0,#1
			VAND.U32 q4,q0,q1
			VCGT.U32 q4,q4,q7
			bal yesA1
            notA1:
            vdup.U32 q4,const0
            yesA1:
            
            VMOV.U32 const0,d5[0]
            cmp const0,#0
            beq notA2
            
            vmovl.u16 q11,d30
            vshl.u32 q10,q11,#16
            vorr.u32 q11,q10,q11
            VSHr.U32 q1,q11,#1
			VAND.U32 q0,q1,q11
			VSHR.U32 q1,q0,#2			
			VAND.U32 q0,q1,q0
			VSHR.U32 q1,q0,#4
			VAND.U32 q0,q0,q1
			VSHR.U32 q1,q0,#1
			VAND.U32 q5,q0,q1
			VCGT.U32 q5,q5,q7
			bal yesA2
            notA2:
            vdup.U32 q5,const0
            yesA2:

            VMOV.U32 const0,d5[1]
            cmp const0,#0
            beq notA3
            
            vmovl.u16 q11,d31
            vshl.u32 q10,q11,#16
            vorr.u32 q11,q10,q11
            VSHr.U32 q1,q11,#1
            VAND.U32 q0,q1,q11
			VSHR.U32 q1,q0,#2			
			VAND.U32 q0,q1,q0
			VSHR.U32 q1,q0,#4
			VAND.U32 q0,q0,q1
			VSHR.U32 q1,q0,#1
			VAND.U32 q6,q0,q1
			VCGT.U32 q6,q6,q7
			bal yesA3
            notA3:
            vdup.U32 q6,const0
            yesA3:



            mov const1,#8        //combine hi and lo result
            lsr const0,const1,#1
			vmov d0,const1,const0
			vshr.u32 d1,d0,#2
			vand.U32 q8,q6,q0
			vshl.u32 q0,#4
			vand.U32 q5,q0
			vorr.u32 q8,q5
			vshl.u32 q0,#4
			vand.U32 q4,q0
			vorr.u32 q8,q4
			vshl.u32 q0,#4
			vand.U32 q3,q0
			vorr.u32 q8,q3
			vorr.u32 d16,d17
			vpadd.u32 d16,d16

			



			VMOV.U16 result,d16[0]
			mov const0,#0
			cmp result,const0
			bls end //if d0 is zero go on
			

			mov const1,#19				//prepare index
			sub const0,const1,cntx
			lsl const0,const0,#4
			add const0,const0,#3
			
			mov const2,#256
			sub const1,const2,const1
			sub const1,const1,cnty 


			lsl result,result,#16      //check all 16 result bits
			lsls result,result,#1
			bcc not0
			str const0,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not0:
			lsls result,result,#1
			bcc  not1
			add const2,const0,#1
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not1:
			lsls result,result,#1
			bcc not2
			add const2,const0,#2
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not2:
			lsls result,result,#1
			bcc not3
			add const2,const0,#3
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not3:
			lsls result,result,#1
			bcc not4
			add const2,const0,#4
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not4:
			lsls result,result,#1
			bcc not5
			add const2,const0,#5
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not5:
			lsls result,result,#1
			bcc not6
			add const2,const0,#6
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not6:
			lsls result,result,#1
			bcc not7
			add const2,const0,#7
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not7:
			lsls result,result,#1
			bcc not8
			add const2,const0,#8
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish
			
			not8:
			lsls result,result,#1
			bcc not9
			add const2,const0,#9
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish
			
			not9:
			lsls result,result,#1
			bcc not10
			add const2,const0,#10
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not10:
			lsls result,result,#1
			bcc not11
			add const2,const0,#11
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not11:
			lsls result,result,#1
			bcc not12
			add const2,const0,#12
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not12:
			lsls result,result,#1
			bcc not13
			add const2,const0,#13
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not13:
			lsls result,result,#1
			bcc not14
			add const2,const0,#14
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not14:
			lsls result,result,#1
			bcc not15
			add const2,const0,#15
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish
			
			not15:
			end:
			add img,img,#19
			subs cntx,cntx,#1

			
		bne start
		add img,img,#16
		subs cnty,cnty,#1

	bne start2
	finish:
	pop {r0-r12,pc}


	adress_output: .word output
	adress_output2: .word output2
	adress_output3: .word output3
	adress_output4: .word output4
	adress_output5: .word output5
	adress_output6: .word output6
	adress_output7: .word output7
//	bx lr
.global printf		
	

