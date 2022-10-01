# declare variables
declare -i j=0
declare -A ips_dict

for i in $(ls ~/Documents/bash/top_100_ips/sources)
do
	if [[ $i == file* ]]
	then
		while IFS='' read -r line || [[ -n "${line}" ]];
		do			
			for word in $line
			do
				j+=1
				if [[ $j == 3 ]]; then 
					if ! [[ ${!ips_dict[@]} =~ $word  ]]; then
						ips_dict["$word"]=1
					else
						((ips_dict["$word"]=ips_dict["$word"]+1))
						# ips_dict["$word"]+=1						
					fi
				fi 
			done
		done < "sources/$i"
	fi
done

for key in "${!ips_dict[@]}"; do
	printf '%s:%s\n' "$key" "${ips_dict[$key]}"
done | sort -t : -k 2nr | head -4

