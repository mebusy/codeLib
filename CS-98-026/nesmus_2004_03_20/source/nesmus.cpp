/*
MUSIC SYNTAX:
txxx: tempo change. xxx is bpm of quarter note (assuming 30fps ticks)
vxx: volume change. x is volume level (0-15)
ox: octave change. x is octave number (0-9)
lx: change current note length x is [1,2,4,8,16]
px: rest for length x [1,2,4,8,16]
*/

#include <stdio.h>
#include <queue>
const int BUFSIZE = 1024;
const int MINTEMPO = 30;
const int MAXTEMPO = 250;
const unsigned char END_LOOP=254;
const unsigned char START_LOOP=255;

#define uchar unsigned char
#define min(a,b) (a<b?a:b)

unsigned int pitcharray[]=
	{
	//A 55
	2033,1928,1803,1720,1620,1531,1433,1363,1285,1215,1140,1075,
	//A 110
	1016,955,908,853,804,760,716,677,638,604,570,537,
	//A 220
	507,479,452,426,403,379,359,339,320,301,248,269,
	//A 440
	253,239,225,213,201,190,179,169,159,150,142,134,
	//A 880
	126,119,112,106,100,94,89,84,79,75,70,66,
	//A 1760
	63,59,56,52,49,47,44,41,39,37,35,33
	};

double currentframe[4]; //start of next note
int octave;
int volume;
int tempo;
int note;
int channel=0;
double notelength;
double current_notelength; //for current note
double restlength;
std::queue<int> channeldata[4];

char lcase(char c)
{
	if(c>='A' && c<='Z') return c-'A'+'a';
	return c;
}

void bitch(char* string,int line, int cchar)
{
	printf("ERROR: %s at character %d of line %d\n",string,cchar,line);
	fflush(stdout);
	exit(0);
}

void addbyte(uchar byte, int line, int cchar)
{
	if (channel<0 || channel>3) bitch("invalid sound channel",line,cchar);
	channeldata[channel].push(byte);
}

void output_note(int line, int cchar)
{
	double delta_frames=(3600.0/tempo)*current_notelength;
	int intlen=(int)(currentframe[channel]+delta_frames+0.5)-(int)(currentframe[channel]+0.5);
	currentframe[channel]+=delta_frames;
	unsigned char reg0,reg1,reg2,reg3,frames;
	int thenote=12*octave+note;

	reg0=(volume%31) + (2<<6)/*duty cycle*/ /*+ (1<<4)*//*decay envelope disable*/;
	reg1=0;
	reg2=pitcharray[thenote]%256; //lower 8 bits of pitch
	reg3=(pitcharray[thenote]>>8) + 48/*length load reg*/;
	frames=(unsigned char)intlen;
//	printf("note ch%d -- %d\n",channel,frames);
//	printf("  .db %d,%d,%d,%d,%d\n",frames,reg0,reg1,reg2,reg3);
//	printf("%c%c%c%c%c%c",frames,3,reg0,reg1,reg2,reg3);
	addbyte(frames,line,cchar);
	addbyte(3<<(channel*2),line,cchar);
	addbyte(reg0,line,cchar);
	addbyte(reg1,line,cchar);
	addbyte(reg2,line,cchar);
	addbyte(reg3,line,cchar);
}

void output_rest(int line, int cchar)
{
	double delta_frames=(3600.0/tempo)*restlength;
	int intlen=(int)(currentframe[channel]+delta_frames+0.5)-(int)(currentframe[channel]+0.5);
	currentframe[channel]+=delta_frames;
	unsigned char frames=(unsigned char)intlen; //does this ugly hack work?
//	printf("rest ch%d -- %d\n",channel,frames);
//	printf("  .db %d,%d,%d,%d,%d\n",frames,reg0,reg1,reg2,reg3);
//	printf("%c%c%c%c%c%c",frames,3,0,0,0,0);
	addbyte(frames,line,cchar);
	addbyte(3<<(channel*2),line,cchar);
	addbyte(0,line,cchar);
	addbyte(0,line,cchar);
	addbyte(0,line,cchar);
	addbyte(0,line,cchar);
}

