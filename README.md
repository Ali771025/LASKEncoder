# ASK / PAM Encoding Exercises

MATLAB exercises for Gray-coded ASK/PAM symbol encoding and pulse shaping.

## Overview

`BinarySource` generates random bits. `Encoder` maps bit groups to Gray-coded PAM amplitudes; `PAMmodulator` applies RECT, DIRAC, or SINC pulses.

## Repository contents

- [BinarySource.m](BinarySource.m)
- [Encoder.m](Encoder.m)
- [LASKEncoder.m](LASKEncoder.m)
- [LICENSE](LICENSE)
- [PAMmodulator.m](PAMmodulator.m)
- [runn.m](runn.m)

## Requirements

MATLAB with Communications Toolbox; Signal Processing Toolbox is needed for `buffer` and pulse-processing helpers.

## Getting started

Clone this repository and open its directory:

```bash
git clone https://github.com/Ali771025/LASKEncoder.git
cd LASKEncoder
```

Inspect the source and the compatibility notes below before setting up an execution environment.

## Compatibility and scope

`runn.m` also calls `ModQAM` and `DeModQAM`, which are not included here. They can be found in the separate [ModQAM repository](https://github.com/Ali771025/ModQAM). `LASKEncoder.m` currently overrides its `nlevels` argument with 16. Treat the files as exercises requiring review before reuse.

## Credits and license

This repository contains educational material. Preserve author credits and license notices in the source files. See the license file where provided; inclusion in this repository does not replace existing source attribution.
