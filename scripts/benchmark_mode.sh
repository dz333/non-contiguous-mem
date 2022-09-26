#!/bin/bash
echo 0 | sudo tee /proc/sys/kernel/randomize_va_space
for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
do
    echo performance | sudo tee $i
done
#sudo cset shield -c 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 -k on
sudo cset shield -c 7 -k on
echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo
echo -1 | sudo tee /proc/sys/kernel/perf_event_paranoid
echo 0 | sudo tee /proc/sys/kernel/nmi_watchdog
