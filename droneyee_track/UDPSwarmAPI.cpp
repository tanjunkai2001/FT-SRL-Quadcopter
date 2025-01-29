/*  RflySim Simulink UDP Interface  **********************************************************************/
/*  Xunhua Dai, 2020/05/03, Beihang University ********************/
#define _linux_
#define S_FUNCTION_NAME UDPSwarmAPI
#define S_FUNCTION_LEVEL 2


/*%%%%%%%%%%%%%%%%%%%%%*/
 
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
*///////

//#else
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

//���������Ӧ������ģʽ��CopterRecA��CopterRecB
//����CopterRecAģʽUDP������11άdouble�����ݣ����?7άdouble��
//CopterRecAģʽUDP������3άdouble���ݣ�û�����?
#define REC_A_LEN 21
#define SEND_A_LEN 8

#define REC_B_LEN 3
#define SEND_B_LEN 0


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
  //  WSACleanup();
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


	if(iUdpMode == 0){
		int outLen = REC_A_LEN;
		int inLen = SEND_A_LEN;		
		if (!ssSetNumInputPorts(S,iNumVehicle)) return;             /* number of input ports                */
		if (!ssSetNumOutputPorts(S,iNumVehicle)) return;            /* number of output ports               */
		for(int i=0;i<iNumVehicle;i++){
			ssSetOutputPortWidth(S,i, outLen);              /* first output port width              */
			ssSetOutputPortDataType(S,0,SS_DOUBLE);            /* first output port data type          */
			ssSetInputPortWidth(S,i, inLen);              /* first intput port width              */
			//ssSetInputPortDirectFeedThrough(S,i,1);
			ssSetInputPortDataType(S,0,SS_DOUBLE);            /* first intput port data type          */
		}		
	}else{
		if (!ssSetNumInputPorts(S,0)) return;             /* number of input ports                */
		if (!ssSetNumOutputPorts(S,iNumVehicle)) return;            /* number of output ports               */		
		int outLen = REC_B_LEN;
		int inLen= SEND_B_LEN;		
		for(int i=0;i<iNumVehicle;i++){
			ssSetOutputPortWidth(S,i, outLen);              /* first output port width              */
			ssSetOutputPortDataType(S,0,SS_DOUBLE);            /* first output port data type          */
			//ssSetInputPortWidth(S,i, inLen);              /* first intput port width              */
			//ssSetInputPortDirectFeedThrough(S,i,1);
			//ssSetInputPortDataType(S,0,SS_DOUBLE);            /* first intput port data type          */
		}		
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
	//���ø��׽���Ϊ�㲥����	
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

	struct sockaddr_in req_sin;
	
	int req_len, recvlen, maxrecvlen=iBufSize;
	SInfo *info;

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

				if(iUdpMode==0){
					if(recvlen==sizeof(double)*REC_A_LEN){
						double in_rec_A[REC_A_LEN]={0};
						memcpy(in_rec_A,buffer,recvlen);
						for(int i=0;i<REC_A_LEN;i++){
							data[i]=in_rec_A[i];
						}
					}
				}else{
					if(recvlen==sizeof(double)*REC_B_LEN){
						double in_rec_B[REC_B_LEN]={0};
						memcpy(in_rec_B,buffer,recvlen);
						for(int i=0;i<REC_B_LEN;i++){
							data[i]=in_rec_B[i];
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
	

    double *dPort; 
	int iPort;
    dPort=(double *)mxGetPr(ssGetSFcnParam(S,0));
	iPort = (int)floor((*dPort)+0.5);


	//send_sin.sin_addr.s_addr=

	for(int idex=0;idex<iNumVehicle;idex++){
		int soIdx = idex+1;
		/* output ports */
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
				if(SEND_A_LEN>0){
					double **u = (double**) ssGetInputPortSignalPtrs(S,idex);
					double out_send_A[SEND_A_LEN]={0};
					for(int i=0;i<SEND_A_LEN;i++){
						out_send_A[i]=(double)*u[i];
					}
					retval = sendto(info->servsock, (const char *)&out_send_A, sizeof(double)*SEND_A_LEN, 0, (SOCKADDR*)&(info->sendadd), sizeof(SOCKADDR));
				}
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
