/*  RflySim Simulink UDP Interface  **********************************************************************/
/*  Xunhua Dai, 2020/05/03, Beihang University ********************/
#define _linux_
#define S_FUNCTION_NAME RflyUdpFast
#define S_FUNCTION_LEVEL 2

#include <sys/ioctl.h>
#define nonblockingsocket(s) {unsigned long ctl = 1;ioctl( s, FIONBIO, &ctl );}

#define MAXLEN 65536

#include "simstruc.h"
#include <math.h>
#include <stdio.h>
#include <string.h>


/*
#ifdef _win_
///// win
#include <winsock2.h>
#pragma comment(lib,"ws2_32.lib")
#define _WINSOCK_DEPRECATED_NO_WARNINGS 1
///////

#else
 */
#include <sys/ioctl.h>
#include <sys/types.h>   
#include <sys/socket.h>  
#include <arpa/inet.h>
#include <netinet/in.h> 
#include <stdlib.h>
#include <unistd.h>
typedef int SOCKET;
typedef unsigned char BYTE;
typedef unsigned long DWORD;
#define FALSE 0
#define SOCKET_ERROR (-1)
/////////////////
//#endif

#define PAYLOAD_LEN_SHORT_SHORT 112

/*
typedef signed char        int8_t;
typedef short              int16_t;
typedef int                int32_t;
typedef long long          int64_t;
typedef unsigned char      uint8_t;
typedef unsigned short     uint16_t;
typedef unsigned int       uint32_t;
typedef unsigned long long uint64_t;
*/

struct outHILStateData{
    uint32_t time_boot_ms; //Timestamp of the message
    uint32_t copterID;     //Copter ID, start from 1
    int32_t GpsPos[3];     //Estimated GPS position£¬lat&long: deg*1e7, alt: m*1e3 and up is positive
    int32_t GpsVel[3];     //Estimated GPS velocity, NED, m/s*1e2->cm/s
    int32_t gpsHome[3];     //Home GPS position, lat&long: deg*1e7, alt: m*1e3 and up is positive
    int32_t relative_alt;  //alt: m*1e3 and up is positive
    int32_t hdg;           //Course angle, NED,deg*1000, 0~360
    int32_t satellites_visible; //GPS Raw data, sum of satellite
    int32_t fix_type;     //GPS Raw data, Fixed type, 3 for fixed (good precision)
    int32_t resrveInit;       //Int, reserve for the future use
    float AngEular[3];    //Estimated Euler angle, unit: rad
    float localPos[3];    //Estimated locoal position, NED, unit: m
    float localVel[3];    //Estimated locoal velocity, NED, unit: m/s
    float pos_horiz_accuracy;   //GPS horizontal accuracy, unit: m
    float pos_vert_accuracy; //GPS vertical accuracy, unit: m
    float resrveFloat;      //float,reserve for the future use
    outHILStateData() {
        reset();
    }
    void reset(){
        time_boot_ms = 0;
        for(int i=0;i<3;i++){
            GpsPos[i]=0;
        }
        for(int i=0;i<3;i++){
            GpsVel[i]=0;
        }
        relative_alt=0;
        hdg=0;
        for(int i=0;i<3;i++){
            AngEular[i]=0;
        }
        for(int i=0;i<3;i++){
            localPos[i]=0;
        }
        for(int i=0;i<3;i++){
            localVel[i]=0;
        }
        for(int i=0;i<3;i++){
            gpsHome[i]=0;
        }
        pos_horiz_accuracy=0;
        pos_vert_accuracy=0;
        satellites_visible=0;
        fix_type=0;
    }
};


typedef struct _netDataShortShort {
    int tg;
    int        len;
    char       payload[PAYLOAD_LEN_SHORT_SHORT];
    _netDataShortShort() {
        memset(payload, 0, sizeof(payload));
    }
}netDataShortShort;

struct outHILStateShort{
    int checksum;
    int32_t gpsHome[3];     //Home GPS position, lat&long: deg*1e7, alt: m*1e3 and up is positive
    float AngEular[3];    //Estimated Euler angle, unit: rad
    float localPos[3];    //Estimated locoal position, NED, unit: m
    float localVel[3];    //Estimated locoal velocity, NED, unit: m/s
    outHILStateShort() {
        reset();
    }
    void reset(){
        checksum = 0;
        for(int i=0;i<3;i++){
            gpsHome[i]=0;
            AngEular[i]=0;
            localPos[i]=0;
            localVel[i]=0;
        }
    }
};


