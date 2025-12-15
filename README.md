# AdventOfCode.jl

[![Julia 1.12.2](https://img.shields.io/badge/Julia-1.12.2-9558B2?style=flat&logo=Julia&logoColor=white)](https://julialang.org/)
[![Total: 119](https://img.shields.io/badge/🎄AoC-⭐119-forestgreen?labelColor=darkred)](https://adventofcode.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac)
[![Badge](https://hitscounter.dev/api/hit?url=https%3A%2F%2Fgithub.com%2FTitas22%2FAdventOfCode.jl&label=Hits&icon=github&color=%2320c997&message=&style=flat&tz=UTC)](https://hitscounter.dev/)
![Repo Size](https://img.shields.io/github/repo-size/Titas22/AdventOfCode.jl)

My [Advent of Code](https://adventofcode.com/) submissions in [Julia](https://julialang.org/).

## Running

```Julia
include("./scripts/init.jl") # Run once to set up and activate the environment

include("./src/AoC_2025/AoC_2025_xx.jl") # use to run & re-run the actual script

# Benchmarking - median times taken
@benchmark (part1, part2) = AoC_2025_xx.solve(use_input_cache=false) # Full benchmark including parsing the file
@benchmark (part1, part2) = AoC_2025_xx.solve(use_input_cache=true) # Algo only benchmark (cached inputs)

# For profiling
@profview for _ in 1:1000; AoC_2025_xx.solve(use_input_cache=true); end
```

## Summary

![16/24](https://img.shields.io/badge/🎄2025-⭐16/24-royalblue?labelColor=darkred)
![Runtime: 6.288ms](https://img.shields.io/badge/Total%20Run%20Time-6.288%20ms-purple)
![Memory: 1.103MiB](https://img.shields.io/badge/Total%20Memory-1.103%20MiB-blue)

| Day | Problem | Total Time | Time (algo) | Total Memory | Memory (algo) | Source |
|----:|:----------------:|:-----:|:------------:|:-----:|:------------:|:------:|
| 01 | [Secret Entrance](https://adventofcode.com/2025/day/1) | 437.100 μs | 83.900 μs | 257.33 KiB | 36.57 KiB | [:white_check_mark:](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2025/AoC_2025_01.jl) |
| 02 | [Gift Shop](https://adventofcode.com/2025/day/2) | 174.400 μs | 37.700 μs | 40.61 KiB | 39.39 KiB | [:white_check_mark:](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2025/AoC_2025_02.jl) |
| 03 | [Lobby](https://adventofcode.com/2025/day/3) | 216.900 μs | 58.500 μs | 35.90 KiB | 4.41 KiB | [:white_check_mark:](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2025/AoC_2025_03.jl) |
| 04 | [Printing Department](https://adventofcode.com/2025/day/4) | 667.400 μs | 531.100 μs | 362.90 KiB | 334.69 KiB | [:white_check_mark:](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2025/AoC_2025_04.jl) |
| 05 | [Cafeteria](https://adventofcode.com/2025/day/5) | 271.100 μs | 68.600 μs | 96.63 KiB | 39.03 KiB | [:white_check_mark:](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2025/AoC_2025_05.jl) |
| 06 | [Trash Compactor](https://adventofcode.com/2025/day/6) | 249.200 μs | 81.500 μs | 120.49 KiB | 100.60 KiB | [:white_check_mark:](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2025/AoC_2025_06.jl) |
| 07 | [Laboratories](https://adventofcode.com/2025/day/7) | 186.600 μs | 32.300 μs | 39.22 KiB | 10.54 KiB | [:white_check_mark:](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2025/AoC_2025_07.jl) |
| 08 | [Playground](https://adventofcode.com/2025/day/8) | 4.086 ms | 3.909 ms | 203.58 KiB | 140.33 KiB | [:white_check_mark:](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2025/AoC_2025_08.jl) |
| 09 | [Movie Theater](https://adventofcode.com/2025/day/9) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |
| 10 | [Factory](https://adventofcode.com/2025/day/10) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |
| 11 | [Reactor](https://adventofcode.com/2025/day/11) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |
| 12 | [Christmas Tree Farm](https://adventofcode.com/2025/day/12) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |

> \* Algo time/memory shows the results of solution without the time taken to read the inputs from file.
> Parsing of the inputs is still included (from the `Vector{String}` format)

---

The benchmarks have been measured on this machine:

```Bash
Julia Version 1.12.2
Commit ca9b6662be (2025-11-20 16:25 UTC)
Platform Info:
    Model:  MSI GE66 Raider 10SFS
    OS:     Windows 11 Home 64-bit (10.0, Build 26100)
    CPU:    Intel(R) Core(TM) i9-10980HK CPU @ 2.40GHz (16 CPUs), ~3.1GHz
    GPU:    NVIDIA GeForce RTX 2070 Super
    Memory: 64.0 GB DDR4-3200 SDRAM

    LLVM: libLLVM-18.1.7 (ORCJIT, skylake)
```

---

## Previous Years

- [![2024: 50/50](https://img.shields.io/badge/🎄2024-⭐50/50-forestgreen?labelColor=darkred)](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2024/Summary.md)
- [![2023: 45/50](https://img.shields.io/badge/🎄2023-⭐45/50-darkviolet?labelColor=darkred)](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2023/Summary.md)
- [![2022: 28/50](https://img.shields.io/badge/🎄2022-⭐28/50-darkviolet?labelColor=darkred)](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2022/Summary.md)
