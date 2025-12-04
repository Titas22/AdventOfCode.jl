# AdventOfCode.jl

[![Julia](https://img.shields.io/badge/Julia-9558B2?style=flat&logo=Julia&logoColor=white)](https://julialang.org/)
[![Total: 109](https://img.shields.io/badge/🎄AoC-⭐109-forestgreen?labelColor=darkred)](https://adventofcode.com/)
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
```

## Summary

![6/24](https://img.shields.io/badge/🎄2025-⭐6/24-royalblue?labelColor=darkred)
![Runtime: 0.954ms](https://img.shields.io/badge/Total%20Run%20Time-0.954%20ms-purple)
![Memory: 334KiB](https://img.shields.io/badge/Total%20Memory-334.0%20KiB-blue)

| Day | Problem | Total Time | Time (algo) | Total Memory | Memory (algo) | Source |
|----:|:----------------:|:-----:|:------------:|:-----:|:------------:|:------:|
| 01 | [Secret Entrance](https://adventofcode.com/2025/day/1) | 437.100 μs | 83.900 μs | 257.33 KiB | 36.57 KiB | [:white_check_mark:](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2025/AoC_2025_01.jl) |
| 02 | [Gift Shop](https://adventofcode.com/2025/day/2) | 174.400 μs | 37.700 μs | 40.61 KiB | 39.39 KiB | [:white_check_mark:](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2025/AoC_2025_02.jl) |
| 03 | [Lobby](https://adventofcode.com/2025/day/3) | 342.600 μs | 185.350 μs | 36.07 KiB | 4.58 KiB | [:white_check_mark:](https://github.com/Titas22/AdventOfCode.jl/blob/main/src/AoC_2025/AoC_2025_03.jl) |
| 04 | [](https://adventofcode.com/2025/day/4) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |
| 05 | [](https://adventofcode.com/2025/day/5) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |
| 06 | [](https://adventofcode.com/2025/day/6) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |
| 07 | [](https://adventofcode.com/2025/day/7) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |
| 08 | [](https://adventofcode.com/2025/day/8) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |
| 09 | [](https://adventofcode.com/2025/day/9) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |
| 10 | [](https://adventofcode.com/2025/day/10) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |
| 11 | [](https://adventofcode.com/2025/day/11) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |
| 12 | [](https://adventofcode.com/2025/day/12) | - s | - s | - KiB | - KiB | [:x:](https://github.com/Titas22/AdventOfCode.jl/AdventOfCode.jl) |

> \* Algo time/memory shows the results of solution without the time taken to read the inputs from file.
> Parsing of the inputs is still included (from the `Vector{String}` format)

---

The benchmarks have been measured on this machine:

```Bash
Julia Version 1.12.1
Commit ba1e628ee4 (2025-10-17 13:02 UTC)
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
