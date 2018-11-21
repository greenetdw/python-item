ls -l | awk '/^[^]/ {print $5,$9}' | sort -nr

ls -l | awk '/^[d]/ {print $5}' | sort -nr | grep 23 | wc -l

ls -l | awk '/^[d]/ {print $5}' | sort -nr  | wc -l