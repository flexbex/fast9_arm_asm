.data
	.balign 4 
	out: .skip 64
	output:	
		.asciz "%08x %08x \n"
	output2:	
		.asciz "was "
	output3:	
		.asciz "here\n"
	output4:	
		.asciz "%08x %08x \n"
	output5:	
		.asciz "kps: %d %d \n"
	output6:	
		.asciz "\n"
	output7:	
		.asciz "R1 was  %d %d\n"
	img .req r0
	kps .req r1
	kps_cnt .req r6
	result .req r8
	res .req r9
	threshold .req r11
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
	push {r1-r12,lr}
	//mov const2,#200
	//add const2,const2,#110
	add img,img,#960
	add img,img,#4
	ldrh cnty,[r2]			//y line counter
	ldrh kps_const,[r2,#2] 	//max keypoints
	ldrh threshold,[r2,#4] 	//threshold value
	sub cnty,#6
	//movw cnty, #234
	mov kps_cnt,#0 //reset keypoint counter
	start2:
		
		movw cntx,#19
		start:
		
		/*
			* Read in center Values
			* and values on the circle
			* compare circle values to upper and lower boundary
			* in the end of this section we have comparison reults of 16 
			* circles
			* q12 and q14 representing comparison to lower boundary
			* q13 and q15 representing comparison to higher boundary
			* q1 and q0 are higher and lower boundary
			*/
	vld1.8 {q7}, [img] 	//#center

	VDUP.8 q2,threshold 
	VADD.I8 q1,q7,q2 	//create uper boundary
	VSUB.I8 q0,q7,q2 	//create lower boundary
	
	VCLT.U8 q8, q0, q7 	//if center was lower then threshold we set it to zero
						//when q0 was lower then threshold it would be negative now so it would be higher in u8 notation.
	VAND.U8 q0,q8,q0

	VCLT.U8 q8,q1,q7 	//if center was higher then 255-threshold we set it to 255
	VORR.U8 q1,q8,q1


	sub img,img,#960
	mov const0,#128
	VDUP.U8 q2,const0	
	vld1.U8 {q3}, [img] //0
	VCGT.U8 q4 , q3,q1
	VAND.U8 q15 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q14 , q2,q3


	add img,img,#1
	VSHR.U8 q2,#1 //64
	vld1.U8 {q3}, [img] //1
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q14,q5,q14
	VORR.U8 q15,q6,q15

	add img,img,#1920
	VSHR.U8 q2,#6 //1
	vld1.U8 {q3}, [img] //7
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q14,q5,q14
	VORR.U8 q15,q6,q15

	sub img,img,#1
	VSHL.U8 q2,#7 //128
	vld1.U8 {q3}, [img] //8
	VCGT.U8 q4 , q3,q1
	VAND.U8 q13 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q12 , q2,q3


	sub img,img,#1
	VSHR.U8 q2,#1 //64
	vld1.U8 {q3}, [img] //9
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q12,q5
	VORR.U8 q13,q6

	sub img,img,#1920
	VSHR.U8 q2,#6 //1
	vld1.U8 	{q3}, [img] //15
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q12,q5
	VORR.U8 q13,q6

	

	add img,img,#320
	sub img,img,#1
	VSHL.U8 q2,#1 //2
	vld1.U8 {q3}, [img] //14
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q12,q5
	VORR.U8 q13,q6
	

	add img,img,#4
	VSHL.U8 q2,#4 //32
	vld1.U8 {q3}, [img] //2
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q14,q5
	VORR.U8 q15,q6

	add img,img,#1280
	VSHR.U8 q2,#4 //#2
	vld1.U8 {q3}, [img] //6
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q14,q5
	VORR.U8 q15,q6


	sub img,img,#4
	VSHL.U8 q2,#4 //32
	vld1.U8 {q3}, [img] //10
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q12,q5
	VORR.U8 q13,q6
	

	sub img,img,#960
	sub img,img,#1
	VSHR.U8 q2,#3 //4
	vld1.U8 {q3}, [img] //13
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q12,q5,q12
	VORR.U8 q13,q6,q13
	

	add img,img,#6
	VSHL.U8 q2,#2 //16
	vld1.U8 {q3}, [img] //3
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q14,q5,q14
	VORR.U8 q15,q6,q15

	add img,img,#320
	VSHR.U8 q2,#1 //8
	vld1.U8 {q3}, [img] //4
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q14,q5,q14
	VORR.U8 q15,q6,q15

	add img,img,#320
	VSHR.U8 q2,#1 //4
	vld1.U8 {q3}, [img] //5
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q14,q5,q14
	VORR.U8 q15,q6,q15

	sub img,img,#6
	VSHL.U8 q2,#2 //16
	vld1.U8 {q3}, [img] //11
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q12,q5,q12
	VORR.U8 q13,q6,q13
	


	sub img,img,#320
	VSHR.U8 q2,#1 //8
	vld1.U8 {q3}, [img] //12
	VCGT.U8 q4 , q3,q1
	VAND.U8 q6 , q2,q4
	VCLT.U8 q3 , q3,q0
	VAND.U8 q5 , q2,q3
	VORR.U8 q12,q5,q12
	VORR.U8 q13,q6,q13
	

	/*
	* In this section we combine lower and upper results
	* only circles with 9 bits higher or lower then boundary
	* survive. values from 16 circles comparison are combined
	* in q13 and q15
	*/

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


	


    /*
    * Now we have to check if at least 9 pixels are ordered in row on a circle
    * First we do a pre check. If at least one of the following 4 circles has 9 bits set
    * If not we skip check for four circles. Results are stored for always 4 Circles in one of the 
    * Quad word vectors q3-q6
    */

     mov const1,#0
            VDUP.U8 q7,const1
            VMOV.U32 const0,d4[0]
            cmp const0,#0
            beq notA0
            
            vmovl.u16 q11,d26
            vshl.u32 q10,q11,#16
            vorr.u32 q11,q10,q11
            VSHr.U32 q1,q11,#1
            VAND.U32 q0,q1,q11
			VSHR.U32 q1,q0,#2			
			VAND.U32 q0,q1,q0
			VSHR.U32 q1,q0,#4
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


            /*
            * comparison results are packed further 
            * in a 16bit format. A set bit represents 
            * a circle with at least 9 pixels that are in 
            * a row smaller or higher then the boundary
            * the result is written in the register result.
            * if results is zero it means there is no circle 
            * which fullfils the Fast 9 constraint and we can skip read out and go straight to the next 16 pixels
            */
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

			/*
			* Result register is read out. always one bit is shifted out to the left with lsls
			* if bit is set we save it as a keypoint
			*/

			mov const1,#19				//prepare index
			sub const0,const1,cntx
			lsl const0,const0,#4
			add const0,const0,#4
			
			mov const2,#256
			sub const1,const2,const1
			sub const1,const1,cnty 


			lsl result,result,#16      //align result bits on the left of the 32bit register
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

/* 
* Last 8 Bit of x row analyze
* Last 8 Bit of x row analyze
*/
/*
			* Read in center Values
			* and values on the circle
			* compare circle values to upper and lower boundary
			* in the end of this section we have comparison reults of 16 
			* circles
			* q12 and q14 representing comparison to lower boundary
			* q13 and q15 representing comparison to higher boundary
			* q1 and q0 are higher and lower boundary
			*/

	vld1.8 {d7}, [img] 	//#center

	VDUP.8 d2,threshold 
	VADD.I8 d1,d7,d2 	//create uper boundary
	VSUB.I8 d0,d7,d2 	//create lower boundary
	
	VCLT.U8 d8, d0, d7 	//if center was lower then threshold we set it to zero
						//when q0 was lower then threshold it would be negative now so it would be higher in u8 notation.
	VAND.U8 d0,d8,d0

	VCLT.U8 d8,d1,d7 	//if center was higher then 255-threshold we set it to 255
	VORR.U8 d1,d8,d1


	sub img,img,#960
	mov const0,#128
	VDUP.U8 d2,const0	
	vld1.U8 {d3}, [img] //0
	VCGT.U8 d4 , d3,d1
	VAND.U8 d15 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d14 , d2,d3


	add img,img,#1
	VSHR.U8 d2,#1 //64
	vld1.U8 {d3}, [img] //1
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d14,d5,d14
	VORR.U8 d15,d6,d15

	add img,img,#1920
	VSHR.U8 d2,#6 //1
	vld1.U8 {d3}, [img] //7
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d14,d5,d14
	VORR.U8 d15,d6,d15

	sub img,img,#1
	VSHL.U8 d2,#7 //128
	vld1.U8 {d3}, [img] //8
	VCGT.U8 d4 , d3,d1
	VAND.U8 d13 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d12 , d2,d3


	sub img,img,#1
	VSHR.U8 d2,#1 //64
	vld1.U8 {d3}, [img] //9
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d12,d5
	VORR.U8 d13,d6

	sub img,img,#1920
	VSHR.U8 d2,#6 //1
	vld1.U8 	{d3}, [img] //15
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d12,d5
	VORR.U8 d13,d6

	

	add img,img,#320
	sub img,img,#1
	VSHL.U8 d2,#1 //2
	vld1.U8 {d3}, [img] //14
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d12,d5
	VORR.U8 d13,d6
	

	add img,img,#4
	VSHL.U8 d2,#4 //32
	vld1.U8 {d3}, [img] //2
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d14,d5
	VORR.U8 d15,d6

	add img,img,#1280
	VSHR.U8 d2,#4 //#2
	vld1.U8 {d3}, [img] //6
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d14,d5
	VORR.U8 d15,d6


	sub img,img,#4
	VSHL.U8 d2,#4 //32
	vld1.U8 {d3}, [img] //10
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d12,d5
	VORR.U8 d13,d6
	

	sub img,img,#960
	sub img,img,#1
	VSHR.U8 d2,#3 //4
	vld1.U8 {d3}, [img] //13
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d12,d5,d12
	VORR.U8 d13,d6,d13
	

	add img,img,#6
	VSHL.U8 d2,#2 //16
	vld1.U8 {d3}, [img] //3
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d14,d5,d14
	VORR.U8 d15,d6,d15

	add img,img,#320
	VSHR.U8 d2,#1 //8
	vld1.U8 {d3}, [img] //4
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d14,d5,d14
	VORR.U8 d15,d6,d15

	add img,img,#320
	VSHR.U8 d2,#1 //4
	vld1.U8 {d3}, [img] //5
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d14,d5,d14
	VORR.U8 d15,d6,d15

	sub img,img,#6
	VSHL.U8 d2,#2 //16
	vld1.U8 {d3}, [img] //11
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d12,d5,d12
	VORR.U8 d13,d6,d13
	


	sub img,img,#320
	VSHR.U8 d2,#1 //8
	vld1.U8 {d3}, [img] //12
	VCGT.U8 d4 , d3,d1
	VAND.U8 d6 , d2,d4
	VCLT.U8 d3 , d3,d0
	VAND.U8 d5 , d2,d3
	VORR.U8 d12,d5,d12
	VORR.U8 d13,d6,d13
	

	/*
	* In this section we combine lower and upper results
	* only circles with 9 bits higher or lower then boundary
	* survive. values from 16 circles comparison are combined
	* in qd13 and d15
	*/


	vcnt.u8 d0,d12				//check lower constraint
	vcnt.u8 d3,d14
	VADD.u8 d2,d0,d3

	

	vcnt.u8 d0,d13				//check higher constraint
	vcnt.u8 d3,d15
	VADD.u8 d3,d0,d3
	




	mov const0,#8				//build constraint mask
	vdup.u8 d1,const0        
	vcgt.u8 d2,d2,d1
	vcgt.u8 d3,d3,d1


	vand.u8 d12,d12,d2
	vand.u8 d14,d14,d2

	vand.u8 d13,d13,d3
	vand.u8 d15,d15,d3

	vorr.u8 d15,d14,d15        
	vorr.u8 d13,d12,d13





    vorr.u8 d12,d2,d3
    vzip.u8 d13,d15





    /*
    * Now we have to check if at least 9 pixels are ordered in row on a circle
    * First we do a pre check. If at least one of the following 4 circles has 9 bits set
    * If not we skip check for four circles. Results are stored for always 4 Circles in one of the 
    * Quad word vectors d3-d6
    */

     		mov const1,#0
            VDUP.U8 q8,const1
            VMOV.U32 const0,d12[0]
            cmp const0,#0
            beq notA0B8
            
            vmovl.u16 q11,d13
            vshl.u32 q10,q11,#16
            vorr.u32 q11,q10,q11
            VSHr.U32 q1,q11,#1
            VAND.U32 q0,q1,q11
			VSHR.U32 q1,q0,#2			
			VAND.U32 q0,q1,q0
			VSHR.U32 q1,q0,#4
			VAND.U32 q0,q0,q1
			VSHR.U32 q1,q0,#1
			VAND.U32 q3,q0,q1
			VCGT.U32 q3,q3,q8


			bal yesA0B8
            notA0B8:
            vdup.U32 q3,const0
            yesA0B8:

            add const1,#4
            vdup.u32 q9,const1// debug
			VMOV.U32 const0,d12[1]
            cmp const0,#0
            beq notA1B8
            
            vmovl.u16 q11,d15
            vmov.u32 q9,q11
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
			
			VCGT.U32 q4,q4,q8
			bal yesA1B8
            notA1B8:
            vdup.U32 q4,const0
            yesA1B8:
            

            /*
            * comparison results are packed further 
            * in a 16bit format. A set bit represents 
            * a circle with at least 9 pixels that are in 
            * a row smaller or higher then the boundary
            * the result is written in the register result.
            * if results is zero it means there is no circle 
            * which fullfils the Fast 9 constraint and we can skip read out and go straight to the next 16 pixels
            */
            mov const1,#8        //combine hi and lo result
            lsr const0,const1,#1
			vmov d0,const1,const0
			vshr.u32 d1,d0,#2   
			vand.U32 q8,q4,q0   //q0:8 4 2 1
			vshl.u32 q0,#4
			vand.U32 q3,q0
			vorr.u32 q8,q3
			vshl.u32 q8,#8
			vorr.u32 d16,d17
			vpadd.u32 d16,d16

			VMOV.U16 result,d16[0]
			




			mov const0,#0
			cmp result,const0
			bls endB8 //if d0 is zero go on

			/*
			* Result register is read out. always one bit is shifted out to the left with lsls
			* if bit is set we save it as a keypoint
			*/

			mov const0,#20				//prepare index
			lsl const0,const0,#4
			sub const0,const0,#12
			
			mov const2,#234
			sub const1,const2,cnty
			add const1,#3

			





			lsl result,result,#16      //align result bits on the left of the 32bit register
			lsls result,result,#1
			bcc not0B8
			str const0,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not0B8:
			lsls result,result,#1
			bcc  not1B8
			add const2,const0,#1
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not1B8:
			lsls result,result,#1
			bcc not2B8
			add const2,const0,#2
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not2B8:
			lsls result,result,#1
			bcc not3B8

			add const2,const0,#3
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not3B8:
			lsls result,result,#1
			bcc not4B8
			add const2,const0,#4
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not4B8:
			lsls result,result,#1
			bcc not5B8
			add const2,const0,#5
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not5B8:
			lsls result,result,#1
			bcc not6B8
			add const2,const0,#6
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not6B8:
			lsls result,result,#1
			bcc not7B8
			add const2,const0,#7
			str const2,[kps]
			add kps,#2
			str const1,[kps]
			add kps,#2
			add kps_cnt,#1
			cmp kps_cnt,kps_const
			beq finish

			not7B8:
			endB8:
			add img,img,#19
			subs cnty,cnty,#1

	bne start2
	finish:
	ldr r0,adress_out
	str kps_cnt,[r0]
	pop {r1-r12,pc}

/*ldr kps_cnt,adress_out
	mov const0,result
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d31[0]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d30[1]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d30[0]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d27[1]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d27[0]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d26[1]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d26[0]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d26[0]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d26[1]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d27[0]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d27[1]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d30[0]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d30[1]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d31[0]
	str const0,[kps_cnt],#4
	VMOV.U32 const0,d31[1]
	str const0,[kps_cnt],#4
	ldr kps_cnt,adress_out*/
	//

            

	adress_output: .word output
	adress_output2: .word output2
	adress_output3: .word output3
	adress_output4: .word output4
	adress_output5: .word output5
	adress_output6: .word output6
	adress_output7: .word output7
	adress_out: .word out
//	bx lr
.global printf		
	