struct inHILCMDData{
    uint32_t time_boot_ms;
    uint32_t copterID;
    uint32_t modes;
    uint32_t flags;
    float ctrls[16];
    inHILCMDData() {
        reset();
    }
    void reset(){
        time_boot_ms = 0;
        copterID=0;
        flags = 0;
        modes=0;
        for(int i=0;i<16;i++){
            ctrls[i]=0;
        }
    }
};


struct inOffboardShortData{
    int checksum;
    int ctrlMode;
    float controls[4];
    inOffboardShortData() {
        reset();
    }
    void reset(){
        checksum = 0;
        ctrlMode=0;
        for(int i=0;i<4;i++){
            controls[i]=0;
        }
    }
};


typedef enum {csError, csReceive} EConnState;

typedef struct SInfoTag
{
	SOCKET servsock;
	EConnState connState;
	struct sockaddr_in sendadd;
} SInfo;


/* Create Structure Info **********************************************************************/
void CreateStructure(SimStruct *S, int indx)
{
	SInfo *info;
	void **PWork = ssGetPWork(S);

	info = (SInfo *)malloc(sizeof(SInfo));
	PWork[indx] = (void *)info;
	
}

/* Get Structure Info *************************************************************************/
SInfo *GetStructure(SimStruct *S, int indx)
{
	void **PWork = ssGetPWork(S);
	return (SInfo *)PWork[indx];
}


void ClearUp(SimStruct *S){
	void **P = ssGetPWork(S);
	/* deallocate buffer */
	free(P[0]);

	//free all udp sockets.
	double *numVehicle=(double *)mxGetPr(ssGetSFcnParam(S,1));
	int iNumVehicle = (int)floor((*numVehicle)+0.5);
	SInfo *info;
	for(int i=1;i<=iNumVehicle;i++){
		info = GetStructure(S,i);
		close(info->servsock);
		free(info);			
	}
 //   WSACleanup();
}

/* mdlCheckParameters, check parameters, this routine is called later from mdlInitializeSizes */
#define MDL_CHECK_PARAMETERS
static void mdlCheckParameters(SimStruct *S)
{
    /* Basic check : All parameters must be real positive vectors                             */
    double *dPort, *dUdpMode, *numVehicle; 
	int iPort, iUdpMode, iNumVehicle;

    /* get the port number */
    dPort=(double *)mxGetPr(ssGetSFcnParam(S,0));
	iPort = (int)floor((*dPort)+0.5);
    if ( (iPort < 1025) || (iPort > 65535) )
    { ssSetErrorStatus(S,"The UDP port # must be from 1025 to 65535"); return; }

    /* get the number of pending connections in queue */
    numVehicle=(double *)mxGetPr(ssGetSFcnParam(S,1));
	iNumVehicle = (int)floor((*numVehicle)+0.5);
    if ( (iNumVehicle < 1) || (iNumVehicle > 1024) )
    { ssSetErrorStatus(S,"The total vehicle number # must be from 1 to 1024"); return; }

	/* size of output vector */
    dUdpMode = (double *)mxGetPr(ssGetSFcnParam(S,2));
	iUdpMode = (int)floor((*dUdpMode)+0.5);
    if ((iUdpMode < 0))
    { 
		ssSetErrorStatus(S, "The UDP simulation mode cannot be negative."); 
		return; 
	}

	char hostname[256];
	mxGetString(ssGetSFcnParam(S,4), hostname, 200);
	if(strcmp(hostname,"255.255.255.255")!=0){
		if(inet_addr(hostname)==INADDR_NONE){
			printf("Can not process address %s",hostname);
			ssSetErrorStatus(S, "The format of the IP address is wrong."); 
			return; 			
		}
	}
    
    printf("** Simulation start and UDP initializing **\n");
    printf("* Target UDP IP address is %s\n",hostname);
    printf("* Start UDP port is %d \n",iPort);
    printf("* Total vehicle number is %d \n",iNumVehicle);
    printf("* UDP data transfer mode is %d \n\n",iUdpMode);

}

