#!/bin/bash
echo 2 | sudo tee /proc/sys/kernel/randomize_va_space
for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
do
    echo powersave| sudo tee $i
done
sudo cset shield -r
echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo
echo 3 | sudo tee /proc/sys/kernel/perf_event_paranoid
