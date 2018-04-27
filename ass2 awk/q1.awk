#!/usr/bin/awk

BEGIN{
	RS="\f";
}

{
	n = split($0,a,"");
	nmc=0;
	nsc=0;
	ns=0;
	
	#strings
	for(i=1; i<=n; i++){
		if(a[i] ~ /"/){
			i++;
			while((i<=n)&&(a[i] !~ /"/)){
				if(a[i]=="\\") a[i+1]="a";
				a[i]="a";
				i++;
				
			}
			a[i]="b";	
		}	
	}

	#comments multi line
	for(i=1; i<n; i++){
		if((a[i] ~ /\//)&&(a[i+1] ~ /\*/)){
			i+=2;
			while(i<n&&!((a[i] ~ /\*/)&&(a[i+1] ~ /\//))){
				if(a[i]=="\\"&&a[i+1]=="\n"){ a[i+1]=a[i-1];}
				if(a[i] == "\n") nmc++
				if(a[i]!="*")a[i]="o";
				i++;	
			}
			nmc++;
			if(i<=n) a[i]="o"
			i++;
			if(i<=n)a[i]="o"
		}	
	}
	
	#comments single line
	for(i=1; i<n; i++){
		if((a[i] ~ /\//)&&(a[i+1] ~ /\//)){
			i+=2;
			nsc++;
			while((i<n)&&(a[i] != "\n")){
				if(a[i]=="\\"&&a[i+1]="\n") a[i+1]="\f";
				a[i]="\f";
				i++;	
			}
			if(i<=n) a[i]="\f"
		}	
	}

	for(i=1; i<=n; i++){
		if(a[i] ~ /"/) ns++;	
	}
}

END{
	nmc=nmc+nsc;
	print nmc, ns
}