/* mdlInitializeSizes - initialize the sizes array ********************************************/
static void mdlInitializeSizes(SimStruct *S)
{
	//int iBufSize;
    
	ssSetNumSFcnParams(S,5);                          /* number of expected parameters        */

    /* Check the number of parameters and then calls mdlCheckParameters to see if they are ok */
    if (ssGetNumSFcnParams(S) == ssGetSFcnParamsCount(S))
    { mdlCheckParameters(S); if (ssGetErrorStatus(S) != NULL) return; } else return;

	//iBufSize = (int)floor((*mxGetPr(ssGetSFcnParam(S,2)))+0.5);

    ssSetNumContStates(S,0);                          /* number of continuous states          */
    ssSetNumDiscStates(S,0);                          /* number of discrete states            */

	double *numVehicle=(double *)mxGetPr(ssGetSFcnParam(S,1));
	int iNumVehicle = (int)floor((*numVehicle)+0.5);

    double *dUdpMode = (double *)mxGetPr(ssGetSFcnParam(S,2));
	int iUdpMode = (int)floor((*dUdpMode)+0.5);


    if (!ssSetNumInputPorts(S,iNumVehicle)) return;             /* number of input ports                */

    if (!ssSetNumOutputPorts(S,iNumVehicle)) return;            /* number of output ports               */

	int outLen = 28;
	int inLen = 15;
	if(iUdpMode==1||iUdpMode==2){
		outLen = 12;
		inLen=5;
	}
	for(int i=0;i<iNumVehicle;i++){
		ssSetOutputPortWidth(S,i, outLen);              /* first output port width              */
		ssSetOutputPortDataType(S,0,SS_DOUBLE);            /* first output port data type          */
		ssSetInputPortWidth(S,i, inLen);              /* first intput port width              */
		//ssSetInputPortDirectFeedThrough(S,i,1);
		ssSetInputPortDataType(S,0,SS_DOUBLE);            /* first intput port data type          */
	}

    ssSetNumSampleTimes(S,0);                         /* number of sample times               */

    ssSetNumRWork(S,0);                               /* number real work vector elements     */
    ssSetNumIWork(S,0);                               /* number int_T work vector elements    */
    ssSetNumPWork(S,1+iNumVehicle);                               /* number ptr work vector elements      */
    ssSetNumModes(S,0);                               /* number mode work vector elements     */
    ssSetNumNonsampledZCs(S,0);                       /* number of nonsampled zero crossing   */

}

/* mdlInitializeSampleTimes - initialize the sample times array *******************************/
static void mdlInitializeSampleTimes(SimStruct *S)
{
	double *dSampleTime=(double *)mxGetPr(ssGetSFcnParam(S,3));
    
	/* Set things up to run with inherited sample time                                        */
    ssSetSampleTime(S, 0, dSampleTime[0]);
    ssSetOffsetTime(S, 0, 0);
}

