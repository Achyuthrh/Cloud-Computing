#!/bin/bash
# Sysbench CPU Benchmark Automation Script
# Cloud Computing Lab - Performance Analysis of Type-1 and Type-2 Hypervisors

OUTPUT_FILE="benchmark_results_$(hostname)_$(date +%Y%m%d_%H%M%S).log"

echo "======================================================" | tee "$OUTPUT_FILE"
echo "  HYPERVISOR CPU BENCHMARK - CLOUD COMPUTING LAB      " | tee -a "$OUTPUT_FILE"
echo "======================================================" | tee -a "$OUTPUT_FILE"
echo "Date: $(date)" | tee -a "$OUTPUT_FILE"
echo "Hostname: $(hostname)" | tee -a "$OUTPUT_FILE"
echo "Kernel: $(uname -r)" | tee -a "$OUTPUT_FILE"
echo "Architecture: $(uname -m)" | tee -a "$OUTPUT_FILE"
echo "------------------------------------------------------" | tee -a "$OUTPUT_FILE"

echo -e "\n--- System Hardware Specifications ---" | tee -a "$OUTPUT_FILE"
lscpu | grep -E "Model name|CPU\(s\)|Thread\(s\) per core|Core\(s\) per socket|Socket\(s\)" | tee -a "$OUTPUT_FILE"
free -h | tee -a "$OUTPUT_FILE"
df -h / | tee -a "$OUTPUT_FILE"

echo -e "\n--- Running Sysbench CPU Benchmark (20,000 Primes) ---" | tee -a "$OUTPUT_FILE"
if ! command -v sysbench &> /dev/null; then
    echo "Sysbench not found! Installing..." | tee -a "$OUTPUT_FILE"
    sudo apt update && sudo apt install sysbench -y
fi

sysbench --version | tee -a "$OUTPUT_FILE"
sysbench cpu --cpu-max-prime=20000 run | tee -a "$OUTPUT_FILE"

echo -e "\n======================================================" | tee -a "$OUTPUT_FILE"
echo "Benchmark Completed. Results saved to $OUTPUT_FILE" | tee -a "$OUTPUT_FILE"
echo "======================================================" | tee -a "$OUTPUT_FILE"
