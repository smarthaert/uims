//-----------------------------------------------------------------
//  CPUInfo.h
//         by kkm1982
//----------------------------------------------------------------
class CCPUInfo  
{
    public:
        int GetTypeName(char *type);
        int GetName(char *name);
        int GetFamily();
        bool withMMX();
        bool hasFPU();
        int GetSpeed();
        CCPUInfo();
        virtual ~CCPUInfo();

    private:
        bool FPU;
        char * Name;
        bool MMX;
        int iFamily;
};
//-----------------------------------------------------------------
// Download by http://www.codefans.net//////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CCPUInfo::CCPUInfo()
{
    char OEMString[13];
    int iEAXValue,iEBXValue,iECXValue,iEDXValue;

	//获取CPU的品牌：
    _asm
	{
        mov eax,0
        cpuid
        mov DWORD PTR OEMString,ebx
        mov DWORD PTR OEMString+4,edx
        mov DWORD PTR OEMString+8,ecx
        mov BYTE PTR OEMString+12,0
	}
	Name=new char[15];
	strcpy(Name,OEMString);

	//更多CPU信息：
    _asm
	{
        mov eax,1
        cpuid
        mov iEAXValue,eax
        mov iEBXValue,ebx
        mov iECXValue,ecx
        mov iEDXValue,edx
	}
	MMX=bool(iEDXValue & 0x800000);
        iFamily=(0xf00 & iEAXValue)>>8;
	FPU=bool(iEDXValue & 0x1);

}

CCPUInfo::~CCPUInfo()
{
    delete []Name;
}

int CCPUInfo::GetSpeed()
{
    int PriorityClass, Priority;
    HANDLE hThread,hProcess;

    hThread=GetCurrentThread();
    hProcess=GetCurrentProcess();

    PriorityClass = GetPriorityClass(hProcess);
    Priority = GetThreadPriority(hThread);

    SetPriorityClass(hProcess, REALTIME_PRIORITY_CLASS);
    SetThreadPriority(hThread,THREAD_PRIORITY_TIME_CRITICAL);

    long lEAXValue,lEDXValue;

    SleepEx(50,false);

	_asm
	{
	     xor eax,eax
	     rdtsc
         mov lEAXValue,eax
         mov lEDXValue,edx
    }

    if(SleepEx(500,false)==0)
	{
	    _asm
		{
    	    xor eax,eax
		    rdtsc
            sub eax,lEAXValue
            sbb edx,lEDXValue
            mov lEAXValue, eax
            mov lEDXValue, edx
		}
    }

    SetThreadPriority(hThread, Priority);
    SetPriorityClass(hProcess, PriorityClass);
	return lEAXValue/(1000.0*500);
}

bool CCPUInfo::withMMX()
{
    return MMX;
}

int CCPUInfo::GetFamily()
{
    return iFamily;
}

int CCPUInfo::GetName(char *name)
{
    if(name==NULL) return -1;
	strcpy(name,Name);
	return 0;
}

int CCPUInfo::GetTypeName(char *type)
{
//EAX的8到11位表明是几86：
//                  3 - 386
//                  4 - i486
//                  5 - Pentium
//                  6 - Pentium Pro Pentium II
//                  2 - Dual Processors
    if(type==NULL) return -1;
	switch(iFamily)
	{
	case 2: strcpy(type,"Dual Processors");break;
	case 3: strcpy(type,"386");break;
    case 4: strcpy(type,"486");break;
	case 5: strcpy(type,"Pentium");break;
	case 6: strcpy(type,"P2,celeron,Pentium Pro");break;
	default: strcpy(type,"Unknown Type");
    }
	return 0;
}

bool CCPUInfo::hasFPU()
{
    return FPU;
}