/*************************************************************************/
SOCKET netServerInit(SimStruct *S, unsigned short port, SInfo *info)
{
    SOCKET serv_sock;
	struct sockaddr_in serv_sin;    /* my address information */

	serv_sock = socket(AF_INET, SOCK_DGRAM, 0);
	if (serv_sock == INVALID_SOCKET) {
		printf("Cannot create socket.\n");
		//ClearUp(S);
		//ssSetErrorStatus(S, "Cannot create socket.");
		goto err;
	}

	bool bOpt = true;
	//set UDP to Broadcast  mode	
	setsockopt(serv_sock, SOL_SOCKET, SO_BROADCAST, (char*)&bOpt, sizeof(bOpt));
	bOpt = true;
	setsockopt(serv_sock, SOL_SOCKET, SO_REUSEADDR, (char*)&bOpt, sizeof(bOpt));
	/* Set up information for bind */
	/* Clear the structure so that we don't have garbage around */
	memset((void *)&serv_sin, 0, sizeof(serv_sin));

	/* AF means Address Family - same as Protocol Family for now */
	serv_sin.sin_family = AF_INET;

	/* Fill in port number in address (careful of byte-ordering) */
	serv_sin.sin_port = htons(port);

	/* Fill in IP address for interface to bind to (INADDR_ANY) */
	serv_sin.sin_addr.s_addr = htonl(INADDR_ANY);

	/* Bind to port and interface */
	if (bind(serv_sock, (struct sockaddr *)&serv_sin,
			 sizeof(serv_sin)) == SOCKET_ERROR)
    {
        printf("Cannot bind.\n");
		//ClearUp(S);
		//ssSetErrorStatus(S, "Cannot bind.");
        goto err;
	}
	info->connState = csReceive;


	// memset((void *)&(info->sendadd), 0, sizeof(info->sendadd));
	// info->sendadd.sin_family = AF_INET;
	// info->sendadd.sin_port = htons(port-1);
	char hostname[256];
	mxGetString(ssGetSFcnParam(S,4), hostname, 200);

	//info->sendadd.sin_addr.s_addr = htonl(INADDR_BROADCAST);
	//info->sendadd.sin_addr.s_addr = INADDR_BROADCAST;
	//printf(hostname);
	
   	memset((void *)&(info->sendadd), 0, sizeof(info->sendadd));
    info->sendadd.sin_family = AF_INET;
    info->sendadd.sin_port = htons(port-1);
    //char bStr[256]="255.255.255.255";
	if(strcmp(hostname,"255.255.255.255")==0){
		info->sendadd.sin_addr.s_addr = htonl(INADDR_BROADCAST);
		//printf("Use broadcast mode\n");
	}else{
    if((info->sendadd.sin_addr.s_addr = inet_addr(hostname))==INADDR_NONE){
		//inet_pton(AF_INET, "127.0.0.1", &info->sendadd.sin_addr);
        info->sendadd.sin_addr.s_addr = inet_addr("127.0.0.1");
		printf("Can not process address %s, use 127.0.0.1 instead.\n",hostname);
	}else{
		//printf("Use the input address %s\n",hostname);
	}
	}

    return serv_sock;

err:
	//ssSetErrorStatus(S, "Error In Init Socket.");
	info->connState = csError;
    return (SOCKET)SOCKET_ERROR;
}

/* start the server - called inside mdlStart **************************************************/

void StartUDPServer(SimStruct *S, SInfo *info, int index)
{
    double *dPort; 
	int iPort;

    /* get the port number */
    dPort=(double *)mxGetPr(ssGetSFcnParam(S,0));
	iPort = (int)floor((*dPort)+0.5) +1 + (index-1)*2;

    /* get the number of pending connections in queue */
    // numVehicle=mxGetPr(ssGetSFcnParam(S,1));
	// iNumVehicle = (int)floor((*numVehicle)+0.5);

	info->servsock = netServerInit(S,(unsigned short)iPort, info);
	if(info->connState == csReceive)
		nonblockingsocket(info->servsock);
}




/* mdlStart - initialize work vectors *********************************************************/
#define MDL_START
static void mdlStart(SimStruct *S)
{
	WSADATA wsa_data;
	int status;
	SInfo *info;

	/* get buffer size */ 
	//int iBufSize = (int)floor((*mxGetPr(ssGetSFcnParam(S,2)))+0.5);
	int iBufSize =240;
	/* retrieve pointer to pointers work vector */
	void **PWork = ssGetPWork(S);

	/* allocate buffer */
	char *buffer;
    buffer = (char *)malloc(iBufSize*sizeof(char));

	/* check if memory allocation was ok */
	if (buffer==NULL) 
		{ ssSetErrorStatus(S,"Error in mdlStart : could not allocate memory"); return; }

    /* store pointers in PWork so they can be accessed later */
	PWork[0] = (void*) buffer;

	/* Activate the Winsock DLL */
	if ((status = WSAStartup(MAKEWORD(2,2),&wsa_data)) != 0) {
		printf("%d is the WSA startup error\n",status);
		exit(1);
	}

	double *numVehicle=(double *)mxGetPr(ssGetSFcnParam(S,1));
	int iNumVehicle = (int)floor((*numVehicle)+0.5);


	for(int i=1;i<=iNumVehicle;i++){
		CreateStructure(S,i);
		info = GetStructure(S,i);
		info->connState = csError;
		StartUDPServer(S, info,i);		
	}
}

