#!/usr/bin/awk
BEGIN{

}
function max(ti1,ti2){
	if(ti1==0)return ti2;
	split(ti1,t1,":");	
	split(ti2,t2,":");
	if(t1[1]*3600+t1[2]*60+t1[3]>t2[1]*3600+t2[2]*60+t2[3]) return ti1;
	else return ti2;	
}

function min(ti1,ti2){
	if(ti1==0) return ti2;
	split(ti1,t1,":");	
	split(ti2,t2,":");
	if(t1[1]*3600+t1[2]*60+t1[3]<t2[1]*3600+t2[2]*60+t2[3]) return ti1;
	else return ti2;	
}

function diff(max,min){
	split(max,t1,":");	
	split(min,t2,":");
	return t1[1]*3600+t1[2]*60+t1[3]-(t2[1]*3600+t2[2]*60+t2[3]);	
}

{
	#formatting ips
	sub(":","",$5);
	split($5,p,".");
	$5=p[1]"."p[2]"."p[3]"."p[4]":"p[5];
	split($3,p,".");
	$3=p[1]"."p[2]"."p[3]"."p[4]":"p[5];
	
	i=$3$4$5;
	#print $1,i
	
	#packets datapackets total data
	packets[i]++;
	if($NF>0) datapacket[i]++;
	total_data[i]+=$NF;

	#time
	timemax[i]=max(timemax[i],$1);
	timemin[i]=min(timemin[i],$1);
	timemax[$5$4$3]=max(timemax[$5$4$3],$1);
	timemin[$5$4$3]=min(timemin[$5$4$3],$1);
	
	#retransmission
	if($8=="seq"){
		if($9~/:/){
			sub(",","",$9);
			split($9,l,":");
			for(j=l[1];j<l[2];j++){
				if(ret[i"@"j]==1&&$NF>0)retrans[i]++;
				ret[i"@"j]=1;	
			}
		}
	}	

}

END{
	for(i in packets){
		split(i,val,">");
		ic=val[2]">"val[1];
		if(packets[i]>0){
		time=diff(timemax[i],timemin[i]);
		xputa=(total_data[i]-retrans[i]+0)/time;	
		xputb=(total_data[ic]-retrans[ic]+0)/time;	
		printf "Connection (A="val[1]",B="val[2]")\n";
		printf "A-->B";
		printf "\t#packets="packets[i];		
		printf "\t#datapackets="datapacket[i]+0;		
		printf "\t#bytes="total_data[i];		
		printf "\t#retrans="(retrans[i]+0);		
		printf "\t#xput=%d bytes/sec\n",xputa;		
		printf "B-->A";		
		printf "\t#packets="packets[ic];		
		printf "\t#datapackets="datapacket[ic]+0;		
		printf "\t#bytes="total_data[ic];		
		printf "\t#retrans="(retrans[ic]+0);		
		printf "\t#xput=%d\n bytes/sec",xputb;
		packets[ic]=0;		
		}

			
	}
}
