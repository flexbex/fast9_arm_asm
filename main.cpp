#include <chrono>
#include <ctime>
#include <arm_neon.h>
#include <iostream>
#include <stdio.h>
#include <stdint.h>

using namespace std;
extern "C" int fast9_asm(uint8_t *img,uint32_t *kps,uint16_t *paras);
#define HT 240
#define WT 320
#define KPS_CNT 5600
#define THRESHOLD 8
typedef std::chrono::high_resolution_clock clock2;
typedef std::chrono::microseconds res;
struct MY_Keypoint{
	uint16_t x;
	uint16_t y;
};
int main() {
	clock2::time_point t1, t2;
	uint8_t img[HT*WT];
	for(int i=0;i<HT*WT;i++){
		img[i]=rand()%60;
	}
	MY_Keypoint kps[KPS_CNT];
	uint32_t *kpP=(uint32_t *)&kps;
	uint16_t paras[3]={240,KPS_CNT,THRESHOLD};
	t1 = clock2::now();
	uint32_t* kps_cnt2=fast9_asm(img,kpP,paras);
	t2 = clock2::now();
	for(int i=0;i<*kps_cnt2;i++){
		cout<<"kps: "<<kps[i].x<<" "<<kps[i].y<<endl;
	}
	std::cout << "Elapsed time is \n" << std::chrono::duration_cast<res>((t2-t1)).count()<< " microseconds.\n";
	return 0;
}