/* mdlOutputs - compute the outputs ***********************************************************/
static void mdlOutputs(SimStruct *S, int_T tid)
{
	//int iBufSize = (int)floor((*mxGetPr(ssGetSFcnParam(S,2)))+0.5);
	//UNUSED(tid);
	UNUSED_ARG(tid);
	int iBufSize =240;
	double *numVehicle=(double *)mxGetPr(ssGetSFcnParam(S,1));
	int iNumVehicle = (int)floor((*numVehicle)+0.5);

    double *dUdpMode = (double *)mxGetPr(ssGetSFcnParam(S,2));
	int iUdpMode = (int)floor((*dUdpMode)+0.5);

	/* retrieve pointer to pointers work vector */
	void **PWork = ssGetPWork(S);

	/* assign buffer pointer */
	char *buffer;
    buffer = (char *)PWork[0];
	//int sock_error;
	outHILStateShort st;
	st.reset();	
	struct sockaddr_in req_sin;
	
	int req_len, recvlen, maxrecvlen=iBufSize;
	SInfo *info;
	outHILStateData stl;
	netDataShortShort nnd;	

    double *dPort; 
	int iPort;
    dPort=(double *)mxGetPr(ssGetSFcnParam(S,0));
	iPort = (int)floor((*dPort)+0.5);

	//send_sin.sin_addr.s_addr=

	for(int idex=0;idex<iNumVehicle;idex++){
		int soIdx = idex+1;
		/* output ports */
		void *y1=ssGetOutputPortSignal(S,idex);
		double *data=(double*) y1;
		//void* In1=ssGetInputPortSignal(S,idex);
		//double *Ins=(double*) In1;

		info = GetStructure(S,soIdx);
		req_len = sizeof(struct sockaddr_in);

		switch(info->connState)
		{
		case csReceive:
			//netDataShortShort nnd;	
			while(1){
				recvlen=recvfrom(info->servsock, buffer, maxrecvlen, 0, (struct sockaddr *)&req_sin, &req_len);
				if(recvlen<=0){
					break;
				}				
				if((iUdpMode==0)&&recvlen==sizeof(netDataShortShort)){
					memcpy(&nnd,buffer,recvlen);
					if(nnd.len==sizeof(outHILStateData)){
						memcpy(&stl,nnd.payload,nnd.len);

						for(int i=0;i<3;i++){
							data[0+i]=(double)stl.gpsHome[i];
							data[3+i]=(double)stl.AngEular[i];
							data[6+i]=(double)stl.localPos[i];
							data[9+i]=(double)stl.localVel[i];
							data[12+i]=(double)stl.GpsPos[i];
							data[15+i]=(double)stl.GpsVel[i];
						}
						data[18] = (double)stl.time_boot_ms;
						data[19] = (double)stl.copterID;
						data[20] = (double)stl.relative_alt;
						data[21] = (double)stl.hdg;
						data[22] = (double)stl.satellites_visible;
						data[23] = (double)stl.fix_type;
						data[24] = (double)stl.resrveInit;
						data[25] = (double)stl.pos_horiz_accuracy;
						data[26] = (double)stl.pos_vert_accuracy;
						data[27] = (double)stl.resrveFloat;
					}
				}
				if((iUdpMode==1||iUdpMode==2)&&recvlen==sizeof(outHILStateShort))
				{
					memcpy(&st,buffer,recvlen);
					if(st.checksum==1234567890){
						if(iUdpMode==1){
							for(int i=0;i<3;i++){
								data[i]=(double)st.gpsHome[i];
								data[i+3]=(double)st.AngEular[i];
								data[i+6]=(double)st.localPos[i];
								data[i+9]=(double)st.localVel[i];
							}
						}
						if(iUdpMode==2){
							double GpsHomePos[3];
							for(int i=0;i<3;i++){
								 GpsHomePos[i] = (double)st.gpsHome[i];
                                 GpsPos[i] = (double)st.gpsHome[i];
								 data[3+i]=(double)st.GpsPos[i];
								 data[6+i]=(double)st.localVel[i];
								 data[9+i]=(double)st.AngEular[i];
							}
							double PIR = 3.1415926536;
							if(fabs(GpsHomePos[0])<1&&fabs(GpsHomePos[1])<1){
								data[0]=0;
								data[1]=0;
								data[2]=0;
							}else{
								//data[0]=(GpsHomePos[0]*1e-7-40.1540302)/180*PIR*6362000+(double)st.localPos[0];
								//data[1]=(GpsHomePos[1]*1e-7-116.2593683)/180*PIR*4.8823e6+(double)st.localPos[1];
								//data[2]=-GpsHomePos[2]*1e-3+(double)st.localPos[2];
                                data[0]=(GpsPos[0]*1e-7-40.1540302)/180*PIR*6362000;
								data[1]=(GpsPos[1]*1e-7-116.2593683)/180*PIR*4.8823e6;
								data[2]=-GpsPos[2]*1e-3;
							}

						}
					}
				}
			}
			break;
		}
	}
}