void parse(FILE *fp, char* input_line, int line)
{
	char* buf=input_line;
	int i=0;
	char c; //temp char
	bool note_ready;
	while(buf[i]!='\n' && buf[i]!='\0')
	{
		note_ready=false;
		switch(lcase(buf[i]))
		{
			case ' ': //whitespace. do nothing
				i++;
				break;
			case 't': //tempo
				i++;
				tempo=0;
				while(buf[i]>='0' && buf[i]<='9')
					tempo=tempo*10+(buf[i++]-'0');
				if(tempo<MINTEMPO || tempo>MAXTEMPO)
					bitch("invalid tempo range",line,i);
				break;
			case 'o': //octave
				i++;
				c=buf[i];
				if(buf[i]<'0' || buf[i]>'9') bitch("invalid octave range",line,i);
				octave=buf[i++]-'0';
				break;
			case 'm': //legato, staccato, normal, duty cycle?
				bitch("option M is not implemented",line,i);
				break;
			case 'v': //volume
				i++;
				volume=0;
				while(buf[i]>='0' && buf[i]<='9')
					volume=volume*10+(buf[i++]-'0');
				if(volume<0 || volume>31)
					bitch("invalid volume range",line,i);
				break;
			case '>': //octave up
				octave++;
				i++;
				break;
			case '<': //octave down
				octave--;
				i++;
				break;
			case 'l': //note length
				i++;
				notelength=0;
				while(buf[i]>='0' && buf[i]<='9')
					notelength=notelength*10.0+(double)(buf[i++]-'0');
				if(notelength==1) notelength=4.0;
				else if(notelength==2) notelength=2.0;
				else if(notelength==4) notelength=1.0;
				else if(notelength==8) notelength=0.5;
				else if(notelength==16) notelength=0.25;
				else bitch("invalid note length",line,i);
				break;
			case 'p': //pause (rest)
				i++;
				restlength=0;
				while(buf[i]>='0' && buf[i]<='9')
					restlength=restlength*10.0+(double)(buf[i++]-'0');
				if(restlength==1) restlength=4.0;
				else if(restlength==2) restlength=2.0;
				else if(restlength==4) restlength=1.0;
				else if(restlength==8) restlength=0.5;
				else if(restlength==16) restlength=0.25;
				else bitch("invalid rest length",line,i);
				while(buf[i]=='.'){restlength*=1.5;i++;}
				output_rest(line,i);
				break;
			
			/*
			 pitches
			 can be followed by #(sharp) -(flat) .(dotted)
			*/
			case 'c':
				i++; note_ready=true; current_notelength=notelength;
				note=0;
				if(buf[i]=='#'){note++;i++;}
				else if(buf[i]=='-'){note--;i++;}
				while(buf[i]=='.'){current_notelength*=1.5;i++;}
				break;
			case 'd':
				i++; note_ready=true; current_notelength=notelength;
				note=2;
				if(buf[i]=='#'){note++;i++;}
				else if(buf[i]=='-'){note--;i++;}
				while(buf[i]=='.'){current_notelength*=1.5;i++;}
				break;
			case 'e':
				i++; note_ready=true; current_notelength=notelength;
				note=4;
				if(buf[i]=='#'){note++;i++;}
				else if(buf[i]=='-'){note--;i++;}
				while(buf[i]=='.'){current_notelength*=1.5;i++;}
				break;
			case 'f':
				i++; note_ready=true; current_notelength=notelength;
				note=5;
				if(buf[i]=='#'){note++;i++;}
				else if(buf[i]=='-'){note--;i++;}
				while(buf[i]=='.'){current_notelength*=1.5;i++;}
				break;
			case 'g':
				i++; note_ready=true; current_notelength=notelength;
				note=7;
				if(buf[i]=='#'){note++;i++;}
				else if(buf[i]=='-'){note--;i++;}
				while(buf[i]=='.'){current_notelength*=1.5;i++;}
				break;
			case 'a':
				i++; note_ready=true; current_notelength=notelength;
				note=9;
				if(buf[i]=='#'){note++;i++;}
				else if(buf[i]=='-'){note--;i++;}
				while(buf[i]=='.'){current_notelength*=1.5;i++;}
				break;
			case 'b':
				i++; note_ready=true; current_notelength=notelength;
				note=11;
				if(buf[i]=='#'){note++;i++;}
				else if(buf[i]=='-'){note--;i++;}
				while(buf[i]=='.'){current_notelength*=1.5;i++;}
				break;
			default:
				bitch("invalid syntax (see ascii)",line, int(lcase(buf[i])));
				break;
		}
	if(note_ready) output_note(line,i);
	}
}


