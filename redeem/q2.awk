#!/usr/bin/awk

BEGIN{

}
	function seconds(t){
		split(t,t1,":");
		return t1[1]*3600+t1[2]*60+t1[3];
	}

{
	if(NR==1){
		for(i=1;i<=NF;i++){
			row[$i]=i;
		}
		uname=row["USER"]
		pid=row["PID"]
		ppid=row["PPID"]
		lwp=row["LWP"]
		sz=row["SZ"]
		rss=row["RSS"]
		time=row["TIME"]
		start_time=row["START"]
		cmd=row["CMD"]
	} else {
		threads[$uname]++;
		cpu[$uname]+=seconds($time)
		if(process[$uname"@"$pid]==0){
			uprocess[$uname]++;
			umemory[$uname]+=$sz
			process[$uname"@"$pid]++;
		}
	}
}

END{
	printf "Total Number of Users:"length(threads)"\n";
	printf "USERNAME\tPROCESSES\tTHREADS\tCPU\tMEMORY\n";
	for(u in threads){
	printf u"\t\t"uprocess[u]"\t\t"threads[u]"\t"cpu[u]"\t"umemory[u]"\n";	
	}
}