#define MDL_UPDATE
/* Function: mdlUpdate ======================================================
 * Abstract:
 *      xdot = Ax + Bu
 */
static void mdlUpdate(SimStruct *S, int_T tid)
{
	UNUSED_ARG(tid);
	double *numVehicle=(double *)mxGetPr(ssGetSFcnParam(S,1));
	int iNumVehicle = (int)floor((*numVehicle)+0.5);

    double *dUdpMode = (double *)mxGetPr(ssGetSFcnParam(S,2));
	int iUdpMode = (int)floor((*dUdpMode)+0.5);

	SInfo *info;
	netDataShortShort nnd;	

    double *dPort; 
	int iPort;
    dPort=(double *)mxGetPr(ssGetSFcnParam(S,0));
	iPort = (int)floor((*dPort)+0.5);
	inHILCMDData inData;

	//send_sin.sin_addr.s_addr=

	for(int idex=0;idex<iNumVehicle;idex++){
		int soIdx = idex+1;
		/* output ports */

		double **u = (double**) ssGetInputPortSignalPtrs(S,idex);
		//void* In1=ssGetInputPortSignal(S,idex);
		//double *Ins=(double*) In1;

		info = GetStructure(S,soIdx);

		//int nPort = iPort+idex*2;
		int retval=0;

		switch(info->connState)
		{
		case csReceive:
			//recvlen = 0;
			if(iUdpMode==0){
				inData.reset();
				//inData.time_boot_ms = 123;
				inData.time_boot_ms = (uint32_t)*u[0];
				inData.copterID=(uint32_t)*u[1];
				inData.modes=(uint32_t)*u[2];
				inData.flags=(uint32_t)*u[3];
				for(int i=0;i<11;i++){
					inData.ctrls[i]=(float)*u[4+i];
				}
				//netDataShortShort nnd1;
				nnd.tg = 3;
				nnd.len = sizeof(inData);
				memcpy(nnd.payload,&inData,nnd.len);
				//memcpy(buffer,&nnd,sizeof(netDataShortShort));
				// //recvlen = sizeof(nnd);
				retval = sendto(info->servsock, (const char *)&nnd, sizeof(netDataShortShort), 0, (SOCKADDR*)&(info->sendadd), sizeof(SOCKADDR));
				//memcpy(buffer,&nnd,recvlen);
			}

			if(iUdpMode==1||iUdpMode==2){
				inOffboardShortData isd;
				isd.checksum = 1234567890;
				isd.ctrlMode = (int)*u[0];
				for(int i=0;i<4;i++){
					isd.controls[i] = (float)*u[1+i];
				}
				retval = sendto(info->servsock, (const char *)&isd, sizeof(isd), 0, (SOCKADDR*)&(info->sendadd), sizeof(SOCKADDR));

			}

		break;
		case csError:
			StartUDPServer(S, info,soIdx);
			break;
		}	
	}

}


/* mdlTerminate - called when the simulation is terminated ***********************************/
static void mdlTerminate(SimStruct *S) 
{
	ClearUp(S);
}

/* Trailer information to set everything up for simulink usage *******************************/
#ifdef  MATLAB_MEX_FILE                      /* Is this file being compiled as a MEX-file?   */
#include "simulink.c"                        /* MEX-file interface mechanism                 */
#else
#include "cg_sfun.h"                         /* Code generation registration function        */
#endif