void output_files(FILE *fp)
{
	currentframe[0]=currentframe[1]=currentframe[2]=currentframe[3]=0.0;
	int fileend=0x8004+channeldata[0].size()+channeldata[1].size()
		+channeldata[2].size()+channeldata[3].size();
	int ctime[4];
	ctime[0]=ctime[1]=ctime[2]=ctime[3]=0;
	unsigned char next_time=0;
	while(!(channeldata[0].empty() && channeldata[1].empty()
		&& channeldata[2].empty() && channeldata[3].empty()))
	{
		unsigned char status=0;
		for(int ch=0;ch<4;ch++)
		{
			if(ctime[ch]==0 && !channeldata[ch].empty())
			{
				ctime[ch]=channeldata[ch].front();
				channeldata[ch].pop();
				status+=channeldata[ch].front();
				channeldata[ch].pop();
				ctime[ch]--;
			}
			else if(!channeldata[ch].empty())
				ctime[ch]--;
		}
		if(status!=0)
		{
			next_time=0xff;
			if(!channeldata[0].empty() && ctime[0]<next_time) next_time=ctime[0];
			if(!channeldata[1].empty() && ctime[1]<next_time) next_time=ctime[1];
			if(!channeldata[2].empty() && ctime[2]<next_time) next_time=ctime[2];
			if(!channeldata[3].empty() && ctime[3]<next_time) next_time=ctime[3];
			fprintf(fp,"%c%c",next_time,status);
		}
		for(int ch=0;ch<4;ch++)
		{
			if((status>>(ch*2))%4==1)
			{
				//compressed handler
				bitch("this should not happen",0,0);
			}
			else if((status>>(ch*2))%4==3)
			{
				//full handler
				for(int i=0;i<4;i++)
				{
					fprintf(fp,"%c",channeldata[ch].front());
					channeldata[ch].pop();
				}
			}
		}
	}
}

bool ischannel(const char* buf)
{
	if(strlen(buf)<9) return false;
	char chstring[]="channel ";
	for (int i=0;i<strlen(chstring);i++)
		if(lcase(buf[i])!=chstring[i]) return false;
	char c=buf[8];
	if(c=='0') {channel=0; return true;}
	if(c=='1') {channel=1; return true;}
	if(c=='2') {channel=2; return true;}
	if(c=='3') {channel=3; return true;}
	return false;
}

bool isloop(const char* buf, FILE *fp,int line)
{
	if(lcase(buf[0])=='e' && lcase(buf[1])=='n' && lcase(buf[2])=='d')
	{
//		printf("end loop\n");
		output_files(fp);
		fprintf(fp,"%c",END_LOOP);
		return true;
	}
	if(lcase(buf[0])=='l' && lcase(buf[1])=='o' && lcase(buf[2])=='o'
		&& lcase(buf[3])=='p' && lcase(buf[4]==' '))
	{
		if(buf[5]<'0' || buf[5]>'9') bitch("invalid loop declaration",line,5);
		int numloops=buf[5]-'0';
		if(buf[6]>='0' && buf[6]<='9')
		{
			numloops=numloops*10 + (buf[6]-'0');
			if(buf[7]>='0' && buf[7]<='9')
				numloops=numloops*10 + (buf[7]-'0');
		}
		if (numloops<=0 || numloops>=256) bitch("invalid loop number",line,5);
		output_files(fp);
		fprintf(fp,"%c%c",START_LOOP,numloops);
//		printf("loop %d times\n",numloops);
		return true;
	}
	return false;
}

int main(int argn, char **argv)
{
	if(argn!=3)
	{
		printf("bitch needs input and output files , argn: %d \n" , argn  );
		exit(0);
	}
	FILE *fp=fopen(argv[1],"r");
	FILE *fout=fopen(argv[2],"w");
	char buf[BUFSIZE];
	currentframe[0]=currentframe[1]=currentframe[2]=currentframe[3]=0.0;
	int line=0;
	while(fgets(buf,BUFSIZE,fp)!=0)
	{
		if (buf[0]==';') {/*comment -- do nothing*/}
		else if (isloop(buf,fout,line)){/*action handled by isloop()*/}
		else if (ischannel(buf)){/*action handled by ischannel()*/}
		else parse(fp,buf,line);
		fflush(stdout);
		line++;
	}
	fclose(fp);
	output_files(fout);
	fclose(fout);
	return 0;
}
